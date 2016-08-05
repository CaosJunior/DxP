function onStepIn(cid, item, position, fromPosition)
local sto_ceru = 4452 
if item.actionid == 2222  then
doTeleportThing(cid, fromPosition, TRUE)
setPlayerStorageValue(cid,181653,1)
setPlayerStorageValue(cid, sto_ceru, 1)	
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"Você Já termino a Liga Quest!")
doSendMagicEffect(getThingPos(cid), CONST_ME_MAGIC_BLUE)
return true
end
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"Bem Vindo á Liga Quest!")
         if getPlayerStorageValue(cid, sto_ceru) >= 1 then
         sendMsgToPlayer(cid, 27, "Desculpe você ja terminou essa quest!")
		 end
         if getPlayerLevel(cid) < 400 then   
		 sendMsgToPlayer(cid, 27, "Desculpe somente level 400 para entar na Liga Quest.")
	     return true
	     end
return true
end