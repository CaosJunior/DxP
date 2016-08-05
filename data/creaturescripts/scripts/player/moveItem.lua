function onMoveItem(cid, item, count, toContainer, fromContainer, fromPos, toPos)
if not isCreature(cid) then return false end
if isWatchingTv(cid) then return false end
local name = getCreatureName(cid)
local transform = false
--- nao retirar item que estao no slot 8 e sao uniques
if fromPos.x ~= 0 and toContainer.uid == 0 and fromContainer.uid == 0 and toPos.x == 65535 and getPlayerSlotItem(cid, 8).uid ~= 0 then
	doPlayerSendCancel(cid, MSG_NAO_E_POSSIVEL)
	return false
end

local itemID = item.itemid
if itemID >= 14795 and itemID <= 14879 or pokeballs[getPokeballType(itemID)] and (itemID ==  pokeballs[getPokeballType(itemID)].use and (#getCreatureSummons(cid) > 0 or isRiderOrFlyOrSurf(cid))) then
   doPlayerSendCancel(cid, "Você não pode mover este item.")
   return false
end

if isFly(cid) and (getTileThingByPos(toPos).itemid == 460 or getTileThingByPos(toPos).itemid == 12171 or getTileThingByPos(toPos).itemid == 12172 or (toContainer.uid == 0 and getThingPos(cid).z ~= toPos.z)) then
	doPlayerSendDefaultCancel(cid, RETURNVALUE_CANNOTTHROW)
	return false
end

if isInArray({2589, 15446, 15447, 15448, 15449, 12355}, toContainer.itemid)then -- nao fazer nada no cp
   return true
end	

local pos =  toPos
local items = getItemsfromPos(pos)
for i = 1, #items do
	local name = getItemInfo(items[i].itemid).name
	if string.find(name, "fainted") or string.find(name, "defeated") then 
	   doSendMsg(cid, "Não pode jogar lá.")
       return false
    end	   
end

	if isPokeball(item.itemid) and toPos.x == 65535 then
		if not getItemAttribute(item.uid, "unique") and getPlayerFreeCap(cid) > 1 then
			 doTransformPokeballIcon(cid, item, count, toContainer, fromContainer, fromPos, toPos)
		end
	else
		  if not getItemAttribute(item.uid, "unique") and not getItemAttribute(item.uid, "torneio") then
	         doTransformPokeballIcon(cid, item, count, toContainer, fromContainer, fromPos, toPos)
		  end
	end


if isPokeball(item.itemid) or isContainer(item.uid) then
if hasSqm(toPos) then

  if isContainer(item.uid) then

   local itens = getItensUniquesInContainer(item.uid)
   local sendMsg = false
    if #itens >= 1 then
	   doSendMsg(cid, #itens.." item"..(#itens < 2 and "" or "s").." neste recipiente "..(#itens < 2 and "é exclusivo" or "são exclusivos")..". Você não pode joga-lo"..(#itens < 2 and "" or "s").." fora!")
	   return false
    end
   
  else

   if getItemAttribute(item.uid, "unique") or getItemAttribute(item.uid, "torneio") then 
      doSendMsg(cid, "Isso é um item exclusivo, você não pode joga-lo fora!")
      return false 
   end  
  end
  
elseif isContainer(toContainer.uid) and (isPokeball(item.itemid) or isContainer(item.uid)) then 

   if toContainer.itemid == getPlayerSlotItem(cid, 3).itemid then -- nao fazer nada na poke bag principal
      return true
   end


  if not isPosEqual(getThingPos(toContainer.uid), getThingPos(cid)) then
	  if isContainer(item.uid) then
	  
			local itens = getItensUniquesInContainer(item.uid)
			local sendMsg = false
			  if #itens >= 1 then
				doSendMsg(cid, #itens.." item"..(#itens < 2 and "" or "s").." neste recipiente "..(#itens < 2 and "é exclusivo" or "são exclusivos")..". Você não pode joga-lo"..(#itens < 2 and "" or "s").." fora!")
				return false
			  end
	   
	  else
		 if getItemAttribute(item.uid, "unique") or getItemAttribute(item.uid, "torneio") then 
			doSendMsg(cid, "Isso é um item exclusivo, você não pode joga-lo fora!")
			return false 
		 end  
	  end
  end
   
end
end  

  return true
end 



function getItemsfromPos(position, fromStackpos)
	local toret = { } -- table to return items
 
	position.stackpos = fromStackpos
	if position.stackpos == nil then
		position.stackpos = 1 -- default
	end
 
	while true do -- loop to catch the items and insert them in toret table
		local thing = getThingfromPos(position)
		if thing.itemid == 0 then -- thing doesn't exist, break the loop...
			break
		end
 
		if getWholeThing ~= nil and getWholeThing ~= 0 then
			-- if getWholeThing isn't nil and isn't 0
			table.insert(toret,thing)
		else
			-- else, insert only item uid in toret table
			table.insert(toret,thing)
		end
 
		position.stackpos = position.stackpos + 1 -- get next item
	end
 
	return toret
end