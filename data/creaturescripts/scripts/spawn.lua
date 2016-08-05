local shinysName = {
"Blastoise", "Venusaur", "Butterfree", "Beedrill", "Pidgeot", "Rattata", "Raticate", "Raichu", "Golbat", "Paras", "Parasect", "Magmar", "Typhlosion", "Xatu", "Growlithe", "Arcanine", "Tentacruel", "Gengar", "Krabby", "Tauros", 
"Kingler", "Cubone", "Horsea", "Seadra", "Weezing", "Scyther", "Pinsir", "Crobat", "Zubat", "Tentacool", "Feraligatr", "Machamp", "Meganium", "Alakazam", "Tangela", "Ampharos", "Electabuzz", "Jynx", "Charizard", "Voltorb", "Electrode"}

function onSpawn(cid)
	if getCreatureName(cid) == "" or getCreatureName(cid) == nil then
	   setPlayerStorageValue(cid, 510, getCreatureNick(cid))
	end
	
	
	
	--if isTwoGerenetion(doCorrectString(getCreatureName(cid))) then doRemoveCreature(cid) return false end
	registerCreatureEvent(cid, "GeneralConfiguration")
	registerCreatureEvent(cid, "WildAttack")
	registerCreatureEvent(cid, "Experience")
	registerCreatureEvent(cid, "Matou")
	registerCreatureEvent(cid, "PokeWalk")
	registerCreatureEvent(cid, "StatsChange")
	
	if not ehMonstro(cid) then
		registerCreatureEvent(cid, "Target")
		registerCreatureEvent(cid, "Matou")
		registerCreatureEvent(cid, "SummonDeath")
		getPokeDistanceToTeleport(cid)
		setPokemonGhost(cid)
		if getCreatureName(cid):find("Shiny ") then
		   setPlayerStorageValue(cid, storages.EhShiny, 1)
		end
	return true
	end
	
	addEvent(doShiny, 5, cid)
	addEvent(adjustWildPoke, 5, cid)
	setPokemonGhost(cid)
	doMarkedPos(cid, getThingPos(cid))
	
	   if isPokePassive(cid) then
	      setPokemonPassive(cid, true)
	   end

return true
end



function doShiny(cid)
	if isCreature(cid) then
		   if isSummon(cid) then return true end
		   if isNpcSummon(cid) then return true end
		    local chance = 0
			if isInArray(shinysName, doCorrectString(getCreatureName(cid))) then  --alterado v1.9 \/
			   chance = 40    --1% chance  
			end    
			local sid = cid
			if math.random(1, 500) <= chance then  
			  doSendMagicEffect(getThingPos(cid), 18)               
			  local name, pos = "Shiny ".. getCreatureName(cid), getThingPos(cid)
			  if not pokes[name] then return true end
			  doRemoveCreature(cid)
			  --print(name .. ", " .. retireShinyName(name))
			  local shi = doCreateMonsterNick(sid, name, retireShinyName(name), pos, false)		  
		   end  
	else 
															   
	return true
	end
end