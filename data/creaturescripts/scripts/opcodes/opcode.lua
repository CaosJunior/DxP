local op_crea = {
      OPCODE_SKILL_BAR = opcodes.OPCODE_SKILL_BAR,
	  OPCODE_POKEMON_HEALTH = opcodes.OPCODE_POKEMON_HEALTH,
	  OPCODE_BATTLE_POKEMON = opcodes.OPCODE_BATTLE_POKEMON,
	  OPCODE_FIGHT_MODE = opcodes.OPCODE_FIGHT_MODE,
	  OPCODE_WILD_POKEMON_STATS = opcodes.OPCODE_WILD_POKEMON_STATS,
	  OPCODE_REQUEST_DUEL = opcodes.OPCODE_REQUEST_DUEL,
	  OPCODE_ACCEPT_DUEL = opcodes.OPCODE_ACCEPT_DUEL,
	  OPCODE_YOU_ARE_DEAD = opcodes.OPCODE_YOU_ARE_DEAD,
	  OPCODE_DITTO_MEMORY = opcodes.OPCODE_DITTO_MEMORY,
}

function onExtendedOpcode(cid, opcode, buffer)
	if opcode == op_crea.OPCODE_SKILL_BAR then
		if buffer == "refresh" then
			doOTCSendPlayerSkills(cid)
		end
	elseif opcode == op_crea.OPCODE_POKEMON_HEALTH then
		if buffer == "refresh" then
			doOTCSendPokemonHealth(cid)
		end
	elseif opcode == op_crea.OPCODE_BATTLE_POKEMON then
		if buffer == "refresh" then
			if #getCreatureSummons(cid) >= 1 then
				doSendPlayerExtendedOpcode(cid, op_crea.OPCODE_BATTLE_POKEMON, tostring(getCreatureSummons(cid)[1]))
			end
		end
	elseif opcode == op_crea.OPCODE_FIGHT_MODE then
		setPlayerStorageValue(cid, storages.fightMode, tonumber(buffer))
	elseif opcode == op_crea.OPCODE_WILD_POKEMON_STATS then
		doSendPlayerExtendedOpcode(cid, op_crea.OPCODE_WILD_POKEMON_STATS, pokeStatus.getVity(tonumber(buffer)).."|"..pokeStatus.getAtk(tonumber(buffer)).."|"..pokeStatus.getSpAtk(tonumber(buffer)).."|"..pokeStatus.getDef(tonumber(buffer)).."|"..pokeStatus.getSpDef(tonumber(buffer)).."|"..pokeStatus.getSpeed(tonumber(buffer)))
	
	--//Duel
	elseif opcode == opcodes.OPCODE_REQUEST_DUEL then
		   --legenda: cid = player, sid = player convidado
		   local cut = string.explode(buffer, "/")
		   local pokeballsCount, sid = tonumber(cut[1]), getCreatureByName(cut[2])
		        if isCreature(sid) then 
				   doIniteDuel(cid, sid, pokeballsCount)
				end
	elseif opcode == opcodes.OPCODE_ACCEPT_DUEL then
		local p2 = getCreatureByName(buffer)
		   if isInvitedDuel(p2, cid) then
		       doPantinNoDuel(cid, p2, getPlayerStorageValue(p2, duelTable.infoBalls), 5)
		   end
		   
	elseif opcode == opcodes.OPCODE_DITTO_MEMORY then
		 local item = getPlayerSlotItem(cid, 8)
			if item.uid == 0 then doSendMsg(cid, "Coloque seu shiny ditto no slot correto.") return true end
		 local pokeName = getItemAttribute(item.uid, "poke")
			if pokeName ~= "Shiny Ditto" then return true end
			
			if isInArray({"saveMemory1", "saveMemory2", "saveMemory3"}, buffer) then
			   local copyName = getItemAttribute(item.uid, "copyName")
			   if pokeName == copyName then doSendMsg(cid, "Transforme seu ditto primeiro.") return true end
			   if isPokeInSlots(getItemAttribute(item.uid, "memoryDitto"), doCorrectString(copyName)) then doSendMsg(cid, "Esta copia já está salva em um slot.") return true end
				   if buffer == "saveMemory1" then
					   doItemSetAttribute(item.uid, "memoryDitto", saveSlot(getItemAttribute(item.uid, "memoryDitto"), 1, getItemInfo(fotos[doCorrectString(copyName)]).clientId)) -- getPortraitClientID(doCorrectString(copyName))))
				   elseif buffer == "saveMemory2" then
					   doItemSetAttribute(item.uid, "memoryDitto", saveSlot(getItemAttribute(item.uid, "memoryDitto"), 2, getItemInfo(fotos[doCorrectString(copyName)]).clientId))
				   elseif buffer == "saveMemory3" then
					   doItemSetAttribute(item.uid, "memoryDitto", saveSlot(getItemAttribute(item.uid, "memoryDitto"), 3, getItemInfo(fotos[doCorrectString(copyName)]).clientId))
				   end
			elseif isInArray({"clearSlot1", "clearSlot2", "clearSlot3"}, buffer) then
				  if buffer == "clearSlot1" then
					   doItemSetAttribute(item.uid, "memoryDitto", saveSlot(getItemAttribute(item.uid, "memoryDitto"), 1, "?"))
				   elseif buffer == "clearSlot2" then
					   doItemSetAttribute(item.uid, "memoryDitto", saveSlot(getItemAttribute(item.uid, "memoryDitto"), 2, "?"))
				   elseif buffer == "clearSlot3" then
					   doItemSetAttribute(item.uid, "memoryDitto", saveSlot(getItemAttribute(item.uid, "memoryDitto"), 3, "?"))
				   end
			elseif isInArray({"use1", "use2", "use3"}, buffer) then
				  local summons = getCreatureSummons(cid)
				  if #summons < 1 then doSendMsg(cid, "Coloque seu ditto para fora da pokeball.") return true end
				  local pokeToTransform = getSlot(getItemAttribute(item.uid, "memoryDitto"), tonumber(buffer:explode("use")[1]))
				  doCopyPokemon(summons[1], pokeToTransform, true)
			end
			   
			   
			local memory = getItemAttribute(item.uid, "memoryDitto")
				  if not memory or memory == nil then
					 doItemSetAttribute(item.uid, "memoryDitto", "?|?|?")
					 memory = getItemAttribute(item.uid, "memoryDitto")
				  end
			local memoryOne, memoryTwo, memoryTree = memory:explode("|")[1], memory:explode("|")[2], memory:explode("|")[3]
			
			local str = memoryOne .. "-".. memoryTwo .."-" .. memoryTree
				  doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_DITTO_MEMORY, str)
				  
				  
	elseif opcode == opcodes.OPCODE_TV_CAM then -- TVCam
			--doCreatePrivateChannel(cid)
			--doInviteToPrivateChannel(cid, playerName)
			--doRemoveIntoPrivateChannel(cid, playerName)
			if getGlobalStorageValue(globalsTV) == -1 then -- iniciar sistema
				setGlobalStorageValue(globalsTV, "")
			end
			local action = buffer:explode("/")[1]
			
			if action == "create" then
				createChannel(cid, buffer)
				
			elseif action == "close" then
				closeInClientChannmel(cid)
				
			elseif action == "watch" then
			
				local playerToWatch = getCreatureByName(buffer:explode("/")[2])
				   if isCreature(playerToWatch) then
					  if getPlayerStorageValue(playerToWatch, storages.playerTVPass) ~= "" and getPlayerStorageValue(playerToWatch, storages.playerTVPass) ~= "notASSenha" then
					     doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_TV_CAM, "requestPass|" .. getPlayerStorageValue(playerToWatch, storages.playerTVPass) .. "|" .. buffer:explode("/")[2]) 
					  else
						 doWatch(cid, playerToWatch)
					  end
					else
					 doSendMsg(cid, "Este player não está mais gravando.")
				   end
				   
			elseif action == "watchWithPass" then
			
				local playerToWatch = getCreatureByName(buffer:explode("/")[2])
				   if isCreature(playerToWatch) then
				      doWatch(cid, playerToWatch)
				   else
					 doSendMsg(cid, "Este player não está mais gravando.")
				   end
				   
			elseif action == "errou" then
				     doSendMsg(cid, "Senha do digitada incorreta.")
			end
			
	elseif opcode == opcodes.OPCODE_PLAYER_SHOW_AUTOLOOT then -- Autoloot
			if buffer:find("load/") then
			  local itens = getAllItensAutoLoot()	
			  doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_PLAYER_SHOW_AUTOLOOT, (isCollectAll(cid) and "yes" or "no") .. "|" .. itens .. "|" .. getAllItensInMyListToClient(cid))
			elseif buffer:find("all") then
			    doCollectAll(cid, true)
				doSendMsg(cid, "AutoLoot: Coletar tudo foi ativado.")
			elseif buffer:find("no") then
			    doCollectAll(cid, false)
				doSendMsg(cid, "AutoLoot: Coletar tudo foi desativado.")
			else
			  doSaveItems(cid, buffer)
			end
			
	elseif opcode == opcodes.OPCODE_PLAYER_SHOW_ONLINE then -- Janela de onlines do ADM
			doGetPlayersOnToADM(cid)
	end
end

function getSlot(strings, slot)
	local slot1, slot2, slot3 = strings:explode("|")[1], strings:explode("|")[2], strings:explode("|")[3]
	local ret, flag = "", false
	for a, b in pairs(fotos) do
	   if getItemInfo(fotos[a]).clientId == tonumber(slot1) and slot == 1 then 
		  ret = doCorrectString(a)
		  flag = true
	   elseif getItemInfo(fotos[a]).clientId == tonumber(slot2) and slot == 2  then 
		  ret = doCorrectString(a)
		  flag = true
	   elseif getItemInfo(fotos[a]).clientId == tonumber(slot3) and slot == 3 then 
		  ret = doCorrectString(a)
		  flag = true
	   end
		   if flag then
			  break
		   end	
	end
	return ret
end

function saveSlot(strings, slot, poke)
	local slot1, slot2, slot3 = strings:explode("|")[1], strings:explode("|")[2], strings:explode("|")[3]
	local finalSlots = (slot == 1 and poke .. "|" or slot1 .. "|") .. (slot == 2 and poke .. "|" or slot2 .. "|") .. (slot == 3 and poke .. "|" or slot3)
		return finalSlots
end

function isPokeInSlots(strings, poke)
	poke = getItemInfo(fotos[poke]).clientId
	local slot1, slot2, slot3 = strings:explode("|")[1], strings:explode("|")[2], strings:explode("|")[3]
	if tonumber(slot1) == poke then
	   return true
	elseif tonumber(slot2) == poke then
	   return true
	elseif tonumber(slot3) == poke then
	   return true
	end
	return false
end