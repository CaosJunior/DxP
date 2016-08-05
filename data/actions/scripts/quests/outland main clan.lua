local posis = {
{'Volcanic',    {x=706, y=845, z=8}}, --nome de cada clan e a pos aonde o player desse clan tem q tar...
{'Seavell',     {x=709, y=843, z=8}},
{'Orebound',    {x=712, y=850, z=8}},
{'Wingeon',     {x=706, y=843, z=8}},
{'Malefic',     {x=708, y=850, z=8}},
{'Gardestrike', {x=706, y=848, z=8}},
{'Psycraft',    {x=714, y=848, z=8}},
{'Naturia',     {x=711, y=847, z=8}},
{'Raibolt',     {x=714, y=844, z=8}},
{'Volcanic',    {x=707, y=847, z=8}},
{'Seavell',     {x=711, y=843, z=8}},
{'Orebound',    {x=714, y=850, z=8}},
{'Wingeon',     {x=708, y=843, z=8}},
{'Malefic',     {x=710, y=850, z=8}},
{'Gardestrike', {x=706, y=850, z=8}},
{'Psycraft',    {x=714, y=846, z=8}},
{'Naturia',     {x=709, y=847, z=8}},
{'Raibolt',     {x=713, y=843, z=8}},
}

local toPosi = {x=721, y=840, z=9} --pos pra onde os players serao teleportados

function onUse(cid, item, frompos, item2, topos)


for _, array in ipairs(posis) do
local p = getRecorderPlayer(array[2])
if not isPlayer(p) or getPlayerClanName(p) ~= array[1] and getPlayerLevel(cid) <= 200 then
doPlayerSendTextMessage(cid, 27, "Algum dos players não está na posição correta ou não possui level 200!!")
return true
end
end
doTransformItem(item.uid, (item.itemid == 14475 and 14475 or 14475))
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