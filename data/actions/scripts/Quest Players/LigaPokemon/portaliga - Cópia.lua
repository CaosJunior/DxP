function onUse(cid, item, frompos, item2, topos) 
local level = 450
local msgsucess = "Bem vindo a Liga Pokemon!" -- mensagem que vai aparece caso ele passar pela porta 
local msgfault = "Você Precisa de level 450 pra entrar!" -- mensagem que ira aparecer caso ele nao tiver o level 
if getPlayerLevel(cid) >= level then 
doTransformItem(item.uid, item.itemid)
doTeleportThing(cid, topos, TRUE)
doSendMagicEffect(topos, 12)
doPlayerSendTextMessage(cid, 22, msgsucess) 
else 
doPlayerSendTextMessage(cid, 22, msgfault) 
end 
return TRUE 
end 