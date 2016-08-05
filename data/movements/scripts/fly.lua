function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)

if isMonster(cid) and not isSummon(cid) then 
   if isInArray(WATER_BORDERS, item.itemid) then
      if getCreatureTarget(cid) >= 1 then 
            doTeleportThing(cid, getMarkedSpawnPos(cid))
            doSendMagicEffect(getThingPos(cid), 10)
         return true 
      end
      doTeleportThing(cid, fromPosition) 
   end
   return true
elseif isSummon(cid) then
   if isInArray(WATER, item.itemid) then
      doTeleportThing(cid, getThingPos(getCreatureMaster(cid)))
      setMoveSummon(getCreatureMaster(cid), false)
      return true
   end
end

if (isFly(cid)) then  ---- fly


local toPos = toPosition
      toPos.stackpos = 0
      if not flyBlackSQM then
        toPos.z = 7
        doCreateTile(toPos)
         if getThingFromPos(toPos).itemid < 1 or getThingFromPos(toPos).itemid == ITEM_FLYTILE then
            doTeleportThing(cid, fromPosition)
         return true
         end
      toPos.z = toPosition.z
      end

if nonFlyableBorder and type(nonFlyableBorder) == "table" then
  for i = toPos.z, 14 do
    toPos.z = i
    toPos.stackpos = 1
    doCreateTile(toPos)
    if isInArray(nonFlyableBorder, getThingFromPos(toPos).itemid) then
       doTeleportThing(cid, fromPosition)
       return true
    end
  end
  
  toPos.z = getCreaturePosition(cid).z
  toPos.stackpos = 0
  
end

for _, area in ipairs(getArea(toPos, RANGEX, RANGEY)) do
   doCreateTile(area)
   local thing = getThingFromPos(area)
     if thing.itemid < 1 or thing.itemid == ITEM_FLYTILE then
        local itemFly = doCreateItem(ITEM_FLYTILE, 1, area)
			  doItemSetAttribute(itemFly, "flyOrder", getCreatureName(cid))
     elseif thing.itemid == ITEM_WATERTILE or isInArray(WATER, thing.itemid) then
        doTransformItem(thing.uid, ITEM_WATERTILE)
		doItemSetAttribute(thing.uid, "flyOrder", getCreatureName(cid))
     end
end

  return true
end

if isPlayer(cid) then -- surf
if isInArray(WATER, item.itemid) then 
   ---//// Seguranças \\\\---
   if isSurf(cid) then return true end
   ---//// Seguranças \\\\---
   
   if #getCreatureSummons(cid) == 0 then 
       doPlayerSendCancel(cid, "Você não pode andar sobre a água.")
       doTeleportThing(cid, fromPosition, false)
     return true
   end
   
  local poke = getCreatureSummons(cid)[1] 
  local name = string.lower(getPokeName(poke))
  local habilidades = getPokemonSkills(name)
  
       if not string.find(habilidades, "surf") then
        if isInArray(WATER, item.itemid) then 
          doPlayerSendCancel(cid, "Seu pokemon não tem a habilidade de surfar.")
          doTeleportThing(cid, fromPosition, false)
          return true
        end
       end
  
          if isFight(cid) then  -- Edição pra ficar igual pxg.. nao dar fly ou ride com fight
             doPlayerSendCancel(cid, "Você não pode surfar se estiver em batalha.")
             doTeleportThing(cid, fromPosition, false)
             return true 
          end 
       
  if not isSurf(cid) then 
         
               doSendMagicEffect(toPosition, 53)
               setPlayerStorageValue(cid, orderTalks["surf"].storage, 1)
               
                    local outfit = getPokemonOutfitToSkill(name)
                    local speed = getPokemonSpeedToSkill(name)
                     
                     doSetCreatureOutfit(cid, {lookType = outfit}, -1)
                     
                     doChangeSpeed(cid, -getCreatureSpeed(cid))
                     doChangeSpeed(cid, speed)
                     doPlayerSay(cid, getCreatureName(poke)..orderTalks["surf"].talks[math.random(#orderTalks["surf"].talks)])
                     doRemoveCreature(poke)
                     
  end    
end  
return true
end
   

return true
end



local function doSendMagicEffecte(pos, effect)
	addEvent(doSendMagicEffect, 50, pos, effect)
end
function onStepOut(cid, item, position, lastPosition, fromPosition, toPosition, actor)

     if isInArray({460, 11675, 11676}, item.itemid) then
        doRemoveItem(item.uid)
     end
     
local area = getAreaToRemove(fromPosition, toPosition)

if isMonster(cid) and not isSummon(cid) then 
   if isInArray(WATER_BORDERS, item.itemid) then
      doTeleportThing(cid, toPosition) 
   end
   return true
end

if isFly(cid) or isSurf(cid) then
local direffects = {84, 85, 86, 87}
 if isInArray(WATER, item.itemid) then 
    if getCreatureLookDir(cid) == NORTH then fromPosition.y = fromPosition.y +1 end 
    doSendMagicEffecte(fromPosition, direffects[getCreatureLookDir(cid) + 1]) -- efeito 
 end 
end

if isSurf(cid) and #getCreatureSummons(cid) == 0 then
local pPos = toPosition
      pPos.stackpos = 0
local pos = getThingFromPos(pPos)
  
    if isInArray(WATER, item.itemid) and not isInArray(WATER, pos.itemid) then 
        
        local ball = getPlayerSlotItem(cid, 8)
            doGoPokemonInOrder(cid, ball, false)
            doRemoveCondition(cid, CONDITION_OUTFIT)
            doPlayerSay(cid, getCreatureName(getCreatureSummons(cid)[1]) .. orderTalks["downability"].talks[math.random(#orderTalks["downability"].talks)])
            doRegainSpeed(cid)
            setPlayerStorageValue(cid, orderTalks["surf"].storage, -1)
            doSendMagicEffect(fromPosition, 53)
   end
      return true
  end

for _, arear in ipairs(area) do
   doCreateTile(arear)
   local thing = getThingFromPos(arear)
   if thing.itemid == ITEM_FLYTILE or isInArray({460, 11675, 11676}, thing.itemid) then
	  if getItemAttribute(thing.uid, "flyOrder") == getCreatureName(cid) then
         doRemoveItem(thing.uid)
	  end 
   elseif thing.itemid == ITEM_WATERTILE then
      doTransformItem(thing.uid, WATER[1])
   end
end

return true
end 