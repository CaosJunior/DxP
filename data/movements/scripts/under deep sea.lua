
local premium = false

function onStepIn(cid, item, position, fromPosition)

return true
end

function onStepOut(cid, item, position, fromPosition)
	addEvent(doSendMagicEffect, 75, fromPosition, 25)
return true
end