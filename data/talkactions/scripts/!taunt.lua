local outfits = {
[1470] = {1538, 1539, 1540, 1541, 1542}, ----assassin homii
[1469] = {1543, 1544, 1545, 1546, 1547}, ----assassin mule
[1413] = {1548, 1549, 1550, 1551, 1552}, ----catcher homi
[1414] = {1553, 1554, 1555, 1556, 1557}, ----catcher mule
[604] = {1558, 1559, 1560, 1561, 1562, 1563, 1564, 1565, 1566}, ----rocket homi
[605] = {1567, 1568, 1569, 1570, 1571, 1572, 1573, 1574, 1575}, ----rocket homi
[1516] = {1580, 1581, 1582, 1583, 1584, 1583, 1584, 1585, 1586, 1587}, ----madruguinha u.u
}
local intervalo_para_trocar_roupas = 2 * 200 -- em ms, 1 * 1000 = 1 segundo
local function doChangeOutfit(cid, id, oldLook)
if not isCreature(cid) then return true end
local n = id or 1
local newOutfit = getCreatureOutfit(cid)
newOutfit.lookType = outfits[oldLook][n]
doSetCreatureOutfit(cid, newOutfit, -1)
if n < #outfits[oldLook] then
addEvent(doChangeOutfit, intervalo_para_trocar_roupas, cid, n + 1, oldLook)
else
doCreatureSetNoMove(cid, false)
doRemoveCondition(cid, CONDITION_OUTFIT)
end
end
function onSay(cid, words, param)
if getCreatureCondition(cid, CONDITION_OUTFIT) and getCreatureNoMove(cid) then
return true
end
if not outfits[getCreatureOutfit(cid).lookType] then
doPlayerSendCancel(cid, "Você não está usando o outfit necessário.")
return true
end
doCreatureSetNoMove(cid, true)
doChangeOutfit(cid, 1, getCreatureOutfit(cid).lookType)
return true
end