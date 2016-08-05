function onUse(cid, item, fromPosition, itemEx, toPosition)
local area1 = {x = daquix, y = daquiy, z = daquiz}
local area2 = {x = ateaquix, y = ateaquiy, z = ateaquiz}
local posquest = {x = 493, y = 1201, z = 8}
if #getPlayerInArea(area1, area2) > 0 then
    doTeleportThing(cid, fromPosition)
    doPlayerSendTextMessage(cid, 20, "Tem um player na quest!")
        return true
    else
    doTeleportThing(cid, posquest)
        doPlayerSendTextMessage(cid, 20, "Boa Sorte!")
        return false
    end
    end