function onUse(cid, item, frompos, item2, topos)

if not isPremium(cid) then
doPlayerSendTextMessage(cid,22,"Você precisa ter Premium Account para passar!") return false end

doTransformItem(item.uid, item.itemid + 1)
doTeleportThing(cid, frompos, true)
return true
end