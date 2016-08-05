local config = {
shallow = "no",
delay = 1,
events = 1
}

local savingEvent = 0
function onThink(interval, lastExecution, thinkInterval)
doSaveServer()
return true
end
function save(delay)
doSaveServer()
if(delay > 0) then
savingEvent = addEvent(save, delay, delay)
end
end