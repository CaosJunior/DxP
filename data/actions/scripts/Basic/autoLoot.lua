function onUse(cid, item, frompos, item2, topos) 
if isWatchingTv(cid) then return true end
	local quemMatou = getItemAttribute(item.uid, "corpseowner")
	if quemMatou then
	local player = getCreatureByName(quemMatou)
		if isPlayer(player) then
		local isInParyWithPlayer = false
			  if isInParty(cid) and isInParty(player) then
			     isInParyWithPlayer = isPartyEquals(player, cid)
			  end
			
			if getCreatureName(cid) ~= getCreatureName(player) and not isInParyWithPlayer then
			   doPlayerSendCancel(cid, "Você não pode abrir um loot que não é seu.")	
			   return true
			end
		end
	end
	      local autoLootList = getAllItensInMyList(cid)
		  local bag = getPlayerSlotItem(cid, 3).uid
		  local itemsToRemove = {}
		  
		  if isCollectAll(cid) then
		    for a = 0, getContainerSize(item.uid) do
				local it = getContainerItem(item.uid, a)
					if it.uid > 0 then
					   if addItemInFreeBag(bag, it.itemid, it.type) ~= false then
					      table.insert(itemsToRemove, it.uid)
					   end
					end
			end
		 end
		  
		  if #autoLootList > 0 and not isCollectAll(cid) then
			  for a = 0, getContainerSize(item.uid) do
				local it = getContainerItem(item.uid, a)
					if it.uid > 0 then
					for i = 1, #autoLootList do 
							if getItemInfo(it.itemid).name == autoLootList[i] then
							   if addItemInFreeBag(bag, it.itemid, it.type) ~= false then
								  table.insert(itemsToRemove, it.uid)
							   end
							end
						end
					end
			   end
		  end
		  
		  if #itemsToRemove > 0 then
		     for i = 1, #itemsToRemove do
			    doChangeTypeItem(itemsToRemove[i], 0)
			 end
		  end
	
end
