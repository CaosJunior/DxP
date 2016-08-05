function onStepIn(cid, item, position, fromPosition)
if item.actionid == 19456 and not isPremium(cid) then
doTeleportThing(cid, fromPosition, TRUE)
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"Você não tem acesso Premium Account!")
doSendMagicEffect(getThingPos(cid), CONST_ME_MAGIC_BLUE)
return true
end
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"Bem Vindo á Área Premium!")
return true
end