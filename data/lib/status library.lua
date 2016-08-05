function doSilence(target, rounds, effect, check)     --Sistema de 'Silence'
if not isCreature(target) then return true end
if getPlayerStorageValue(target, 21099) >= 1 then return true end --reflect
if getPlayerStorageValue(target, 32698) >= 1 and rounds ~= -1 then return true end

if check and check ~= getPlayerStorageValue(target, 32698) then return true end

	if not check and getPlayerStorageValue(target, 32698) >= 1 then
		setPlayerStorageValue(target, 32698, getPlayerStorageValue(target, 32698) + rounds - 1)
	else
		setPlayerStorageValue(target, 32698, getPlayerStorageValue(target, 32698) + rounds)
	end

	local a = getPlayerStorageValue(target, 32698)
                                                                                        --alterado v1.4!!
	if isSummon(target) then
		local item = getPlayerSlotItem(getCreatureMaster(target), 8)
		doItemSetAttribute(item.uid, "silenceSyst", a)
		doItemSetAttribute(item.uid, "silenceEff", effect)
	end

	if a <= -1 then setPlayerStorageValue(target, 32698, -1) return true end
	
	doSendMagicEffect(getThingPos(target), effect)

    addEvent(doSilence, 1000, target, -1, effect, a)
end



function isSleeping(cid)
if isCreature(cid) then
	if getPlayerStorageValue(cid, 98271) >= 1 then
	return true
	end
	if getPlayerStorageValue(cid, 32698) >= 1 then
	return true          --alterado v1.4 - silence system
	end
end
return false
end

function doSendSleepEffect(cid)
	if not isCreature(cid) or not isSleeping(cid) then return true end
	doSendMagicEffect(getThingPos(cid), 32)
	addEvent(doSendSleepEffect, 1500, cid)
end


function doSleep(target, rounds, first)

local cid = target

	if not isCreature(target) then
	return true
	end

    if getPlayerStorageValue(target, 21099) >= 1 then return true end  --edited reflect
    if getPlayerStorageValue(target, 98271) >= 1 and rounds ~= 0 then return true end  --edited pra nao contar os efeitos
    
	if not isSleeping(target) then
		addEvent(doSendSleepEffect, 500, target)
	end

	if isSleeping(target) and first then
		setPlayerStorageValue(target, 98271, getPlayerStorageValue(target, 98271) + rounds)
	return true
	end

    local outfits = {366, 912, 1317, 952, 909, 910} 
    if isInArray(outfits, getCreatureOutfit(target).lookType) then
       setPlayerStorageValue(target, 98654, getCreatureOutfit(target).lookType)    --edited pra da passivas ms quando esta durmindo!!
    end
    
    if isPlayer(target) then
       mayNotMove(target, true)
    else
	   doChangeSpeed(target, -getCreatureSpeed(target))
    end

if not isPlayer(cid) then
   passivaOutfit = {652, 878, 496, 918, 849, 1193, 1194, 1192}
   Info = getMonsterInfo(getCreatureName(target)).lookCorpse                --edited pra da passivas ms quando esta durmindo!!
   look = getCreatureOutfit(target) 
end

	if isMonster(target) then
		if getCreatureName(target) == "Ditto" and isSummon(target) and getPlayerStorageValue(target, 1010) ~= "Ditto" then
			local InfoDitto = getMonsterInfo(getPlayerStorageValue(target, 1010)).lookCorpse
            if InfoDitto ~= 0 and look.lookType ~= 0 and not isInArray(passivaOutfit, look.lookType) then             
               doSetCreatureOutfit(target, {lookType = 0, lookTypeEx = getMonsterInfo(getPlayerStorageValue(target, 1010)).lookCorpse}, -1)
		    end   
        else                                                                                                 --edited pra da passivas ms quando esta durmindo!!
            if Info ~= 0 and look.lookType ~= 0 and not isInArray(passivaOutfit, look.lookType) then
			   doSetCreatureOutfit(target, {lookType = 0, lookTypeEx = getMonsterInfo(getCreatureName(target)).lookCorpse}, -1)
		    end
        end
	end

	if rounds and rounds > 0 then
		setPlayerStorageValue(target, 98271, rounds)
		if isSummon(target) then
			doItemSetAttribute(getPlayerSlotItem(getCreatureMaster(cid), 8).uid, "sleep", rounds)
		end
	end

	setPlayerStorageValue(target, 98271, getPlayerStorageValue(target, 98271) - 1)

	if getPlayerStorageValue(target, 98271) <= 0 then
		if isPlayer(target) then
		   mayNotMove(target, false)
        else
           doRegainSpeed(target)
		end
        if not isPlayer(target) then
			if getCreatureName(target) == "Ditto" and isSummon(target) and getPlayerStorageValue(target, 1010) ~= "Ditto" then
				doSetCreatureOutfit(target, {lookType = getItemAttribute(getPlayerSlotItem(getCreatureMaster(target), 8).uid, "transOutfit")}, -1)
			else
				doRemoveCondition(target, CONDITION_OUTFIT)
			end
			if getPlayerStorageValue(target, 98654) >= 1 then
               setPlayerStorageValue(target, 98654, -1)
            end 
		end
	return true
	end

		if isSummon(target) then
			doItemSetAttribute(getPlayerSlotItem(getCreatureMaster(cid), 8).uid, "sleep", getPlayerStorageValue(cid, 98271))
		end
	addEvent(doSleep, 1100, target, 0, false)
return true
end

function doAdvancedConfuse(target, rounds, check, cid)
	if not isCreature(target) then return true end
    if getPlayerStorageValue(target, 21099) >= 1 then return true end  --edited reflect
    if cid and canAttackOther(cid, target) == "Cant" then return true end    --edited PVP system
    if isPlayer(target) and getPlayerStorageValue(target, 6598754) <= 0 and getPlayerStorageValue(target, 6598755) <= 0 then
       return true 
    end
    if getPlayerStorageValue(target, 3891) >= 1 and rounds ~= -1 then return true end   --edited pra nao contar os efeitos
                                                                  
	if check and check ~= getPlayerStorageValue(target, 3891) then return true end

	if not check and getPlayerStorageValue(target, 3891) >= 1 then
		setPlayerStorageValue(target, 3891, getPlayerStorageValue(target, 3891) + rounds - 1)
	else
		setPlayerStorageValue(target, 3891, getPlayerStorageValue(target, 3891) + rounds)
	end

	local a = getPlayerStorageValue(target, 3891)

	if isSummon(target) then
		local item = getPlayerSlotItem(getCreatureMaster(target), 8)
		doItemSetAttribute(item.uid, "confuse", a)
	end

	if a <= -1 then if getCreatureCondition(target, CONDITION_PARALYZE) then addEvent(doRegainSpeed, 4000, target) else doRegainSpeed(target) end setPlayerStorageValue(target, 3891, -1) return true end

	local p = getThingPos(target)

	if math.random(1, 6) >= 4 then
		doSendMagicEffect(getThingPos(target), 31)
	end

    local isTarget = isSummon(target) and getCreatureTarget(getCreatureMaster(target)) or getCreatureTarget(target)
    if isCreature(isTarget) then
		doChangeSpeed(target, -getCreatureSpeed(target))
		doChangeSpeed(target, 100)
	    if not isSleeping(target) and getPlayerStorageValue(target, 654878) <= 0 then
		   doPushCreature(target, math.random(0, 3), 1, 0)    --alterado v1.4
	    end
		doChangeSpeed(target, -100)
	end

	local pos = getThingPos(target)
	addEvent(doSendMagicEffect, math.random(0, 450), pos, 31)

	addEvent(doAdvancedConfuse, 1000, target, -1, a)
end

local feardirections = {
[NORTH] = {SOUTH, WEST, EAST},
[SOUTH] = {NORTH, WEST, EAST},
[WEST] = {SOUTH, NORTH, EAST},
[EAST] = {SOUTH, WEST, NORTH}}

local roardirections = {
[NORTH] = {SOUTH},
[SOUTH] = {NORTH},
[WEST] = {EAST},           --edited sistema de roar
[EAST] = {WEST}}

function doAdvancedFear(target, rounds, check, cid, spell, baseoff) --baseoff
	if not isCreature(target) then return true end
	if not isCreature(cid) then
       doRegainSpeed(target)
	   setPlayerStorageValue(target, 3894, -1)
    return true 
    end
	if getPlayerStorageValue(target, 21099) >= 1 then return true end --edited reflect
    if cid and canAttackOther(cid, target) == "Cant" then return true end  --edited PVP system
    if isPlayer(target) and getPlayerStorageValue(target, 6598754) <= 0 and getPlayerStorageValue(target, 6598755) <= 0 then
       return true 
    end
    if getPlayerStorageValue(target, 3894) >= 1 and rounds ~= -1 then return true end   --edited pra nao contar os efeitos
    
	if check and check ~= getPlayerStorageValue(target, 3894) then return true end

	if not check and getPlayerStorageValue(target, 3894) >= 1 then
		setPlayerStorageValue(target, 3894, getPlayerStorageValue(target, 3894) + rounds - 1)
	else
		setPlayerStorageValue(target, 3894, getPlayerStorageValue(target, 3894) + rounds)
	end

	local a = getPlayerStorageValue(target, 3894)

    if isSummon(target) then
		local item = getPlayerSlotItem(getCreatureMaster(target), 8)
		doItemSetAttribute(item.uid, spell, a)
	end
	
	if a <= -1 then
		doRegainSpeed(target)
		setPlayerStorageValue(target, 3894, -1)
	return true
	end

	local p = getThingPos(target)

    if spell == "Roar" then
       eff = 244
    else                --edited Roar
       eff = 139
    end
    
	if math.random(1, 6) >= 4 then 
		doSendMagicEffect(getThingPos(target), eff)
	end

	local dir = getCreatureDirectionToTarget(target, cid)

		doChangeSpeed(target, -getCreatureSpeed(target))
		doChangeSpeed(target, 100)
		local delay = getNextStepDelay(target, 0)

	if not isSleeping(target) then
	    if isCreature(getCreatureTarget(target)) then   --edited attacker precisa ter cid como target
	        doPushCreature(target, roardirections[dir][1], 1, 0)
        end
		doChangeSpeed(target, -100)
    end
    
	    local pos = getThingPos(target)
        addEvent(doSendMagicEffect, math.random(0, 450), pos, eff)
	    addEvent(doAdvancedFear, delay, target, -1, a, cid, spell)
end


function doAdvancedPoison(cid, master, target, damage, rounds, check)
	if not isCreature(target) then return true end
    if getPlayerStorageValue(target, 21099) >= 1 then return true end --edited reflect
    if cid and canAttackOther(cid, target) == "Can" then return true end  --edited PVP System
    if isPlayer(target) and getPlayerStorageValue(target, 6598754) <= 0 and getPlayerStorageValue(target, 6598755) <= 0 then
       return true 
    end
    if getPlayerStorageValue(target, 3893) >= 1 and rounds ~= -1 then return true end  --edited pra nao contar os efeitos
    
	if isSummon(target) then
		local x = getCreatureMaster(target)
		local y = getPlayerSlotItem(x, 8).uid
		doItemSetAttribute(y, "poisondmg", damage)
	end

	if check and check ~= getPlayerStorageValue(target, 3893) then return true end

	if not check and getPlayerStorageValue(target, 3893) >= 1 then
		setPlayerStorageValue(target, 3893, getPlayerStorageValue(target, 3893) + rounds - 1)
	else
		setPlayerStorageValue(target, 3893, getPlayerStorageValue(target, 3893) + rounds)
	end
	local a = getPlayerStorageValue(target, 3893)

	if isSummon(target) and a >= 0 then
		doItemSetAttribute(getPlayerSlotItem(getCreatureMaster(target), 8).uid, "poison", getPlayerStorageValue(target, 3893))
	end

	if a <= -1 then setPlayerStorageValue(target, 3893, -1) return true end

	local x = math.abs(damage)
		if not isCreature(cid) and isCreature(master) then
			x = x * getResistance(target, POISONDAMAGE)
		end
	if isPlayer(target) and getCreatureHealth(target) <= x then
		x = getCreatureHealth(target) - 1
	end
		doSendMagicEffect(getThingPos(target), 8)
	if isCreature(cid) and cid ~= target then
		doAreaCombatHealth(cid, POISONEDDAMAGE, getThingPos(target), 0, -x, -x, 8)
	elseif not isCreature(cid) and isCreature(master) then
		doAreaCombatHealth(master, POISONEDDAMAGE, getThingPos(target), 0, -x, -x, 8)
	else
		doCreatureAddHealth(target, -x, 8, COLOR_GRASS)
	end
		addEvent(doAdvancedPoison, 2500, cid, master, target, damage, -1, a)
end

function doAdvancedBurn(cid, master, target, damage, rounds, check)
	if not isCreature(target) then return true end
    if getPlayerStorageValue(target, 21099) >= 1 then return true end --edited reflect
    if cid and canAttackOther(cid, target) == "Cant" then return true end --edited PVP system
    if isPlayer(target) and getPlayerStorageValue(target, 6598754) <= 0 and getPlayerStorageValue(target, 6598755) <= 0 then
       return true 
    end
    if getPlayerStorageValue(target, 3892) >= 1 and rounds ~= -1 then return true end  --edited pra nao contar os efeitos
    
	if isSummon(target) then
		local x = getCreatureMaster(target)
		local y = getPlayerSlotItem(x, 8).uid
		doItemSetAttribute(y, "burndmg", damage)
	end

	if check and check ~= getPlayerStorageValue(target, 3892) then return true end

	if not check and getPlayerStorageValue(target, 3892) >= 1 then
		setPlayerStorageValue(target, 3892, getPlayerStorageValue(target, 3892) + rounds - 1)
	else
		setPlayerStorageValue(target, 3892, getPlayerStorageValue(target, 3892) + rounds)
	end
	local a = getPlayerStorageValue(target, 3892)

	if isSummon(target) then
		local item = getPlayerSlotItem(getCreatureMaster(target), 8)
		doItemSetAttribute(item.uid, "burn", a)
	end

	if a <= -1 then setPlayerStorageValue(target, 3892, -1) return true end

	local x = math.abs(damage)
		if not isCreature(cid) and isCreature(master) then
			x = x * getResistance(target, FIREDAMAGE)
		end
	if isPlayer(target) and getCreatureHealth(target) <= x then
		x = getCreatureHealth(target) - 1
	end
		doSendMagicEffect(getThingPos(target), 15)
	if isCreature(cid) and cid ~= target then
		doAreaCombatHealth(cid, BURNEDDAMAGE, getThingPos(target), 0, -x, -x, 15)
	elseif not isCreature(cid) and isCreature(master) then
		doAreaCombatHealth(master, BURNEDDAMAGE, getThingPos(target), 0, -x, -x, 15)
	else
		doCreatureAddHealth(target, -x, 15, COLOR_BURN)
	end
		addEvent(doAdvancedBurn, 5000, cid, master, target, damage, -1, a)
end

local injuries = {
[1] = {n = "burn", m = 3892},
[2] = {n = "poison", m = 3893},
[3] = {n = "confuse", m = 3891},
[4] = {n = "Fear", m = 3894},
[5] = {n = "sleep", m = 98271},
[6] = {n = "missSyst", m = 32659},  --edited novos sistemas
[7] = {n = "Roar", m = 3894},
[8] = {n = "silenceSyst", m = 32698}     --alterado v1.4
}


function doCureStatus(cid, type, playerballs)    --alterado v1.9 \/
	if not isCreature(cid) then return true end
	if playerballs and isPlayer(cid) then
		local bp = getPlayerSlotItem(cid, CONST_SLOT_BACKPACK)
		local mb = getPlayerSlotItem(cid, 8)
		local balls = getPokeballsInContainer(bp.uid)
		if isPokeball(mb.itemid) then
			if not type or type == "all" then
				for b = 1, #injuries2 do
				    doItemSetAttribute(mb.uid, ""..injuries2[b].n.."", -1)
				end
			else
				doItemSetAttribute(mb.uid, ""..type.."", -1)
			end
		end
		if #balls >= 1 then
		   for _, uid in ipairs(balls) do
		       if not type or type == "all" then
					for b = 1, #injuries2 do
					doItemSetAttribute(uid, ""..injuries2[b].n.."", -1)
					end
				else
					doItemSetAttribute(uid, ""..type.."", -1)
				end
            end
        end    
	end
	if type == "all" then
		for a = 1, #injuries2 do
			setPlayerStorageValue(cid, injuries2[a].m, -1)
		end
	return true
	end
	for a, b in pairs (injuries2) do
		if b.n == type then
		setPlayerStorageValue(cid, b.m, -1)
		end
	end
end 

function isWithCondition(cid)
for i = 1, #injuries do 
   if getPlayerStorageValue(cid, injuries[i].m) >= 1 then
      return true
   end                             --alterado v1.4
end
return false
end
      
function doCureBallStatus(item, type)
	if not type or type == "all" then
		for b = 1, #injuries do
		doItemSetAttribute(item, ""..injuries[b].n.."", -1)
		end
	else
		doItemSetAttribute(item, ""..type.."", -1)
	end
end
	

function getRoundsLeft(cid, type)
	if not isCreature(cid) then return 0 end
	for a, b in pairs (injuries) do
		if b.n == type then
		return getPlayerStorageValue(cid, b.m) + 1
		end
	end
print("Error on function getRoundsLeft(cid, type) - type doesn't exist.")
return 0
end

function isBurning(cid)
	if not isCreature(cid) then return false end
	if getPlayerStorageValue(cid, 3892) >= 0 then return true end
return false
end

function isPoisoned(cid)
	if not isCreature(cid) then return false end
	if getPlayerStorageValue(cid, 3893) >= 0 then return true end
return false
end