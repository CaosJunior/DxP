function onStepIn(cid, item, position, fromPosition)
level = 150
if getPlayerLevel(cid) < level then
doTeleportThing(cid, fromPosition, true)
doSendMagicEffect(getThingPos(cid), CONST_ME_MAGIC_RED)
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Somente level " .. level .. " ou mais podem passar aqui.")
end
if item.actionid == 19456  then

end
return TRUE
end
