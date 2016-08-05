local sto_daisy = 13590
local sto_food = 13589
function onUse(cid, item, frompos, item2, topos)
   if getPlayerStorageValue(cid, sto_food) < 1 then
     sendMsgToPlayer(cid, 27, "You dont are complete to Delia Mission!")
      return true 
   elseif getPlayerStorageValue(cid, sto_daisy) >= 1 then
      sendMsgToPlayer(cid, 27, "You dont are complete to Delia Mission!")
      return true
   end
   setPlayerStorageValue(cid, sto_daisy, 1)	
   setPlayerStorageValue(cid, 13589, -1)
   doPlayerAddLevel(cid, 5)   
   sendMsgToPlayer(cid, 27, "Now talk with Daisy Oak to complete his mission.")
return true 
end