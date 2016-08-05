local posis = {
{'Volcanic',    {x=1059, y=1705, z=8}}, --nome de cada clan e a pos aonde o player desse clan tem q tar...
{'Seavell',     {x=1063, y=1703, z=8}},
{'Orebound',    {x=1063, y=1709, z=8}},
{'Wingeon',     {x=1061, y=1703, z=8}},
{'Malefic',     {x=1065, y=1708, z=8}},
{'Gardestrike', {x=1065, y=1705, z=8}},
{'Psycraft',    {x=1061, y=1709, z=8}},
{'Naturia',     {x=1059, y=1707, z=8}},
{'Raibolt',     {x=1062, y=1706, z=8}},
}

local toPosi = {x=1060, y=1717, z=8} --pos pra onde os players serao teleportados

function onUse(cid, item, frompos, item2, topos)


for _, array in ipairs(posis) do
local p = getRecorderPlayer(array[2])
if not isPlayer(p) or getPlayerClanName(p) ~= array[1] and getPlayerLevel(cid) <= 200 then
doPlayerSendTextMessage(cid, 27, "One or more players aren't in the correct place or not have level necessary!")
return true
end
end
doTransformItem(item.uid, (item.itemid == 14474 and 14474 or 14474))
for _, array in ipairs(posis) do
local p = getRecorderPlayer(array[2])
if isPlayer(p) then
doPlayerAddItem(cid, 14403, 1)
   setPlayerStorageValue(cid, 121212, 50)
doTeleportThing(p, toPosi)
doSendMagicEffect(getThingPos(p), 21)
end
end

return true
end