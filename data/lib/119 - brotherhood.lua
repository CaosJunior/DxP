brotherhoodConf = {
	["Saffron"] = { storage = 20020,
			["Easy"] = {
				    posis = {
					    [1] = {1068, 961, 7, desc = "Esta proximo a alguma caverna de pokemons de earth."},
					    }
                                   },
			["Medio"] = {
				    posis = {
					    [1] = {1110, 923, 7, desc = "Esta em algum lugar ao nordeste daqui."},
					    }
                                   },
			["Hard"] = {
				    posis = {
					    [1] = {914, 964, 7, desc = "Esta em algum lugar ao noroeste daqui."},
					    }
                                   },
			["Expert"] = {
				    posis = {
					    [1] = {1011, 1066, 7, desc = "Esta em algum lugar ao sul daqui."},
					    }
                                   },
			["Lendario"] = {
				    posis = {
					    [1] = {1011, 1066, 7, desc = "Esta em algum lugar ao sul daqui."},
					    }
                                   },
		      },
	
}

function doSpawnNPCsBrotherHood()
	local dif = {"Easy", "Medio", "Hard", "Expert", "Lendario"}
	setGlobalStorageValue(20019, -1) --resetar sistema ao ligar servidor
	for a, b in pairs(brotherhoodConf) do
	   setGlobalStorageValue(b.storage, "easy-1/medio-1/hard-1/expert-1/")
	   for i = 1, #dif do
		local randomPosIndex = 1 --math.random(1, 1)	
		local pos = b[dif[i]].posis[randomPosIndex]
		local npcDescPos = pos.desc
	        local npc = doSummonWildNpcInMap({x = pos[1], y = pos[2], z = pos[3]}, dif[i], npcDescPos, a)
		globalNpcsAdd(npc)
	   end
	end    
end

function getNPCDescByCity(cityName, nivel)
    local ret = nil
    local npcsList = getGlobalNpcList()
    for i = 1, #npcsList do
	local npc = npcsList[i]
	if isCreature(npc) and getNPCNivel(npc) == nivel then
	   ret = getNPCDescriptionPos(npc)
	   break
	end
    end
   return ret
end

function globalNpcsAdd(npc)
   if getGlobalStorageValue(20019) == -1 then
      setGlobalStorageValue(20019, "/")
   end
   local list = getGlobalNpcList()
   local newList = "/"
	for i = 1, #list do
	    local npcs = list[i]
	    if isCreature(npc) then	
		newList = newList .. "" .. npcs .. "/"
	    end
	end
   newList = newList .. npc .. "/"   	
   setGlobalStorageValue(20019, "")		
   setGlobalStorageValue(20019, newList)
end

function getGlobalNpcList()
   if getGlobalStorageValue(20019) == -1 then
      return {}
   else
      return getGlobalStorageValue(20019):explode("/")
   end	
end

function isBrotherHoodMember(cid)
   return getPlayerStorageValue(cid, storages.BrotherHoodMember) == -1 and false or true
end

function getPlayerRankNivel(cid)
   return getPlayerStorageValue(cid, storages.BrotherHoodMemberRANK) 
end

function doSummonNpcInCity(city, nivel)
local randomPosIndex = 1 --math.random(1, 1)	
local pos = brotherhoodConf[city][nivel].posis[randomPosIndex]
local npcDescPos = pos.desc
local npc = doSummonWildNpcInMap({x = pos[1], y = pos[2], z = pos[3]}, nivel, npcDescPos, city)
      globalNpcsAdd(npc)
end

function doPlayerAddPrizesBrotherhood(cid)
	local token = 15644
	local conf = {
		["Easy"] = {8000, 1},
		["Medio"] = {20000, 3},
		["Hard"] = {75000, 5},
		["Expert"] = {80000, 6},
		["Lendario"] = {100000, 7},
	}	
	doPlayerAddExp(cid, conf[getPlayerRankNivel(cid)][1])
	doSendAnimatedText(getThingPos(cid), conf[getPlayerRankNivel(cid)][1], 215)
	doPlayerAddItem(cid, token, conf[getPlayerRankNivel(cid)][2])
end

local helds = {
	["X-Attack"] = {t1 = 15559, t2 = 15560, t3 = 15561, t4 = 15562, t5 = 15563, t6 = 15564, t7 = 15565},	
	["X-Block"] = {t1 = 15566, t2 = 15567, t3 = 15568, t4 = 15569, t5 = 15570, t6 = 15571, t7 = 15572},
	["X-Boost"] = {t1 = 15573, t2 = 15574, t3 = 15575, t4 = 15576, t5 = 15577, t6 = 15578, t7 = 15579}, 
	["X-Critical"] = {t1 = 15580, t2 = 15581, t3 = 15582, t4 = 15583, t5 = 15584, t6 = 15585, t7 = 15586}, 
	["X-Defense"] = {t1 = 15587, t2 = 15588, t3 = 15589, t4 = 15590, t5 = 15591, t6 = 15592, t7 = 15593}, 
	["X-Experience"] = {t1 = 15594, t2 = 15595, t3 = 15596, t4 = 15597, t5 = 15598, t6 = 15599, t7 = 15600}, 
	["X-Hellfire"] = {t1 = 15601, t2 = 15602, t3 = 15603, t4 = 15604, t5 = 15605, t6 = 15606, t7 = 15607}, 
	["X-Haste"] = {t1 = 15608, t2 = 15609, t3 = 15610, t4 = 15611, t5 = 15612, t6 = 15613, t7 = 15614}, 
	["X-Lucky"] = {t1 = 15615, t2 = 15616, t3 = 15617, t4 = 15618, t5 = 15619, t6 = 15620, t7 = 15621}, 
	["X-Poison"] = {t1 = 15622, t2 = 15623, t3 = 15624, t4 = 15625, t5 = 15626, t6 = 15627, t7 = 15628}, 
	["X-Return"] = {t1 = 15629, t2 = 15630, t3 = 15631, t4 = 15632, t5 = 15633, t6 = 15634, t7 = 15635}, 
	["X-Vitality"] = {t1 = 15636, t2 = 15637, t3 = 15638, t4 = 15639, t5 = 15640, t6 = 15641, t7 = 15642},
	["Y-Ghost"] = {id = 15643, megaID = "", pokeName = "none"},
}
local heldsName = {"Y-Ghost", "X-Vitality", "X-Return", "X-Attack", "X-Block", "X-Boost", "X-Critical", "X-Defense", "X-Experience", "X-Hellfire", "X-Haste", "X-Lucky", "X-Poison"}
function doPlayerAddRandomHeld(cid, tier)
   local heldT = helds[heldsName[math.random(1, #heldsName)]]
   local held = heldT.t1
	if held then
		if tier == 2 then
		   held = heldT.t2 
		elseif tier == 3 then
		   held = heldT.t3 
		elseif tier == 4 then
		   held = heldT.t4 
		elseif tier == 5 then
		   held = heldT.t5 
		elseif tier == 6 then
		   held = heldT.t6 
		elseif tier == 7 then
		   held = heldT.t7 
		end
	else 
	    	held = heldT.id
	end
	doPlayerAddItem(cid, held, 1)
end

function doPlayerAddRandomHeldQuest(cid)
   local newTable = heldsName
   local index = math.random(1, #heldsName)
   local heldT = helds[heldsName[index]]
   table.remove(newTable, index)
   local index2 = math.random(1, #newTable)
   local heldT2 = helds[newTable[index2]]

   local held = heldT.t7
   local held2 = heldT2.t7
	if not held then
	    held = heldT.id
	end
	if not held2 then
	    held2 = heldT2.id
	end
	doPlayerAddItem(cid, held, 1)
	doPlayerAddItem(cid, held2, 1)
	doSendMagicEffect(getThingPos(cid), 28)
end
