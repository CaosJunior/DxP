function markPosEff(sid, pos)
if not isCreature(sid) then return end
setPlayerStorageValue(sid, 26547, pos.x)
setPlayerStorageValue(sid, 26548, pos.y)
setPlayerStorageValue(sid, 26549, pos.z)
end

function getMarkedPosEff(sid)
if not isCreature(sid) then return end
local xx = getPlayerStorageValue(sid, 26547)
local yy = getPlayerStorageValue(sid, 26548)
local zz = getPlayerStorageValue(sid, 26549)
return {x = xx, y = yy, z = zz}
end

function sendMoveEffect(cid, effect, pos)
if isCreature(cid) then
   if pos then                                                --Functions pro sistema de sair efeito quando magmar/jynx andam e fly porygon
      doSendMagicEffect(pos, effect)
   else
      doSendMagicEffect(getThingPos(cid), effect)
   end
end
end

function sendAuraEffect(cid, eff)  --alterado v1.8 \/
----------------
if isPlayer(cid) and (getPlayerStorageValue(cid, 17000) <= 0 and getPlayerStorageValue(cid, 17001) <= 0 and getPlayerStorageValue(cid, 63215) <= 0) then
   setPlayerStorageValue(cid, 42368, -1)
   return true
end
----------------  
if isCreature(cid) and getCreatureOutfit(cid).lookType ~= 2 then  
   setPlayerStorageValue(cid, 42368, 1)
   doSendMagicEffect(getThingPos(cid), eff)
end
----------------
if isCreature(cid) then
   addEvent(sendAuraEffect, 1000, cid, eff)
end
end


function sendMovementEffect(cid, eff, pos)
if isPlayer(cid) then
   if getCreatureOutfit(cid).lookType ~= 667 and getCreatureOutfit(cid).lookType ~= 999 then
      return true
   end
end
if isCreature(cid) then
local nPos = getMarkedPosEff(cid)

if pos.x ~= nPos.x or pos.y ~= nPos.y then
   sendMoveEffect(cid, eff, nPos)
   markPosEff(cid, getThingPos(cid))
end
addEvent(sendMovementEffect, 100, cid, eff, getThingPos(cid)) 
end
end