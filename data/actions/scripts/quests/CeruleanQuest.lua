local cerulean_cfg = {
{2160, 1},
{2392, 50},
{2393, 80},
{11640, 1}, 
}
local sto_ceru = 91120
--//--
function onUse(cid, item, frompos, item2, topos)
         if getPlayerLevel(cid) < 30 then   
		 sendMsgToPlayer(cid, 27, "Desculpe somente level 30 pode terminar essa quest.")
	     return true
	     end
          --//
         if getPlayerStorageValue(cid, sto_ceru) >= 1 then
         sendMsgToPlayer(cid, 27, "Desculpe você ja terminou essa quest!")
         return true
		 end
		 --//
        for i = 1, #cerulean_cfg do
       doPlayerAddItem(cid, cerulean_cfg[i][1], cerulean_cfg[i][2])
              doPlayerAddExperience(cid, 150000)  --premio
       end
	   --//
setPlayerStorageValue(cid, sto_ceru, 1)	   
doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
sendMsgToPlayer(cid, 27, "Parabéns você terminou a Cerulean Quest!")
return true
end