function onUse(cid, item, fromPosition, itemEx, toPosition)
local area1 = {x = 483, y = 1132, z = 8}
local area2 = {x = 560, y = 1208, z = 8}
local posquest = {x = 493, y = 1201, z = 8}
if #getPlayerInArea(area1, area2) > 0 then

    doPlayerSendTextMessage(cid, 20, "Tem um player na quest, espere sua vez!")
        return true
    else
    doTeleportThing(cid, posquest)
        doPlayerSendTextMessage(cid, 20, "Boa Sorte!")
        return false
    end
    end