local tp_r = {x=716, y=1186, z=7}
function onStepIn(cid, item, fromPosition, toPosition)
              if getPlayerStorageValue(cid, 81234) == 1 then
	doTeleportThing(cid, tp_r)
     sendMsgToPlayer(cid, 20, "You need talk to npc delia first to leave to here.")
     return true
     end
return true
end