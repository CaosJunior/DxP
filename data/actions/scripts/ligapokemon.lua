function onUse(cid, item, fromPosition, itemEx, toPosition)
local flag = 0
local pos = {x = 654, y = 1175, z = 5}
for i = 12252, 12259 do
        if getPlayerItemCount(cid, i) >= 1 then
           flag = flag+1
        end
end
if flag == 8 then
   doTeleportThing(cid, pos)
   doSendMagicEffect(getThingPos(cid), 21)
   return true
end
if getPlayerLevel(cid) < 400 then   
		 sendMsgToPlayer(cid, 27, "Desculpe somente level 400 pode fazer a Liga Pokemon.")
	     return true
	     end
sendMsgToPlayer(cid, 20, "Você precisa de todas as insignias para passar!")
return true
end  
