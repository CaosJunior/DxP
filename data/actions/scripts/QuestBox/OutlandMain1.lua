local posis = {
{'Volcanic',    {x=1705, y=737, z=9}}, --nome de cada clan e a pos aonde o player desse clan tem q tar...
{'Seavell',     {x=1706, y=737, z=9}},
{'Orebound',    {x=1707, y=737, z=9}},
{'Wingeon',     {x=1708, y=737, z=9}},
}

local toPosi = {x=1722, y=738, z=9} --pos pra onde os players serao teleportados

function onUse(cid, item, frompos, item2, topos)


for _, array in ipairs(posis) do
local p = getRecorderPlayer(array[2])
if not isPlayer(p) or getPlayerClanName(p) ~= array[1] and getPlayerLevel(cid) <= 150 then
doPlayerSendTextMessage(cid, 27, "Não tem 4 Players Necessarios!")
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