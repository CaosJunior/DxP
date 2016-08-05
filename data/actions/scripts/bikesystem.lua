-- [ Bike System - BY Nogard ] --


function onUse(cid, item, frompos, item2, topos)

local bike = {lookType = 1726 } --- LookType do player em cima da bike.
local speed = 30000 --- Velocidade que a bike terá.



if getPlayerStorageValue(cid, 32001) == 1 then
setPlayerStorageValue(cid, 32001, 0)
doRemoveCondition(cid, CONDITION_OUTFIT)
doSendAnimatedText(getCreaturePosition(cid), 'Bike OFF!', 32)
doChangeSpeed(cid, -speed)
doPlayerSendTextMessage(cid, MESSSAGE_STATUS_CONSOLE_ORANGE, 'Voce montou na bike.')



else


doChangeSpeed(cid, speed)
doSetCreatureOutfit(cid, bike, -1)
doSendAnimatedText(getCreaturePosition(cid), 'Bike ON!', 32)
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, 'Você desceu da bike.')
setPlayerStorageValue(cid, 32001, 1)



end

return true
end