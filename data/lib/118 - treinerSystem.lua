local outfits = {
	[1] = {{495, 524}, lOut = 1674, names = {"Beatriz", "Julia", "Joana", "Laura", "Ana", "Sofia", "Isabela", "Camila", "Larissa", "Alice"}}, -- femea
	[2] = {{494, 522}, lOut = 1673, names = {"Miguel", "Enzo", "Gitzo", "Gustos", "Arthor", "Davison", "Ednizo", "Samzo", "Liraks", "Horth"}}, -- macho
}
local niveis = {
	["Easy"] = {table = diarias.Hard, habilitiesRange = {15, 20}, lifeMult = 5},
	["Medio"] = {table = diarias.Hard, habilitiesRange = {21, 25}, lifeMult = 7},
	["Hard"] = {table = diarias.Hard, habilitiesRange = {26, 28}, lifeMult = 8},
	["Expert"] = {table = diarias.Expert, habilitiesRange = {29, 32}, lifeMult = 10},
	["Lendario"] = {table = diarias.Lendario, habilitiesRange = {40, 45}, lifeMult = 15},
}

-- sexo e o nome do loot
function doSummonWildNpcInMap(pos, nivel, desc, city)
	local sex = math.random(1, 2)
	local npcName = sex == 1 and "Testef" or "Teste"
	local apelido = outfits[sex].names[math.random(1, #outfits[sex].names)]
	local wildNPC = doCreateMonsterNick(121212, npcName, apelido, pos, false)
	      if wildNPC ~= "Nao" then	
		 local out = outfits[sex][1][math.random(1, #outfits[sex][1])]
			if nivel == "Lendario" then
			   out = outfits[sex].lOut
			end 
		 doSetCreatureOutfit(wildNPC, {lookType = out}, -1)
		 setCreatureTargetDistance(wildNPC, 4) 
		 setPlayerStorageValue(wildNPC, storages.isWildTrainer, 1)
	         setPlayerStorageValue(wildNPC, storages.NPCPokeCounts, 7)
		 setPlayerStorageValue(wildNPC, storages.NPCNameWILD, apelido)
		 setPlayerStorageValue(wildNPC, storages.NPCNIVEL, nivel)
		 setPlayerStorageValue(wildNPC, storages.NPCPOSDESC, desc)
		 setPlayerStorageValue(wildNPC, storages.NPCCITY, city)
		 doSetWildNPCPokemons(wildNPC)
		 doSummonNextPokemon(wildNPC)
		 setPokemonPassive(wildNPC, true)
	      end 
   return wildNPC	
end

function doSetWildNPCPokemons(npc)
	local pokes = ""
	local nivel = getNPCNivel(npc)
	local dificultPokes = niveis[nivel].table
	for i = 1, 6 do
	    pokes = pokes .. "n-" .. dificultPokes[math.random(1, #dificultPokes)] .. "/"
	end
	setPlayerStorageValue(npc, storages.wildTrainerPokemons, pokes)
end

function doSummonNextPokemon(npc)
	if not isCreature(npc) then return true end
	setPlayerStorageValue(npc, storages.NPCPokeCounts, getPlayerStorageValue(npc, storages.NPCPokeCounts) -1)
	if tonumber(getNPCPokeCounts(npc)) < 1 then
	   return true
	end
	
	local nivel = getNPCNivel(npc)
	local pokes = getPlayerStorageValue(npc, storages.wildTrainerPokemons):explode("/")
	local newListPokes = ""
	local pokeToSummon = ""
	for i = 1, 6 do
	   if pokes[i]:explode("-")[1] == "n" and pokeToSummon == "" then
	      pokeToSummon = pokes[i]:explode("-")[2]
	      newListPokes = newListPokes .. "s-" .. pokes[i]:explode("-")[2] .. "/"	
	   else
	      newListPokes = newListPokes .. pokes[i]:explode("-")[1] .. "-" .. pokes[i]:explode("-")[2] .. "/"
	   end	
	end
	
	local npcPoke = doCreateMonsterNick(npc, pokeToSummon, pokeToSummon, getThingPos(npc), false)
	local habilities = math.random(niveis[nivel].habilitiesRange[1], niveis[nivel].habilitiesRange[2])
	if getCreatureTarget(npc) >= 1 then
	   local master = not isPlayer(getCreatureTarget(npc)) and getCreatureMaster(getCreatureTarget(npc)) or getCreatureTarget(npc)
	   doSetPokemonAgressiveToPlayer(npcPoke, master)
	else 
	   setPokemonPassive(npcPoke, true)
	end
	addEvent(doRaiseHabilities, 5, npcPoke, habilities, niveis[nivel].lifeMult)

	doSendMagicEffect(getThingPos(npcPoke), 188)
	doCreatureSay(npc, "" .. pokeToSummon .. ", sua vez!", TALKTYPE_ORANGE_1)
	setPlayerStorageValue(npcPoke, storages.isWildTrainerPoke, 1)
	setPlayerStorageValue(npcPoke, storages.isWildTrainerID, npc)
	
	setPlayerStorageValue(npc, storages.wildTrainerPokemons, newListPokes)
	setPlayerStorageValue(npc, storages.WILDNPCMYSUMMON, npcPoke)
end

function canKillNPC(cid, npc)
   local ret = true
   if getNPCPokeCounts(npc) > 0 then
      ret = false
   end	
   return ret
end

function getNPCPokeCounts(npc)
  return getPlayerStorageValue(npc, storages.NPCPokeCounts)
end

function getNPCNivel(npc)
  return getPlayerStorageValue(npc, storages.NPCNIVEL)
end

function getNPCDescriptionPos(npc)
  return getPlayerStorageValue(npc, storages.NPCPOSDESC)
end

function getNpcCity(npc)
  return getPlayerStorageValue(npc, storages.NPCCITY)
end

function getMasterWildNPCPokemon(npc)
return getPlayerStorageValue(npc, storages.isWildTrainerID)
end

function getWildNPCPokemon(npc)
return getPlayerStorageValue(npc, storages.WILDNPCMYSUMMON)
end

function isWildTrainerNPC(npc) 
   if not isCreature(npc) then return false end
   return getPlayerStorageValue(npc, storages.isWildTrainer) == 1 and true or false
end

function isWildTrainerPokemon(npc)
   if not isCreature(npc) then return false end
   return getPlayerStorageValue(npc, storages.isWildTrainerPoke) == 1 and true or false
end
