local ball_cfg = {
{2391, 30},
{2392, 15},
{2393, 25},
{2394, 50},
{2152, 15},
{11638, 1},
}
local sto_ball = 91123
--//--
function onUse(cid, item, frompos, item2, topos)
         if getPlayerLevel(cid) < 15 then   
		 sendMsgToPlayer(cid, 27, "Sorry, you need to have level 15 to completed this quest.")
	     return true
	     end
          --//
         if getPlayerStorageValue(cid, sto_ball) >= 1 then
         sendMsgToPlayer(cid, 27, "Sorry, you've already completed this quest!")
         return true
		 end
		 --//
        for i = 1, #ball_cfg do
       doPlayerAddItem(cid, ball_cfg[i][1], ball_cfg[i][2])
		doPlayerAddExperience(cid, 50000)
       end
	   --//
setPlayerStorageValue(cid, sto_ball, 1)	   
doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
sendMsgToPlayer(cid, 27, "Congratulations, you complete the PokeBall Quest!")
return true
end