local outfits = {1441,1505,1506,1507,1508,1509,1510,1511}-- somente o lookType
local copiar_cores = true -- se true, copia as cores da outfit que o player estava usando
local intervalo_para_trocar_roupas = 2 * 200 -- em ms, 1 * 1000 = 1 segundo
local function doChangeOutfit(cid, id)
if not isCreature(cid) then return true end
local n = id or 1
local newOutfit = copiar_cores and getCreatureOutfit(cid) or {}
newOutfit.lookType = outfits[n]
doSetCreatureOutfit(cid, newOutfit, -1)
if n < #outfits then
addEvent(doChangeOutfit, intervalo_para_trocar_roupas, cid, n + 1)
else
doCreatureSetNoMove(cid, false)
doRemoveCondition(cid, CONDITION_OUTFIT)
end
end
function onSay(cid, words, param)
if getCreatureCondition(cid, CONDITION_OUTFIT) and getCreatureNoMove(cid) then
return true
end
if getCreatureOutfit(cid).lookType ~= 1441 then
doPlayerSendCancel(cid, "Você não está usndo o outfit necessário.")
return true
end
doCreatureSetNoMove(cid, true)
doChangeOutfit(cid)
return true
end
