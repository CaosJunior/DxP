local posis = {
{'Volcanic',    {x=1237, y=616, z=8}}, --nome de cada clan e a pos aonde o player desse clan tem q tar...
{'Seavell',     {x=1237, y=618, z=8}},
{'Orebound',    {x=1233, y=620, z=8}},
{'Wingeon',     {x=1235, y=615, z=8}},
{'Malefic',     {x=1233, y=618, z=8}},
{'Gardestrike', {x=1235, y=618, z=8}},
{'Psycraft',    {x=1237, y=620, z=8}},
{'Naturia',     {x=1233, y=616, z=8}},
{'Raibolt',     {x=1235, y=621, z=8}},
}

local toPosi = {x=1168, y=551, z=9} --pos pra onde os players serao teleportados

function onUse(cid, item, frompos, item2, topos)


for _, array in ipairs(posis) do
local p = getRecorderPlayer(array[2])
if not isPlayer(p) or getPlayerClanName(p) ~= array[1] and getPlayerLevel(cid) <= 120 then
doPlayerSendTextMessage(cid, 27, "Esta faltando um membro de clan ou alguem não possui level necessário!")
return true
end
end
doTransformItem(item.uid, (item.itemid == 3033 and 3033 or 3033))
for _, array in ipairs(posis) do
local p = getRecorderPlayer(array[2])
if isPlayer(p) then
   setPlayerStorageValue(cid, 121212, 500)
doTeleportThing(p, toPosi)
doSendMagicEffect(getThingPos(p), 21)
end
end

return true
end