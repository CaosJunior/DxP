function onUse(cid, item, fromPosition, itemEx, toPosition)
   if not getItemAttribute(item.uid, "movel") then
      return true
   elseif(fromPosition.x == CONTAINER_POSITION) then
      return doPlayerSendCancel(cid, "Please, first put your  on the floor.")
   end
  	    
   if getTileInfo(fromPosition).house then
      local movel = getItemAttribute(item.uid, "movel")      
      doTransformItem(item.uid, movel)
      doSendMagicEffect(fromPosition, CONST_ME_POFF)
   else
      doPlayerSendCancel(cid,"You can only construct this furniture item at your home.") 
   end      
return true                                            
end
   