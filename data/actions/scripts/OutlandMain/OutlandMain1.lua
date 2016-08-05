local posis = {
{'Volcanic',    {x=223, y=405, z=7}}, --nome de cada clan e a pos aonde o player desse clan tem q tar...
{'Seavell',     {x=223, y=407, z=7}},
{'Orebound',    {x=223, y=409, z=7}},
{'Wingeon',     {x=225, y=410, z=7}},
{'Malefic',     {x=227, y=409, z=7}},
{'Gardestrike', {x=227, y=407, z=7}},
{'Psycraft',    {x=227, y=405, z=7}},
{'Naturia',     {x=225, y=407, z=7}},
{'Raibolt',     {x=225, y=404, z=7}},
}

local toPosi = {x=225, y=407, z=8} --pos pra onde os players serao teleportados

function onUse(cid, item, frompos, item2, topos)


for _, array in ipairs(posis) do
local p = getRecorderPlayer(array[2])
if not isPlayer(p) or getPlayerClanName(p) ~= array[1] and getPlayerLevel(cid) <= 150 then
doPlayerSendTextMessage(cid, 27, "One or more players aren't in the correct place or not have level necessary!")
return true
end
end
doTransformItem(item.uid, (item.itemid == 19390 and 19390 or 19390))
for _, array in ipairs(posis) do
local p = getRecorderPlayer(array[2])
if isPlayer(p) then
doTeleportThing(p, toPosi)
doSendMagicEffect(getThingPos(p), 21)
end
end

return true
end