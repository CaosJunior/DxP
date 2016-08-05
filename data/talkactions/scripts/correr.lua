function onSay(cid, words, param)
if exhaustion.get(cid, 500) then
doPlayerSendCancel(cid, 'You can use this command only once per 10 seconds.')
return true
end
doCreatureSay(cid, "correr", TALKTYPE_ORANGE_1)
doChangeSpeed(cid, 1 * 500)
doSendMagicEffect(getPlayerPosition(cid), 40)
exhaustion.set(cid, 501, 10)
return true
end 