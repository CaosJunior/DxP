function onMove(cid, fromPosition, toPosition)
     if isPlayer(cid) then
	 
		movePlayerListWatchingMe(cid, toPosition)
		
		if getCreatureSkullType(cid) == SKULL_WHITE then
			local p2 = getPlayerByName(getPlayerAdvers(cid))
			if getDistanceBetween(getThingPos(p2), toPosition) > 3 then
				  doWin(p2)
				  doGiveUP(cid)
				  doSendMsg(cid, "Você se distanciou de mais do seu adversário.")
				  doSendMsg(p2, getCreatureName(cid) .. " se distanciou de mais do de você.")
			end
		elseif getCreatureSkullType(cid) == 1 or getCreatureSkullType(cid) == 2 then
			local p2 = getPlayerByName(getPlayerAdvers(cid))
			if getDistanceBetween(getThingPos(p2), toPosition) > 3 then
				doEreaseDuel(cid) doEreaseDuel(p2)
			end
		end

        setMoveSummon(cid, true)
		
		if isInArray({1467, 1468}, getCreatureOutfit(cid).lookType) then--fishing cancel
		  setPlayerStorageValue(cid, 154585, -1)
          doRemoveCondition(cid, CONDITION_OUTFIT)
		end
		
		local max = 6 --- poke teletrasporte
		local eff = 21
		local sum = getCreatureSummons(cid)
			if #sum >= 1 then
			local posSummon = getThingPos(sum[1])
			   if getDistanceBetween(getThingPos(cid), getThingPos(sum[1])) > max or posSummon.z ~= toPosition.z then
				  doTeleportThing(sum[1], getThingPos(cid), false)
				  doSendMagicEffect(getThingPos(sum[1]), eff)
			   end
			end
        return true
     end
     
     if isWild(cid) then
		if getTileInfo(toPosition).itemid == 460 then 
		   return false
		end
		
        if type(toPosition) == "table" and getTileInfo(toPosition).protection then
           return false
        end
		onWalkSetTargetPassive(cid)
		if getDistanceBetween(toPosition, getMarkedSpawnPos(cid)) > 25 then
		  doSendMagicEffect(toPosition, 21)
		  doTeleportThing(cid, getMarkedSpawnPos(cid))
		  doSendMagicEffect(getThingPos(cid), 21)
		  return false
		end
     end
	 
	 if not isWalkable(toPosition, true, true, false, true) then -- bug dos pokes andarem na agua
		return false
	 end
      
      if isSummon(cid) then
           local owner = getCreatureMaster(cid)
      
		  -- Summon nao andar em pz caso seu dono esteja em duel
		  if getTileInfo(toPosition).protection and (getCreatureSkullType(owner) == SKULL_WHITE or getCreatureSkullType(owner) == 1 or getCreatureSkullType(owner) == 2) then
            return false
          end
			
          if getPlayerStorageValue(owner, 500) == -1 then
             return true
          end
		 
         if isRiderOrFlyOrSurf(cid) then 
          local cilinderPos = getSpectators(toPosition, 1, 1, false)
             for i, tid in ipairs(cilinderPos) do 
                 if (isPlayer(tid) and tid == owner) then  
                 
                    if isRider(cid) then 
                     doUp(tid, cid, "ride")
                    elseif isFly(cid) then
                     doUp(tid, cid, "fly")
                    end
                    
                 end
             end
             return true
          elseif isUsingOrder(cid) then
                 local markPos = getMarkedSpawnPos(cid) 
                 local dig = getPlayerStorageValue(cid, orderTalks["dig"].storage)
                 local cut = getPlayerStorageValue(cid, orderTalks["cut"].storage)
                 local rock = getPlayerStorageValue(cid, orderTalks["rock"].storage)
                 local head = getPlayerStorageValue(cid, orderTalks["headbutt"].storage)
                 local item, effe = 0, 0
                 local pos = toPosition
                       pos.stackpos = 0
                 local thing = getThingFromPos(pos)       
                 
                 if cut == 1 then
                    local pos = getCylinderTiles(markPos, 1)
                     for i = 1, #pos do
                         if not isUsingOrder(cid) then break end
		                      if doComparePositions(pos[i], toPosition) then
		                         recheck(cid, "cut", markPos)
		                         break
                        end
                     end
                     return true
                 elseif rock == 1 then
                    local pos = getCylinderTiles(markPos, 1)
                     for i = 1, #pos do
                         if not isUsingOrder(cid) then break end
		                      if doComparePositions(pos[i], toPosition) then
		                         recheck(cid, "rock", markPos)
		                         break
                        end
                     end
                     return true  
                 elseif head == 1 then
                    local pos = getCylinderTiles(markPos, 1)
                     for i = 1, #pos do
                         if not isUsingOrder(cid) then break end
		                      if doComparePositions(pos[i], toPosition) then
		                         recheck(cid, "headbutt", markPos)
		                         break
                        end
                     end
                     return true    
                 end  
                 
                 if doComparePositions(pos, markPos) then
                     if dig == 1 then
                        item = thing.itemid+1
                        effe = EFFECT_DIG  
                     end
                     
                     local thing = getThingFromPos(pos)
                     doMovePokeToPos(cid, fromPosition)
                     doTransformItem(thing.uid, item)
                     doDecayItem(thing.uid)
                     doSendMagicEffect(pos, effe)
                     doEreaseUsingOrder(cid)
                 end  
                 
             return true
          end
        
    end
return true
end