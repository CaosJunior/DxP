local configuracao = {
efeito = {28, 29}, 		-- Efeito que vai mandar ao avançar de level.
texto = "Level up!", 	-- Texto que vai aparecer ao avançar de level.
cortexto = 215		-- Cor do texto, sendo o número entre 1 e 254.
}

function onAdvance(cid, skill, oldLevel, newLevel)
if skill ~= 8 then return true end
if newLevel >= 11 and newLevel <= 200 then doPlayerSetLossPercent(cid, PLAYERLOSS_EXPERIENCE, math.floor(newLevel/2)) end   --alterado v1.8



doRegainSpeed(cid)
doSendMagicEffect(getThingPos(cid), configuracao.efeito[math.random(#configuracao.efeito)])

local color = 0

if configuracao.texto then
    if configuracao.cortexto ~= 0 then
    color = configuracao.cortexto
    else
    color = math.random(1, 254)
    end
doSendAnimatedText(getThingPos(cid), configuracao.texto, color)
end
local s = getCreatureSummons(cid)
local item = getPlayerSlotItem(cid, 8)
  -- doCreatureAddHealth(cid, getCreatureMaxHealth(cid))
   doSendMagicEffect(getThingPos(cid), 132)                                                             
return true
end