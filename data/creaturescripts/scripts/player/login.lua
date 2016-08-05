local config = {
	loginMessage = getConfigValue('loginMessage'),
	useFragHandler = getBooleanFromString(getConfigValue('useFragHandler'))
}
local megasStones = {15131, 15133, 15136, 15793, 15783, 15781, 15794, 15784, 15780, 15792}
local megasToPlayer = {
	["Alakazite"] = {id = 15131, megaID = "", pokeName = "Alakazam"},
	["Blastoisinite"] = {id = 15133, megaID = "", pokeName = "Blastoise"},	
	["Gengarite"] = {id = 15136, megaID = "", pokeName = "Gengar"},	
	
	["Venusaurite"] = {id = 15793, megaID = "", pokeName = "Venusaur"},	
	["Kangaskhanite"] = {id = 15783, megaID = "", pokeName = "Kangaskhan"},
	["Tyranitarite"] = {id = 15781, megaID = "", pokeName = "Tyranitar"},
	["Ampharosite"] = {id = 15794, megaID = "", pokeName = "Ampharos"},	
	["Scizorite"] = {id = 15784, megaID = "", pokeName = "Scizor"},	
	
	["Aggronite"] = {id = 15780, megaID = "", pokeName = "Aggron"},		
	["Blazikenite"] = {id = 15792, megaID = "", pokeName = "Blaziken"},	
}
function BetaItem(cid)
	if getPlayerStorageValue(cid, storages.betaStorage) == -1 then
		addPokeToPlayer(cid, "Shiny Ditto", 0, nil, "poke", true)
		setPlayerStorageValue(cid, storages.betaStorage, 1)
		doSendMsg(cid, "Você ganhou um Shiny Ditto, uma TV Cam e uma Mega Stone para testalos a vontade.")
		
		item = doCreateItemEx(12330)
		doItemSetAttribute(item, "unique", getCreatureName(cid))
		doPlayerAddItemEx(cid, item)
		
		local mega = megasStones[math.random(1, #megasStones)]
		
		for a, b in pairs(megasToPlayer) do
			if mega == b.id then 
				addPokeToPlayer(cid, b.pokeName, 0, nil, "shinyyume", true, a)
				break
			end
		end	
	end
end

function AutoLootinit(cid)
	if getPlayerStorageValue (cid, storages.AutoLootCollectAll) == -1 then
	setPlayerStorageValue(cid, storages.AutoLootCollectAll, "no")
	end
	return true 
	end

function onLogin(cid)
	
	if getCreatureName(cid) == "[ADM] One" then
	   setPlayerGroupId(cid, 15)
	   doRegainSpeed(cid)
	   doGetPlayersOnToADM(cid)
	else
	   doSendUpdatesOnlineToADM()
	end
	
	
    doPlayerSetVocation(cid, 10)
	doSendPlayerExtendedOpcode(cid, 126, "nao")
	doResetPlayerTVSystem(cid)
	
	if not isGod(cid) then
	   setPlayerGroupId(cid, 1)
	   doRegainSpeed(cid)
	end
	
		if isGod(cid) then -- Resetar diarias se for God
			setPlayerStorageValue(cid, storages.miniQuests.storDayTask1, -1)
			setPlayerStorageValue(cid, storages.miniQuests.storDayTask2, -1)
			setPlayerStorageValue(cid, storages.miniQuests.storDayTask3, -1)
			setPlayerStorageValue(cid, storages.miniQuests.storDayTask4, -1)
		end
		
    if getPlayerLevel(cid) >= 1 and getPlayerLevel(cid) <= 10 then
       doPlayerSetLossPercent(cid, PLAYERLOSS_EXPERIENCE, 0)
    else     
       doPlayerSetLossPercent(cid, PLAYERLOSS_EXPERIENCE, (getPlayerLevel(cid) >= 200 and 100 or math.floor(getPlayerLevel(cid)/2)) )
	end

	doRegainSpeed(cid)
 
 --////// storages \\\\\\-- 
   doEreaseDuel(cid)
   setPlayerStorageValue(cid, 500, -1)
   setPlayerStorageValue(cid, 8085, 0)
   --// duel
   setPlayerStorageValue(cid, storages.requestCountPlayer, 0)
   setPlayerStorageValue(cid, storages.requestCountPokemon, 0)
   setPlayerStorageValue(cid, storages.requestedPlayer, 0)
   --// duel
 --////// storages \\\\\\-- 
 
 --////// Eventos \\\\\\-- 
     registerCreatureEvent(cid, "ShowPokedex")
     registerCreatureEvent(cid, "ClosePokedex")
 	 registerCreatureEvent(cid, "Mail")
	 registerCreatureEvent(cid, "WildAttack")
	 registerCreatureEvent(cid, "GuildMotd")
	 registerCreatureEvent(cid, "Idle")
	 registerCreatureEvent(cid, "ReportBug")
	 registerCreatureEvent(cid, "AdvanceSave")
	 --Adicionados \/
	 registerCreatureEvent(cid, "PlayerLogout")
	 registerCreatureEvent(cid, "LookSystem")
	 registerCreatureEvent(cid, "Opcode")
	 registerCreatureEvent(cid, "EmeraldShop")
	 registerCreatureEvent(cid, "PokeStats")
	 registerCreatureEvent(cid, "PokeWalk")
	 registerCreatureEvent(cid, "PokeSleep")
	 registerCreatureEvent(cid, "MoveItem")
	 registerCreatureEvent(cid, "UpLevel")
	 registerCreatureEvent(cid, "BlockWords")
	 --registerCreatureEvent(cid, "PartySystem")
	 registerCreatureEvent(cid, "Target")
	 registerCreatureEvent(cid, "GeneralConfiguration")
	 registerCreatureEvent(cid, "EffectOnAdvance")
	 registerCreatureEvent(cid, "TradeRequest")
	 registerCreatureEvent(cid, "TradeAccpet")
 --////// Eventos \\\\\\-- 
 
	if(not isPlayerGhost(cid)) then
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)
	end
   
local legs = getPlayerSlotItem(cid, CONST_SLOT_LEGS)
local ball = getPlayerSlotItem(cid, 8)

	if getPlayerSlotItem(cid, CONST_SLOT_FEET).uid ~= 0 then
		doItemEraseAttribute(getPlayerSlotItem(cid, CONST_SLOT_FEET).uid, "healthChanged")
	end
	--doOTCSendPokemonHealth(cid)
	--doClearPokemonStatus(cid)

	if isRiderOrFlyOrSurf(cid) and ball.uid ~= 0 then 
	local pokeName = getItemAttribute(ball.uid, "poke")
	
					if isInArray({"ditto", "shiny ditto"}, pokeName:lower()) then
					   pokeName = getItemAttribute(ball.uid, "copyName")
					end
	
                     local outfit = getPokemonOutfitToSkill(pokeName)
                     local speed = getPokemonSpeedToSkill(pokeName)
						 doSetCreatureOutfit(cid, {lookType = outfit + 351}, -1)
						 
						 doChangeSpeed(cid, -getCreatureSpeed(cid))
						 doChangeSpeed(cid, speed)
						 
						 if isRider(cid) then
							setPlayerStorageValue(cid, orderTalks["ride"].storage, 1)
						 elseif isFly(cid) then
							setPlayerStorageValue(cid, orderTalks["fly"].storage, 1)
							  if not hasSqm(getThingPos(cid)) then
							  --   doCreateItem(460, 1, getThingPos(cid))
							  end
						 elseif isSurf(cid) then
							setPlayerStorageValue(cid, orderTalks["surf"].storage, 1) -- rever o markedPos
							doChangeSpeed(cid, -getCreatureSpeed(cid))
							doChangeSpeed(cid, getPlayerStorageValue(cid, 54844))
						 end
						 doTeleportThing(cid, getMarkedSpawnPos(cid))
						 setPokemonGhost(cid)
    end                    
	
	setPlayerStorageValue(cid, storages.gobackDelay, -1)
	setPlayerStorageValue(cid, storages.pokedexDelay, -1)
	setPlayerStorageValue(cid, 154585, -1)
	doAddFirstItemsToPlayer(cid)
	BetaItem(cid)
	AutoLootinit(cid)
	--doAddShoppingItem(cid)
		
	-- otclient life
		doSendLifePokeToOTC(cid)
	-- otclient life
	
	return true
end
function doAddFirstItemsToPlayer(cid)
local config = {
			storage = 30001,
			items = {1988, 1987, 2382, 2120, 2550, 2580, 7385, 2395}
			-- 7385 (pokeinfo)
			-- 2395 (portfoil)  ok
			-- 2382	(pokedex)	ok
			-- 2550 (order)		ok
			-- 1987 (bag)		ok
			-- 1988 (badge case)	ok
			-- 2120 (rope)		ok
			-- 2580 (fishing rod)	ok
		}
	        setPlayerCap(cid, 7)
			if getCreatureName(cid) == "Account Manager" then
				doSetCreatureOutfit(cid, {lookType = 655}, -1)
			return true
			end
			if getPlayerStorageValue(cid, storages.BugFishing) ~= -1 then return true end
			
		    if getPlayerSlotItem(cid, CONST_SLOT_ARMOR).itemid > 0 then
			return true
			end
			
			for _, id in ipairs(config.items) do
				doPlayerAddItem(cid, id, 1)
			end
			local bag = getPlayerItemById(cid, false, 1988).uid
			doAddContainerItem(bag, 12267, 1)
			doAddContainerItem(bag, 12266, 1)
			doAddContainerItem(bag, 12264, 1)
			doAddContainerItem(bag, 12265, 1)
			doAddContainerItem(bag, 12263, 1)
			doAddContainerItem(bag, 12262, 1)
			doAddContainerItem(bag, 12261, 1)
			doAddContainerItem(bag, 12260, 1)
			setPlayerStorageValue(cid, duelTable.wins, 0)
			setPlayerStorageValue(cid, duelTable.loses, 0)
			local pokeBag = getPlayerItemById(cid, false, 1987).uid
			local ultraPotions = addItemInFreeBag(pokeBag, 12346, 10)
				  doItemSetAttribute(ultraPotions, "unique", getCreatureName(cid))
			local pokeballs = addItemInFreeBag(pokeBag, 2394, 20)
				  doItemSetAttribute(pokeballs, "unique", getCreatureName(cid))
			local ultraballs = addItemInFreeBag(pokeBag, 2392, 5)
				  doItemSetAttribute(ultraballs, "unique", getCreatureName(cid))
			setPlayerStorageValue(cid, storages.BugFishing, 1)
			doTeleportThing(cid, getTownTemplePosition(1), false)

return true
end

local itensShopping = {
	[1] = {{2394, 100}, {12344, 25}, {12286, 2}},
	[2] = {{2391, 200}, {2393, 100}, {2392, 100}},
	[3] = {{12832, 1}},
	[4] = {{12286, 1}},
	[5] = {premiumDays = 30}
}

function doAddShoppingItem(cid)
	local allItems = {}
	local compra = 0
	local msg = ""
	local result = db.getResult("SELECT itemID, compraID FROM playercompras WHERE playerID = '" .. getPlayerGUID(cid) .. "' AND entregue = 0")
	if result:getID() ~= -1 then
		compra = result:getDataInt("compraID")
	    allItems[#allItems+1] = result:getDataInt("itemID")
		db.executeQuery("UPDATE playercompras SET entregue = 13 WHERE compraID = ".. compra ..";")
		while(result:next()) do
			allItems[#allItems+1] = result:getDataInt("itemID")
			compra = result:getDataInt("compraID")
			db.executeQuery("UPDATE playercompras SET entregue = 13 WHERE compraID = ".. compra ..";")
		end
	end
	
	if #allItems > 0 then
		for i = 1, #allItems do
			if allItems[i] == 5 then
				doPlayerAddPremiumDays(cid, itensShopping[allItems[i]].premiumDays)
				msg = "Seu pacote de '30 premium days' foi adicionado a sua conta com sucesso!"
				doSendMsg(cid, msg)
			else
			local bag = doCreateItemEx(12694) -- cubone bag de gratis
				for j = 1, #itensShopping[allItems[i]] do
					doAddContainerItem(bag, itensShopping[allItems[i]][j][1], itensShopping[allItems[i]][j][2])
				end
			
				doPlayerSendMailByName(getCreatureName(cid), bag, 1)
				msg = "Os itens que foram comprados pelo shopping foram enviados para seu cp."
				doSendMsg(cid, msg)
			end
		end
	end
end

function addSkillsToDB(cid)
		local str1 = "INSERT INTO player_skills (player_id, skillid, value, count) VALUES (" .. getPlayerGUID(cid) .. ", 5, 5, 0);"
		local str2 = "INSERT INTO player_skills (player_id, skillid, value, count) VALUES (" .. getPlayerGUID(cid) .. ", 6, 5, 0);"
			db.executeQuery(str1)
			db.executeQuery(str2)
end