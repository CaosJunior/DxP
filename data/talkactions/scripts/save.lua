local savingEvent = 0

function onSay(cid, words, param, channel)

doSaveServer()

return true
end

function save(delay)
	doSaveServer()
	if(delay > 0) then
		savingEvent = addEvent(save, delay, delay)
	end
end
