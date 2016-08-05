function onStepIn(cid, item, position, fromPosition)

level = 120
if getPlayerLevel(cid) < level then
doTeleportThing(cid, fromPosition, true)
doSendMagicEffect(getThingPos(cid), CONST_ME_MAGIC_RED)
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Somente level " .. level .. " ou mais podem passar aqui.")

end
return TRUE
end
