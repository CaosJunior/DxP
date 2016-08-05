local msgs = {"use ", ""}

function doAlertReady(cid, id, movename, n, cd)
	if not isCreature(cid) then return true end
	local myball = getPlayerSlotItem(cid, 8)
	if myball.itemid > 0 and getItemAttribute(myball.uid, cd) == "cd:"..id.."" then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, getPokeballName(myball.uid).." - "..movename.." (m"..n..") is ready!")
	return true
	end
	local p = getPokeballsInContainer(getPlayerSlotItem(cid, 3).uid)
	if not p or #p <= 0 then return true end
	for a = 1, #p do
		if getItemAttribute(p[a], cd) == "cd:"..id.."" then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, getPokeballName(p[a]).." - "..movename.." (m"..n..") is ready!")
		return true
		end
	end
end

function onSay(cid, words, param, channel)


	if param ~= "" then return true end
	if string.len(words) > 3 then return true end

	if #getCreatureSummons(cid) == 0 then
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You need a pokemon to use moves.")
	return 0
	end
                      --alterado v1.5
local mypoke = getCreatureSummons(cid)[1]
local item = getPlayerSlotItem(cid, 8)

	if getCreatureCondition(cid, CONDITION_EXHAUST) then return true end
	if getCreatureName(mypoke) == "Evolution" then return true end
	local name = getItemAttribute(getPlayerSlotItem(cid, 8).uid, "poke")
	local copy = getItemAttribute(item.uid, "copyName") or ""
	
	if isInArray({"ditto", "shiny ditto"}, copy:lower()) then
	   return true
	end
	
    if getItemAttribute(item.uid, "copyName") then -- ditto system
        name = getItemAttribute(item.uid, "copyName")
	elseif  isMega(mypoke) then  --alterado v1.9
	    name = getPlayerStorageValue(mypoke, storages.isMega)
    end  
	
    --local name = getCreatureName(mypoke) == "Ditto" and getPlayerStorageValue(mypoke, 1010) or getCreatureName(mypoke)

local it = string.sub(words, 2, 3)
if not movestable[name] then 
	doSendMsg(cid, "Este pokémon não tem spell.")
	return true 
end
local move = movestable[name].move1
if getPlayerStorageValue(mypoke, 212123) >= 1 then
   cdzin = "cm_move"..it..""
else
   cdzin = "move"..it..""       --alterado v1.5
end

	if it == "2" then
		move = movestable[name].move2
	elseif it == "3" then
		move = movestable[name].move3
	elseif it == "4" then
		move = movestable[name].move4
	elseif it == "5" then
		move = movestable[name].move5
	elseif it == "6" then
		move = movestable[name].move6
	elseif it == "7" then
		move = movestable[name].move7
	elseif it == "8" then
		move = movestable[name].move8
	elseif it == "9" then
		move = movestable[name].move9
	elseif it == "10" then
		move = movestable[name].move10
	elseif it == "11" then
		move = movestable[name].move11
	elseif it == "12" then
		move = movestable[name].move12
	elseif it == "13" then
		move = movestable[name].move13
	end

	local heldy = getItemAttribute(item.uid, "yHeldItem")
	if not move or (string.find(move.name, "- ") and not (heldy and string.find(heldy, "MEGA"))) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Your pokemon doesn't recognize this move.")
	return true
	end
	
	if not string.find(move.name, "Mega") then
		if getPlayerLevel(cid) < move.level then
		   doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You need be atleast level "..move.level.." to use this move.")
		   return true
		end

		if getPlayerGroupId(cid) < 4 and getCD(getPlayerSlotItem(cid, 8).uid, cdzin) > 0 and getCD(getPlayerSlotItem(cid, 8).uid, cdzin) < (move.cd + 2) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have to wait "..getCD(getPlayerSlotItem(cid, 8).uid, cdzin).." seconds to use "..move.name.." again.")
		return true
		end

		if getTileInfo(getThingPos(mypoke)).protection then
			doPlayerSendCancel(cid, "Your pokemon cannot use moves while in protection zone.")
		return true
		end
		
	   if getPlayerStorageValue(mypoke, 3894) >= 1 then
		  return doPlayerSendCancel(cid, "You can't attack because you is with fear") --alterado v1.3
	   end
	end
	                              --alterado v1.6                  
	if (move.name == "Team Slice" or move.name == "Team Claw") and #getCreatureSummons(cid) < 2 then       
	    doPlayerSendCancel(cid, "Your pokemon need be in a team for use this move!")
    return true
    end
	
	if move.passive and move.passive == "sim" then
		return true
	end
         


if move.target == 1 then

	if not isCreature(getCreatureTarget(cid)) then
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You don\'t have any targets.")
	return 0
	end

	if getCreatureCondition(getCreatureTarget(cid), CONDITION_INVISIBLE) then
	return 0
	end

	if getCreatureHealth(getCreatureTarget(cid)) <= 0 then
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Your have already defeated your target.")
	return 0
	end

	if not isCreature(getCreatureSummons(cid)[1]) then
	return true
	end

	if getDistanceBetween(getThingPos(getCreatureSummons(cid)[1]), getThingPos(getCreatureTarget(cid))) > move.dist then
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Get closer to the target to use this move.")
	return 0
	end

	if not isSightClear(getThingPos(getCreatureSummons(cid)[1]), getThingPos(getCreatureTarget(cid)), false) then
	return 0
	end
end

	local newid = 0
	
        if isSleeping(mypoke) or isSilence(mypoke) then  --alterado v1.5
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Sorry you can't do that right now.")
			return 0
		else
			newid = setCD(getPlayerSlotItem(cid, 8).uid, cdzin, move.cd)
		end
		
	if string.find(move.name, "- ") then
	  doCreatureSay(cid, ""..getPokeName(mypoke)..", mega evolução!", TALKTYPE_ORANGE_1)
	else
	  doCreatureSay(cid, ""..getPokeName(mypoke)..", "..msgs[math.random(#msgs)]..""..move.name.."!", TALKTYPE_ORANGE_1)
	end
	
    local summons = getCreatureSummons(cid) --alterado v1.6

	--addEvent(doAlertReady, move.cd * 1000, cid, newid, move.name, it, cdzin)
	
	for i = 2, #summons do
       if isCreature(summons[i]) then
          docastspell(summons[i], move.name)        --alterado v1.6
       end
    end 

    docastspell(mypoke, move.name)
	doCreatureAddCondition(cid, playerexhaust)

	if useKpdoDlls then
		doUpdateCooldowns(cid)
	end

return 0
end