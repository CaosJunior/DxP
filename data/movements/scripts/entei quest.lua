function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
if isSummon(cid) or isMonster(cid) then return false end
local uballs = getPlayerItemCount(cid, 2392)
local pballs = getPlayerItemCount(cid, 2394)
local gballs = getPlayerItemCount(cid, 2391)
local sballs = getPlayerItemCount(cid, 2393)
local safballs = getPlayerItemCount(cid, 2146)
local dballs = getPlayerItemCount(cid, 12832)
if uballs > 0 or pballs > 0 or sballs > 0 or gballs > 0 or safballs > 0 or dballs > 0 then
doPlayerSendTextMessage(cid,22,"Você não pode entrar aqui com pokeballs!")
doTeleportThing(cid, fromPosition, TRUE)
end
if item.actionid == 25708 and getPlayerLevel(cid) <= 119 then
doTeleportThing(cid, fromPosition, TRUE)
doPlayerSendTextMessage(cid,22,"Somente level 120+ pode entrar aqui!")
doSendMagicEffect(position, 21)
end
end