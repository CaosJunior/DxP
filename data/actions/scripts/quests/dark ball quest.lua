function onUse(cid, item, frompos, item2, topos)

pos2 = getPlayerPosition(cid)
aux = 2100

if (item2.actionid == 2017 and getPlayerStorageValue(cid,aux) <= 4) then
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Aki esta seu premio")
doTeleportThing(cid, {x=476,y=1100,z=11})
			doSendMagicEffect(pos2, CONST_ME_TELEPORT)
setPlayerStorageValue(cid,aux,1)
	
else
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voce ja completou todas as salas...")

end
end



