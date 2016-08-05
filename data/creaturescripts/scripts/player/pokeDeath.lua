function matou(cid, target)
if isSummon(target) and isPlayer(getCreatureMaster(target)) then
 
	doPlayerSendCancel(getCreatureMaster(target), '12//,hide') --alterado v1.7
	doUpdateMoves(getCreatureMaster(target))
	doKillPlayerPokemon(target)
	doRemoveCreature(target)
	doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_POKEMON_HEALTH, "0|0")
	
elseif isWild(target) then

if getPlayerStorageValue(target, 637500) >= 1 then -- sherdder team
	doRemoveCreature(target)
	return true
end


local nameDeath = doCorrectString(getCreatureName(target))
local pos = getThingPos(target)
local corpseID = getPokemonCorpse(nameDeath)
local corpse = doCreateItem(corpseID, 1, pos) 

	if isSummon(cid) then
		checkDirias(cid, nameDeath)
    end	   
	  doItemSetAttribute(corpse, "pokeName", "fainted " .. nameDeath:lower())
      doDecayItem(corpse)
	  local name = getCreatureName(getCreatureMaster(cid))
	  doCorpseAddLoot(getCreatureName(target), corpse, getCreatureMaster(cid), target)
      doRemoveCreature(target)
	 
end 

return false
end

local stoneEffect = {
	  ["fire stone"] = 268,
	  ["water stone"] = 269,
	  ["leaf stone"] = 270,
	  ["heart stone"] = 271,
	  ["thunder stone"] = 272,
	  ["venom stone"] = 273,
	  ["enigma stone"] = 274,
	  ["rock stone"] = 275,
	  ["earth stone"] = 276,
	  ["ice stone"] = 277,
	  ["darkness stone"] = 278,
	  ["punch stone"] = 279,
	  ["coccon stone"] = 280,
	  ["metal stone"] = 281,
	  ["ancient stone"] = 282,
	  ["crystal stone"] = 283,
	  ["dragon scale"] = 284,
}

function doCorpseAddLoot(name, item, cid, target) -- essa func j‡∏£‡∏Å vai ajudar em um held, luck.
if cid == target then 
doItemSetAttribute(item, "corpseowner", "as√ßdlkas√ßldka√ßslkd√ßaskd√ßaslkd√ßlsakd√ßkasl√ß")
return true 
end -- selfdestruct
local lootList = getMonsterLootList(name)
local isStoneDroped = false
name = doCorrectString(name)
local pokeName = name
local str, vir = "Loot from " .. name .. ": ", 0
local megaID, megaName = "", ""
local lootListNow = {}
	if isMega(target) then
		  if name == "Charizard" then
			 megaID = getPlayerStorageValue(target, storages.isMegaID)
		  end
		megaName = "Mega " .. name .. (megaID ~= "" and " " .. megaID or "")
	    str = "Loot from " .. megaName .. ": "
	    pokeName = megaName
	    local t = {id = megasConf[megaName].itemToDrop, count = 1, chance = 0.1}
	     table.insert(lootList, t)
	end
    local countVirg = 0
	for i, _ in pairs(lootList) do
	    countVirg = countVirg + 1
	    local id, count, chance = lootList[i].id, lootList[i].count, lootList[i].chance * 2
		
		---- X-Lucky
		local heldx = getItemAttribute(getPlayerSlotItem(cid, 8).uid, "xHeldItem")
			if heldx then
			local heldName, heldTier = string.explode(heldx, "|")[1], string.explode(heldx, "|")[2]
				  if heldName == "X-Lucky" then -- dar mais loot
					 chance = chance * heldLucky[tonumber(heldTier)]
				  end
			end
		---- X-Lucky
		
		
		local percent, lootCount = math.random(0.1, 100.9), math.random(1, count)
		if (percent <= chance) then
			if isStone(id) then
			   isStoneDroped = true
			   local posCorpse = getThingPos(item)
				     posCorpse.x = posCorpse.x +1
			   doSendMagicEffect(posCorpse, stoneEffect[getItemNameById(id):lower()])
			   posCorpse.y = posCorpse.y +1
			   addEvent(doSendMagicEffect, 2000, posCorpse, 285)
			end
		     doAddContainerItem(item, id, lootCount)
			 table.insert(lootListNow, getItemNameById(id) .. " (" .. lootCount .. ")")
		end
	end
	
	for i = 1, #lootListNow do
		str = str .. lootListNow[i] .. (tonumber(i) == tonumber(#lootListNow) and "." or ", ")
	end
	if getExpByMoreDano(target) == true then
		return true
	end
	local players = string.explode(getExpByMoreDano(target), "|")
	local xp, newXP = getPokemonExperienceD(name), xp
	local maiorPercent = 0
	local playerWinner = ""
			if players ~= nil then
				for i = 1, #players do
				local name = string.explode(players[i], "/")[1]
				local percent = tonumber(string.explode(players[i], "/")[2])
					  if percent > maiorPercent then
					     playerWinner = name
						 maiorPercent = percent
					  end
					  if #players == 1 then -- caso so um player matou o bixo
					     percent = 100
					  end
					  local heldExp = 1
					  local player = getPlayerByName(name)
							local heldx = getItemAttribute(getPlayerSlotItem(player, 8).uid, "xHeldItem")
							if heldx then
							local heldName, heldTier = string.explode(heldx, "|")[1], string.explode(heldx, "|")[2]
								  if heldName == "X-Experience" then -- dar mais experiencia
									 heldExp = heldExperience[tonumber(heldTier)]
								  end
							end
					  playerAddExp(player,  math.ceil(percent * xp / 100) * heldExp)
				end
			end
		  local pWinnerLoot = getPlayerByName(playerWinner)	
		  if isCreature(pWinnerLoot) then
		     doItemSetAttribute(item, "corpseowner", playerWinner)
			 local loot =  str .. (str == "Loot from ".. name .. ": " and "Nothing." or "")
		     doPlayerSendTextMessage(pWinnerLoot, MESSAGE_INFO_DESCR, loot)
			 doSendMsgInParty(cid, loot)
			 if isStoneDroped then
			    doSendMagicEffect(getThingPos(pWinnerLoot), 173, pWinnerLoot)
				doSendMsg(pWinnerLoot, "ParabÈns! O pokemon " .. pokeName .. " dropou uma stone!!!")
				--- adicionar efeito em cima do loot
			 end
		  end
end


function playerAddExp(cid, exp)
if not isCreature(cid) then return true end
	if isInPartyAndSharedExperience(cid) then
		local partyPlayers = getPartyMembers(getPlayerParty(cid))
		local partyExp = math.ceil(exp / #partyPlayers)
			  for i = 1, #partyPlayers do
				 if isPlayer(partyPlayers[i]) then
				    doPlayerAddExp(partyPlayers[i], partyExp * 30)
				    doSendAnimatedText(getThingPos(partyPlayers[i]), partyExp * 30, 215)
				 end
			  end
		return true
	end
	doPlayerAddExp(cid, exp * 30)
	doSendAnimatedText(getThingPos(cid), exp * 30, 215)
end

function doSendMsgInParty(cid, loot)
	if isInPartyAndSharedExperience(cid) then
		local partyPlayers = getPartyMembers(getPlayerParty(cid))
			  for i = 1, #partyPlayers do
				 if isPlayer(partyPlayers[i]) then
					doSendMsgToPartyChannel(partyPlayers[i], loot)
				 end
			  end
		return true
	end
end

function checkDirias(cid, nameDeath)

	    local master = getCreatureMaster(cid)
		local getNpcTaskName = getPlayerStorageValue(master, storages.miniQuests.storNpcTaskName)
		local pokeTask1 = getPlayerStorageValue(master, storages.miniQuests.storPokeNameTask1)
		local pokeCountTask1 = tonumber(getPlayerStorageValue(master, storages.miniQuests.storPokeCountTask1))
		
	   if pokeTask1 ~= -1 and pokeTask1 == nameDeath then
		  setPlayerStorageValue(master, storages.miniQuests.storPokeCountTask1, pokeCountTask1 -1) 
		  local getCountNow = tonumber(getPlayerStorageValue(master, storages.miniQuests.storPokeCountTask1))
		  if getCountNow >= 1 then
		     doSendMsg(master, getNpcTaskName .. ": Faltam " .. getCountNow .. " " .. nameDeath .. (getCountNow > 1 and "s" or "") .. ".")
		  else
		     doSendMsg(master, getNpcTaskName .. ": VocÍ j· concluiu minha task venha pegar sua recompensa.")
		  end
	   end
	   
	    local getNpcTaskName2 = getPlayerStorageValue(master, storages.miniQuests.storNpcTaskName2)
		local pokeTask2 = getPlayerStorageValue(master, storages.miniQuests.storPokeNameTask2)
		local pokeCountTask2 = tonumber(getPlayerStorageValue(master, storages.miniQuests.storPokeCountTask2))
		
	   if pokeTask2 ~= -1 and pokeTask2 == nameDeath then
		  setPlayerStorageValue(master, storages.miniQuests.storPokeCountTask2, pokeCountTask2 -1) 
		  local getCountNow2 = tonumber(getPlayerStorageValue(master, storages.miniQuests.storPokeCountTask2))
		  if getCountNow2 >= 1 then
		     doSendMsg(master, getNpcTaskName2 .. ": Faltam " .. getCountNow2 .. " " .. nameDeath .. (getCountNow2 > 1 and "s" or "") .. ".")
		  else
		     doSendMsg(master, getNpcTaskName2 .. ": VocÍ j· concluiu minha task venha pegar sua recompensa.")
		  end
	   end
	   
	   local getNpcTaskName3 = getPlayerStorageValue(master, storages.miniQuests.storNpcTaskName3)
	   local pokeTask3 = getPlayerStorageValue(master, storages.miniQuests.storPokeNameTask3)
	   local pokeCountTask3 = tonumber(getPlayerStorageValue(master, storages.miniQuests.storPokeCountTask3))
		
	   if pokeTask3 ~= -1 and pokeTask3 == nameDeath then
		  setPlayerStorageValue(master, storages.miniQuests.storPokeCountTask3, pokeCountTask3 -1) 
		  local getCountNow3 = tonumber(getPlayerStorageValue(master, storages.miniQuests.storPokeCountTask3))
		  if getCountNow3 >= 1 then
		     doSendMsg(master, getNpcTaskName3 .. ": Faltam " .. getCountNow3 .. " " .. nameDeath .. (getCountNow3 > 1 and "s" or "") .. ".")
		  else
		     doSendMsg(master, getNpcTaskName3 .. ": VocÍ j· concluiu minha task venha pegar sua recompensa.")
		  end
	   end
	   
	   local getNpcTaskName4 = getPlayerStorageValue(master, storages.miniQuests.storNpcTaskName4)
	   local pokeTask4 = getPlayerStorageValue(master, storages.miniQuests.storPokeNameTask4)
	   local pokeCountTask4 = tonumber(getPlayerStorageValue(master, storages.miniQuests.storPokeCountTask4))
		
	   if pokeTask4 ~= -1 and pokeTask4 == nameDeath then
		  setPlayerStorageValue(master, storages.miniQuests.storPokeCountTask4, pokeCountTask4 -1) 
		  local getCountNow4 = tonumber(getPlayerStorageValue(master, storages.miniQuests.storPokeCountTask4))
		  if getCountNow4 >= 1 then
		     doSendMsg(master, getNpcTaskName4 .. ": Faltam " .. getCountNow4 .. " " .. nameDeath .. (getCountNow4 > 1 and "s" or "") .. ".")
		  else
		     doSendMsg(master, getNpcTaskName4 .. ": VocÍ j· concluiu minha task venha pegar sua recompensa.")
		  end
	   end
end