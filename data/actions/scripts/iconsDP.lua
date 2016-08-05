function onUse(cid, item, frompos, item2, topos)
if getPlayerStorageValue(cid, 8955) >= 1 then
   local locker = getTileItemById(frompos, item.itemid).uid
     if locker <= 0 or not isContainer(locker) then return true end
     local balls = getPokeballsInContainer(locker)
       if  #balls >= 1 then
          for _, ball in pairs (balls) do
local x = icons[getItemAttribute(item, "poke")]	
              if getItemAttribute(ball, "morta") == "no" then
		doItemSetAttribute(item, "ball", "pokeball")
		doItemSetAttribute(ball, "morta", "no")
		doItemSetAttribute(ball, "Icone", "yes")	
		doTransformItem(ball, icons[getItemAttribute(ball, "poke")].on)
              elseif getItemAttribute(ball, "morta") == "yes"then
		doItemSetAttribute(item, "ball", "pokeball")
		doItemSetAttribute(ball, "morta", "yes")
		doItemSetAttribute(ball, "Icone", "yes")	
		doTransformItem(ball, icons[getItemAttribute(ball, "poke")].off)

              end
          end
       end 
     end
end






	
