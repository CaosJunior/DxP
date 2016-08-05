function onSay(cid, words, param, channel)
if(param == '') then
	doSendMsg(cid, "Relate o bug da seguinte forma: '!report Encontrei um bug'")
	return true
end

local playerName, playerPos = getCreatureName(cid), getThingPos(cid)
local str = "Nome: " .. playerName .. "\nPosX: " .. playerPos.x ..", PosY: " .. playerPos.y .. ", PosZ: " .. playerPos.z .. "\nData: " .. os.date()

local file = io.open('data/reports/'.. playerName ..' Bug ' .. getAllReports(playerName) +1 .. '.txt', 'w')

str = str .. "\n\nBug: " .. param 

file:write(str)
file:close()
doSendMsg(cid, 'Bug reportado com sucesso.')
return true
end

function getAllReports(name)
local count = 0
for i = 1, 300 do
local file = io.open('data/reports/'.. name ..' Bug '.. i ..'.txt', 'r')
	if file ~= nil then 
		io.close(file) 
		count = count +1
	end
end
	return count
end