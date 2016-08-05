local pewter_cfg = {
{2160, 2},
{2392, 80},
{2393, 100},
}
local sto_pewter = 91121
--//--
function onUse(cid, item, frompos, item2, topos)
         if getPlayerLevel(cid) < 35 then   
		 sendMsgToPlayer(cid, 27, "Sorry, you need to have level 35 to completed this quest.")
	     return true
	     end
          --//
         if getPlayerStorageValue(cid, sto_pewter) >= 1 then
         sendMsgToPlayer(cid, 27, "Sorry, you've already completed this quest!")
         return true
		 end
		 --//
        for i = 1, #pewter_cfg do
       doPlayerAddItem(cid, pewter_cfg[i][1], pewter_cfg[i][2])
       end
	   --//
setPlayerStorageValue(cid, sto_pewter, 1)	   
doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
sendMsgToPlayer(cid, 27, "Congratulations, you complete the Pewter Quest!")
return true
end