function onUse(cid, item, frompos, item2, topos)

pos2 = getPlayerPosition(cid)
aux = 2100

if (item2.actionid == 2011 and getPlayerStorageValue(cid,aux) <= 4) then
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Main room, puxe a alavanca no fim para ser teportado para as outras salas...")
doTeleportThing(cid, {x=1408,y=1135,z=8})
			doSendMagicEffect(pos2, CONST_ME_TELEPORT)
setPlayerStorageValue(cid,aux,1)
			
elseif item2.actionid == 2012 then
doTeleportThing(cid, {x=1418,y=1135, z=8})
			doSendMagicEffect(pos2, CONST_ME_TELEPORT)

elseif item2.actionid == 2013 then
doTeleportThing(cid, {x=1424,y=1181, z=8})
			doSendMagicEffect(pos2, CONST_ME_TELEPORT)

elseif item2.actionid == 2014 then
doTeleportThing(cid, {x=1461,y=1158, z=8})
			doSendMagicEffect(pos2, CONST_ME_TELEPORT)
			
elseif item2.actionid == 2015 then
doTeleportThing(cid, {x=1418,y=1096, z=8})
			doSendMagicEffect(pos2, CONST_ME_TELEPORT)
		
elseif item2.actionid == 2016 then
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Parabens, voce completou o desafio, pegue sua recompensa...")
doTeleportThing(cid, {x=1414,y=1121,z=8})
doSendMagicEffect(pos2, CONST_ME_TELEPORT)
		

	
else
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voce ja completou todas as salas...")

end
end

