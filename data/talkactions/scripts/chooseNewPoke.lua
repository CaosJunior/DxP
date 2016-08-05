local reward_cfg = {
{12344, 1},
{12348, 20},
{12349, 15},
{2394, 25},
{2392, 2},
}

local sto_city = 13611 --storage para quando o player ganhar a ball

function onSay(cid, words, param)

if getPlayerStorageValue(cid, sto_city) ~= 1 then
   return true
end
local name = ""           

if tostring(param) then
	name = doCorrectString(param)   
	if not pokes[name] then
	   doPlayerSendCancel(cid, "Sorry, a pokemon with the name "..name.." doesn't exists.")
	   return true
	end
end

addPokeToPlayer(cid, name, 0, -1, 'normal', true)
for i = 1, #reward_cfg do
doPlayerAddItem(cid, reward_cfg[i][1], reward_cfg[i][2])
end
setPlayerStorageValue(cid, sto_city, 2)
doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)), false)
doSendMagicEffect(getThingPos(cid), 21)

return true
end