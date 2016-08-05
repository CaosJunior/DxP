local fishing = {
[-1] = { segs = 5, pokes = {{"Magikarp", 5}} },

[3976] = { segs = 5, pokes = {{"Horsea", 5}, {"Remoraid", 3}, {"Goldeen", 3}, {"Poliwag", 2}} },  -- pega no client da pxg

[12855] = { segs = 5, pokes = {{"Tentacool", 3}, {"Staryu", 2}, {"Krabby", 3}, {"Shellder", 2} } },

[12854] = { segs = 5, pokes = {{"Seel", 2}, {"Chinchou", 2} } },

[12858] = { segs = 5, pokes = {{"Seaking", 2}, {"Seadra", 2}, {"Poliwhirl", 2}} },

[12857] = { segs = 5, pokes = {{"Starmie", 2}, {"Kingler", 2}, {"Corsola", 2}, {"Qwilfish", 2}} },  -- pega no client da pxg

[12860] = { segs = 5, pokes = {{"Lanturn", 2}, {"Dewgong", 2}}},

[12859] = { segs = 5, pokes = {{"Cloyster", 2}, {"Poliwrath", 2}, {"Politoed", 2}, {"Octillery", 2}} },

[12856] = { segs = 5, pokes = {{"Dratini", 3}, {"Dragonair", 2} }},

[12853] = { segs = 5, pokes = {{"Gyarados", 1}, {"Mantine", 1}, {"Tentacruel", 1}, {"Kingdra", 1}} },
}

local storageP = 154585
local sto_iscas = 5648454 --muda aki pra sto q ta no script da isca
local bonus = 15
local limite = 100


local function doFish(cid, pos, ppos, interval)
      if not isCreature(cid) then return false end
      if getThingPos(cid).x ~= ppos.x or getThingPos(cid).y ~= ppos.y then
         return false 
      end
      
      doSendMagicEffect(pos, CONST_ME_LOSEENERGY)
      
      if interval > 0 then
         addEvent(doFish, 1000, cid, pos, ppos, interval-1)
         return true
      end   

      local peixe = 0
      local playerpos = getClosestFreeTile(cid, getThingPos(cid))
      local fishes = fishing[getPlayerStorageValue(cid, sto_iscas)]
      local random = {}   

      if getPlayerSkillLevel(cid, 6) < limite then 
         doPlayerAddSkillTry(cid, 6, bonus * 5)
      end
	  
	     --[[if math.random(1, 100) <= chance then
		if getPlayerSkillLevel(cid, 6) < limite then
		doPlayerAddSkillTry(cid, 6, bonus * 5)
		end]]
	  
      random = fishes.pokes[math.random(#fishes.pokes)]
	  
      for i = 1, math.random(random[2]) do
          peixe = doSummonCreature(random[1], playerpos)
          if not isCreature(peixe) then
             setPlayerStorageValue(cid, storageP, -1)
             doRemoveCondition(cid, CONDITION_OUTFIT)
             return true
          end
          setPokemonPassive(peixe, true)
		  doSetPokemonAgressiveToPlayer(peixe, cid)
		  setPlayerStorageValue(peixe, storageP, 1)
	      if #getCreatureSummons(cid) >= 1 then
             doSendMagicEffect(getThingPos(getCreatureSummons(cid)[1]), 0)
		     doChallengeCreature(getCreatureSummons(cid)[1], peixe)
          else	
             doSendMagicEffect(getThingPos(cid), 0)
		     doChallengeCreature(cid, peixe)
          end
       end
       setPlayerStorageValue(cid, storageP, -1)
       doRemoveCondition(cid, CONDITION_OUTFIT)
return true
end

local waters = {11756}

function onUse(cid, item, fromPos, itemEx, toPos)

if isWatchingTv(cid) then
return true
end

local checkPos = toPos
checkPos.stackpos = 0

if getTileThingByPos(checkPos).itemid <= 0 then
   return true
end

if not isInArray(waters, getTileInfo(toPos).itemid) then
   return true
end

if getPlayerStorageValue(cid, storageP) == 1 then 
	doSendMsg(cid, "Aguarde! Você já está pescando.")
	return true
end

if isRiderOrFlyOrSurf(cid) and not canFishWhileSurfingOrFlying then
   doPlayerSendCancel(cid, "You can't fish while surfing/flying.")
   return true
end

if getTileInfo(getThingPos(getCreatureSummons(cid)[1] or cid)).protection then
	doPlayerSendCancel(cid, "You can't fish pokémons if you or your pokémon is in protection zone.")
return true
end

local delay = fishing[getPlayerStorageValue(cid, sto_iscas)].segs

if getPlayerStorageValue(cid, sto_iscas) ~= -1 then
   if getPlayerItemCount(cid, getPlayerStorageValue(cid, sto_iscas)) >= 1 then
      doPlayerRemoveItem(cid, getPlayerStorageValue(cid, sto_iscas), 1)
   else
      setPlayerStorageValue(cid, sto_iscas, -1)
   end
end

local outfit = getCreatureOutfit(cid)
local out = getPlayerSex(cid) == 0 and 1467 or 1468

doSetCreatureOutfit(cid, {lookType = out, lookHead = outfit.lookHead, lookBody = outfit.lookBody, lookLegs = outfit.lookLegs, lookFeet = outfit.lookFeet}, -1)
setPlayerStorageValue(cid, storageP, 1)     --alterei looktype
doCreatureSetNoMove(cid, false)
local pos2 = getThingPos(itemEx.uid)
doCreatureSetLookDir(cid, getLookToFish(getThingPos(cid), pos2))  --alterado ver depois
doFish(cid, toPos, getThingPos(cid), math.random(5, delay))

return true
end

function getLookToFish(pos, pos2)
local x1, y1 = pos.x, pos.y
local x2, y2 = pos2.x, pos2.y

if x1-x2 <= 0 and  y1-y2 > 0 then
	return NORTH
elseif x1-x2 < 0 and  y1-y2 == 0 then
	return EAST
elseif x1-x2 < 0 and  y1-y2 < 0 then
	return EAST
elseif x1-x2 > 0 and  y1-y2 < 0 then
	return SOUTH
elseif x1-x2 > 0 and  y1-y2 <= 0 then
	return WEST
elseif x1-x2 > 0 and  y1-y2 >= 0 then
	return WEST
elseif x1-x2 < 0 and  y1-y2 < 0 then
	return EAST
elseif x1-x2 == 0 and  y1-y2 < 0 then
	return SOUTH
end
return WEST
end

--[[-- resulatados em linha reta(exatos)
if x1 == x2 then -- virar para norte
	if (y1 - y2) > 0 then -- virar para cima
	    return NORTH
	elseif (y1 - y2) < 0 then -- virar para baixo
		return SOUTH
	end
elseif y1 == y2 then
	if (x1 - x2) > 0 then -- virar para OESTE <<
	    return WEST
	elseif (x1 - x2) < 0 then -- virar para LESTE >>
		return EAST
	end
end
-- resulatados em linha reta(exatos)

if (x1 ~= x2) or (y1 ~= y2) then
	if (x1 - x2) < 0 then
	   return EAST -- virar para LESTE >>
	elseif (x1 - x2) > 0 then
	   return WEST
	end
end]]