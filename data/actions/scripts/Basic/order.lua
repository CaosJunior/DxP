function onUse(cid, item, frompos, item2, topos) 

if getCreatureCondition(cid, CONDITION_EXHAUST) or isWatchingTv(cid) then return true end
doAddCondition(cid, ordercondition)

local pPos = getThingPos(cid)
      pPos.stackpos = 0
local pos = getThingFromPos(pPos)
      
if isSurf(cid) or isInArray(11756, item2.itemid) or item2.itemid == 11756 or isInArray(11756, pos.itemid) or pos.itemid == 11756 or isInArray({11756, 11675, 11676, 460}, pos.itemid) then
   return doPlayerSendCancel(cid, MSG_NAO_E_POSSIVEL)
end

if item2.uid == cid then -- demound poke
	if isPlayer(item2.uid) and isInDuel(item2.uid) then
	   return doPlayerSendCancel(cid, MSG_NAO_E_POSSIVEL)
	end
   if isRiderOrFlyOrSurf(cid) then 
      local ball = getPlayerSlotItem(cid, 8)
            doGoPokemonInOrder(cid, ball, false)
            doRemoveCondition(cid, CONDITION_OUTFIT)
            doPlayerSay(cid, getCreatureNick(getCreatureSummons(cid)[1]) .. orderTalks["downability"].talks[math.random(#orderTalks["downability"].talks)])
            
            doRegainSpeed(cid)
            
            setPlayerStorageValue(cid, orderTalks["ride"].storage, -1)
            setPlayerStorageValue(cid, orderTalks["fly"].storage, -1)
			doPlayerSendCancel(cid, '12//,show')
      return true
   end
end
--- ride/fly retirada


if isRiderOrFlyOrSurf(cid) then
   return doPlayerSendCancel(cid, MSG_NAO_E_POSSIVEL)
end
   
if #getCreatureSummons(cid) == 0 then
  return doPlayerSendCancel(cid, "Você precisa de um pokemon para usar o order.")
end
	
local poke = getCreatureSummons(cid)[1]
local pokeName = getCreatureNick(poke)
local habilidades = getPokemonSkills(getCreatureName(poke))  
  
if item2.uid == cid then

   if isFight(cid) then  -- EdiÃ§Ã£o pra ficar igual pxg.. nao dar fly ou ride com fight
	   setMoveSummon(cid, false)
	   addEvent(doMovePokeToPos, 5, poke, getThingPos(cid))
	   return true 
   end 
   
   if isMega(poke) then
	 return doPlayerSendCancel(cid, "Pokemons megas não tem habilidades de fly/ride.")
   end
   
    if isPlayer(item2.uid) and (isInDuel(item2.uid) or getCreatureSkullType(item2.uid) == SKULL_WHITE or getCreatureSkullType(item2.uid) == 1 or getCreatureSkullType(item2.uid) == 2) then
	   return doPlayerSendCancel(cid, MSG_NAO_E_POSSIVEL)
	end
   
   if not (getThingPos(poke) or getThingPos(item2.uid)) then -- correÃ§Ã£o de um erro.
      return true
   end
   local dist = getDistanceBetween(getThingPos(poke), getThingPos(item2.uid))   
   --- ride
   if string.find(habilidades, "ride") then
      doPlayerSay(cid, pokeName..orderTalks["ride"].talks[math.random(#orderTalks["ride"].talks)])
      
	  if dist == 1 then
	    doUp(cid, poke, "ride")
	  return true
	  end
	  
      setMoveSummon(cid, false)
      addEvent(doMovePokeToPos, 200, poke, topos)
      setPlayerStorageValue(poke, orderTalks["ride"].storage, 1)
      
   elseif string.find(habilidades, "fly") or string.find(habilidades, "levitate") then
   
       if string.find(habilidades, "levitate") then
          doPlayerSay(cid, pokeName..orderTalks["levitate"].talks[math.random(#orderTalks["levitate"].talks)])
       else
          doPlayerSay(cid, pokeName..orderTalks["fly"].talks[math.random(#orderTalks["fly"].talks)])
       end
	   
	   if dist == 1 then
	    doUp(cid, poke, "fly")
	   return true
	   end
       
      setMoveSummon(cid, false)
      addEvent(doMovePokeToPos, 200, poke, topos)
      setPlayerStorageValue(poke, orderTalks["fly"].storage, 1)
   end  
----------------- Ditto ----------------- 
elseif isMonster(item2.uid) and isInArray({"Shiny Ditto", "Ditto"}, getItemAttribute(getPlayerSlotItem(cid, 8).uid, "poke"))  then
       
	   if isPlayer(item2.uid) and isInDuel(item2.uid) then
	     return doPlayerSendCancel(cid, MSG_NAO_E_POSSIVEL)
	   end
	   
       if isPlayerSummon(cid, item2.uid) and isInArray({"Shiny Ditto", "Ditto"}, getItemAttribute(getPlayerSlotItem(cid, 8).uid, "poke")) and not isInArray({"Shiny Ditto", "Ditto"}, getItemAttribute(getPlayerSlotItem(cid, 8).uid, "copyName")) then 
       
          doCopyPokemon(poke, getItemAttribute(getPlayerSlotItem(cid, 8).uid, "poke"), true)
          doPlayerSay(cid, getCreatureNick(getCreatureSummons(cid)[1])..", reverta-se.")
          return true
          
       elseif not isPlayerSummon(cid, item2.uid) and getPokeName(item2.uid) ~= getPokeName(poke) then    

		if isSummon(item2.uid) then
		   if getPlayerSlotItem(getCreatureMaster(item2.uid), 8).uid ~= 0 and isInArray({"Shiny Ditto", "Ditto"}, getItemAttribute(getPlayerSlotItem(getCreatureMaster(item2.uid), 8).uid, "poke")) then
		      doSendMsg(cid, "Você não pode fazer uma copia de um outro ditto.")
			  return true 
		   end
		end
		   
       local thingName = doCorrectString(getCreatureName(item2.uid))
				if pokes[thingName].level > getPlayerLevel(cid) then
					doSendMsg(cid, "Você não tem level para copiar este pokémon.")
					return true 
				end
                 doCopyPokemon(poke, thingName, true)
                 return true 
                 
       end
                 
      
----------------- Mover ----------------- 
elseif not isCreature(item2.uid) then
    
    setMoveSummon(cid, false)
    doEreaseUsingOrder(poke)
    local oldTopos = getThingPos(item2.uid)
    local oldTopos_2 = topos
    local x, y = 0, 0
         
    if (topos.x - getThingPos(poke).x)  > 0 then
       topos.x = topos.x +1
    elseif (topos.x - getThingPos(poke).x)  < 0 then
       topos.x = topos.x -1
    end
    if (topos.y - getThingPos(poke).y)  > 0 then
       topos.y = topos.y +1    
    elseif (topos.y - getThingPos(poke).y)  < 0 then
       topos.y = topos.y -1
    end  
    
    
    
    setPlayerStorageValue(poke, 505, getThingPos(cid).x)
    setPlayerStorageValue(poke, 506, getThingPos(cid).y)
    
    addEvent(doMovePokeToPos, 5, poke, topos)
    doWalkAgain(poke)
    
    
    ----- EdiÃ§Ãµes dig/cut/rock smash/headbutt/blink
    local buracos = {468, 481, 483} 
    local arvores = {2767}    
    local pedras = {1285}  
    local headbutt = {2707}   

	if item2.uid == 0 then return true end
    local pos = getThingPos(item2.uid)
	local dist = getDistanceBetween(getThingPos(poke), getThingPos(item2.uid)) 
    
       
       if not isFight(cid) then  -- EdiÃ§Ã£o pra ficar igual pxg.. nao dar fly ou ride com fight         
          if isInArray(buracos, item2.itemid) then   ----------------------- DIG
          
             if not string.find(habilidades, "dig") then
                return doPlayerSendCancel(cid, "Esse pokemon não tem a habilidade de cavar.")
             end
             
             doMarkedPos(poke, getThingPos(item2.uid))
             doEreaseUsingOrder(cid)
             setPlayerStorageValue(poke, orderTalks["dig"].storage, 1)
             setMoveSummon(cid, false)
			 if dist == 1 then
				recheck(poke, "cut", getThingPos(item2.uid))
			 else 
			    addEvent(doMovePokeToPos, 200, poke, topos)
             end
             doPlayerSay(cid, getCreatureNick(poke)..orderTalks["dig"].talks[math.random(#orderTalks["dig"].talks)])
             
             return true
          elseif isInArray(arvores, item2.itemid) then   ----------------------- CUT
          
             if not string.find(habilidades, "cut") then
                return doPlayerSendCancel(cid, "Esse pokemon não tem a habilidade de cortar.")
             end
             
                doMarkedPos(poke, getThingPos(item2.uid))
                doEreaseUsingOrder(cid)
                setPlayerStorageValue(poke, orderTalks["cut"].storage, 1)
                setMoveSummon(cid, false)
                if dist == 1 then
                  addEvent(recheck, (1000 - (2.3*getCreatureSpeed(poke))) * dist, poke, "cut", getThingPos(item2.uid))
			    else 
			      addEvent(doMovePokeToPos, 200, poke, topos)
                end
                doPlayerSay(cid, getCreatureNick(poke)..orderTalks["cut"].talks[math.random(#orderTalks["cut"].talks)])
                return true
          elseif isInArray(pedras, item2.itemid) then   ----------------------- ROCK
          
             if not string.find(habilidades, "rock smash") then
                return doPlayerSendCancel(cid, "Esse pokemon não tem a habilidade de quebrar.")
             end
             
             local pos = getThingPos(item2.uid)
                doMarkedPos(poke, getThingPos(item2.uid))
                doEreaseUsingOrder(cid)
                setPlayerStorageValue(poke, orderTalks["rock"].storage, 1)
                setMoveSummon(cid, false)
                if dist == 1 then
                  addEvent(recheck, (1000 - (2.3*getCreatureSpeed(poke))) * dist, poke, "rock", getThingPos(item2.uid))
				else 
			      addEvent(doMovePokeToPos, 200, poke, topos)
                end
                doPlayerSay(cid, getCreatureNick(poke)..orderTalks["rock"].talks[math.random(#orderTalks["rock"].talks)])
                return true
				
          elseif isInArray(headbutt, item2.itemid) then   ----------------------- HEAD
          
             if not string.find(habilidades, "headbutt") then
                return doPlayerSendCancel(cid, "Esse pokemon nao tem a habilidade de balancar Arvores.")
             end
             
            local pos = getThingPos(item2.uid)
                doMarkedPos(poke, getThingPos(item2.uid))
                doEreaseUsingOrder(cid)
                setPlayerStorageValue(poke, orderTalks["headbutt"].storage, 1)
                setMoveSummon(cid, false)
                if dist <= 1 then
                  addEvent(recheck, (1000 - (2.3*getCreatureSpeed(poke))) * dist, poke, "headbutt", getThingPos(item2.uid))
				else 
			      addEvent(doMovePokeToPos, 200, poke, topos)
                end
                doPlayerSay(cid, getCreatureNick(poke)..orderTalks["headbutt"].talks[math.random(#orderTalks["headbutt"].talks)])
                
             return true
          end
          end
          if string.find(habilidades, "blink") then
                  if os.time() < getPlayerStorageValue(poke, storages.blink) and not isGod(cid) then
                     doPlayerSay(cid, getCreatureNick(poke)..orderTalks["move"].talks[math.random(#orderTalks["move"].talks)])
					 return true
                  elseif (getCreatureSkullType(cid) == SKULL_WHITE or isInDuel(cid)) and getTileInfo(getThingPos(item2.uid)).protection then 
				     doSendMsg(cid, "Você não pode usar blink em protection zone quando está em duelo.")
					 return true
                  end
                       setPlayerStorageValue(poke, storages.blink, os.time()+7)
                       doSendMagicEffect(getThingPos(poke), 134)  
                       doTeleportThing(poke, getThingPos(item2.uid), false)
                       doSendMagicEffect(getThingPos(poke), 134)
                       doPlayerSay(cid, getCreatureNick(poke)..orderTalks["blink"].talks[math.random(#orderTalks["blink"].talks)])
          
              return true
          end
         
         doPlayerSay(cid, getCreatureNick(poke)..orderTalks["move"].talks[math.random(#orderTalks["move"].talks)])
    
end    
    return true
end

function isGhost(cid)
local hab = getPokemonSkills(string.lower(getPokeName(cid)))
   if string.find(hab, "ghost")  then
      return true
   end
  return false
end
