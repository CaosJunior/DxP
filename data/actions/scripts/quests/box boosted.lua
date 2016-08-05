local posis = {
{'Volcanic',    {x=1231, y=617, z=8}}, --nome de cada clan e a pos aonde o player desse clan tem q tar...
{'Seavell',     {x=1235, y=615, z=8}},
{'Orebound',    {x=1235, y=621, z=8}},
{'Wingeon',     {x=1233, y=615, z=8}},
{'Malefic',     {x=1237, y=620, z=8}},
{'Gardestrike', {x=1237, y=617, z=8}},
{'Psycraft',    {x=1232, y=621, z=8}},
{'Naturia',     {x=1234, y=618, z=8}},
{'Raibolt',     {x=1231, y=619, z=8}},
}

local toPosi = {x=1234, y=589, z=8} --pos pra onde os players serao teleportados

function onUse(cid, item, frompos, item2, topos)


for _, array in ipairs(posis) do
local p = getRecorderPlayer(array[2])
if not isPlayer(p) or getPlayerClanName(p) ~= array[1] and getPlayerLevel(cid) <= 150 then
doPlayerSendTextMessage(cid, 27, "Algum dos players não está na posição correta ou não possui level 150!")
return true
end
end
doTransformItem(item.uid, (item.itemid == 14474 and 14474 or 14474))
for _, array in ipairs(posis) do
local p = getRecorderPlayer(array[2])
if isPlayer(p) then
doTeleportThing(p, toPosi)
doSendMagicEffect(getThingPos(p), 21)
end
end

return true
end