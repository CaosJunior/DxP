local days_gain = 30 -- Dias que ganham

function onUse (cid,item,frompos,item2,topos)

if not doRemoveItem(item.uid) then return true end

doPlayerAddPremiumDays(cid, days_gain)
doSendMagicEffect(getCreaturePosition(cid), 14)
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você acaba de ganhar 30 dias de Premium Account, terá áreas e bonus EXP exclusivas como benefício!")
return true
end