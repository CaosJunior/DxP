local toPosi = {x=851, y=981, z=8} --pos pra onde os players serao teleportados

function onUse (cid,item,frompos,item2,topos)

if not doRemoveItem(item.uid) then return true end

doTeleportThing(p, toPosi)
doSendMagicEffect(getCreaturePosition(cid), 47)
return true
end