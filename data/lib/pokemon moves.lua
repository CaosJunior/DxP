const_distance_delay = 56

function doForceDanoSpeel(cid, moveName)
local name = doCorrectString(getCreatureName(cid))
local masterLevel = (isSummon(cid) and getPlayerLevel(getCreatureMaster(cid)) or getPokemonLevelByName(name))
	    min = (getMoveForce(name, moveName) / 2) + (masterLevel * 1.5) --alterado v1.6
	    max = getMoveForce(name, moveName) + (masterLevel * 1.5) --min + (isSummon(cid) and getMasterLevel(cid) or getPokemonLevel(cid))
		return math.random(min, max)
end

function doForceDano(cid)
local name = doCorrectString(getCreatureName(cid))
local masterLevel = (isSummon(cid) and getPlayerLevel(getCreatureMaster(cid)) or getPokemonLevelByName(name))
	    min = (getMoveForce(name, moveName) / 2) + (masterLevel * 1.5) --alterado v1.6
	    max = getMoveForce(name, moveName) + (masterLevel * 1.5) --min + (isSummon(cid) and getMasterLevel(cid) or getPokemonLevel(cid))
		return math.random(min, max)
end

function isShredTEAM(cid)
	if getPlayerStorageValue(cid, 637500) >= 1 then
	   return true 
	end
	return false
end

--//////////////////////////////////////////////////////////////////////////////////////////////////////////--
local function getSubName(cid, target)
if not isCreature(cid) then return "" end
if getCreatureName(cid) == "Ditto" and pokes[getPlayerStorageValue(cid, 1010)] and getPlayerStorageValue(cid, 1010) ~= "Ditto" then
   return getPlayerStorageValue(cid, 1010)
elseif pokeHaveReflect(cid) and isCreature(target) then
   return getCreatureName(target)
else                                                                --alterado v1.6.1
   return getCreatureName(cid)
end
end

local function getThingName(cid)
if not isCreature(cid) then return "" end   --alterado v1.6
return getCreatureName(cid)
end


function getMasterTarget(cid)
if isCreature(cid) and getPlayerStorageValue(cid, 21101) ~= -1 then
   return getPlayerStorageValue(cid, 21101)     --alterado v1.6
end
    if isSummon(cid) then
	    return getCreatureTarget(getCreatureMaster(cid))
	else
	    return getCreatureTarget(cid)
    end
end
--////////////////////////////////////////////////////////////////////////////////////////////////////////--

function docastspell(cid, spell, reflectName)

local target = 0
local getDistDelay = 0
if not isCreature(cid) or getCreatureHealth(cid) <= 0 then return false end  --alterado v1.6
if isSleeping(cid) and getPlayerStorageValue(cid, 21100) <= -1 then return true end  --alterado v1.6

if isCreature(getMasterTarget(cid)) then
	target = getMasterTarget(cid)
	getDistDelay = getDistanceBetween(getThingPosWithDebug(cid), getThingPosWithDebug(target)) * const_distance_delay
end

if isMonster(cid) and not isSummon(cid) then
	if getCreatureCondition(cid, CONDITION_EXHAUST) then
	return true
	end
	doCreatureAddCondition(cid, wildexhaust)
end

local mydir = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)
local name = getCreatureName(cid)
	  if reflectName and reflectName ~= "" then
		 name = reflectName
	  end
	  name = doCorrectString((name))
	  
	  if isMega(cid) then
	     name = getPlayerStorageValue(cid, storages.isMega)
      end
	  
local table = getTableMove(name, spell) --alterado v1.6

local min = 0
local max = 0

--- FEAR / ROAR / SILENCE ---
if (isWithFear(cid) or isSilence(cid)) and getPlayerStorageValue(cid, 21100) <= -1 then
return true                                      --alterado v1.6!!
end
----------------------------min= 1000 + 
	if table ~= "" and table ~= nil then   --alterado v1.6
		local masterLevel = (isSummon(cid) and getPlayerLevel(getCreatureMaster(cid)) or getPokemonLevelByName(doCorrectString(getCreatureName(cid))))
		local mutiplay = 0.1
		
		if masterLevel > 20 and masterLevel < 30 then -- 21 ao 29
			mutiplay = 1.2
		elseif masterLevel > 29 and masterLevel < 61 then -- 30 ao 60
			mutiplay = 1.3
		elseif  masterLevel > 60 and masterLevel < 86 then -- 61 ao 85
			mutiplay = 1.4
		elseif masterLevel > 85 and masterLevel < 121 then -- 86 ao 120
			mutiplay = 1.5
		elseif masterLevel > 120 and masterLevel < 181 then -- 121 ao 180
			mutiplay = 1.6
		elseif  masterLevel > 180 and masterLevel < 221 then -- 181 ao 220
			mutiplay = 1.7
		elseif masterLevel > 220 and masterLevel < 351 then -- 221 ao 350
			mutiplay = 1.8
		elseif masterLevel > 351 then -- 350++
			mutiplay = 1.9
		end
		
		if string.find(getCreatureName(cid):lower(), "shiny") then
			mutiplay = 2
		end
		
	    min = getSpecialAttack(cid) * table.f * mutiplay   --alterado v1.6
	    max = min + (isSummon(cid) and getMasterLevel(cid) or getPokemonLevel(cid))
	
	    if spell == "Selfdestruct" then
	       min = getCreatureHealth(cid)  --alterado v1.6
	       max = getCreatureHealth(cid)
        end

		if not isSummon(cid) and not isInArray({"Demon Puncher", "Demon Kicker"}, spell) then --alterado v1.7
			doCreatureSay(cid, string.upper(spell).."!", TALKTYPE_MONSTER)
		end
		if isNpcSummon(cid) then
			local mnn = {" use ", " "}
			local use = mnn[math.random(#mnn)]
			doCreatureSay(getCreatureMaster(cid), getPlayerStorageValue(cid, 1007)..","..use..""..doCorrectString(spell).."!", 1)
		end
	else
	local namePoke = doCorrectString(getCreatureName(cid))
	local remover = removeSpellInXML(namePoke, spell)
	if remover then print("Magia: " .. spell .. " removida do XML: " .. namePoke .. ".xml") end
	end
--- FOCUS ----------------------------------           
if getPlayerStorageValue(cid, 253) >= 0 and table ~= "" and table.f ~= 0 then   --alterado v1.6
	min = min * 2
	max = max * 2
	setPlayerStorageValue(cid, 253, -1)
end
--- Shredder Team -------------------------------
if getPlayerStorageValue(cid, 637501) >= 1 then
   if #getCreatureSummons(cid) == 1 then
      docastspell(getCreatureSummons(cid)[1], spell)
   elseif #getCreatureSummons(cid) == 2 then
      docastspell(getCreatureSummons(cid)[1], spell)
      docastspell(getCreatureSummons(cid)[2], spell)
   end                              
end
------------------Miss System--------------------------
local cd = getPlayerStorageValue(cid, conds["Miss"])
local cd2 = getPlayerStorageValue(cid, conds["Confusion"])      --alterado v1.5
local cd3 = getPlayerStorageValue(cid, conds["Stun"]) 
	if cd >= 0 or cd2 >= 0 or cd3 >= 0 then                                                         --alterado v1.7
	   if not isInArray({"Shock-Counter", "Lava-Counter", "Counter Helix", "Demon Puncher", "Demon Kicker", "Stunning Confusion", "Electric Charge", "Melody", "Mirror Coat", "Mega Drain", 
	"Aromateraphy", "Heal Bell", "Emergency Call", "Magical Leaf", "Sunny Day", "Taunt", "Skull Bash", "Safeguard", "Rain Dance", "Spores Reaction", "Giroball", "Counter Claw", "Counter Spin", "Dragon Fury", 
	"Amnesia", "Zen Mind", "Bone Spin"}, spell) and getPlayerStorageValue(cid, 21100) <= -1 then
		if not string.find(spell, "Mega") then	
		   if math.random(1, 100) > 30 then                                                                               --alterado v1.6
			 doSendAnimatedText(getThingPosWithDebug(cid), "MISS", 215)
			 return false
		   end
		end
	end
end
---------------GHOST DAMAGE-----------------------
ghostDmg = GHOSTDAMAGE
psyDmg = PSYCHICDAMAGE

if getPlayerStorageValue(cid, 999457) >= 1 and table ~= "" and table.f ~= 0 then    --alterado v1.6
   psyDmg = MIRACLEDAMAGE                                                              
   ghostDmg = DARK_EYEDAMAGE
   addEvent(setPlayerStorageValue, 50, cid, 999457, -1)
end
--------------------REFLECT----------------------
setPlayerStorageValue(cid, 21100, -1)                --alterado v1.6
if not isInArray({"Psybeam", "Sand Attack", "Flamethrower", "Heal Bell"}, spell) then  --alterado v1.8
   setPlayerStorageValue(cid, 21101, -1)
end
setPlayerStorageValue(cid, 21102, spell)
---------------------------------------------------



if spell == "Reflect" or spell == "Mimic"  or spell == "Magic Coat" then

    if spell == "Magic Coat" then
      eff = 11
    else
      eff = 135
    end

	doSendMagicEffect(getThingPosWithDebug(cid), eff)
	setPlayerStorageValue(cid, storages.reflect, 1)        
	
elseif spell == "Quick Attack" then

   doDanoWithProtect(cid, NORMALDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 111)

elseif spell == "Razor Leaf" or spell == "Magical Leaf" then                      

local eff = spell == "Razor Leaf" and 8 or 21

local function throw(cid, target)
if not isCreature(cid) or not isCreature(target) then return false end
    doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), eff)
	doDanoInTargetWithDelay(cid, target, GRASSDAMAGE, min, max, 245)  --alterado v1.7
end

addEvent(throw, 0, cid, target)
addEvent(throw, 100, cid, target) --alterado v1.7

elseif spell == "Fire Fist" then 

local function throw(cid, target)
if not isCreature(cid) or not isCreature(target) then return false end
    doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 92)
	doDanoInTargetWithDelay(cid, target, GRASSDAMAGE, min, max, 355)  --alterado v1.7
	pos = getThingPos(target)
	pos.x = pos.x +1
	doSendMagicEffect(pos, 357)
end

local function voltar(cid, target)
if not isCreature(cid) then return true end
	doRemoveCondition(cid, CONDITION_OUTFIT)
	doRegainSpeed(cid)
	doRegainSpeed(target)
	doPantinOutfit(cid, 0, getPlayerStorageValue(cid, storages.isMega))
end

doSetCreatureOutfit(cid, {lookType = 1875}, -1) 
doChangeSpeed(cid, -getCreatureSpeed(cid))
doChangeSpeed(target, -getCreatureSpeed(target))
addEvent(throw, 200, cid, target)
addEvent(throw, 800, cid, target) --alterado v1.7
addEvent(throw, 1200, cid, target) --alterado v1.7
addEvent(voltar, 1501, cid, target)

		
elseif spell == "Vine Whip" then

local area = getThingPosWithDebug(cid)
local dano = {}
local effect = 255

	if mydir == 0 then
		area.x = area.x + 1
		area.y = area.y - 1
		dano = whipn
		effect = 80
	elseif mydir == 1 then
		area.x = area.x + 2
		area.y = area.y + 1
		dano = whipe
		effect = 83
	elseif mydir == 2 then
		area.x = area.x + 1
		area.y = area.y + 2		
		dano = whips
		effect = 81
	elseif mydir == 3 then
		area.x = area.x - 1
		area.y = area.y + 1
		dano = whipw
		effect = 82
	end

		doSendMagicEffect(area, effect)
		doAreaCombatHealth(cid, GRASSDAMAGE, getThingPosWithDebug(cid), dano, -min, -max, 255)
		
elseif spell == "Headbutt" then
       
       doAreaCombatHealth(cid, NORMALDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 118)
       
elseif spell == "Leech Seed" then

    local ret = {}
    ret.id = target
    ret.attacker = cid
    ret.cd = 5
    ret.check = getPlayerStorageValue(target, conds["Leech"])
    ret.damage = isSummon(cid) and getMasterLevel(cid)+getPokemonBoost(cid) or getPokemonLevelD(doCorrectString(getCreatureName(cid)))
    ret.cond = "Leech"
    
	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 1)
	addEvent(doMoveDano2, 1000, cid, target, GRASSDAMAGE, 0, 0, ret, spell)
	
elseif spell == "Protection" then

    local pos = getPosfromArea(cid, heal)
    local n = 0
    
    while n < #pos do
    n = n+1
    thing = {x=pos[n].x,y=pos[n].y,z=pos[n].z,stackpos=253}
    local pid = getThingFromPosWithProtect(thing)
    local pospid = getThingPosWithDebug(pid)
    local poscid = getThingPosWithDebug(cid)

    doSendMagicEffect(pos[n], 12)
    for i = 0, 9 do
    if isCreature(pid) then
        if isSummon(cid) and (isSummon(pid) or isPlayer(pid)) then
            if canAttackOther(cid, pid) == "Cant" then
                doCreatureSetNoMove(pid, true)
                doCreatureSetNoMove(cid, true)
                setPlayerStorageValue(pid, 9658783, 1)
                setPlayerStorageValue(cid, 9658783, 1)
                addEvent(doSendMagicEffect, i*800, pospid, 117)
                addEvent(doSendMagicEffect, i*800, poscid, 117)
                addEvent(setPlayerStorageValue, 8000, pid, 9658783, -1)
                addEvent(setPlayerStorageValue, 8000, cid, 9658783, -1)
                addEvent(doCreatureSetNoMove, 8000, pid, false)
                addEvent(doCreatureSetNoMove, 8000, cid, false)
            end
        elseif ehMonstro(cid) and ehMonstro(pid) then
            doCreatureSetNoMove(pid, true)
            doCreatureSetNoMove(cid, true)
            setPlayerStorageValue(pid, 9658783, 1)
            setPlayerStorageValue(cid, 9658783, 1)
            addEvent(doSendMagicEffect, i*800, pospid, 117)
            addEvent(doSendMagicEffect, i*800, poscid, 117)
            addEvent(setPlayerStorageValue, 8000, pid, 9658783, -1)
            addEvent(setPlayerStorageValue, 8000, cid, 9658783, -1)
            addEvent(doCreatureSetNoMove, 8000, pid, false)
            addEvent(doCreatureSetNoMove, 8000, cid, false)
        end
    end
    end
    end

elseif spell == "Solar Beam" then
	
local function useSolarBeam(cid)
		if not isCreature(cid) then
		return true
		end
		if isSleeping(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then
		return true
		end
		if isWithFear(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then
		return true
		end
			local effect1 = 255
			local effect2 = 255
			local effect3 = 255
			local effect4 = 255
			local effect5 = 255
			local area = {}
			local pos1 = getThingPosWithDebug(cid)
			local pos2 = getThingPosWithDebug(cid)
			local pos3 = getThingPosWithDebug(cid)
			local pos4 = getThingPosWithDebug(cid)
			local pos5 = getThingPosWithDebug(cid)
		if getCreatureLookDir(cid) == 1 then
			effect1 = 4
			effect2 = 10
			effect3 = 10
			effect4 = 10
			effect5 = 0
			pos1.x = pos1.x + 2
			pos1.y = pos1.y + 1
			pos2.x = pos2.x + 3
			pos2.y = pos2.y + 1
			pos3.x = pos3.x + 4
			pos3.y = pos3.y + 1
			pos4.x = pos4.x + 5
			pos4.y = pos4.y + 1
			pos5.x = pos5.x + 6
			pos5.y = pos5.y + 1
			area = solare
		elseif getCreatureLookDir(cid) == 0 then
			effect1 = 36
			effect2 = 37
			effect3 = 37
			effect4 = 38
			pos1.x = pos1.x + 1
			pos1.y = pos1.y - 1
			pos2.x = pos2.x + 1
			pos2.y = pos2.y - 3
			pos3.x = pos3.x + 1
			pos3.y = pos3.y - 4
			pos4.x = pos4.x + 1
			pos4.y = pos4.y - 5
			area = solarn
		elseif getCreatureLookDir(cid) == 2 then
			effect1 = 46
			effect2 = 50
			effect3 = 50
			effect4 = 59
			pos1.x = pos1.x + 1
			pos1.y = pos1.y + 2
			pos2.x = pos2.x + 1
			pos2.y = pos2.y + 3
			pos3.x = pos3.x + 1
			pos3.y = pos3.y + 4
			pos4.x = pos4.x + 1
			pos4.y = pos4.y + 5
			area = solars
		elseif getCreatureLookDir(cid) == 3 then
			effect1 = 115
			effect2 = 162
			effect3 = 162
			effect4 = 162
			effect5 = 163
			pos1.x = pos1.x - 1
			pos1.y = pos1.y + 1
			pos2.x = pos2.x - 3
			pos2.y = pos2.y + 1
			pos3.x = pos3.x - 4
			pos3.y = pos3.y + 1
			pos4.x = pos4.x - 5
			pos4.y = pos4.y + 1
			pos5.x = pos5.x - 6
			pos5.y = pos5.y + 1
			area = solarw
		end

		if effect1 ~= 255 then
			doSendMagicEffect(pos1, effect1)
		end
		if effect2 ~= 255 then
			doSendMagicEffect(pos2, effect2)
		end
		if effect3 ~= 255 then
			doSendMagicEffect(pos3, effect3)
		end
		if effect4 ~= 255 then
			doSendMagicEffect(pos4, effect4)
		end
		if effect5 ~= 255 then
			doSendMagicEffect(pos5, effect5)
		end
	
		doAreaCombatHealth(cid, GRASSDAMAGE, getThingPosWithDebug(cid), area, -min, -max, 255)	
		doRegainSpeed(cid)
		setPlayerStorageValue(cid, 3644587, -1)
	end

	local function ChargingBeam(cid)
		if not isCreature(cid) then
		return true
		end
		if isSleeping(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then
		return true
		end
		if isWithFear(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then
		return true
		end
		local tab = {}

		for x = -2, 2 do
			for y = -2, 2 do
				local pos = getThingPosWithDebug(cid)
				pos.x = pos.x + x
				pos.y = pos.y + y
					if pos.x ~= getThingPosWithDebug(cid).x and pos.y ~= getThingPosWithDebug(cid).y then
					table.insert(tab, pos)
					end
			end
		end
	doSendDistanceShoot(tab[math.random(#tab)], getThingPosWithDebug(cid), 37)
	end

doChangeSpeed(cid, -getCreatureSpeed(cid))
setPlayerStorageValue(cid, 3644587, 1)          --alterado v1.6  n sei pq mas tava dando debug o.O

doSendMagicEffect(getThingPosWithDebug(cid), 132) 
addEvent(useSolarBeam, 650, cid)

elseif spell == "Sleep Powder" then

local ret = {}
ret.id = 0
ret.cd = math.random(6, 9)
ret.check = 0
ret.first = true                        --alterado v1.6
ret.cond = "Sleep"
	
doMoveInArea2(cid, 27, confusion, NORMALDAMAGE, 0, 0, spell, ret)

elseif spell == "Stun Spore" then
        
    local ret = {}
    ret.id = 0
    ret.cd = 9
    ret.eff = 0
    ret.check = 0
    ret.spell = spell
    ret.cond = "Stun"
    
    doMoveInArea2(cid, 85, confusion, GRASSDAMAGE, 0, 0, spell, ret)

elseif spell == "Poison Powder" then                              
local name = doCorrectString(getCreatureName(cid))
local ret = {}
ret.id = 0
ret.cd = math.random(6, 15)              --alterado v1.6
ret.check = 0
local lvl = isSummon(cid) and getMasterLevel(cid) or getPokemonLevelD(name)
local heldPercent = 1
	if isSummon(cid) then
	   local heldx = getItemAttribute(getPlayerSlotItem(getCreatureMaster(cid), 8).uid, "xHeldItem")
			if heldx then
			local heldName, heldTier = string.explode(heldx, "|")[1], string.explode(heldx, "|")[2]
				  if heldName == "X-Poison" then -- dar mais experiencia
					 heldPercent = heldPoisonBurn[tonumber(heldTier)]
				  end
			end
	end
local dano =  math.floor((getPokemonLevelD(name)+lvl * 3)/2)
ret.damage = dano + (heldPercent * dano / 100)
ret.cond = "Poison" 
ret.im = target
ret.attacker = cid                             

doMoveInArea2(cid, 84, confusion, NORMALDAMAGE, 0, 0, spell, ret)
	
elseif spell == "Bullet Seed" then
               --cid, effDist, effDano, areaEff, areaDano, element, min, max
doMoveInAreaMulti(cid, 1, 45, bullet, bulletDano, GRASSDAMAGE, min, max)

elseif spell == "Body Slam" then
	
       doAreaCombatHealth(cid, NORMALDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 118)
    
elseif spell == "Leaf Storm" or tonumber(spell) == 73 then

	addEvent(doDanoWithProtect, 150, cid, GRASSDAMAGE, getThingPosWithDebug(cid), grassarea, -min, -max, 0)

	local pos = getThingPosWithDebug(cid)

	local function doSendLeafStorm(cid, pos)              --alterado!!
		if not isCreature(cid) then return true end
	    doSendDistanceShoot(getThingPosWithDebug(cid), pos, 8)
	end

	for a = 1, 100 do
		local lugar = {x = pos.x + math.random(-6, 6), y = pos.y + math.random(-5, 5), z = pos.z}
		addEvent(doSendLeafStorm, a * 2, cid, lugar)
	end
    
elseif spell == "Scratch" then

	doDanoWithProtect(cid, NORMALDAMAGE, getThingPos(target), 0, -min, -max, 142)

    
elseif spell == "Iron Head" then

	doDanoWithProtect(cid, NORMALDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 77)
    
elseif spell == "Ember" then

		doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), (isMega(cid) and getMegaID(cid) == "X") and 57 or 3)
		doDanoInTargetWithDelay(cid, target, FIREDAMAGE, min, max, (isMega(cid) and getMegaID(cid) == "X") and 302 or 15)  --alterado v1.7
		
		doBurnPoke(cid, target)

elseif spell == "Flamethrower" then

	local flamepos = getThingPosWithDebug(cid)
    local effect = 255
    local a = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)

	if a == 0 then
		flamepos.x = flamepos.x+1
		flamepos.y = flamepos.y-1
		effect = (isMega(cid) and getMegaID(cid) == "X") and 292 or 106
	elseif a == 1 then
		flamepos.x = flamepos.x+3
		flamepos.y = flamepos.y+1
		effect = (isMega(cid) and getMegaID(cid) == "X") and 295 or 109
	elseif a == 2 then
		flamepos.x = flamepos.x+1
		flamepos.y = flamepos.y+3
		effect = (isMega(cid) and getMegaID(cid) == "X") and 293 or 107
	elseif a == 3 then
		flamepos.x = flamepos.x-1
		flamepos.y = flamepos.y+1
		effect = (isMega(cid) and getMegaID(cid) == "X") and 294 or 108
	end

        doMoveInArea2(cid, 0, flamek, FIREDAMAGE, min, max, spell)
		doSendMagicEffect(flamepos, effect)  
     

elseif spell == "Fireball" then

	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), (isMega(cid) and getMegaID(cid) == "X") and 57 or 3)
	addEvent(doDanoWithProtect, 200, cid, FIREDAMAGE, getThingPosWithDebug(target), waba, min, max, (isMega(cid) and getMegaID(cid) == "X") and 302 or 5)
	
elseif spell == "Fire Fang" then

	doSendMagicEffect(getThingPosWithDebug(target), 138) 
    doDanoInTargetWithDelay(cid, target, FIREDAMAGE, min, max, (isMega(cid) and getMegaID(cid) == "X") and 302 or 15) --alterado v1.7
	
elseif spell == "Fire Blast" then

local p = getThingPosWithDebug(cid)
local d = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)

function sendAtk(cid, area, eff)
if isCreature(cid) then
   if not isSightClear(p, area, false) then return true end 
   doAreaCombatHealth(cid, FIREDAMAGE, area, 0, 0, 0, eff)
   doAreaCombatHealth(cid, FIREDAMAGE, area, whirl3, -min, -max, (isMega(cid) and getMegaID(cid) == "X") and 301 or 35)
end
end

for a = 0, 4 do

local t = {
[0] = {60, {x=p.x, y=p.y-(a+1), z=p.z}},           --alterado v1.4
[1] = {61, {x=p.x+(a+1), y=p.y, z=p.z}},
[2] = {62, {x=p.x, y=p.y+(a+1), z=p.z}},
[3] = {63, {x=p.x-(a+1), y=p.y, z=p.z}}
}  
if (isMega(cid) and getMegaID(cid) == "X") then
t = {
[0] = {303, {x=p.x, y=p.y-(a+1), z=p.z}},           --alterado v1.4
[1] = {304, {x=p.x+(a+1), y=p.y, z=p.z}},
[2] = {305, {x=p.x, y=p.y+(a+1), z=p.z}},
[3] = {306, {x=p.x-(a+1), y=p.y, z=p.z}}
} 
end 
addEvent(sendAtk, 300*a, cid, t[d][2], t[d][1])
end
	
elseif spell == "Rage" then

   local ret = {}
   ret.id = cid
   ret.cd = 15
   ret.eff = 13
   ret.check = 0
   ret.buff = spell
   ret.first = true
   
   doCondition2(ret)
      
elseif spell == "Raging Blast" then

                 --cid, effDist, effDano, areaEff, areaDano, element, min, max
       doMoveInAreaMulti(cid, (isMega(cid) and getMegaID(cid) == "X") and 57 or 3, (isMega(cid) and getMegaID(cid) == "X") and 302 or 6, bullet, bulletDano, FIREDAMAGE, min, max) 
       
elseif spell == "Dragon Claw" then


       doDanoWithProtect(cid, DRAGONDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 141)
       
elseif spell == "Wing Attack" or spell == "Steel Wing" then

local effectpos = getThingPosWithDebug(cid)
local effect = 255
local a = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)

	if a == 0 then
		effect = spell == "Steel Wing" and 251 or 128
		effectpos.x = effectpos.x + 1
		effectpos.y = effectpos.y - 1                   --alterado v1.4
	elseif a == 1 then
		effectpos.x = effectpos.x + 2
		effectpos.y = effectpos.y + 1
		effect = spell == "Steel Wing" and 253 or 129
	elseif a == 2 then
		effectpos.x = effectpos.x + 1
		effectpos.y = effectpos.y + 2
		effect = spell == "Steel Wing" and 252 or 131
	elseif a == 3 then
		effectpos.x = effectpos.x - 1
		effectpos.y = effectpos.y + 1
		effect = spell == "Steel Wing" and 254 or 130
	end

		doSendMagicEffect(effectpos, effect)
		doMoveInArea2(cid, 0, wingatk, FLYINGDAMAGE, min, max, spell)
		
elseif spell == "Magma Storm" then

local eff = (isMega(cid) and getMegaID(cid) == "X") and {302, 301, 302, 301} or {6, 35, 6, 35}
local area = {flames1, flames2, flames3, flames4}

addEvent(doMoveInArea2, 2*450, cid, 2, flames0, FIREDAMAGE, min, max, spell)
for i = 0, 3 do
    addEvent(doMoveInArea2, i*450, cid, eff[i+1], area[i+1], FIREDAMAGE, min, max, spell)
end

elseif spell == "Bubbles" then

	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 2)
	doDanoInTargetWithDelay(cid, target, WATERDAMAGE, min, max, 68) --alterado v1.7
	
elseif spell == "Clamp" then

	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 2)
	doDanoInTargetWithDelay(cid, target, WATERDAMAGE, min, max, 53)  --alterado v1.7

elseif spell == "Water Gun" then

local a = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)
local p = getThingPosWithDebug(cid)
local t = {
[0] = {69, {x=p.x, y=p.y-1, z=p.z}},
[1] = {70, {x=p.x+6, y=p.y, z=p.z}},      --alterado v1.8
[2] = {71, {x=p.x, y=p.y+6, z=p.z}},
[3] = {72, {x=p.x-1, y=p.y, z=p.z}},
}
local area = reto4

if (isMega(cid)) then
   t = {
	[0] = {299, {x=p.x+1, y=p.y-2, z=p.z}},
	[1] = {296, {x=p.x+5, y=p.y+1, z=p.z}},      --alterado v1.8
	[2] = {298, {x=p.x+1, y=p.y+5, z=p.z}},
	[3] = {297, {x=p.x-1, y=p.y, z=p.z}},
	[3] = {297, {x=p.x-1, y=p.y+1, z=p.z}},
   }
   area = triplo6
end   

doMoveInArea2(cid, 0, area, WATERDAMAGE, min, max, spell)
doSendMagicEffect(t[a][2], t[a][1])
	
elseif spell == "Waterball" then
		             
    doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 2)
    doDanoWithProtectWithDelay(cid, target, WATERDAMAGE, min, max, 68, waba)
	
elseif spell == "Aqua Tail" then

	local function rebackSpd(cid, sss)
		if not isCreature(cid) then return true end
		doChangeSpeed(cid, sss)
		setPlayerStorageValue(cid, 446, -1)
	end

	local x = getCreatureSpeed(cid)
	doFaceOpposite(cid)
	doChangeSpeed(cid, -x)
	addEvent(rebackSpd, 400, cid, x)
	setPlayerStorageValue(cid, 446, 1)
	doAreaCombatHealth(cid, WATERDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 68)

elseif spell == "Dragon Tail" then

	local function rebackSpd(cid, sss)
		if not isCreature(cid) then return true end
		doChangeSpeed(cid, sss)
		setPlayerStorageValue(cid, 446, -1)
	end

	local x = getCreatureSpeed(cid)
	doChangeSpeed(cid, -x)
	addEvent(rebackSpd, 400, cid, x)
	setPlayerStorageValue(cid, 446, 1)
	pos = getThingPos(target)
	pos.x = pos.x +1
	doSendMagicEffect(pos, 365)
	doAreaCombatHealth(cid, DRAGONDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 0)
	
elseif spell == "Hydro Cannon" then

local p = getThingPosWithDebug(cid)
local d = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)

function sendAtk(cid, area, eff)
if isCreature(cid) then
   if not isSightClear(p, area, false) then return true end
   doAreaCombatHealth(cid, WATERDAMAGE, area, 0, 0, 0, eff)
   doAreaCombatHealth(cid, WATERDAMAGE, area, whirl3, -min, -max, 68)
end
end

for a = 0, 4 do

local t = {                                     --alterado v1.4
[0] = {64, {x=p.x, y=p.y-(a+1), z=p.z}},
[1] = {65, {x=p.x+(a+1), y=p.y, z=p.z}},
[2] = {66, {x=p.x, y=p.y+(a+1), z=p.z}},
[3] = {67, {x=p.x-(a+1), y=p.y, z=p.z}}
}   
addEvent(sendAtk, 300*a, cid, t[d][2], t[d][1])
end
	
elseif spell == "Harden" or spell == "Calm Mind" or spell == "Defense Curl" or spell == "Charm" then	
                                                                    --alterado v1.4
    if spell == "Calm Mind" then
       eff = 133
    elseif spell == "Charm" then
       eff = 147                --efeito n eh esse.. e n sei se eh soh bonus de def, ou sp.def tb.. ;x
    else                             
       eff = 144
    end
    
    local ret = {}
    ret.id = cid
    ret.cd = 8
    ret.eff = eff
    ret.check = 0
    ret.buff = spell
    ret.first = true
   
    doCondition2(ret)

elseif spell == "Bubble Blast" then

                 --cid, effDist, effDano, areaEff, areaDano, element, min, max
       doMoveInAreaMulti(cid, 2, 68, bullet, bulletDano, WATERDAMAGE, min, max)
      
elseif spell == "Skull Bash" then
local ret = {}
ret.id = 0
ret.cd = 9                        --alterado v1.6
ret.eff = 118
ret.check = 0
ret.first = true
ret.cond = "Paralyze"

       doMoveInArea2(cid, 118, reto5, NORMALDAMAGE, min, max, spell, ret)              

elseif spell == "Hydropump" then

local pos = getThingPosWithDebug(cid)

	local function doSendBubble(cid, pos)
		if not isCreature(cid) then return true end
		if isWithFear(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then return true end
		if isSleeping(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then return true end
		doSendDistanceShoot(getThingPosWithDebug(cid), pos, 2)
		doSendMagicEffect(pos, 53)
	end
	                                                          --alterado!!
	for a = 1, 20 do
	    local lugar = {x = pos.x + math.random(-4, 4), y = pos.y + math.random(-3, 3), z = pos.z}
	    addEvent(doSendBubble, a * 25, cid, lugar)
	end
	addEvent(doDanoWithProtect, 150, cid, WATERDAMAGE, pos, waterarea, -min, -max, 0)

elseif spell == "Giga Impact" then

local tempo = 3    --Tempo, em segundos.
local a = {}
local ret1 = {}
    ret1.id = 0
    ret1.cd = 5
    ret1.eff = 0
    ret1.check = 0
    ret1.first = true
    ret1.cond = "Slow"
local ret2 = {}
    ret2.id = 0
    ret2.cd = 5                   
    ret2.eff = 0
    ret2.check = 0
    ret2.first = true
    ret2.cond = "Miss"
    a.speed = getCreatureSpeed(cid)
    doChangeSpeed(cid, -getCreatureSpeed(cid))
    doChangeSpeed(cid, a.speed*2)
    addEvent(function()
        if not isCreature(cid) then return true end
        doRegainSpeed(cid)
        doMoveInArea2(cid, 118, quake, NORMALDAMAGE, min, max, spell, ret1)
        doMoveInArea2(cid, 118, quake, NORMALDAMAGE, 0, 0, spell, ret2)
    end, tempo*1000)

elseif spell == "String Shot" then

   doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 23)
   
   local ret = {}
   ret.id = target
   ret.cd = 6
   ret.eff = 137
   ret.check = getPlayerStorageValue(target, conds["Stun"])
   ret.spell = spell
   ret.cond = "Stun"
   
   addEvent(doMoveDano2, 100, cid, target, BUGDAMAGE, 0, 0, ret, spell)

elseif spell == "Bug Bite" then

	doSendMagicEffect(getThingPosWithDebug(target), 244)
    doDanoInTargetWithDelay(cid, target, BUGDAMAGE, min, max, 8) --alterado v1.7

elseif spell == "Super Sonic" then

	local rounds = math.random(4, 7)
	rounds = rounds + math.floor(getPokemonLevel(cid) / 35)

	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 32)
	local ret = {}
	ret.id = target
	ret.cd = rounds
	ret.check = getPlayerStorageValue(target, conds["Confusion"])
	ret.cond = "Confusion"
	
	addEvent(doMoveDano2, 100, cid, target, NORMALDAMAGE, 0, 0, ret, spell)

elseif spell == "Whirlwind" then

area = {SL1, SL2, SL3, SL4}

for i = 0, 3 do
    addEvent(doMoveInArea2, i*300, cid, 42, area[i+1], FLYINGDAMAGE, min, max, spell)
end
	
	elseif spell == "Razor Wind" then

area = {SL1, SL2, SL3, SL4}

for i = 0, 3 do
    addEvent(doMoveInArea2, i*300, cid, 131, area[i+1], NORMALDAMAGE, min, max, spell)
end
	
elseif spell == "Psybeam" then

local a = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)
local t = {
[0] = 58,       --alterado v1.6
[1] = 234,
[2] = 58,
[3] = 209,
}

doMoveInArea2(cid, t[a], reto4, psyDmg, min, max, spell)     --alterado v1.4

elseif spell == "Sand Attack" then

local a = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)
local t = {
[0] = 120,
[1] = 121,
[2] = 122,
[3] = 119,
}

local ret = {}
ret.id = 0
ret.cd = 9
ret.eff = 34
ret.check = 0
ret.spell = spell
ret.cond = "Miss"

doCreatureSetLookDir(cid, a)  --sera? '-'
stopNow(cid, 1000)  
doMoveInArea2(cid, t[a], reto5, GROUNDDAMAGE, 0, 0, spell, ret) 

elseif spell == "Confusion" or spell == "Night Shade" then

    local rounds = math.random(4, 7)       --rever area...
    rounds = rounds + math.floor(getPokemonLevel(cid) / 35)
    
    if spell == "Confusion" then
       dano = psyDmg             --alterado v1.4
    else
       dano = ghostDmg
    end

	local ret = {}
    ret.id = 0
    ret.check = 0
    ret.cd = rounds
    ret.cond = "Confusion"

    doMoveInArea2(cid, 136, selfArea1, dano, min, max, spell, ret)
	
elseif spell == "Horn Attack" then
       
       doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 15)
       doDanoInTargetWithDelay(cid, target, NORMALDAMAGE, min, max, 3) --alterado v1.7

elseif spell == "Poison Sting" then
       
       doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 15)
       doDanoInTargetWithDelay(cid, target, POISONDAMAGE, min, max, 8) --alterado v1.7
		
elseif spell == "Fury Cutter" or spell == "Red Fury" then

       local effectpos = getThingPosWithDebug(cid)
       local effect = 255
       local a = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)

	if a == 0 then
	    if getSubName(cid, target) == "Scizor" then  --alterado v1.6.1
	       effect = 236
	    else
		   effect = 128
	    end
		effectpos.x = effectpos.x + 1
		effectpos.y = effectpos.y - 1
	elseif a == 1 then
		effectpos.x = effectpos.x + 2
		effectpos.y = effectpos.y + 1
		if getSubName(cid, target) == "Scizor" then   --alterado v1.6.1
	       effect = 232
	    else
		   effect = 129
	    end
	elseif a == 2 then
		effectpos.x = effectpos.x + 1
		effectpos.y = effectpos.y + 2
		if getSubName(cid, target) == "Scizor" then   --alterado v1.6.1
	       effect = 233
	    else
		   effect = 131
	    end
	elseif a == 3 then
		effectpos.x = effectpos.x - 1
		effectpos.y = effectpos.y + 1
		if getSubName(cid, target) == "Scizor" then   --alterado v1.6.1
	       effect = 224
	    else
		   effect = 130
	    end
	end
        local function doFury(cid, effect)
        if not isCreature(cid)  then return true end
        if isWithFear(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then return true end
        if isSleeping(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then return true end
		   doSendMagicEffect(effectpos, effect)
		   doMoveInArea2(cid, 2, wingatk, BUGDAMAGE, min, max, spell)
        end                               
        
        addEvent(doFury, 0, cid, effect)
        addEvent(doFury, 350, cid, effect)
        
elseif spell == "Pin Missile" then

       doMoveInAreaMulti(cid, 13, 7, bullet, bulletDano, BUGDAMAGE, min, max)
       
elseif spell == "Strafe" or spell == "Agility" then

   local ret = {}
   ret.id = cid
   ret.cd = 15
   ret.eff = 14
   ret.check = 0
   ret.buff = spell
   ret.first = true
   
   doCondition2(ret)
    
elseif spell == "Gust" then

       doMoveInArea2(cid, 42, reto5, FLYINGDAMAGE, min, max, spell) 
       
elseif spell == "Drill Peck" then
	
doDanoWithProtect(cid, FLYINGDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 148)

elseif spell == "Tornado" then

    local pos = getThingPosWithDebug(cid)

	local function doSendTornado(cid, pos)
		if not isCreature(cid) then return true end
		if isWithFear(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then return true end
		if isSleeping(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then return true end
		doSendDistanceShoot(getThingPosWithDebug(cid), pos, 22)
		doSendMagicEffect(pos, 42)
	end

	for b = 1, 3 do
		for a = 1, 20 do
			local lugar = {x = pos.x + math.random(-4, 4), y = pos.y + math.random(-3, 3), z = pos.z}
			addEvent(doSendTornado, a * 75, cid, lugar)
		end
	end
	doDanoWithProtect(cid, FLYINGDAMAGE, pos, waterarea, -min, -max, 0)
	
elseif spell == "Bite" or tonumber(spell) == 5 then

	doDanoWithProtect(cid, DARKDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 146)
	
elseif spell == "Super Fang" then

	doDanoWithProtect(cid, NORMALDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 244)
	
elseif spell == "Poison Fang" then

	doSendMagicEffect(getThingPosWithDebug(target), 244)
    doDanoInTargetWithDelay(cid, target, POISONDAMAGE, min, max, 114) --alterado v1.7
	
elseif spell == "Sting Gun" then
       
       local function doGun(cid, target)
       if not isCreature(cid) or not isCreature(target) then return true end    --alterado v1.7
          doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 13)
          doDanoInTargetWithDelay(cid, target, POISONDAMAGE, min, max, 8)  --alterado v1.7
       end

       setPlayerStorageValue(cid, 3644587, 1)
       addEvent(setPlayerStorageValue, 200, cid, 3644587, 1)
       for i = 0, 2 do
	       addEvent(doGun, i*100, cid, target)
       end 
       
elseif spell == "Acid" then

	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 14)
	doDanoInTargetWithDelay(cid, target, POISONDAMAGE, min, max, 20)    --alterado v1.7
	
elseif spell == "Fear" or spell == "Roar" then

    local ret = {}
    ret.id = 0
    ret.cd = 5
    ret.check = 0
    ret.skill = spell
    ret.cond = "Fear"
    
    doMoveInArea2(cid, 0, confusion, DARKDAMAGE, 0, 0, spell, ret)
    
elseif spell == "Iron Tail" then

	local function rebackSpd(cid, sss)
		if not isCreature(cid) then return true end
		doChangeSpeed(cid, sss)
		setPlayerStorageValue(cid, 446, -1)
	end

	local x = getCreatureSpeed(cid)
	doFaceOpposite(cid)
	doChangeSpeed(cid, -x)
	addEvent(rebackSpd, 400, cid, x)
	setPlayerStorageValue(cid, 446, 1)
	doDanoWithProtect(cid, STEELDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 160)
	
elseif spell == "Thunder Shock" then
                                     
	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 40)
	doDanoInTargetWithDelay(cid, target, ELECTRICDAMAGE, min, max, 48)   --alterado v1.7

elseif spell == "Thunder Bolt" then

        --alterado v1.7
		local function doThunderFall(cid, frompos, target)
			if not isCreature(target) or not isCreature(cid) then return true end
		local pos = getThingPosWithDebug(target)
		local ry = math.abs(frompos.y - pos.y)
		doSendDistanceShoot(frompos, getThingPosWithDebug(target), 41)
		addEvent(doDanoInTarget, ry * 11, cid, target, ELECTRICDAMAGE, min, max, 48) --alterado v1.7
		end

		local function doThunderUp(cid, target)
			if not isCreature(target) or not isCreature(cid) then return true end
		local pos = getThingPosWithDebug(target)
		local mps = getThingPosWithDebug(cid)
		local xrg = math.floor((pos.x - mps.x) / 2)
		local topos = mps
		topos.x = topos.x + xrg
		local rd =  7
		topos.y = topos.y - rd
		doSendDistanceShoot(getThingPosWithDebug(cid), topos, 41)
		addEvent(doThunderFall, rd * 49, cid, topos, target)
		end		

    setPlayerStorageValue(cid, 3644587, 1)
	addEvent(setPlayerStorageValue, 350, cid, 3644587, -1)
    for thnds = 1, 2 do
		addEvent(doThunderUp, thnds * 155, cid, target)
	end
	
elseif spell == "Thunder Wave" then

local ret = {}
ret.id = 0
ret.cd = 9
ret.check = 0
ret.eff = 48
ret.spell = spell
ret.cond = "Stun"

doMoveInArea2(cid, 48, db1, ELECTRICDAMAGE, min, max, spell, ret) --alterado v1.8

elseif spell == "Thunder" then

local ret = {}
ret.id = 0
ret.cd = 9
ret.check = 0
ret.eff = 48
ret.spell = spell
ret.cond = "Stun"

doMoveInArea2(cid, 48, thunderr, ELECTRICDAMAGE, min, max, spell, ret)

elseif spell == "Web Shot" then
                                                  
local ret = {}
ret.id = target
ret.cd = 9
ret.eff = 26
ret.check = 0
ret.spell = spell
ret.cond = "Paralyze"

	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 23)
	addEvent(doMoveDano2, 100, cid, target, BUGDAMAGE, -min, -max, ret, spell)

elseif spell == "Mega Kick" then

    doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 39)
	doDanoInTargetWithDelay(cid, target, FIGHTINGDAMAGE, min, max, 113)   --alterado v1.7
	
elseif spell == "Thunder Punch" then

	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 39)
    doSendMagicEffect(getThingPosWithDebug(target), 112)
    doDanoInTargetWithDelay(cid, target, ELECTRICDAMAGE, min, max, 48) --alterado v1.7

elseif spell == "Comet Punch" then

	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 39)
    doSendMagicEffect(getThingPosWithDebug(target), 112)
    doDanoInTargetWithDelay(cid, target, ELECTRICDAMAGE, min, max, 118) --alterado v1.7
	
elseif spell == "Electric Storm" then             

local master = isSummon(cid) and getCreatureMaster(cid) or cid

local function doFall(cid)
for rocks = 1, 42 do
    addEvent(fall, rocks*35, cid, master, ELECTRICDAMAGE, 41, 48)
end
end

for up = 1, 10 do
    addEvent(upEffect, up*75, cid, 41)
end
addEvent(doFall, 450, cid)

local ret = {}
ret.id = 0
ret.cd = 9
ret.check = 0
ret.eff = 48
ret.spell = spell
ret.cond = "Stun"

addEvent(doMoveInArea2, 1400, cid, 0, BigArea2, ELECTRICDAMAGE, min, max, spell, ret)

elseif spell == "Frenzy Plant" then             

local master = isSummon(cid) and getCreatureMaster(cid) or cid

local function doFall(cid)
for rocks = 1, 42 do
    addEvent(fall, rocks*35, cid, master, ELECTRICDAMAGE, 255, 259)
end
end

for up = 1, 10 do
    addEvent(upEffect, up*75, cid, 255)
end
addEvent(doFall, 450, cid)

local ret = {}
ret.id = 0
ret.cd = 9
ret.check = 0
ret.eff = 220
ret.spell = spell
ret.cond = "Stun"

addEvent(doMoveInArea2, 1400, cid, 0, BigArea2, ELECTRICDAMAGE, min, max, spell, ret)

elseif spell == "Web Rain" then             

local master = isSummon(cid) and getCreatureMaster(cid) or cid

local function doFall(cid)
for rocks = 1, 42 do
    addEvent(fall, rocks*35, cid, master, BUGDAMAGE, 23)
end
end

for up = 1, 10 do
    addEvent(upEffect, up*75, cid, 23)
end
addEvent(doFall, 450, cid)

local ret = {}
ret.id = 0
ret.cd = 9
ret.check = 0
ret.eff = 26
ret.spell = spell
ret.cond = "Silence"

addEvent(doMoveInArea2, 1400, cid, 0, BigArea2, BUGDAMAGE, min, max, spell, ret)

elseif spell == "Spider Web" then

local ret = {}
ret.id = 0
ret.cd = 9
ret.check = 0
ret.eff = 26
ret.cond = "Silence"

doMoveInAreaMulti(cid, 23, 26, multi, multiDano, BUGDAMAGE, min, max)
doMoveInArea2(cid, 0, multiDano, BUGDAMAGE, 0, 0, spell, ret)
	
	
elseif spell == "Mud Shot" or spell == "Mud Slap" then

if isCreature(target) then                                    --alterado v1.8
local contudion = spell == "Mud Shot" and "Miss" or "Stun"                                                   
local ret = {}
ret.id = target
ret.cd = 9
ret.eff = 34
ret.check = getPlayerStorageValue(target, conds[contudion])
ret.spell = spell
ret.cond = contudion

	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 6)
	addEvent(doMoveDano2, 100, cid, target, GROUNDDAMAGE, -min, -max, ret, spell)
end

elseif spell == "Metal Burst" then

if isCreature(target) then                                    --alterado v1.8
local contudion = "Stun"                                                   
local ret = {}
ret.id = target
ret.cd = 2
ret.eff = 349
ret.check = getPlayerStorageValue(target, conds[contudion])
ret.spell = spell
ret.cond = contudion

	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 9)
	addEvent(doMoveDano2, 255, cid, target, GROUNDDAMAGE, -min, -max, ret, spell)
end
 
elseif spell == "Rollout" then
local RollOuts = {
["Voltorb"] = {lookType = 638},
["Electrode"] = {lookType = 637},
["Sandshrew"] = {lookType = 635},
["Sandslash"] = {lookType = 636},
["Phanpy"] = {lookType = 1005},
["Donphan"] = {lookType = 1007},
["Miltank"] = {lookType = 1006},                
["Golem"] = {lookType = 639},
["Omastar"] = {lookType = 1579},
["Shiny Electrode"] = {lookType = 1387},
["Shiny Golem"] = {lookType = 1403},
["Shiny Voltorb"] = {lookType = 1388},
["Shiny Sandslash"] = {lookType = 1506}
}
    local function setOutfit(cid, outfit)
          if isCreature(cid) and getCreatureCondition(cid, CONDITION_OUTFIT) == true then
             if getCreatureOutfit(cid).lookType == outfit then
                doRemoveCondition(cid, CONDITION_OUTFIT)
                if getCreatureName(cid) == "Ditto" and pokes[getPlayerStorageValue(cid, 1010)] and getPlayerStorageValue(cid, 1010) ~= "Ditto" then
                   if isSummon(cid) then
                      local item = getPlayerSlotItem(getCreatureMaster(cid), 8)
                      doSetCreatureOutfit(cid, {lookType = getItemAttribute(item.uid, "transOutfit")}, -1)   --alterado v1.8
                   end
                end 
             end
          end
    end
	
	local name = doCorrectString(getCreatureName(cid))
		  
	if RollOuts[name] then
		doSetCreatureOutfit(cid, RollOuts[name], -1)   --alterado v1.6.1
    end 

	local outfit = getCreatureOutfit(cid).lookType

    local function roll(cid, outfit)
    if not isCreature(cid) then return true end
    if isSleeping(cid) then return true end
       if RollOuts[name] then
          doSetCreatureOutfit(cid, RollOuts[name], -1)  
       end
       doDanoWithProtect(cid, ROCKDAMAGE, getThingPosWithDebug(cid), splash, -min, -max, 0)
    end

    setPlayerStorageValue(cid, 3644587, 1)
    addEvent(setPlayerStorageValue, 9000, cid, 3644587, -1)
    for r = 1, 11 do  --8
        addEvent(roll, 750 * r, cid, outfit)
    end
    addEvent(setOutfit, 9050, cid, outfit)
    
elseif spell == "Shockwave" then

local p = getThingPosWithDebug(cid)
local d = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)

function sendAtk(cid, area, areaEff, eff)
if isCreature(cid) then
   if not isSightClear(p, area, false) then return true end                                             --testar o atk!!
   doAreaCombatHealth(cid, GROUNDDAMAGE, areaEff, 0, 0, 0, eff)    
   doAreaCombatHealth(cid, GROUNDDAMAGE, area, whirl3, -min, -max, 255)     
end
end

for a = 0, 5 do

local t = {
[0] = {126, {x=p.x, y=p.y-(a+1), z=p.z}, {x=p.x+1, y=p.y-(a+1), z=p.z}},           
[1] = {124, {x=p.x+(a+1), y=p.y, z=p.z}, {x=p.x+(a+1), y=p.y+1, z=p.z}},
[2] = {125, {x=p.x, y=p.y+(a+1), z=p.z}, {x=p.x+1, y=p.y+(a+1), z=p.z}},
[3] = {123, {x=p.x-(a+1), y=p.y, z=p.z}, {x=p.x-(a+1), y=p.y+1, z=p.z}}
}   
addEvent(sendAtk, 325*a, cid, t[d][2], t[d][3], t[d][1])
end                          
	
elseif spell == "Earthshock" then

local eff = getSubName(cid, target) == "Shiny Onix" and 179 or 127 --alterado v1.6.1              

	doAreaCombatHealth(cid, GROUNDDAMAGE, getThingPosWithDebug(cid), splash, -min, -max, 255)

	local sps = getThingPosWithDebug(cid)
	sps.x = sps.x+1
	sps.y = sps.y+1
	doSendMagicEffect(sps, eff)
	
elseif spell == "Earthquake" then

local eff = getSubName(cid, target) == "Shiny Onix" and 175 or 118  --alterado v1.6.1
 
local function doQuake(cid)
if not isCreature(cid) then return false end
if isSleeping(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then return false end
if isWithFear(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then return true end
   doMoveInArea2(cid, eff, confusion, GROUNDDAMAGE, min, max, spell)
end

times = {0, 500, 1000, 1500, 2300, 2800, 3300, 3800, 4600, 5100, 5600, 6100, 6900, 7400, 7900, 8400, 9200, 10000}

setPlayerStorageValue(cid, 3644587, 1)
addEvent(setPlayerStorageValue, 10000, cid, 3644587, -1)
for i = 1, #times do                   --alterado v1.4
    addEvent(doQuake, times[i], cid)
end
	
	
elseif spell == "Stomp" then
    
    local ret = {}
    ret.id = 0
    ret.cd = 9
    ret.check = 0
    ret.eff = 34
    ret.spell = spell
    ret.cond = "Stun"   
       
    doMoveInArea2(cid, 118, stomp, GROUNDDAMAGE, min, max, spell, ret)
       
elseif spell == "Toxic Spikes" then
       
       local function doToxic(cid, target)
       if not isCreature(cid) or not isCreature(target) then return true end  --alterado v1.7
          doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 15)
          doDanoInTargetWithDelay(cid, target, POISONDAMAGE, min, max, 114) --alterado v1.7
       end

       setPlayerStorageValue(cid, 3644587, 1)
       addEvent(setPlayerStorageValue, 300, cid, 3644587, -1)
	   addEvent(doToxic, 0, cid, target)
       addEvent(doToxic, 300, cid, target)
       
elseif spell == "Horn Drill" then
       
       local function doHorn(cid, target)
       if not isCreature(cid) or not isCreature(target) then return true end   --alterado v1.7
          doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 25)
          doDanoInTargetWithDelay(cid, target, NORMALDAMAGE, min, max, 3)  --alterado v1.7
       end

       setPlayerStorageValue(cid, 3644587, 1)
	   addEvent(setPlayerStorageValue, 300, cid, 3644587, -1)
       addEvent(doHorn, 0, cid, target)
       addEvent(doHorn, 300, cid, target)
       
elseif spell == "Doubleslap" then
       
	doAreaCombatHealth(cid, NORMALDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 148)
    
elseif spell == "Lovely Kiss" then 
   
	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 16)
	
	local ret = {}
    ret.id = target
    ret.cd = 9
    ret.check = getPlayerStorageValue(target, conds["Stun"])
    ret.eff = 147
    ret.spell = spell
    ret.cond = "Stun"  
    
    addEvent(doMoveDano2, 100, cid, target, NORMALDAMAGE, 0, 0, ret, spell)
    
elseif spell == "Sing" then

local ret = {}
ret.id = 0
ret.cd = math.random(6, 10)
ret.check = 0
ret.first = true
ret.cond = "Sleep"                 --alterado v1.6
	
doMoveInArea2(cid, 33, selfArea1, NORMALDAMAGE, 0, 0, spell, ret) 
    
elseif spell == "Multislap" then

       doAreaCombatHealth(cid, NORMALDAMAGE, getThingPosWithDebug(cid), splash, -min, -max, 3)
       
elseif spell == "Metronome" then

local spells = {"Shadow Storm", "Electric Storm", "Magma Storm", "Blizzard", "Meteor Mash", "Leaf Storm", "Hydropump", "Falling Rocks"}

    local random = math.random(1, #spells)

	local randommove = spells[random]
	local pos = getThingPosWithDebug(cid)
	pos.y = pos.y - 1

	doSendMagicEffect(pos, 161)
	
	local function doMetronome(cid, skill)
	if not isCreature(cid) then return true end
       docastspell(cid, skill)
    end
    
    addEvent(doMetronome, 200, cid, randommove)
    
elseif spell == "Sketch 1" then

local spells = {"Psy Pulse", "Shadow Ball", "Thunder Bolt", "Ember", "Rock Throw", "Razor Leaf", "Bubbles", "Ice Shards", "Egg Bomb", "Poison Bomb"}

    local random = math.random(1, #spells)

	local randommove = spells[random]
	local pos = getThingPosWithDebug(cid)
	pos.y = pos.y - 1

	doSendMagicEffect(pos, 0)
	
	local function doMetronome(cid, skill)
	if not isCreature(cid) then return true end
       docastspell(cid, skill)
    end
    
    addEvent(doMetronome, 200, cid, randommove)
    
elseif spell == "Sketch 2" then

local spells = {"Mud Bomb", "Cyber Pulse", "Dark Pulse", "Rock Slide", "Magical Leaf", "Fireball", "Waterball", "Feather Dance"}

    local random = math.random(1, #spells)

	local randommove = spells[random]
	local pos = getThingPosWithDebug(cid)
	pos.y = pos.y - 1

	doSendMagicEffect(pos, 0)
	
	local function doMetronome(cid, skill)
	if not isCreature(cid) then return true end
       docastspell(cid, skill)
    end
    
    addEvent(doMetronome, 200, cid, randommove)
    
elseif spell == "Sketch 3" then

local spells = {"Poison Gas", "Earthquake", "Petal Tornado", "Electro Field", "Flame Wheel"}

    local random = math.random(1, #spells)

	local randommove = spells[random]
	local pos = getThingPosWithDebug(cid)
	pos.y = pos.y - 1

	doSendMagicEffect(pos, 0)
	
	local function doMetronome(cid, skill)
	if not isCreature(cid) then return true end
       docastspell(cid, skill)
    end
    
    addEvent(doMetronome, 200, cid, randommove)
    
elseif spell == "Sketch 4" then

local spells = {"Thunder", "Night Slash", "Confusion", "Air Slash", "Confusion", "Night Shade"}

    local random = math.random(1, #spells)

	local randommove = spells[random]
	local pos = getThingPosWithDebug(cid)
	pos.y = pos.y - 1

	doSendMagicEffect(pos, 0)
	
	local function doMetronome(cid, skill)
	if not isCreature(cid) then return true end
       docastspell(cid, skill)
    end
    
    addEvent(doMetronome, 200, cid, randommove)
    
elseif spell == "Sketch 5" then

local spells = {"Solar Beam", "Bullet Seed", "Raging Blast", "Fire Blast", "Bubble Blast", "Hydro Cannon", "Pin Missile"}

    local random = math.random(1, #spells)

	local randommove = spells[random]
	local pos = getThingPosWithDebug(cid)
	pos.y = pos.y - 1

	doSendMagicEffect(pos, 0)
	
	local function doMetronome(cid, skill)
	if not isCreature(cid) then return true end
       docastspell(cid, skill)
    end
    
    addEvent(doMetronome, 200, cid, randommove)
    
	elseif spell == "Sketch 6" then

local spells = {"Shockwave", "Petal Dance", "Hyper Beam", "Zap Cannon", "Aurora Beam", "Ice Beam", "Ground Chop"}

    local random = math.random(1, #spells)

	local randommove = spells[random]
	local pos = getThingPosWithDebug(cid)
	pos.y = pos.y - 1

	doSendMagicEffect(pos, 0)
	
	local function doMetronome(cid, skill)
	if not isCreature(cid) then return true end
       docastspell(cid, skill)
    end
    
    addEvent(doMetronome, 200, cid, randommove)
    
elseif spell == "Sketch 7" then

local spells = {"Fear", "Sunny Day", "Scary Face", "Skull Bash", "Cotton Spore", "Sleep Powder"}

    local random = math.random(1, #spells)

	local randommove = spells[random]
	local pos = getThingPosWithDebug(cid)
	pos.y = pos.y - 1

	doSendMagicEffect(pos, 0)
	
	local function doMetronome(cid, skill)
	if not isCreature(cid) then return true end
       docastspell(cid, skill)
    end
    
    addEvent(doMetronome, 200, cid, randommove)
    
elseif spell == "Sketch 8" then

local spells = {"Reflect", "Charm", "Agility", "Safeguard", "Synthesis", "Emergency Call", "Healarea", "Sing"}

    local random = math.random(1, #spells)

	local randommove = spells[random]
	local pos = getThingPosWithDebug(cid)
	pos.y = pos.y - 1

	doSendMagicEffect(pos, 0)
	
	local function doMetronome(cid, skill)
	if not isCreature(cid) then return true end
       docastspell(cid, skill)
    end
    
    addEvent(doMetronome, 200, cid, randommove)
    
elseif spell == "Sketch 9" then

local spells = {"Psychic", "Epicenter", "Mortal Gas", "Hydropump", "Muddy Water"}

    local random = math.random(1, #spells)

	local randommove = spells[random]
	local pos = getThingPosWithDebug(cid)
	pos.y = pos.y - 1

	doSendMagicEffect(pos, 0)
	
	local function doMetronome(cid, skill)
	if not isCreature(cid) then return true end
       docastspell(cid, skill)
    end
    
    addEvent(doMetronome, 200, cid, randommove)
    
elseif spell == "Sketch 10" then

local spells = {"Focus Blast", "Blizzard", "Shadow Storm", "Falling Rocks", "Meteor Mash", "Electric Storm", "Hydro Dance", "Magma Storm", "Draco Meteor", "Psy Impact"}

    local random = math.random(1, #spells)

	local randommove = spells[random]
	local pos = getThingPosWithDebug(cid)
	pos.y = pos.y - 1

	doSendMagicEffect(pos, 0)
	
	local function doMetronome(cid, skill)
	if not isCreature(cid) then return true end
       docastspell(cid, skill)
    end
    
    addEvent(doMetronome, 200, cid, randommove)
    
elseif spell == "Focus" or spell == "Charge" or spell == "Swords Dance" then
                                                    --alterado v1.4
       if spell == "Charge" then
          doSendAnimatedText(getThingPosWithDebug(cid), "CHARGE", 168)
          doSendMagicEffect(getThingPosWithDebug(cid), 177)
       elseif spell == "Swords Dance" then
           doSendMagicEffect(getThingPosWithDebug(cid), 132) 
	   elseif spell == "Bulk Up" then
            doSendMagicEffect(getThingPosWithDebug(cid), 91)
       else
           doSendAnimatedText(getThingPosWithDebug(cid), "FOCUS", 144)
           doSendMagicEffect(getThingPosWithDebug(cid), 132)
       end
       setPlayerStorageValue(cid, 253, 1)
	   
	   elseif spell == "Growth" then
                                                    --alterado v1.4
       if spell == "Growth" then
          doSendAnimatedText(getThingPosWithDebug(cid), "Growth", 168)
          doSendMagicEffect(getThingPosWithDebug(cid), 177)
       end
       setPlayerStorageValue(cid, 253, 1)
	   
	   
       
--[[elseif spell == "Flame Wheel" then
                                                    --alterado v1.8 o atk ta la pra baixo agora...
    local function sendFireEff(cid, dir)
    if not isCreature(cid) then return true end
    if isSleeping(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then return false end
    if isWithFear(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then return true end
       doDanoWithProtect(cid, FIREDAMAGE, getPosByDir(getThingPosWithDebug(cid), dir), 0, -min, -max, 15)
	end

	local function doWheel(cid)
	if not isCreature(cid) then return true end
	local t = {
	      [1] = SOUTH,
	      [2] = SOUTHEAST,
	      [3] = EAST,
	      [4] = NORTHEAST,
	      [5] = NORTH,        --alterado!
	      [6] = NORTHWEST,
	      [7] = WEST,
	      [8] = SOUTHWEST,
		}
		for a = 1, 8 do
            addEvent(sendFireEff, a * 140, cid, t[a])
		end
	end

	doWheel(cid, false, cid)    ]]
    
elseif spell == "Hyper Voice" then

    local ret = {}
    ret.id = 0
    ret.cd = 9
    ret.check = 0
    ret.eff = 22
    ret.spell = spell
    ret.cond = "Stun"   
       
    doMoveInArea2(cid, 22, tw1, NORMALDAMAGE, min, max, spell, ret)

elseif spell == "Restore" or spell == "Selfheal" then
	
	local min = (getCreatureMaxHealth(cid) * 75) / 100
	local max = (getCreatureMaxHealth(cid) * 85) / 100
	
	local function doHealArea(cid, min, max)
    local amount = math.random(min, max)
    if (getCreatureHealth(cid) + amount) >= getCreatureMaxHealth(cid) then
        amount = -(getCreatureHealth(cid)-getCreatureMaxHealth(cid))
    end
    if getCreatureHealth(cid) ~= getCreatureMaxHealth(cid) then
       doCreatureAddHealth(cid, amount)
       doSendAnimatedText(getThingPosWithDebug(cid), "+"..amount.."", 65)
    end
    end
    
	doSendMagicEffect(getThingPosWithDebug(cid), 132)
    doHealArea(cid, min, max)
	
	elseif spell == "Aqua Ring"  then
	
	local min = (getCreatureMaxHealth(cid) * 75) / 100
	local max = (getCreatureMaxHealth(cid) * 85) / 100
	
	local function doHealArea(cid, min, max)
    local amount = math.random(min, max)
    if (getCreatureHealth(cid) + amount) >= getCreatureMaxHealth(cid) then
        amount = -(getCreatureHealth(cid)-getCreatureMaxHealth(cid))
    end
    if getCreatureHealth(cid) ~= getCreatureMaxHealth(cid) then
       doCreatureAddHealth(cid, amount)
       doSendAnimatedText(getThingPosWithDebug(cid), "+"..amount.."", 65)
    end
    end
    
	doSendMagicEffect(getThingPosWithDebug(cid), 132)
    doHealArea(cid, min, max)
    
	
elseif spell == "Healarea" then
	
	local min = (getCreatureMaxHealth(cid) * 50) / 100
	local max = (getCreatureMaxHealth(cid) * 60) / 100
    
    local function doHealArea(cid, min, max)
    local amount = math.random(min, max)
    if (getCreatureHealth(cid) + amount) >= getCreatureMaxHealth(cid) then
        amount = -(getCreatureHealth(cid)-getCreatureMaxHealth(cid))
    end
    if getCreatureHealth(cid) ~= getCreatureMaxHealth(cid) then
       doCreatureAddHealth(cid, amount)
       doSendAnimatedText(getThingPosWithDebug(cid), "+"..amount.."", 65)
    end
    end
    
    local pos = getPosfromArea(cid, heal)
    local n = 0
    doHealArea(cid, min, max)
    
    while n < #pos do
    n = n+1
    thing = {x=pos[n].x,y=pos[n].y,z=pos[n].z,stackpos=253}
    local pid = getThingFromPosWithProtect(thing)
    
    doSendMagicEffect(pos[n], 12)
    if isCreature(pid) then
       if isSummon(cid) and (isSummon(pid) or isPlayer(pid)) then
          if canAttackOther(cid, pid) == "Cant" then
             doHealArea(pid, min, max)
          end 
       elseif ehMonstro(cid) and ehMonstro(pid) then
          doHealArea(pid, min, max)
       end
    end 
    end
    
elseif spell == "Milk Drink" then
	
	local min = (getCreatureMaxHealth(cid) * 50) / 100
	local max = (getCreatureMaxHealth(cid) * 60) / 100
    
    local function doHealArea(cid, min, max)
    local amount = math.random(min, max)
    if (getCreatureHealth(cid) + amount) >= getCreatureMaxHealth(cid) then
        amount = -(getCreatureHealth(cid)-getCreatureMaxHealth(cid))
    end
    if getCreatureHealth(cid) ~= getCreatureMaxHealth(cid) then
       doCreatureAddHealth(cid, amount)
       doSendAnimatedText(getThingPosWithDebug(cid), "+"..amount.."", 65)
    end
    end
    
    local pos = getPosfromArea(cid, heal)
    local n = 0
    doHealArea(cid, min, max)
    
    while n < #pos do
    n = n+1
    thing = {x=pos[n].x,y=pos[n].y,z=pos[n].z,stackpos=253}
    local pid = getThingFromPosWithProtect(thing)
    
    doSendMagicEffect(pos[n], 12)
    if isCreature(pid) then
       if isSummon(cid) and (isSummon(pid) or isPlayer(pid)) then
          if canAttackOther(cid, pid) == "Cant" then
             doHealArea(pid, min, max)
          end 
       elseif ehMonstro(cid) and ehMonstro(pid) then
          doHealArea(pid, min, max)
       end
    end 
    end
    
elseif spell == "Toxic" then
 
  doMoveInArea2(cid, 114, reto5, POISONDAMAGE, min, max, spell)

elseif spell == "Absorb" then
local function getCreatureHealthSecurity(cid)
	if not isCreature(cid) then return 0 end
	return getCreatureHealth(cid) or 0
end
	local life = getCreatureHealthSecurity(target)

	doAreaCombatHealth(cid, GRASSDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 14)
    
	local newlife = life - getCreatureHealthSecurity(target)

	doSendMagicEffect(getThingPosWithDebug(cid), 14)
	if newlife >= 1 then
		if isCreature(cid) then
	       doCreatureAddHealth(cid, newlife)
		end
       doSendAnimatedText(getThingPosWithDebug(cid), "+"..newlife.."", 32)
	end  
	
elseif spell == "Poison Bomb" then

    doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 14)
    doDanoWithProtectWithDelay(cid, target, POISONDAMAGE, min, max, 20, bombWee2)

elseif spell == "Poison Gas" then 

local dmg = isSummon(cid) and getMasterLevel(cid)+getPokemonBoost(cid) or getPokemonLevel(cid)

local ret = {id = 0, cd = 13, eff = 34, check = 0, spell = spell, cond = "Miss"}
local ret2 = {id = 0, cd = 13, check = 0, damage = dmg, cond = "Poison"}                          --rever isso ainda!!
  
	local function gas(cid)
           doMoveInArea2(cid, 114, confusion, POISONDAMAGE, 0, 0, spell, ret)
		   doMoveInArea2(cid, 0, confusion, POISONDAMAGE, min, max, spell)
	end
    	
times = {0, 500, 1000, 1500, 2300, 2800, 3300, 3800, 4600, 5100, 5600, 6100, 6900, 7400, 7900, 8400, 9200, 10000}

for i = 1, #times do
    addEvent(gas, times[i], cid)                            
end
	
elseif spell == "Petal Dance" then

       doMoveInAreaMulti(cid, 21, 245, bullet, bulletDano, GRASSDAMAGE, min, max)
       

elseif spell == "Dynamic Punch" then

local pos = getThingPosWithDebug(cid)
local areas = {rock5, rock4, rock3, rock2, rock1, rock5, rock4, rock3, rock2, rock1}

for i = 0, 9 do
    addEvent(doMoveInArea2, i*400, cid, 112, areas[i+1], FIGHTINGDAMAGE, min, max, spell)
    addEvent(doMoveInArea2, i*410, cid, 112, areas[i+1], FIGHTINGDAMAGE, 0, 0, spell)
end


elseif spell == "Revenge" then

local function doRevenge(cid)
if not isCreature(cid) then return false end
if isSleeping(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then return false end
if isWithFear(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then return true end
local rev = getThingPosWithDebug(cid)
rev.x = rev.x+1
rev.y = rev.y+1
doSendMagicEffect(rev, 99)
	doAreaCombatHealth(cid, FIGHTINGDAMAGE, getThingPosWithDebug(cid), splash, -min, -max, 255)

end

times = {0, 500, 1000, 1500, 2300}

setPlayerStorageValue(cid, 3644587, 1)
addEvent(setPlayerStorageValue, 10000, cid, 3644587, -1)
for i = 1, #times do                   --alterado v1.4
addEvent(doRevenge, times[i], cid)
end
	
	 
elseif spell == "Close Combat" then
	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 26)
	doDanoInTargetWithDelay(cid, target, FIGHTINGDAMAGE, -min, -max, 237)  --alterado v1.7 
       doSendAnimatedText(getThingPosWithDebug(cid), "FOCUS", 144)   
       setPlayerStorageValue(cid, 253, 1)

elseif spell == "Sand Storm" then

local master = isSummon(cid) and getCreatureMaster(cid) or cid
------------
local ret = {}
ret.id = 0
ret.cd = 9
ret.check = 0
ret.eff = 34
ret.cond = "Silence"
---
local function doFall(cid)
for rocks = 1, 42 do --62
    addEvent(fall, rocks*35, cid, master, GROUNDDAMAGE, 22, 158)
end
end
---
local function doRain(cid)
if isSummon(cid) then 
   doCureBallStatus(getPlayerSlotItem(getCreatureMaster(cid), 8).uid, "all")
end                                                      --cura status
doCureStatus(cid, "all")
---
setPlayerStorageValue(cid, 253, 1)  --focus
doSendMagicEffect(getThingPosWithDebug(cid), 132)
---
doMoveInArea2(cid, 0, confusion, GROUNDDAMAGE, 0, 0, spell, ret)
end
---
addEvent(doFall, 200, cid)
addEvent(doRain, 1000, cid)

elseif spell == "Powder Snow" then
 
snowP = getThingPosWithDebug(cid)
    
    local ret = {}
    ret.id = 0
    ret.cd = 10
    ret.check = 0
    ret.eff = 43
    ret.spell = spell
    ret.cond = "Slow"   
 
    doMoveInArea2(cid, 0, check, ICEDAMAGE, min, max, spell, ret)
    doSendMagicEffect({x = snowP.x + 1, y = snowP.y, z = snowP.z}, 206)

elseif spell == "Slash" then

	doAreaCombatHealth(cid, NORMALDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 159)
	
elseif spell == "X-Scissor" then

local a = getThingPosWithDebug(cid)
 
local X = {
{{x = a.x+1, y = a.y, z = a.z}, 16}, --norte
{{x = a.x+2, y = a.y+1, z = a.z}, 221}, --leste
{{x = a.x+1, y = a.y+2, z = a.z}, 223}, --sul
{{x = a.x, y = a.y+1, z = a.z}, 243}, --oeste
}

local pos = X[mydir+1]

for b = 1, 3 do
    addEvent(doSendMagicEffect, b * 70, pos[1], pos[2])
end
	
doMoveInArea2(cid, 2, xScissor, BUGDAMAGE, min, max, spell)
	
elseif spell == "Psychic" then
                                    
	doDanoWithProtect(cid, psyDmg, getThingPosWithDebug(cid), selfArea2, min, max, 133)     
	
elseif spell == "Pay Day" then

        --alterado v1.7
		local function doThunderFall(cid, frompos, target)
			if not isCreature(target) or not isCreature(cid) then return true end
		local pos = getThingPosWithDebug(target)
		local ry = math.abs(frompos.y - pos.y)
		doSendDistanceShoot(frompos, getThingPosWithDebug(target), 39)
		addEvent(doDanoInTarget, ry * 11, cid, target, NORMALDAMAGE, min, max, 28)  --alterado v1.7
		end

		local function doThunderUp(cid, target)
			if not isCreature(target) or not isCreature(cid) then return true end
		local pos = getThingPosWithDebug(target)
		local mps = getThingPosWithDebug(cid)
		local xrg = math.floor((pos.x - mps.x) / 2)
		local topos = mps
		topos.x = topos.x + xrg
		local rd =  7
		topos.y = topos.y - rd
		doSendDistanceShoot(getThingPosWithDebug(cid), topos, 39)
		addEvent(doThunderFall, rd * 49, cid, topos, target)
		end		

    setPlayerStorageValue(cid, 3644587, 1)
	addEvent(setPlayerStorageValue, 350, cid, 3644587, -1)          
    for thnds = 1, 2 do
		addEvent(doThunderUp, thnds * 155, cid, target)
	end 
    
elseif spell == "Psywave" then

doMoveInArea2(cid, 133, db1, psyDmg, min, max, spell)      

elseif spell == "Triple Kick" or spell == "Triple Kick Lee" then

	doDanoWithProtect(cid, FIGHTINGDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 110)
	
elseif spell == "Karate Chop" then
    
    doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 39)
	doDanoInTargetWithDelay(cid, target, FIGHTINGDAMAGE, -min, -max, 113)  --alterado v1.7
	
elseif spell == "Ground Chop" then

local p = getThingPosWithDebug(cid)
local d = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)

function sendAtk(cid, area, area2, eff)  --alterado v1.6
if isCreature(cid) then
   if not isSightClear(p, area, false) then return true end
   doAreaCombatHealth(cid, FIGHTINGDAMAGE, area, 0, 0, 0, eff)    
   doAreaCombatHealth(cid, FIGHTINGDAMAGE, area2, whirl3, -min, -max, 255)  --alterado v1.6   
end
end

for a = 0, 4 do

local t = {
[0] = {99, {x=p.x+1, y=p.y-(a+1), z=p.z}, {x=p.x, y=p.y-(a+1), z=p.z}},           --alterado v1.6
[1] = {99, {x=p.x+(a+2), y=p.y+1, z=p.z}, {x=p.x+(a+1), y=p.y, z=p.z}},
[2] = {99, {x=p.x+1, y=p.y+(a+2), z=p.z}, {x=p.x, y=p.y+(a+1), z=p.z}},
[3] = {99, {x=p.x-(a+1), y=p.y+1, z=p.z}, {x=p.x-(a+1), y=p.y, z=p.z}}
}   
addEvent(sendAtk, 270*a, cid, t[d][2], t[d][3], t[d][1]) --alterado v1.6
end    
      
elseif spell == "Mega Punch" then

	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 39)
	doDanoInTargetWithDelay(cid, target, FIGHTINGDAMAGE, -min, -max, 112)  --alterado v1.7
    
elseif spell == "Tri Flames" then

local ret = {}
ret.id = 0
ret.cd = 9
ret.check = 0
ret.eff = 39
ret.cond = "Silence"

       doMoveInArea2(cid, 6, triflames, FIREDAMAGE, min, max, spell, ret)
          
elseif spell == "War Dog" then

   local ret = {}
   ret.id = cid
   ret.cd = 15
   ret.eff = 28
   ret.check = 0
   ret.buff = spell
   ret.first = true
   
   doCondition2(ret)
 
elseif spell == "Bulk Up" or spell == "Outrage" then

   local ret = {}
   ret.id = cid
   ret.cd = 10
   ret.eff = spell == "Outrage" and 358 or 356
   ret.check = 0
   ret.buff = spell
   ret.first = true
   
   doCondition2(ret)
            
elseif spell == "Hypnosis" then

local ret = {}
ret.id = target
ret.cd = math.random(6, 9)
ret.check = getPlayerStorageValue(target, conds["Sleep"])
ret.first = true                                                --alterado v1.6
ret.cond = "Sleep"

   doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 24)
   addEvent(doMoveDano2, 150, cid, target, PSYCHICDAMAGE, 0, 0, ret, spell)

elseif spell == "Dizzy Punch" then

   local rounds = getPokemonLevel(cid) / 12
   rounds = rounds + 2
   
   local ret = {}
   ret.id = target
   ret.check = getPlayerStorageValue(target, conds["Confusion"])
   ret.cd = rounds
   ret.cond = "Confusion"
   
   doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 26)
   doDanoWithProtect(cid, FIGHTINGDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 112)	
   addEvent(doMoveDano2, 50, cid, target, NORMALDAMAGE, 0, 0, ret, spell)

elseif spell == "Ice Punch" then
                   
local ret = {}
ret.id = target
ret.cd = 9
ret.eff = 43
ret.check = getPlayerStorageValue(target, conds["Slow"])
ret.first = true
ret.cond = "Slow"

    doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 28)
    doSendMagicEffect(getThingPosWithDebug(target), 112)
    doDanoWithProtectWithDelay(cid, target, ICEDAMAGE, min, max, 43)
    addEvent(doMoveDano2, 50, cid, target, ICEDAMAGE, 0, 0, ret, spell)
	
elseif spell == "Ice Beam" then

local a = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)
local p = getThingPosWithDebug(cid)
local t = {
[0] = {97, {x=p.x+1, y=p.y-1, z=p.z}},
[1] = {96, {x=p.x+6, y=p.y+1, z=p.z}}, 
[2] = {97, {x=p.x+1, y=p.y+6, z=p.z}},
[3] = {96, {x=p.x-1, y=p.y+1, z=p.z}},
}

local ret = {}
ret.id = 0
ret.cd = 9
ret.eff = 43
ret.check = 0
ret.first = true
ret.cond = "Slow"

doMoveInArea2(cid, 0, triplo6, ICEDAMAGE, min, max, spell, ret)
doSendMagicEffect(t[a][2], t[a][1])
	
	
elseif spell == "Psy Pulse" or spell == "Cyber Pulse" or spell == "Dark Pulse" then

damage = skill == "Dark Pulse" and DARKDAMAGE or psyDmg

local function doPulse(cid, eff)
if not isCreature(cid) then return true end
   doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 3)
   doDanoInTargetWithDelay(cid, target, damage, min, max, eff)      --alterado v1.7
end

   if spell == "Cyber Pulse" then
      eff = 11
   elseif spell == "Dark Pulse" then
      eff = 47  --efeito n eh esse mas... ;p
   else
      eff = 133
   end 
   
   addEvent(doPulse, 0, cid, eff)                
   addEvent(doPulse, 250, cid, eff)
    
elseif spell == "Psyusion" then

       local rounds = math.random(4, 7)
       rounds = rounds + math.floor(getPokemonLevel(cid) / 35)
       local eff = {136, 133, 136, 133, 137}
       local area = {psy1, psy2, psy3, psy4, psy5}

       local ret = {}
       ret.id = 0
       ret.check = 0
       ret.cd = rounds
       ret.cond = "Confusion"

       setPlayerStorageValue(cid, 3644587, 1)
       addEvent(setPlayerStorageValue, 4*400, cid, 3644587, -1)
       for i = 0, 4 do
           addEvent(doMoveInArea2, i*400, cid, eff[i+1], area[i+1], psyDmg, min, max, spell, ret)
       end
       
elseif spell == "Triple Punch" then

	doDanoWithProtect(cid, FIGHTINGDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 110)
	
elseif spell == "Fist Machine" or spell == "Bullet Punch" then

	local mpos = getThingPosWithDebug(cid)
	local b = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)
	local effect = 0
	local xvar = 0
	local yvar = 0

	if b == SOUTH then
		effect = spell == "Bullet Punch" and 373 or 218
		yvar = 2
	elseif b == NORTH then
		effect = spell == "Bullet Punch" and 372 or 217
	elseif b == WEST then
		effect = spell == "Bullet Punch" and 371 or 216
	elseif b == EAST then
		effect = spell == "Bullet Punch" and 370 or 215
		xvar = 2
	end

	mpos.x = mpos.x + xvar
	mpos.y = mpos.y + yvar         

	doSendMagicEffect(mpos, effect)
	doMoveInArea2(cid, 0, machine, FIGHTINGDAMAGE, min, max, spell)
	
elseif spell == "Destroyer Hand" then

       doMoveInAreaMulti(cid, 26, 111, bullet, bulletDano, FIGHTINGDAMAGE, min, max)
       
elseif spell == "Rock Throw" then

local effD = getSubName(cid, target) == "Shiny Onix" and 0 or 11
local eff = getSubName(cid, target) == "Shiny Onix" and 176 or 44  --alterado v1.6.1

	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), effD)
	doDanoInTargetWithDelay(cid, target, ROCKDAMAGE, min, max, eff) --alterado v1.7
	
elseif spell == "Rock Slide" or spell == "Stone Edge" then

atk = {
["Rock Slide"] = {11, 44, 0, 176},
["Stone Edge"] = {11, 239}
}                          

local effD = getSubName(cid, target) == "Shiny Onix" and atk[spell][3] or atk[spell][1]
local eff = getSubName(cid, target) == "Shiny Onix" and atk[spell][4] or atk[spell][2]  --alterado v1.6.1

        --alterado v1.7
		local function doRockFall(cid, frompos, target)
			if not isCreature(target) or not isCreature(cid) then return true end
		local pos = getThingPosWithDebug(target)
		local ry = math.abs(frompos.y - pos.y)
		doSendDistanceShoot(frompos, getThingPosWithDebug(target), effD)
		addEvent(doDanoInTarget, ry * 11, cid, target, ROCKDAMAGE, min, max, eff) --alterado v1.7
		end

		local function doRockUp(cid, target)
			if not isCreature(target) or not isCreature(cid) then return true end
		local pos = getThingPosWithDebug(target)
		local mps = getThingPosWithDebug(cid)
		local xrg = math.floor((pos.x - mps.x) / 2)
		local topos = mps
		topos.x = topos.x + xrg
		local rd =  7
		topos.y = topos.y - rd
		doSendDistanceShoot(getThingPosWithDebug(cid), topos, effD)
		addEvent(doRockFall, rd * 49, cid, topos, target)
		end		

    setPlayerStorageValue(cid, 3644587, 1)
    addEvent(setPlayerStorageValue, 350, cid, 3644587, -1)
	for thnds = 1, 2 do
		addEvent(doRockUp, thnds * 155, cid, target)
	end 
	
elseif spell == "Falling Rocks" then

local effD = getSubName(cid, target) == "Shiny Onix" and 0 or 11
local eff = getSubName(cid, target) == "Shiny Onix" and 176 or 44  --alterado v1.6.1

local master = isSummon(cid) and getCreatureMaster(cid) or cid
------------

local function doFall(cid)
for rocks = 1, 62 do
    addEvent(fall, rocks*35, cid, master, ROCKDAMAGE, effD, eff)
end
end

for up = 1, 10 do                                                            
    addEvent(upEffect, up*75, cid, effD)
end
addEvent(doFall, 450, cid)
addEvent(doDanoWithProtect, 1400, cid, ROCKDAMAGE, getThingPosWithDebug(cid), waterarea, -min, -max, 0)

elseif spell == "Selfdestruct" then
                                
		doDanoWithProtect(cid, ROCKDAMAGE, getThingPosWithDebug(cid), selfArea2, -min, -max, 5)
		if isSummon(cid) then
		local master = getCreatureMaster(cid)
			checkGiveUp(master)
			if isInDuel(master) then
				doRemoveCountPokemon(master)
			end
		end
		doKillWildPoke(cid, cid)
        
		
elseif spell == "Crusher Stomp" then
       
local pL = getThingPosWithDebug(cid)
pL.x = pL.x+5
pL.y = pL.y+1 
-----------------
local pO = getThingPosWithDebug(cid)
pO.x = pO.x-3
pO.y = pO.y+1 
------------------
local pN = getThingPosWithDebug(cid)
pN.x = pN.x+1
pN.y = pN.y+5 
-----------------
local pS = getThingPosWithDebug(cid)
pS.x = pS.x+1
pS.y = pS.y-3 

local po = {pL, pO, pN, pS}
local po2 = {
{x = pL.x, y = pL.y-1, z = pL.z},
{x = pO.x, y = pO.y-1, z = pO.z},
{x = pN.x-1, y = pN.y, z = pN.z},
{x = pS.x-1, y = pS.y, z = pS.z},
}

local ret = {}
ret.id = 0
ret.cd = 9
ret.check = 0
ret.eff = 34
ret.spell = spell
ret.cond = "Stun"

for i = 1, 4 do
    doSendMagicEffect(po[i], 127)
    doAreaCombatHealth(cid, GROUNDDAMAGE, po2[i], crusher, -min, -max, 255)
end
doMoveInArea2(cid, 118, stomp, GROUNDDAMAGE, min, max, spell, ret)  

elseif spell == "Water Pulse" then
                                    
	doDanoWithProtect(cid, WATERDAMAGE, getThingPosWithDebug(cid), selfArea2, min, max, 155)     
	
elseif spell == "Sonicboom" then

local function doBoom(cid)
if not isCreature(cid) then return true end
   doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 33)
   doDanoInTargetWithDelay(cid, target, NORMALDAMAGE, min, max, 3)   --alterado v1.7
end

   addEvent(doBoom, 0, cid)
   addEvent(doBoom, 250, cid)
   
elseif spell == "Stickmerang" then   

   doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 34)
   doDanoInTargetWithDelay(cid, target, FLYINGDAMAGE, min, max, 212)  --alterado v1.7

elseif spell == "Stickslash" then

    local function sendStickEff(cid, dir)
    if not isCreature(cid) then return true end
       doAreaCombatHealth(cid, FLYINGDAMAGE, getPosByDir(getThingPosWithDebug(cid), dir), 0, -min, -max, 212)
	end

	local function doStick(cid)
	if not isCreature(cid) then return true end
	local t = {
	      [1] = SOUTHWEST,
	      [2] = SOUTH,
	      [3] = SOUTHEAST,
	      [4] = EAST,
	      [5] = NORTHEAST,
	      [6] = NORTH,
	      [7] = NORTHWEST,
	      [8] = WEST,
	      [9] = SOUTHWEST,
		}
		for a = 1, 9 do
            addEvent(sendStickEff, a * 140, cid, t[a])
		end
	end

	doStick(cid, false, cid)

elseif spell == "Cannon Ball" then

local area = {Throw01, Throw02, Throw03, Throw04, Throw03, Throw02, Throw01}

for i = 0, 6 do
    addEvent(doMoveInArea2, i*400, cid, 100, area[i+1], GROUNDDAMAGE, min, max, spell)
end	


elseif spell == "Pluck" then

   doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 39)
   doDanoInTargetWithDelay(cid, target, FLYINGDAMAGE, min, max, 111)  --alterado v1.7

elseif spell == "Tri-Attack" then

   --alterado v1.7
   setPlayerStorageValue(cid, 3644587, 1)
   addEvent(setPlayerStorageValue, 600, cid, 3644587, -1) 
   doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 42)  --alterado v1.6
   for i = 0, 2 do
       addEvent(doDanoInTargetWithDelay, i*300, cid, target, NORMALDAMAGE, min, max, 238)      --alterado v1.7
   end 
    
elseif spell == "Fury Attack" then

    --alterado v1.7
    setPlayerStorageValue(cid, 3644587, 1)
    addEvent(setPlayerStorageValue, 600, cid, 3644587, -1) 
    for i = 0, 2 do
       addEvent(doDanoInTargetWithDelay, i*300, cid, target, NORMALDAMAGE, min, max, 110)    --alterado v1.7
    end  
   
elseif spell == "Ice Shards" then

    doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 28)
    doDanoInTargetWithDelay(cid, target, ICEDAMAGE, min, max, 43)  --alterado v1.7
    
elseif spell == "Icy Wind" then                   

local ret = {}
ret.id = 0
ret.cd = 9
ret.eff = 43
ret.check = 0
ret.first = true
ret.cond = "Slow"
	
  doMoveInArea2(cid, 17, db1, ICEDAMAGE, min, max, spell, ret)
  
elseif spell == "Aurora Beam" then

local a = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)
local p = getThingPosWithDebug(cid)
local t = {
[0] = {186, {x=p.x+1, y=p.y-1, z=p.z}},
[1] = {57, {x=p.x+6, y=p.y+1, z=p.z}},   --alterado v1.6
[2] = {186, {x=p.x+1, y=p.y+6, z=p.z}},
[3] = {57, {x=p.x-1, y=p.y+1, z=p.z}},  --alterado v1.6
}

local ret = {}
ret.id = 0
ret.cd = 9
ret.eff = 43
ret.check = 0
ret.first = true
ret.cond = "Slow"

doMoveInArea2(cid, 0, triplo6, ICEDAMAGE, min, max, spell, ret)
doSendMagicEffect(t[a][2], t[a][1])

elseif spell == "Rest" then

   local ret = {}
   ret.id = cid
   ret.cd = 6
   ret.eff = 0
   ret.check = 0
   ret.buff = spell
   ret.first = true
   
   doCondition2(ret)
	
elseif spell == "Sludge" then 

        --alterado v1.7
		local function doSludgeFall(cid, frompos, target)
			if not isCreature(target) or not isCreature(cid) then return true end
		local pos = getThingPosWithDebug(target)
		local ry = math.abs(frompos.y - pos.y)
		doSendDistanceShoot(frompos, getThingPosWithDebug(target), 6)
		addEvent(doDanoInTargetWithDelay, ry * 11, cid, target, POISONDAMAGE, min, max, 116) --alterado v1.7
		end

		local function doSludgeUp(cid, target)
			if not isCreature(target) or not isCreature(cid) then return true end
		local pos = getThingPosWithDebug(target)
		local mps = getThingPosWithDebug(cid)
		local xrg = math.floor((pos.x - mps.x) / 2)
		local topos = mps
		topos.x = topos.x + xrg
		local rd =  7
		topos.y = topos.y - rd
		doSendDistanceShoot(getThingPosWithDebug(cid), topos, 6)
		addEvent(doSludgeFall, rd * 49, cid, topos, target)
		end		

    setPlayerStorageValue(cid, 3644587, 1)
    addEvent(setPlayerStorageValue, 350, cid, 3644587, -1) 
	for thnds = 1, 2 do
		addEvent(doSludgeUp, thnds * 155, cid, target)
	end                                               --alterado v1.5

elseif spell == "Mud Bomb" then

   doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 6)  --alterado v1.8
   doDanoWithProtectWithDelay(cid, target, MUDBOMBDAMAGE, min, max, 116, bombWee2)

elseif spell == "Mortal Gas" then

    local pos = getThingPosWithDebug(cid)

	local function doSendAcid(cid, pos)
		if not isCreature(cid) then return true end
		doSendDistanceShoot(getThingPosWithDebug(cid), pos, 14)
		doSendMagicEffect(pos, 114)
	end
 
	for b = 1, 3 do
		for a = 1, 20 do
			local lugar = {x = pos.x + math.random(-4, 4), y = pos.y + math.random(-3, 3), z = pos.z}
			addEvent(doSendAcid, a * 75, cid, lugar)
		end
	end
	doDanoWithProtect(cid, POISONDAMAGE, pos, waterarea, -min, -max, 0) 
    
elseif spell == "Rock Drill" or spell == "Megahorn" or spell == "Rock Blast" then

local damage = spell == "Megahorn" and BUGDAMAGE or ROCKDAMAGE
local eff = spell == "Megahorn" and 8 or 44 
local effD = spell == "Rock Blast" and 11 or 25                    
                --cid, effDist, effDano, areaEff, areaDano, element, min, max
doMoveInAreaMulti(cid, effD, eff, bullet, bulletDano, damage, min, max)

elseif spell == "Egg Bomb" then

	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 12)
	doDanoWithProtectWithDelay(cid, target, NORMALDAMAGE, min, max, 5, crusher)
    
elseif spell == "Super Vines" then

    stopNow(cid, 200)           --alterado v1.6
    doCreatureSetLookDir(cid, 2)

	local effect = 0
	local pos = getThingPosWithDebug(cid)
	pos.x = pos.x + 1
	pos.y = pos.y + 1
	
    local effect = getSubName(cid, target) == "Tangela" and 213 or 229  --alterado v1.6.1

	doSendMagicEffect(pos, effect)
	doDanoWithProtect(cid, GRASSDAMAGE, getThingPosWithDebug(cid), splash, -min, -max, 0)
    
elseif spell == "Epicenter" then

        doMoveInArea2(cid, 127, epicenter, GROUNDDAMAGE, min, max, spell)
        
elseif spell == "Bubblebeam" then

local function sendBubbles(cid)
if not isCreature(cid) or not isCreature(target) then return true end
   doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 2)
   doDanoInTargetWithDelay(cid, target, WATERDAMAGE, min, max, 68)  --alterado v1.7
end

sendBubbles(cid)
addEvent(sendBubbles, 250, cid) 

elseif  spell == "Swift" then

local function sendSwift(cid, target)
if not isCreature(cid) or not isCreature(target) then return true end
   doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 32)
   doDanoInTargetWithDelay(cid, target, NORMALDAMAGE, min, max, 3)   --alterado v1.7
end

addEvent(sendSwift, 100, cid, target)
addEvent(sendSwift, 200, cid, target) 

elseif spell == "Spark" then
       
   doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 32)
   doDanoInTargetWithDelay(cid, target, ELECTRICDAMAGE, min, max, 48)    --alterado v1.7
   

elseif  spell == "Mimic Wall" then

local p = getThingPosWithDebug(cid)
local dirr = getCreatureLookDir(cid)

if dirr == 0 or dirr == 2 then
   item = 11439
else
   item = 11440
end

local wall = {
[0] = {{x = p.x, y = p.y-1, z = p.z}, {x = p.x+1, y = p.y-1, z = p.z}, {x = p.x-1, y = p.y-1, z = p.z}},
[2] = {{x = p.x, y = p.y+1, z = p.z}, {x = p.x+1, y = p.y+1, z = p.z}, {x = p.x-1, y = p.y+1, z = p.z}},
[1] = {{x = p.x+1, y = p.y, z = p.z}, {x = p.x+1, y = p.y+1, z = p.z}, {x = p.x+1, y = p.y-1, z = p.z}},
[3] = {{x = p.x-1, y = p.y, z = p.z}, {x = p.x-1, y = p.y+1, z = p.z}, {x = p.x-1, y = p.y-1, z = p.z}},
}

for i = 1, 3 do
    if wall[dirr] then
       local t = wall[dirr]
       if hasTile(t[i]) and canWalkOnPos2(t[i], true, true, true, true, false) then  --alterado v1.6
          local walls = doCreateItem(item, 1, t[i])
		  doDecayItem(walls)
       end
    end
end   

elseif spell == "Bullet Punch" then
	
	
	
elseif spell == "Compass Slash" then

	pos = getThingPos(cid)
		pos.x = pos.x +2
		pos.y = pos.y +2
    doSendMagicEffect(pos, 374)
	doDanoWithProtect(cid, ROCKDAMAGE, getThingPosWithDebug(cid), splash, -min, -max, 0)
   
elseif spell == "Shredder Team" or spell == "Double Team" then     --alterado v1.8 \/

local team = {
["Scyther"] = 3,
["Shiny Scyther"] = 3,
["Scizor"] = 4,
["Xatu"] = 2,
["Shiny Xatu"] = 3,
["Yanma"] = 2,
}

local function RemoveTeam(cid)
if isCreature(cid) then
  doSendMagicEffect(getThingPosWithDebug(cid), 211)
  doRemoveCreature(cid)
end
end

local function sendEff(cid, master, t)
if isCreature(cid) and isCreature(master) and t > 0 and #getCreatureSummons(master) >= 2 then
   doSendMagicEffect(getThingPosWithDebug(cid), 86, master)
   addEvent(sendEff, 1000, cid, master, t-1)                        --alterado v1.9
end
end

if getPlayerStorageValue(cid, 637500) >= 1 then
return true
end

local master = getCreatureMaster(cid)
local item = getPlayerSlotItem(master, 8)
local life, maxLife = getCreatureHealth(cid), getCreatureMaxHealth(cid)
local name = doCorrectString(getCreatureName(cid))
local pos = getThingPosWithDebug(cid)
local time = 21

doItemSetAttribute(item.uid, "hp", (life/maxLife))

local num = team[name]
local pk = {}
local function doCreatureAddHealthWithSecurity(cid, heal)
if not isCreature(cid) then return true end
doCreatureAddHealth(cid, heal)
end
local function setStorage(cid)
if not isCreature(cid) then return true end
setPlayerStorageValue(cid, 63012, 1)
addEvent(setStorage, 1000, cid)
end
--doTeleportThing(cid, {x=4, y=3, z=10}, false) 

if team[name] then
   pk[1] = cid
   for b = 2, num do
       local pokeSourceCode = doCreateMonsterNick(master, name,retireShinyName(name), getThingPos(master), true)
	   
	   if pokeSourceCode == "Nao" then
		   doSendMsg(master, "Não há espaço para seu pokemon.")
		   return true 
		end	 
	   
       pk[b] = getCreatureSummons(master)[b]
	   setPlayerStorageValue(pk[b], 510, name)
	   setStorage(pk[b])
	   adjustStatus(pk[b], getPlayerSlotItem(master, 8).uid, true, true, true, true)
	   doCreatureAddHealthWithSecurity(pk[b], -(maxLife-life))
   end

   for a = 1, num do
      addEvent(doTeleportThing, math.random(0, 5), pk[a], getClosestFreeTile(pk[a], pos), false)
      --addEvent(doAdjustWithDelay, 5, master, pk[a], true, true, true)
      doSendMagicEffect(getThingPosWithDebug(pk[a]), 211)
	  setPlayerStorageValue(pk[2], 637500, 1)
	  doCreatureSetSkullType(pk[a], getCreatureSkullType(pk[1]))
	  if a ~= 1 then
        addEvent(RemoveTeam, time * 1000, pk[a])
	  end
   end 
   sendEff(cid, master, time)     --alterado v1.9
   setPlayerStorageValue(master, 637501, 1)
   addEvent(setPlayerStorageValue, time * 1000, master, 637501, -2)
   
end


elseif spell == "Team Slice" or spell == "Team Claw" then

local master = getCreatureMaster(cid)
if #getCreatureSummons(master) < 2 or not isCreature(target) then return true end

local summons = getCreatureSummons(master)
local posis = {[1] = pos1, [2] = pos2, [3] = pos3, [4] = pos4}

if getSubName(cid, target) == "Scyther" then  --alterado v1.6.1
 eff = 39
elseif getSubName(cid, target) == "Shiny Scyther" then  --alterado v1.6.1
 eff = 39
else
 eff = 42  --alterado v1.5
end

   if #getCreatureSummons(master) >= 2 and isCreature(target) then
      if isCreature(cid) then
         addEvent(doDanoInTarget, 500, cid, target, BUGDAMAGE, -min, -max, 0) --alterado v1.7
         for i = 1, #summons do
             posis[i] = getThingPosWithDebug(summons[i])
             doDisapear(summons[i])
             stopNow(summons[i], 670)
             addEvent(doSendMagicEffect, 300, posis[i], 211)
             addEvent(doSendDistanceShoot, 350, posis[i], getThingPosWithDebug(target), eff)
             addEvent(doSendDistanceShoot, 450, getThingPosWithDebug(target), posis[i], eff)
             addEvent(doSendDistanceShoot, 600, posis[i], getThingPosWithDebug(target), eff)
             addEvent(doSendDistanceShoot, 650, getThingPosWithDebug(target), posis[i], eff)
             addEvent(doAppear, 670, summons[i])
         end
      end
    end
    
elseif spell == "Blizzard" then

local master = isSummon(cid) and getCreatureMaster(cid) or cid
local ret = {}
ret.id = 0
ret.cd = 9
ret.eff = 43
ret.check = 0
ret.first = true
ret.cond = "Slow"

local function doFall(cid)
for rocks = 1, 42 do
    addEvent(fall, rocks*35, cid, master, ICEDAMAGE, 28, 52)
end
end

for up = 1, 10 do
    addEvent(upEffect, up*75, cid, 28)
end                                         --alterado v1.4
addEvent(doFall, 450, cid)
addEvent(doMoveInArea2, 1400, cid, 0, BigArea2, ICEDAMAGE, min, max, spell, ret)



elseif spell == "Meteor Mash" then

	local pos = getThingPos(cid)
		  pos.x = pos.x + 1
		  pos.y = pos.y + 1
doSendMagicEffect(pos, 351)
doDanoWithProtect(cid, STEELDAMAGE, getThingPosWithDebug(cid), meteorMash1, -min, -max, 350)
doDanoWithProtect(cid, STEELDAMAGE, getThingPosWithDebug(cid), meteorMash2, -min, -max, 352)

elseif spell == "Great Love" then

local master = getCreatureMaster(cid) or 0
local ret = {}
ret.id = 0
ret.cd = 9
ret.eff = 147
ret.check = 0
ret.spell = spell
ret.cond = "Stun"
    
for rocks = 1, 62 do
    addEvent(fall, rocks*35, cid, master, NORMALDAMAGE, -1, 147)
end

addEvent(doMoveInArea2, 500, cid, 0, BigArea2, NORMALDAMAGE, min, max, spell, ret) 

elseif spell == "Fire Punch" then

	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 39)
    doSendMagicEffect(getThingPosWithDebug(target), 112)
    doDanoInTargetWithDelay(cid, target, FIREDAMAGE, min, max, 35) --alterado v1.7
    
elseif spell == "Guillotine" then

doDanoWithProtect(cid, NORMALDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 146)

elseif spell ==  "Hyper Beam" then  --alterado v1.7 \/

local a = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)
local p = getThingPosWithDebug(cid)
local t = {
[0] = {149, {x=p.x+1, y=p.y-1, z=p.z}},
[1] = {150, {x=p.x+6, y=p.y+1, z=p.z}},   
[2] = {149, {x=p.x+1, y=p.y+6, z=p.z}},
[3] = {150, {x=p.x-1, y=p.y+1, z=p.z}},  
}

doMoveInArea2(cid, 0, triplo6, NORMALDAMAGE, min, max, spell)
doSendMagicEffect(t[a][2], t[a][1])

elseif spell ==  "Flash Cannon" then 

local a = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)
local p = getThingPosWithDebug(cid)
local t = {
[0] = {354, {x=p.x+1, y=p.y-1, z=p.z}},
[1] = {353, {x=p.x+6, y=p.y+1, z=p.z}},   
[2] = {354, {x=p.x+1, y=p.y+6, z=p.z}},
[3] = {353, {x=p.x-1, y=p.y+1, z=p.z}},  
}

doMoveInArea2(cid, 0, triplo6, STEELDAMAGE, min, max, spell)
doSendMagicEffect(t[a][2], t[a][1])

elseif spell ==  "Dragon mist" or spell == "Mega Wing" then 

local a = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)
local p = getThingPosWithDebug(cid)
local t = {
[0] = {364, {x=p.x+1, y=p.y-1, z=p.z}, 0, -5},
[1] = {361, {x=p.x+5, y=p.y+1, z=p.z}, 5, 0},   
[2] = {363, {x=p.x+1, y=p.y+5, z=p.z}, 0, 5},
[3] = {362, {x=p.x-1, y=p.y+1, z=p.z}, -5, 0},  
}

if spell == "Mega Wing" then
t = {
[0] = {369, {x=p.x+1, y=p.y-1, z=p.z}, 0, -5},
[1] = {367, {x=p.x+5, y=p.y+1, z=p.z}, 5, 0},   
[2] = {366, {x=p.x+1, y=p.y+5, z=p.z}, 0, 5},
[3] = {368, {x=p.x-1, y=p.y+1, z=p.z}, -5, 0},  
}
end

local function doTeleportMe(cid, pos)
	if not isCreature(cid) then return true end
	if canWalkOnPos(pos, false, true, true, true, true) then 
	   doTeleportThing(cid, pos)
	end
	doAppear(cid)
	
	if getPlayerStorageValue(cid, storages.isMega) == "Mega Ampharos" then
	    doPantinOutfit(cid, 0, getPlayerStorageValue(cid, storages.isMega))
	else
		doSetCreatureOutfit(cid, {lookType = megasConf[getPlayerStorageValue(cid, storages.isMega)].out}, -1)
		checkOutfitMega(cid, getPlayerStorageValue(cid, storages.isMega))	
	end
end

doMoveInArea2(cid, 0, triplo6, STEELDAMAGE, min, max, spell)
doSendMagicEffect(t[a][2], t[a][1])
local pos = getThingPos(cid)
	  doSendMagicEffect(pos, 307)
	  doDisapear(cid)
	  local x, y = t[a][3], t[a][4]
	  pos.x = pos.x + x
	  pos.y = pos.y + y	
      addEvent(doTeleportMe, 300, cid, pos)	
    
elseif spell ==  "Signal Beam" then  --alterado v1.7 \/

local a = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)
local p = getThingPosWithDebug(cid)
local t = {
[0] = {262, {x=p.x+1, y=p.y-1, z=p.z}},
[1] = {263, {x=p.x+6, y=p.y+1, z=p.z}},   
[2] = {264, {x=p.x+1, y=p.y+6, z=p.z}},
[3] = {265, {x=p.x-1, y=p.y+1, z=p.z}},  
}

doMoveInArea2(cid, 0, triplo6, BUGDAMAGE, min, max, spell)
doSendMagicEffect(t[a][2], t[a][1])
    

elseif spell ==  "Flash Cannon" then  --alterado v1.7 \/

local a = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)
local p = getThingPosWithDebug(cid)
local t = {
[0] = {260, {x=p.x+1, y=p.y-1, z=p.z}},
[1] = {259, {x=p.x+6, y=p.y+1, z=p.z}},   
[2] = {260, {x=p.x+1, y=p.y+6, z=p.z}},
[3] = {259, {x=p.x-1, y=p.y+1, z=p.z}},  
}

doMoveInArea2(cid, 0, triplo6, STEELDAMAGE, min, max, spell)
doSendMagicEffect(t[a][2], t[a][1])
    

elseif spell == "Thrash" then

                --cid, effDist, effDano, areaEff, areaDano, element, min, max
doMoveInAreaMulti(cid, 10, 111, bullet, bulletDano, NORMALDAMAGE, min, max) 

elseif spell == "Splash" or tonumber(spell) == 7 then

	doAreaCombatHealth(cid, WATERDAMAGE, getThingPosWithDebug(cid), splash, -min, -max, 255)
	doSendMagicEffect(getThingPosWithDebug(cid), 53)
    
elseif spell == "Dragon Breath" then     

    doMoveInArea2(cid, 143, db1, DRAGONDAMAGE, min, max, spell) 
       
elseif spell == "Muddy Water" then

local pos = getThingPosWithDebug(cid)

doMoveInArea2(cid, 55, doSurf1, GROUNDDAMAGE, 0, 0, spell)
addEvent(doDanoWithProtect, math.random(100, 400), cid, GROUNDDAMAGE, pos, doSurf2, -min, -max, 0)

elseif spell == "Venom Motion" then

local ret = {}
ret.id = 0
ret.cd = 9
ret.eff = 34
ret.check = 0
ret.spell = spell
ret.cond = "Miss"

   doMoveInArea2(cid, 114, muddy, POISONDAMAGE, min, max, spell, ret)
       
elseif spell == "Thunder Fang" then

	doSendMagicEffect(getThingPosWithDebug(target), 146)
    doDanoInTargetWithDelay(cid, target, ELECTRICDAMAGE, min, max, 48)  --alterado v1.7
    
elseif spell == "Zap Cannon" then

local a = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)
local p = getThingPosWithDebug(cid)
local t = {
[0] = {73, {x=p.x, y=p.y-1, z=p.z}},
[1] = {74, {x=p.x+6, y=p.y, z=p.z}},      --alterado v1.8
[2] = {75, {x=p.x, y=p.y+6, z=p.z}},
[3] = {76, {x=p.x-1, y=p.y, z=p.z}},
}

doMoveInArea2(cid, 0, triplo6, ELECTRICDAMAGE, min, max, spell)
doMoveInArea2(cid, 177, reto6, ELECTRICDAMAGE, 0, 0, "Zap Cannon Eff")
doSendMagicEffect(t[a][2], t[a][1])
    
elseif spell == "Charge Beam" then

local a = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)
local p = getThingPosWithDebug(cid)
local t = {
[0] = {73, {x=p.x, y=p.y-1, z=p.z}},
[1] = {74, {x=p.x+6, y=p.y, z=p.z}},      --alterado v1.8
[2] = {75, {x=p.x, y=p.y+6, z=p.z}},
[3] = {76, {x=p.x-1, y=p.y, z=p.z}},
}

doMoveInArea2(cid, 0, triplo6, ELECTRICDAMAGE, min, max, spell)
doSendMagicEffect(t[a][2], t[a][1])
	
elseif spell == "Sacred Fire" then

     doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 3)
     doDanoWithProtectWithDelay(cid, target, SACREDDAMAGE, min, max, 143, sacred)    --alterado v1.6
            
elseif spell == "Blaze Kick" then

doMoveInArea2(cid, 6, blaze, FIREDAMAGE, min, max, spell) 
addEvent(doMoveInArea2, 200, cid, 6, kick, FIREDAMAGE, min, max, spell) 

elseif spell == "Cross Chop" then

doMoveInArea2(cid, 118, blaze, FIGHTINGDAMAGE, min, max, spell) 
addEvent(doMoveInArea2, 200, cid, 118, kick, FIGHTINGDAMAGE, min, max, spell) 

elseif spell == "Overheat" then

   doMoveInArea2(cid, 5, reto5, FIREDAMAGE, min, max, spell) 
   
elseif spell == "Ancient Power" then

local p = getThingPosWithDebug(cid)
local d = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)

function sendAtk(cid, area, eff)
if isCreature(cid) then
   if not isSightClear(p, area, false) then return true end
   doAreaCombatHealth(cid, ROCKDAMAGE, area, 0, 0, 0, eff)
   doAreaCombatHealth(cid, ROCKDAMAGE, area, whirl3, -min, -max, 137)
end
end

for a = 0, 4 do

local t = {
[0] = {18, {x=p.x, y=p.y-(a+1), z=p.z}},           --alterado v1.4
[1] = {18, {x=p.x+(a+1), y=p.y, z=p.z}},
[2] = {18, {x=p.x, y=p.y+(a+1), z=p.z}},
[3] = {18, {x=p.x-(a+1), y=p.y, z=p.z}}
}   
addEvent(sendAtk, 300*a, cid, t[d][2], t[d][1])
end
    
elseif spell == "Twister" then

doMoveInAreaMulti(cid, 28, 42, bullet, bulletDano, DRAGONDAMAGE, min, max)

elseif spell == "Multi-Kick" then

doMoveInAreaMulti(cid, 39, 113, multi, multiDano, FIGHTINGDAMAGE, min, max)

elseif spell == "Sky Uppercut" then
local function sendEffect(cid)
if not isCreature(cid) or not isCreature(target) then return true end
local pos = getThingPos(target)
local lado = getCreatureLookDir(cid)
local effes = {
    [0] = {effe1 = 261, effe2 = 265},
	[1] = {effe1 = 263, effe2 = 266},
	[2] = {effe1 = 262, effe2 = 264},
	[3] = {effe1 = 260, effe2 = 267}
	}
	   if lado == 0 then
		    local pos2 = pos
				  pos2.y = pos2.y +1
		    doSendMagicEffect(pos2, effes[lado].effe1)
			pos.y = pos.y -2
			pos.x = pos.x +1
	   elseif lado == 1 then
	        doSendMagicEffect(pos, effes[lado].effe1)
			pos.y = pos.y +2
			pos.x = pos.x +2
	   elseif lado == 2 then
		    local pos2 = pos
				  pos2.x = pos2.x +1
		    doSendMagicEffect(pos2, effes[lado].effe1)
			pos.y = pos.y +2
			pos.x = pos.x +1
	   elseif lado == 3 then
		    local pos2 = pos
				  pos2.x = pos2.x +1
		    doSendMagicEffect(pos2, effes[lado].effe1)
			pos.y = pos.y +2
			pos.x = pos.x -2
	   end	
addEvent(doSendMagicEffect, 100, pos, effes[lado].effe2)
addEvent(doDanoWithProtectWithDelay, 50, cid, target, SACREDDAMAGE, min, max, 255, sacred)    --alterado v1.6
end
sendEffect(cid)
elseif spell == "Hi Jump Kick" then

doMoveInAreaMulti(cid, 39, 113, multi, multiDano, FIGHTINGDAMAGE, min, max)

elseif spell == "Multi-Punch" then

doMoveInAreaMulti(cid, 39, 112, multi, multiDano, FIGHTINGDAMAGE, min, max) 

elseif spell == "Squisky Licking" then 
                                                      
local ret = {}
ret.id = 0
ret.cd = 9
ret.check = 0
ret.eff = 0
ret.spell = spell
ret.cond = "Stun"

local areas = {SL1, SL2, SL3, SL4}

for i = 0, 3 do
    addEvent(doMoveInArea2, i*200, cid, 145, areas[i+1], NORMALDAMAGE, min, max, spell, ret)
end

elseif spell == "Lick" then

local ret = {}
ret.id = target
ret.cd = 9
ret.check = getPlayerStorageValue(target, conds["Stun"])
ret.eff = 0
ret.spell = spell
ret.cond = "Stun"

   doSendMagicEffect(getThingPosWithDebug(target), 145)      --alterado v1.4!
   addEvent(doMoveDano2, 100, cid, target, NORMALDAMAGE, 0, 0, ret, spell)

elseif spell == "Bonemerang" then

   doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 7)
   doDanoInTargetWithDelay(cid, target, GROUNDDAMAGE, min, max, 227)  --alterado v1.7
   addEvent(doSendDistanceShoot, 250, getThingPosWithDebug(target), getThingPosWithDebug(cid), 7)

elseif spell == "Bone Club" then

  doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 7)
  doDanoInTargetWithDelay(cid, target, GROUNDDAMAGE, min, max, 118)  --alterado v1.7
	
elseif spell == "Bone Slash" then

local function sendStickEff(cid, dir)
    if not isCreature(cid) then return true end
       doAreaCombatHealth(cid, GROUNDDAMAGE, getPosByDir(getThingPosWithDebug(cid), dir), 0, -min, -max, 227)
	end

	local function doStick(cid)
	if not isCreature(cid) then return true end
	local t = {
	      [1] = SOUTHWEST,
	      [2] = SOUTH,
	      [3] = SOUTHEAST,
	      [4] = EAST,
	      [5] = NORTHEAST,
	      [6] = NORTH,
	      [7] = NORTHWEST,
	      [8] = WEST,
	      [9] = SOUTHWEST,
		}
		for a = 1, 9 do
            addEvent(sendStickEff, a * 140, cid, t[a])
		end
	end

	doStick(cid, false, cid)
                                                                            --alterado v1.4
elseif spell == "Furious Legs" or spell == "Ultimate Champion" or spell == "Fighter Spirit" then

   local ret = {}
   ret.id = cid
   ret.cd = 15
   ret.eff = 13
   ret.check = 0
   ret.buff = spell
   ret.first = true
   
   doCondition2(ret)      
            
elseif spell == "Sludge Wave" then                

local p = getThingPosWithDebug(cid)
local d = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)

local master = isSummon(cid) and getCreatureMaster(cid) or cid
local ret = {}
ret.id = 0
ret.cd = 9
ret.eff = 34
ret.check = 0
ret.spell = spell
ret.cond = "Miss"   

function sendAtk(cid, area, eff)
if isCreature(cid) then
   if not isSightClear(p, area, false) then return true end 
   doAreaCombatHealth(cid, POISONDAMAGE, area, 0, 0, 0, eff)
   doAreaCombatHealth(cid, POISONDAMAGE, area, whirl3, -min, -max, 114)
end
end

for a = 0, 4 do

local t = {
[0] = {114, {x=p.x, y=p.y-(a+1), z=p.z}},           --alterado v1.4
[1] = {114, {x=p.x+(a+1), y=p.y, z=p.z}},
[2] = {114, {x=p.x, y=p.y+(a+1), z=p.z}},
[3] = {114, {x=p.x-(a+1), y=p.y, z=p.z}}
}   
addEvent(sendAtk, 300*a, cid, t[d][2], t[d][1])
end
	
elseif spell == "Sludge Rain" then

local master = isSummon(cid) and getCreatureMaster(cid) or cid
local ret = {}
ret.id = 0
ret.cd = 9
ret.eff = 34
ret.check = 0
ret.spell = spell
ret.cond = "Miss"

local function doFall(cid)
for rocks = 1, 42 do
    addEvent(fall, rocks*35, cid, master, POISONDAMAGE, 6, 116)
end
end

for up = 1, 10 do
    addEvent(upEffect, up*75, cid, 6)
end         
                               
addEvent(doFall, 450, cid)
addEvent(doMoveInArea2, 1400, cid, 0, BigArea2, POISONDAMAGE, min, max, spell, ret)  

elseif spell == "Shadow Ball" then

    doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 18)

    local function doDamageWithDelay(cid, target)
    if not isCreature(cid) or not isCreature(target) then return true end
    if isSleeping(cid) then return false end
    if getPlayerStorageValue(cid, conds["Fear"]) >= 1 then return true end
	   doAreaCombatHealth(cid, ghostDmg, getThingPosWithDebug(target), 0, -min, -max, 255)
	   local pos = getThingPosWithDebug(target)
	   pos.x = pos.x + 1
	   doSendMagicEffect(pos, 140)
	end

	addEvent(doDamageWithDelay, 100, cid, target)
	
elseif spell == "Shadow Punch" then

	local pos = getThingPosWithDebug(target)
	doSendMagicEffect(pos, 112)

		local function doPunch(cid, target)
			if not isCreature(cid) or not isCreature(target) then return true end
		       doAreaCombatHealth(cid, ghostDmg, getThingPosWithDebug(target), 0, -min, -max, 255)
		       pos.x = pos.x + 1
		       doSendMagicEffect(pos, 140)
        end

	addEvent(doPunch, 200, cid, target)


elseif spell == "Brick Beak" then

local ret = {}
ret.id = 0
ret.cd = 9                        
ret.eff = 88
ret.check = 0
ret.first = true
ret.cond = "Paralyze"
ret.id = 0
ret.cd = 9                        
ret.eff = 88
ret.check = 0
ret.first = true
ret.cond = "Silence"

local a = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)
local p = getThingPosWithDebug(cid)
local t = {
[0] = {90, {x=p.x+1, y=p.y-1, z=p.z}},
[1] = {90, {x=p.x+2, y=p.y+1, z=p.z}},   
[2] = {90, {x=p.x+1, y=p.y+2, z=p.z}},
[3] = {90, {x=p.x-1, y=p.y+1, z=p.z}},  
}

doMoveInArea2(cid, 0, BrickBeak, FIGHTINGDAMAGE, min, max, spell, ret)
doSendMagicEffect(t[a][2], t[a][1])


elseif spell == "Shadow Storm" then

local master = isSummon(cid) and getCreatureMaster(cid) or cid

local function doFall(cid)
for rocks = 1, 42 do   --62
    addEvent(fall, rocks*35, cid, master, ghostDmg, 18, 140)
end
end

for up = 1, 10 do
    addEvent(upEffect, up*75, cid, 18)
end
addEvent(doFall, 450, cid)
addEvent(doMoveInArea2, 1400, cid, 2, BigArea2, ghostDmg, min, max, spell)

elseif spell == "Invisible" then

doDisapear(cid)
doSendMagicEffect(getThingPosWithDebug(cid), 134)
if isMonster(cid) then
  local pos = getThingPosWithDebug(cid)                           --alterei!
  doTeleportThing(cid, {x=4, y=3, z=10}, false)
  doTeleportThing(cid, pos, false)
end
addEvent(doAppear, 4000, cid)
        
elseif spell == "Nightmare" then

    if not isSleeping(target) then
		doSendMagicEffect(getThingPosWithDebug(target), 3)
		doSendAnimatedText(getThingPosWithDebug(target), "FAIL", 155)
	return true
	end
	
doDanoWithProtectWithDelay(cid, target, ghostDmg, -min, -max, 138)  

elseif spell == "Dream Eater" then

	if not isSleeping(target) then
		doSendMagicEffect(getThingPosWithDebug(target), 3)
		doSendAnimatedText(getThingPosWithDebug(target), "FAIL", 155)
	return true
	end
	                                                          --alterado v1.6
    setPlayerStorageValue(cid, 95487, 1)
    doSendMagicEffect(getThingPosWithDebug(cid), 132)
    doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 39)
    doDanoWithProtectWithDelay(cid, target, psyDmg, -min, -max, 138)
    
elseif spell == "Dark Eye" or spell == "Miracle Eye" then

doSendMagicEffect(getThingPosWithDebug(cid), 47)
setPlayerStorageValue(cid, 999457, 1)  

elseif spell == "Elemental Hands" then

if getCreatureOutfit(cid).lookType == 1301 then
print("Error occurred with move 'Elemental Hands', outfit of hitmonchan is wrong")
doPlayerSendTextMessage(getCreatureMaster(cid), MESSAGE_STATUS_CONSOLE_BLUE, "A error are ocurred... A msg is sent to gamemasters!") 
return true
end        --proteçao pra n usar o move com o shiny hitmonchan com outfit diferente da do elite monchan do PO...

local e = getCreatureMaster(cid)
local name = getItemAttribute(getPlayerSlotItem(e, 8).uid, "poke")
local hands = getItemAttribute(getPlayerSlotItem(e, 8).uid, "hands")

       if hands == 4 then
       doItemSetAttribute(getPlayerSlotItem(e, 8).uid, "hands", 0)
       doSendMagicEffect(getThingPosWithDebug(cid), hitmonchans[name][0].eff)
       doSetCreatureOutfit(cid, {lookType = hitmonchans[name][0].out}, -1)
       else
       doItemSetAttribute(getPlayerSlotItem(e, 8).uid, "hands", hands+1)
       doSendMagicEffect(getThingPosWithDebug(cid), hitmonchans[name][hands+1].eff)
       doSetCreatureOutfit(cid, {lookType = hitmonchans[name][hands+1].out}, -1)
       end
       
elseif spell == "Crabhammer" then

doDanoWithProtect(cid, NORMALDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 225)

elseif spell == "Ancient Fury" then

   local ret = {}
   ret.id = cid
   ret.cd = 15
   ret.eff = 0
   ret.check = 0
   ret.buff = spell
   ret.first = true
   
   doCondition2(ret)
   
elseif spell == "Divine Punishment" then

local roardirections = {            
[NORTH] = {SOUTH},
[SOUTH] = {NORTH},
[WEST] = {EAST},
[EAST] = {WEST}}

local function divineBack(cid)
if not isCreature(cid) then return true end
local uid = checkAreaUid(getCreaturePosition(cid), check, 1, 1)
      for _,pid in pairs(uid) do
          dirrr = getCreatureDirectionToTarget(pid, cid)
          delay = getNextStepDelay(pid, 0)
          if isSummon(cid) and (isMonster(pid) or (isSummon(pid) and canAttackOther(cid, pid) == "Can") or (isPlayer(pid) and canAttackOther(cid, pid) == "Can")) and pid ~= cid then
             setPlayerStorageValue(pid, 654878, 1)
             doChangeSpeed(pid, -getCreatureSpeed(pid))
             doChangeSpeed(pid, 100)
		     doPushCreature(pid, roardirections[dirrr][1], 1, 0)
		     doChangeSpeed(pid, -getCreatureSpeed(pid))
             addEvent(setPlayerStorageValue, 6450, pid, 654878, -1)
             addEvent(doRegainSpeed, 6450, pid)
           elseif isMonster(cid) and (isSummon(pid) or (isPlayer(pid) and #getCreatureSummons(pid) <= 0)) and pid ~= cid then
             setPlayerStorageValue(pid, 654878, 1)
             doChangeSpeed(pid, -getCreatureSpeed(pid))
		     doChangeSpeed(pid, 100)
		     doPushCreature(pid, roardirections[dirrr][1], 1, 0)
		     doChangeSpeed(pid, -getCreatureSpeed(pid))
             addEvent(doRegainSpeed, 6450, pid)
             addEvent(setPlayerStorageValue, 6450, pid, 654878, -1)
           end
       end    
end

local function doDivine(cid, min, max, spell, rounds, area)
if not isCreature(cid) then return true end
local ret = {}
ret.id = 0
ret.check = 0
ret.cd = rounds
ret.cond = "Confusion"
       
for i = 1, 9 do
    addEvent(doMoveInArea2, i*500, cid, 137, area[i], psyDmg, min, max, spell, ret)
end
end
       
       local rounds = math.random(9, 12)
       local area = {punish1, punish2, punish3, punish1, punish2, punish3, punish1, punish2, punish3}
       
       local posi = getThingPosWithDebug(cid) 
       posi.x = posi.x+1
       posi.y = posi.y+1

       setPlayerStorageValue(cid, 2365487, 1)
       addEvent(setPlayerStorageValue, 6450, cid, 2365487, -1) --alterado v1.4
       doDisapear(cid)
       doChangeSpeed(cid, -getCreatureSpeed(cid))
       doSendMagicEffect(posi, 247)   
       addEvent(doAppear, 6450, cid)
       addEvent(doRegainSpeed, 6450, cid)
       
       local uid = checkAreaUid(getCreaturePosition(cid), check, 1, 1)
             for _,pid in pairs(uid) do
                 if isSummon(cid) and (isMonster(pid) or (isSummon(pid) and canAttackOther(cid, pid) == "Can") or (isPlayer(pid) and canAttackOther(cid, pid) == "Can")) and pid ~= cid then
                    doChangeSpeed(pid, -getCreatureSpeed(pid))
                 elseif isMonster(cid) and (isSummon(pid) or (isPlayer(pid) and #getCreatureSummons(pid) <= 0)) and pid ~= cid then
                    doChangeSpeed(pid, -getCreatureSpeed(pid))
                 end
             end
                        
       addEvent(divineBack, 2100, cid)
       addEvent(doDivine, 2200, cid, min, max, spell, rounds, area)
       
elseif isInArray({"Psychic Sight", "Future Sight", "Camouflage", "Acid Armor", "Iron Defense", "Minimize"}, spell) then

   local ret = {}
   ret.id = cid
   ret.cd = 10
   ret.eff = 0
   ret.check = 0
   ret.buff = spell
   ret.first = true
   
   doCondition2(ret)    	

elseif spell == "Shadowave" then

doMoveInArea2(cid, 222, db1, DARKDAMAGE, min, max, spell)

elseif spell == "Confuse Ray" then

	local rounds = math.random(4, 7)
	rounds = rounds + math.floor(getPokemonLevel(cid) / 35)
	
    local ret = {}
	ret.id = target
	ret.cd = rounds
	ret.check = getPlayerStorageValue(target, conds["Confusion"])
	ret.cond = "Confusion"

    posi = getThingPosWithDebug(target)
         posi.y = posi.y+1
    ---
	doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 39)
	addEvent(doSendMagicEffect, 100, posi, 222)
    addEvent(doMoveDano2, 100, cid, target, GHOSTDAMAGE, -min, -max, ret, spell)

elseif spell == "Leaf Blade" then

local a = getThingPosWithDebug(target)
posi = {x = a.x+1, y = a.y+1, z = a.z}

doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 39)
addEvent(doSendMagicEffect, 200, posi, 240)
doDanoWithProtectWithDelay(cid, target, GRASSDAMAGE, -min, -max, 0, LeafBlade)

elseif spell == "Eruption" or spell == "Elecball" then


   local ret = {}
   ret.id = cid
   ret.cd = 15
   ret.eff = 14
   ret.check = 0
   ret.buff = spell
   ret.first = true
   
   doCondition2(ret)
    
pos = getThingPosWithDebug(cid)
    pos.x = pos.x+1
    pos.y = pos.y+1
    
atk = {
["Eruption"] = {241, FIREDAMAGE},
["Elecball"] = {171, ELECTRICDAMAGE}
}

stopNow(cid, 1000)
doSendMagicEffect(pos, atk[spell][1])
doMoveInArea2(cid, 0, bombWee1, atk[spell][2], min, max, spell) 

elseif spell == "Meteor Smash" then

doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 20)
doDanoInTargetWithDelay(cid, target, NORMALDAMAGE, -min, -max, 242) --alterado v1.7

elseif spell == "Draco Meteor" then

local effD = 5
local eff = 248
local master = isSummon(cid) and getCreatureMaster(cid) or cid

local function doFall(cid)
for rocks = 5, 42 do
    addEvent(fall, rocks*35, cid, master, DRAGONDAMAGE, effD, eff)
end
end

for up = 1, 10 do
    addEvent(upEffect, up*75, cid, effD)
end
addEvent(doFall, 450, cid)
addEvent(doDanoWithProtect, 1400, cid, DRAGONDAMAGE, getThingPosWithDebug(cid), waterarea, -min, -max, 0)


elseif spell == "Dragon Pulse" then

local p = getThingPosWithDebug(cid)
local d = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)

function sendAtk(cid, area)
if isCreature(cid) then
   if not isSightClear(p, area, false) then return true end
   doAreaCombatHealth(cid, DRAGONDAMAGE, area, pulse2, -min, -max, 255)
end
end

for a = 0, 3 do

local t = {
[0] = {249, {x=p.x, y=p.y-(a+1), z=p.z}},
[1] = {249, {x=p.x+(a+1), y=p.y, z=p.z}},
[2] = {249, {x=p.x, y=p.y+(a+1), z=p.z}},
[3] = {249, {x=p.x-(a+1), y=p.y, z=p.z}}
}   
addEvent(sendAtk, 300*a, cid, t[d][2])
addEvent(doDanoWithProtect, 400*a, cid, DRAGONDAMAGE, t[d][2], pulse2, 0, 0, 177)
addEvent(doDanoWithProtect, 400*a, cid, DRAGONDAMAGE, t[d][2], pulse1, 0, 0, t[d][1])
end

elseif spell == "Psy Ball" then

   doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 3)
   doDanoInTargetWithDelay(cid, target, psyDmg, min, max, 250)  --alterado v1.7

elseif spell == "SmokeScreen" then

local ret = {}
ret.id = 0
ret.cd = 9
ret.eff = 34
ret.check = 0
ret.spell = spell
ret.cond = "Miss"

local function smoke(cid)
if not isCreature(cid) then return true end
if isSleeping(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then return false end
if isWithFear(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then return true end
   doMoveInArea2(cid, 34, confusion, NORMALDAMAGE, 0, 0, spell, ret)
end

setPlayerStorageValue(cid, 3644587, 1)
addEvent(setPlayerStorageValue, 1000, cid, 3644587, -1) 
for i = 0, 2 do
    addEvent(smoke, i*500, cid)                               
end

elseif spell == "Faint Attack" or spell == "Sucker Punch" then  --alterado v1.5

   doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 39)
   doDanoInTargetWithDelay(cid, target, DARKDAMAGE, min, max, 237)  --alterado v1.7

elseif spell == "Assurance" then

local p = getThingPosWithDebug(cid)
local d = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)

function sendAtk(cid, area1, area2, eff)
if isCreature(cid) then
   if not isSightClear(p, area1, false) then return true end
   if not isSightClear(p, area2, false) then return true end
   doAreaCombatHealth(cid, DARKDAMAGE, area1, 0, 0, 0, eff)
   doAreaCombatHealth(cid, DARKDAMAGE, area2, whirl3, -min, -max, 0)
end
end

for a = 0, 3 do

local t = {
[0] = {230, {x=p.x+1, y=p.y-(a+1), z=p.z}, {x=p.x, y=p.y-(a+1), z=p.z}},
[1] = {226, {x=p.x+(a+2), y=p.y+1, z=p.z}, {x=p.x+(a+1), y=p.y, z=p.z}},
[2] = {235, {x=p.x+1, y=p.y+(a+1), z=p.z}, {x=p.x, y=p.y+(a+1), z=p.z}},
[3] = {231, {x=p.x-(a+1), y=p.y+1, z=p.z}, {x=p.x-(a+1), y=p.y, z=p.z}}
}   
addEvent(sendAtk, 300*a, cid, t[d][2], t[d][3], t[d][1])
end

elseif spell == "Scary Face" then

local ret = {}
ret.id = 0
ret.cd = 9
ret.check = 0
ret.eff = 0
ret.spell = spell
ret.cond = "Stun"


local p = getThingPosWithDebug(cid)
doSendMagicEffect({x=p.x+1, y=p.y+1, z=p.z}, 228)
doMoveInArea2(cid, 0, electro, NORMALDAMAGE, 0, 0, spell, ret)

elseif spell == "Surf" then

local pos = getThingPosWithDebug(cid)

doMoveInArea2(cid, 246, doSurf1, WATERDAMAGE, 0, 0, spell)
addEvent(doDanoWithProtect, math.random(100, 400), cid, WATERDAMAGE, pos, doSurf2, -min, -max, 0)

elseif spell == "Sunny Day" then

local ret = {}
ret.id = 0
ret.cd = 9
ret.check = 0
ret.eff = 39
ret.cond = "Silence"
----
local p = getThingPosWithDebug(cid)
doSendMagicEffect({x=p.x+1, y=p.y, z=p.z}, 181)
---
if isSummon(cid) then 
   doCureBallStatus(getPlayerSlotItem(getCreatureMaster(cid), 8).uid, "all")
end
doCureStatus(cid, "all")
setPlayerStorageValue(cid, 253, 1)  --focus
doMoveInArea2(cid, 0, electro, NORMALDAMAGE, 0, 0, spell, ret)


elseif spell == "Taunt" then

local ret = {}
ret.id = 0
ret.cd = 9
ret.check = 0
ret.eff = 136
ret.cond = "Silence"
----
local p = getThingPosWithDebug(cid)
doSendMagicEffect({x=p.x+1, y=p.y, z=p.z}, 140)
---
if isSummon(cid) then 
   doCureBallStatus(getPlayerSlotItem(getCreatureMaster(cid), 8).uid, "all")
end
doCureStatus(cid, "all")
setPlayerStorageValue(cid, 253, 1)  --focus
doMoveInArea2(cid, 0, electro, NORMALDAMAGE, 0, 0, spell, ret)




elseif isInArray({"Pursuit", "ExtremeSpeed", "U-Turn", "Shell Attack"}, spell) then

local atk = {
["Pursuit"] = {17, DARKDAMAGE},
["ExtremeSpeed"] = {50, NORMALDAMAGE, 51},
["U-Turn"] = {19, BUGDAMAGE},
["Shell Attack"] = {45, BUGDAMAGE}      --alterado v1.5
}

local pos = getThingPosWithDebug(cid)
local p = getThingPosWithDebug(target)
local newPos = getClosestFreeTile(target, p)

local eff = getSubName(cid, target) == "Shiny Arcanine" and atk[spell][3] or atk[spell][1] --alterado v1.6.1

local damage = atk[spell][2]
-----------
doDisapear(cid)
doChangeSpeed(cid, -getCreatureSpeed(cid))
-----------
addEvent(doSendMagicEffect, 300, pos, 211)
addEvent(doSendDistanceShoot, 400, pos, p, eff)
addEvent(doSendDistanceShoot, 400, newPos, p, eff)
addEvent(doDanoInTarget, 400, cid, target, damage, -min, -max, 0) --alterado v1.7
addEvent(doSendDistanceShoot, 800, p, pos, eff)
addEvent(doSendMagicEffect, 850, pos, 211)
addEvent(doRegainSpeed, 1000, cid)
addEvent(doAppear, 1000, cid)

elseif spell == "Egg Rain" then

local effD = 12
local eff = 5
local master = isSummon(cid) and getCreatureMaster(cid) or cid
------------

local function doFall(cid)
for rocks = 1, 62 do
    addEvent(fall, rocks*35, cid, master, ROCKDAMAGE, effD, eff)
end
end

for up = 1, 10 do
    addEvent(upEffect, up*75, cid, effD)
end
addEvent(doFall, 450, cid)
addEvent(doDanoWithProtect, 1400, cid, NORMALDAMAGE, getThingPosWithDebug(cid), waterarea, -min, -max, 0)


elseif spell == "Stampade" then

local master = getCreatureMaster(cid) or 0
local ret = {}
ret.id = 0
ret.cd = 9
ret.eff = 0
ret.check = 0
ret.spell = spell
ret.cond = "Stun"
    
for rocks = 1, 42 do
    addEvent(fall, rocks*35, cid, master, NORMALDAMAGE, -1, 187)
end

addEvent(doMoveInArea2, 500, cid, 0, BigArea2, NORMALDAMAGE, min, max, spell, ret) 

elseif spell == "Stampage" then

local master = getCreatureMaster(cid) or 0
local ret = {}
ret.id = 0
ret.cd = 9
ret.eff = 0
ret.check = 0
ret.spell = spell
ret.cond = "Stun"
    
for rocks = 1, 42 do
    addEvent(fall, rocks*35, cid, master, NORMALDAMAGE, -1, 194)
end

addEvent(doMoveInArea2, 500, cid, 0, BigArea2, NORMALDAMAGE, min, max, spell, ret)

elseif spell == "Barrier" then
if not isCreature(getCreatureTarget(cid)) then
local function sendAtk(cid)
if not isCreature(cid) then return true end
setPlayerStorageValue(cid, 9658783, -1) 
setPlayerStorageValue(cid, 734276, -1) 
end
setPlayerStorageValue(cid, 734276, 1) 
setPlayerStorageValue(cid, 9658783, 1)
pos = getThingPosWithDebug(cid)

local function doSendEff(cid)
if not isCreature(cid) then return true end
doSendMagicEffect({x = pos.x + 1, y = pos.y + 1, z = pos.z}, 172)
end
for i = 0, 7 do
 addEvent(doSendEff, i*1000, cid)
end
addEvent(sendAtk, 8000, cid)  
stopNow(cid, 8 * 800) 
else
local ret = {}
ret.id = target
ret.cd = 10
ret.check = getPlayerStorageValue(target, conds["Sleep"])
ret.eff = 0
ret.cond = "Sleep"

doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 24)
pos = getThingPosWithDebug(target)
addEvent(doMoveDano2, 150, cid, target, PSYCHICDAMAGE, 0, 0, ret, spell)
local function doSendEff(cid)
if not isCreature(cid) then return true end
doSendMagicEffect({x = pos.x + 1, y = pos.y + 1, z = pos.z}, 172)
end
for i = 0, 7 do
 addEvent(doSendEff, i*1000, cid)
end
stopNow(target, 8 * 800)
end

elseif spell == "Air Cutter" then
local p = getThingPosWithDebug(cid)
local d = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)

function sendAtk(cid, area)
if isCreature(cid) then
   if not isSightClear(p, area, false) then return true end
   doAreaCombatHealth(cid, FLYINGDAMAGE, area, whirl3, -min, -max, 255)
end
end

for a = 0, 5 do

local t = {
[0] = {128, {x=p.x, y=p.y-(a+1), z=p.z}, {x=p.x+1, y=p.y-(a+1), z=p.z}},
[1] = {129, {x=p.x+(a+1), y=p.y, z=p.z}, {x=p.x+(a+2), y=p.y+1, z=p.z}},
[2] = {131, {x=p.x, y=p.y+(a+1), z=p.z}, {x=p.x+1, y=p.y+(a+2), z=p.z}},
[3] = {130, {x=p.x-(a+1), y=p.y, z=p.z}, {x=p.x-(a+1), y=p.y+1, z=p.z}}
}   
addEvent(doSendMagicEffect, 300*a, t[d][3], t[d][1])
addEvent(sendAtk, 300*a, cid, t[d][2])
end

elseif spell == "Venom Gale" then

local area = {gale1, gale2, gale3, gale4, gale3, gale2, gale1}

for i = 0, 6 do
    addEvent(doMoveInArea2, i*400, cid, 138, area[i+1], POISONDAMAGE, min, max, spell)
end	

elseif spell == "Crunch" then

doMoveInArea2(cid, 146, Crunch1, DARKDAMAGE, min, max, spell)
addEvent(doMoveInArea2, 300, cid, 146, Crunch2, DARKDAMAGE, min, max, spell)

elseif spell == "Ice Fang" then

doTargetCombatHealth(cid, target, ICEDAMAGE, 0, 0, 146)
addEvent(doDanoWithProtect, 250, cid, ICEDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 17)

elseif spell == "Psyshock" then

local p = getThingPosWithDebug(cid)
local d = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)

function sendAtk(cid, area, eff)
if isCreature(cid) then 
   if not isSightClear(p, area, false) then return true end
   doAreaCombatHealth(cid, psyDmg, area, 0, 0, 0, eff)    --alterado v1.4
   doAreaCombatHealth(cid, psyDmg, area, whirl3, -min, -max, 255)     --alterado v1.4
end
end

for a = 0, 4 do

local t = {
[0] = {250, {x=p.x, y=p.y-(a+1), z=p.z}},           --alterado v1.4
[1] = {250, {x=p.x+(a+1), y=p.y, z=p.z}},
[2] = {250, {x=p.x, y=p.y+(a+1), z=p.z}},
[3] = {250, {x=p.x-(a+1), y=p.y, z=p.z}}
}   
addEvent(sendAtk, 370*a, cid, t[d][2], t[d][1])
end


elseif spell == "Hurricane" then

local function hurricane(cid)
		if not isCreature(cid) then return true end
		if isSleeping(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then return false end
		if isWithFear(cid) and getPlayerStorageValue(cid, 3644587) >= 1 then return true end
		   doMoveInArea2(cid, 42, bombWee1, FLYINGDAMAGE, min, max, spell)
	end

doSetCreatureOutfit(cid, {lookType = 1398}, 10000)

setPlayerStorageValue(cid, 3644587, 1)
addEvent(setPlayerStorageValue, 17*600, cid, 3644587, -1)    	
for i = 1, 17 do
    addEvent(hurricane, i*600, cid)                                --alterado v1.4
end

elseif spell == "Aromateraphy" or spell == "Emergency Call" then

eff = spell == "Aromateraphy" and 14 or 13

doAreaCombatHealth(cid, GRASSDAMAGE, getThingPosWithDebug(cid), bombWee3, 0, 0, eff)
if isSummon(cid) then 
   doCureBallStatus(getPlayerSlotItem(getCreatureMaster(cid), 8).uid, "all")
end
doCureStatus(cid, "all") 

local uid = checkAreaUid(getThingPosWithDebug(cid), confusion, 1, 1)
for _,pid in pairs(uid) do
    if isCreature(pid) then
       if ehMonstro(cid) and ehMonstro(pid) and pid ~= cid then
          doCureStatus(pid, "all")
       elseif isSummon(cid) and ((isSummon(pid) and canAttackOther(cid, pid) == "Cant") or (isPlayer(pid) and canAttackOther(cid, pid) == "Cant")) and pid ~= cid then
          if isSummon(pid) then 
             doCureBallStatus(getPlayerSlotItem(getCreatureMaster(pid), 8).uid, "all")
          end
          doCureStatus(pid, "all")
       end
    end
end

elseif spell == "Synthesis" or spell == "Roost" then

    local min = (getCreatureMaxHealth(cid) * 45) / 100
	local max = (getCreatureMaxHealth(cid) * 60) / 100
	
	local function doHealArea(cid, min, max)
    local amount = math.random(min, max)
    if (getCreatureHealth(cid) + amount) >= getCreatureMaxHealth(cid) then
        amount = -(getCreatureHealth(cid)-getCreatureMaxHealth(cid))
    end
    if getCreatureHealth(cid) ~= getCreatureMaxHealth(cid) then
       doCreatureAddHealth(cid, amount)
       doSendAnimatedText(getThingPosWithDebug(cid), "+"..amount.."", 65)
    end
    end
    
	doSendMagicEffect(getThingPosWithDebug(cid), 39)
    doHealArea(cid, min, max) 
    
elseif spell == "Cotton Spore" then

    local ret = {}
    ret.id = 0
    ret.cd = 9
    ret.eff = 0
    ret.check = 0
    ret.spell = spell
    ret.cond = "Stun"
    
    doMoveInArea2(cid, 85, confusion, GRASSDAMAGE, 0, 0, spell, ret)

elseif spell == "Peck" then

sendDistanceShootWithProtect(cid, getThingPosWithDebug(cid), getThingPosWithDebug(target), 39)
doDanoInTargetWithDelay(cid, target, FLYINGDAMAGE, min, max, 3)  --alterado v1.7

elseif spell == "Night Daze" then

local pos = getThingPosWithDebug(cid)
local eff = spell == "Night Daze" and 222 or 113
local dmg = spell == "Night Daze" and DARKDAMAGE or FIGHTINGDAMAGE

local out = getSubName(cid, target) == "Hitmontop" and 1193 or 1451 --alterado v1.6.1

	local function doSendBubble(cid, pos)
		if not isCreature(cid) then return true end
		doSendDistanceShoot(getThingPosWithDebug(cid), pos, 39)
		doSendMagicEffect(pos, eff)
	end
	                                                          --alterado!!
	for a = 1, 20 do
	    local r1 = math.random(-4, 4)
	    local r2 = r1 == 0 and choose(-3, -2, -1, 2, 3) or math.random(-3, 3)
	    --
	    local lugar = {x = pos.x + r1, y = pos.y + r2, z = pos.z}
	    addEvent(doSendBubble, a * 25, cid, lugar)
	end
	if isInArray({"Hitmontop", "Shiny Hitmontop"}, getSubName(cid, target)) then  --alterado v1.6.1
	   doSetCreatureOutfit(cid, {lookType = out}, 400)
    end 
	addEvent(doDanoWithProtect, 150, cid, dmg, pos, waterarea, -min, -max, 0)
	
elseif spell == "Rolling Kick" then

local pos = getThingPosWithDebug(cid)
local eff = spell == "Night Daze" and 222 or 113
local dmg = spell == "Night Daze" and DARKDAMAGE or FIGHTINGDAMAGE

local out = getSubName(cid, target) == "Hitmontop" and 1193 or 1451 --alterado v1.6.1

	local function doSendBubble(cid, pos)
		if not isCreature(cid) then return true end
		doSendDistanceShoot(getThingPosWithDebug(cid), pos, 27)
		doSendMagicEffect(pos, eff)
	end
	                                                          --alterado!!
	for a = 1, 20 do
	    local r1 = math.random(-4, 4)
	    local r2 = r1 == 0 and choose(-3, -2, -1, 2, 3) or math.random(-3, 3)
	    --
	    local lugar = {x = pos.x + r1, y = pos.y + r2, z = pos.z}
	    addEvent(doSendBubble, a * 25, cid, lugar)
	end
	if isInArray({"Hitmontop", "Shiny Hitmontop"}, getSubName(cid, target)) then  --alterado v1.6.1
	   doSetCreatureOutfit(cid, {lookType = out}, 400)
    end 
	addEvent(doDanoWithProtect, 150, cid, dmg, pos, waterarea, -min, -max, 0)
	
elseif spell == "Safeguard" then

doSendMagicEffect(getThingPosWithDebug(cid), 1)
if isSummon(cid) then 
   doCureBallStatus(getPlayerSlotItem(getCreatureMaster(cid), 8).uid, "all")
end
doCureStatus(cid, "all") 

elseif spell == "Air Slash" then

local p = getThingPosWithDebug(cid)

local t = {
{{128, {x = p.x+1, y = p.y-1, z = p.z}}, {16, {x = p.x+1, y = p.y-1, z = p.z}}},
{{129, {x = p.x+2, y = p.y+1, z = p.z}}, {221, {x = p.x+3, y = p.y+1, z = p.z}}},
{{131, {x = p.x+1, y = p.y+2, z = p.z}}, {223, {x = p.x+1, y = p.y+3, z = p.z}}},
{{130, {x = p.x-1, y = p.y+1, z = p.z}}, {243, {x = p.x-1, y = p.y+1, z = p.z}}},
}

for i = 1, 4 do
    doSendMagicEffect(t[i][2][2], t[i][2][1])
end
doDanoWithProtect(cid, FLYINGDAMAGE, getThingPosWithDebug(cid), airSlash, -min, -max, 0)    

for i = 1, 4 do
    addEvent(doSendMagicEffect, 400, t[i][1][2], t[i][1][1])
end
addEvent(doDanoWithProtect, 400, cid, FLYINGDAMAGE, getThingPosWithDebug(cid), bombWee2, -min, -max, 0)

elseif spell == "Feather Dance" then

local function doPulse(cid, eff)
if not isCreature(cid) or not isCreature(target) then return true end
   doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 9)
   doDanoInTargetWithDelay(cid, target, FLYINGDAMAGE, -min, -max, eff)   --alterado v1.7
end

   addEvent(doPulse, 0, cid, 137)                
   addEvent(doPulse, 100, cid, 137)


elseif spell == "Tailwind" then

   local ret = {}
   ret.id = cid
   ret.cd = 10
   ret.eff = 137
   ret.check = 0
   ret.buff = spell
   ret.first = true
   
   doCondition2(ret)

elseif spell == "Tackle" then

   doDanoWithProtect(cid, NORMALDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 111)

elseif spell == "Giga Drain" then

local life = getCreatureHealth(target) or 0

	doDanoWithProtect(cid, GRASSDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 258)
    
	local newlife = life - (getCreatureHealth(target) or 0)

	doSendMagicEffect(getThingPosWithDebug(cid), 14)
	if newlife >= 1 then
	doCreatureAddHealth(cid, newlife)
	doSendAnimatedText(getThingPosWithDebug(cid), "+"..newlife.."", 32)
	end  
	

elseif spell == "Leech Life" then

local life = getCreatureHealth(target)

	doDanoWithProtect(cid, BUGDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 14)
    
	local newlife = life - getCreatureHealth(target)

	doSendMagicEffect(getThingPosWithDebug(cid), 14)
	if newlife >= 1 then
	doCreatureAddHealth(cid, newlife)
	doSendAnimatedText(getThingPosWithDebug(cid), "+"..newlife.."", 32)
	end  
	
elseif spell == "Bug Fighter" then
	
   local ret = {}
   ret.id = cid
   ret.cd = 10
   ret.eff = 0
   ret.check = 0
   ret.buff = spell
   ret.first = true
   
   doCondition2(ret)	
	
elseif spell == "Metal Claw" then

   doDanoWithProtect(cid, STEELDAMAGE, getThingPosWithDebug(target), 0, -min, -max, 160)	
	
elseif spell == "Power Gem" then

local p = getThingPosWithDebug(cid)
local d = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)

function sendAtk(cid, area)
if isCreature(cid) then
   if not isSightClear(p, area, false) then return true end
   doAreaCombatHealth(cid, ROCKDAMAGE, area, pulse2, -min, -max, 255)
end
end

for a = 0, 3 do

local t = {
[0] = {29, {x=p.x, y=p.y-(a+1), z=p.z}},     
[1] = {29, {x=p.x+(a+1), y=p.y, z=p.z}},
[2] = {29, {x=p.x, y=p.y+(a+1), z=p.z}},
[3] = {29, {x=p.x-(a+1), y=p.y, z=p.z}}                            
}   
addEvent(sendAtk, 400*a, cid, t[d][2])
addEvent(doAreaCombatHealth, 400*a, cid, ROCKDAMAGE, t[d][2], pulse1, 0, 0, t[d][1])
addEvent(doAreaCombatHealth, 400*a, cid, ROCKDAMAGE, t[d][2], pulse1, 0, 0, 103)
end	
	
elseif spell == "Octazooka" then

local ret = {}
ret.id = 0
ret.cd = 9
ret.check = 0
ret.eff = 34
ret.cond = "Silence"

doMoveInAreaMulti(cid, 6, 116, multi, multiDano, WATERDAMAGE, min, max)
doMoveInArea2(cid, 0, multiDano, WATERDAMAGE, 0, 0, spell, ret)
	
	
elseif spell == "Take Down" then

    doMoveInArea2(cid, 111, reto5, NORMALDAMAGE, min, max, spell)

elseif spell == "Yawn" then

local ret = {}
ret.id = target
ret.cd = math.random(6, 9)
ret.check = getPlayerStorageValue(target, conds["Sleep"])
ret.first = true
ret.cond = "Sleep"

    doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 11)
    addEvent(doMoveDano2, 1500, cid, target, NORMALDAMAGE, 0, 0, ret, spell)

elseif spell == "Tongue Hook" then

sendDistanceShootWithProtect(cid, getThingPosWithDebug(cid), getThingPosWithDebug(target), 38)
addEvent(doTeleportThing, 200, target, getClosestFreeTile(cid, getThingPosWithDebug(cid)), true)
addEvent(sendDistanceShootWithProtect, 200, cid, getThingPosWithDebug(target), getThingPosWithDebug(cid), 38)


elseif spell == "Tongue Grap" then

local function distEff(cid, target)
if not isCreature(cid) or not isCreature(target) or not isSilence(target) then return true end  --alterado v1.6
   sendDistanceShootWithProtect(cid, getThingPosWithDebug(target), getThingPosWithDebug(cid), 38)
end

local ret = {}
ret.id = target
ret.cd = 10
ret.check = getPlayerStorageValue(target, conds["Silence"])
ret.eff = 185
ret.cond = "Silence"

sendDistanceShootWithProtect(cid, getThingPosWithDebug(cid), getThingPosWithDebug(target), 38)
addEvent(doMoveDano2, 100, cid, target, NORMALDAMAGE, 0, 0, ret, spell)
 
for i = 1, 10 do
    addEvent(distEff, i*930, cid, target)
end 

elseif spell == "Struggle Bug" then

    local function sendFireEff(cid, dir)
    if not isCreature(cid) then return true end
       doDanoWithProtect(cid, BUGDAMAGE, getPosByDir(getThingPosWithDebug(cid), dir), 0, -min, -max, 105)
	end

	local function doWheel(cid)
	if not isCreature(cid) then return true end
	local t = {
	      [1] = SOUTH,
	      [2] = SOUTHEAST,
	      [3] = EAST,
	      [4] = NORTHEAST,
	      [5] = NORTH,        --alterado v1.5
	      [6] = NORTHWEST,
	      [7] = WEST,
	      [8] = SOUTHWEST,
		}
		for a = 1, 8 do
            addEvent(sendFireEff, a * 200, cid, t[a])
		end
	end

	doWheel(cid, false, cid)
	
elseif spell == "Low Kick" then
  
    doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 39)
    doDanoInTargetWithDelay(cid, target, FIGHTINGDAMAGE, min, max, 113)	--alterado v1.7

elseif spell == "Present" then

local function sendHeal(cid)
if isCreature(cid) and isCreature(target) then 
   doAreaCombatHealth(cid, NORMALDAMAGE, getThingPosWithDebug(target), crusher, min, max, 5)
   doSendAnimatedText(getThingPosWithDebug(target), "HEALTH!", 65)
end
end

    doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 31)
    if math.random(1, 100) >= 10 then
	   doDanoWithProtectWithDelay(cid, target, NORMALDAMAGE, min, max, 5, crusher) 
    else
       addEvent(sendHeal, 100, cid) 
    end
	
elseif spell == "Inferno" or spell == "Fissure" then
    
local pos = getThingPosWithDebug(cid)

atk = {
["Inferno"] = {101, FIREDAMAGE},
["Fissure"] = {102, GROUNDDAMAGE}
}

doMoveInArea2(cid, atk[spell][1], inferno1, atk[spell][2], 0, 0, spell)
addEvent(doDanoWithProtect, math.random(100, 400), cid, atk[spell][2], pos, inferno2, -min, -max, 0)


elseif spell == "Wrap" then

local ret = {}
ret.id = target
ret.cd = 10
ret.check = getPlayerStorageValue(target, conds["Silence"])
ret.eff = 104
ret.cond = "Silence"

doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 39)
addEvent(doMoveDano2, 100, cid, target, NORMALDAMAGE, 0, 0, ret, spell)

elseif spell == "Rock n'Roll" then

local pos = getThingPosWithDebug(cid)
local areas = {rock1, rock2, rock3, rock4, rock5, rock4, rock3, rock2, rock1}
local ret = {}
ret.id = 0
ret.cd = 9
ret.eff = 1
ret.check = 0
ret.spell = spell
ret.cond = "Miss"

for i = 0, 8 do
    addEvent(doMoveInArea2, i*400, cid, 1, areas[i+1], NORMALDAMAGE, min, max, spell, ret)
    addEvent(doMoveInArea2, i*410, cid, 1, areas[i+1], NORMALDAMAGE, 0, 0, spell)
end

elseif spell == "Power Wave" then
                                             
local pos = getThingPosWithDebug(cid)
local areas = {rock1, rock2, rock3, rock4, rock5}
local ret = {}
ret.id = 0
ret.cd = 9
ret.eff = 103
ret.check = 0
ret.first = true
ret.cond = "Paralyze"

local function sendAtk(cid)
if isCreature(cid) then 
doRemoveCondition(cid, CONDITION_OUTFIT)
setPlayerStorageValue(cid, 9658783, -1)  
for i = 0, 4 do
    addEvent(doMoveInArea2, i*400, cid, 103, areas[i+1], psyDmg, min, max, spell, ret)
    addEvent(doMoveInArea2, i*410, cid, 103, areas[i+1], psyDmg, 0, 0, spell)
end
end
end

doSetCreatureOutfit(cid, {lookType = 1001}, -1)
setPlayerStorageValue(cid, 9658783, 1)
addEvent(sendAtk, 2000, cid)  


elseif spell == "Heal Bell" then

if isSummon(cid) then 
   doCureBallStatus(getPlayerSlotItem(getCreatureMaster(cid), 8).uid, "all")
end
doCureStatus(cid, "all") 

       local areas = {rock1, rock2, rock3, rock4, rock5, rock1, rock2, rock3, rock4, rock5, rock1, rock2, rock3, rock4, rock5, rock1, rock2, rock3, rock4, rock5, rock1, rock2, rock3, rock4, rock5}
   local ret = {}
   ret.id = cid
   ret.cd = 10
   ret.eff = 0
   ret.check = 0
   ret.buff = spell
   ret.first = true
   
   doCondition2(ret)    
 
       for i = 0, 22 do
    addEvent(doMoveInArea2, i*400, cid, 33, areas[i+1], NORMALDAMAGE, 0, 0, spell)
       end

elseif spell == "Ground Crusher" then

local pos = getThingPosWithDebug(cid)
local areas = {rock1, rock2, rock3, rock4, rock5}
local ret = {}
    ret.id = 0
    ret.cd = 12
    ret.eff = 0
    ret.check = 0
    ret.spell = spell
    ret.cond = "Stun"
    
local function endMove(cid)
if isCreature(cid) then
   doRemoveCondition(cid, CONDITION_OUTFIT)   
end
end

doSetCreatureOutfit(cid, {lookType = 1449}, -1)
stopNow(cid, 16*360)
addEvent(endMove, 16*360, cid)
----
for i = 0, 4 do
    addEvent(doMoveInArea2, i*350, cid, 100, areas[i+1], GROUNDDAMAGE, min, max, spell, ret)
    addEvent(doMoveInArea2, i*360, cid, 100, areas[i+1], GROUNDDAMAGE, 0, 0, spell, ret)
end
for i = 4, 8 do
    local a = i-3
    addEvent(doMoveInArea2, i*350, cid, 100, areas[a], GROUNDDAMAGE, min, max, spell, ret)
    addEvent(doMoveInArea2, i*360, cid, 100, areas[a], GROUNDDAMAGE, 0, 0, spell, ret)
end
for i = 8, 12 do
    local a = i-7
    addEvent(doMoveInArea2, i*350, cid, 100, areas[a], GROUNDDAMAGE, min, max, spell, ret)
    addEvent(doMoveInArea2, i*360, cid, 100, areas[a], GROUNDDAMAGE, 0, 0, spell, ret)
end
for i = 12, 16 do
    local a = i-11
    addEvent(doMoveInArea2, i*350, cid, 100, areas[a], GROUNDDAMAGE, min, max, spell, ret)
    addEvent(doMoveInArea2, i*360, cid, 100, areas[a], GROUNDDAMAGE, 0, 0, spell, ret)
end
for i = 16, 20 do
    local a = i-15
    addEvent(doMoveInArea2, i*350, cid, 100, areas[a], GROUNDDAMAGE, min, max, spell, ret)
    addEvent(doMoveInArea2, i*360, cid, 100, areas[a], GROUNDDAMAGE, 0, 0, spell, ret)
end

elseif spell == "Last Resort" then

local pos = getThingPosWithDebug(cid)
local areas = {rock5, rock4, rock3, rock2, rock1, rock5, rock4, rock3, rock2, rock1}

for i = 0, 9 do
    addEvent(doMoveInArea2, i*400, cid, 3, areas[i+1], NORMALDAMAGE, min, max, spell)
    addEvent(doMoveInArea2, i*410, cid, 3, areas[i+1], NORMALDAMAGE, 0, 0, spell)
end

elseif spell == "Psy Impact" then

local master = getCreatureMaster(cid) or 0
local ret = {}
ret.id = 0
ret.cd = 9
ret.eff = 0
ret.check = 0
ret.spell = spell
ret.cond = "Miss"
    
for rocks = 1, 42 do
    addEvent(fall, rocks*35, cid, master, psyDmg, -1, 98)
end

addEvent(doMoveInArea2, 500, cid, 0, BigArea2, psyDmg, min, max, spell, ret) 

elseif spell == "Two Face Shock" then

local atk = {
[1] = {179, ICEDAMAGE},
[2] = {127, GROUNDDAMAGE}
}

    local rand = math.random(1, 2)

	doAreaCombatHealth(cid, atk[rand][2], getThingPosWithDebug(cid), splash, -min, -max, 255)

	local sps = getThingPosWithDebug(cid)
	sps.x = sps.x+1
	sps.y = sps.y+1
	doSendMagicEffect(sps, atk[rand][1])


elseif spell == "Aerial Ace" then

local eff = {16, 221, 223, 243}

for rocks = 1, 32 do
    addEvent(fall, rocks*22, cid, master, FLYINGDAMAGE, -1, eff[math.random(1, 4)])
end

addEvent(doMoveInArea2, 500, cid, 0, BigArea2, FLYINGDAMAGE, min, max, spell) 

elseif spell == "Echoed Voice" then

local p = getThingPosWithDebug(cid)
local d = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)

function sendAtk(cid, area)
if isCreature(cid) then
   if not isSightClear(p, area, false) then return true end
   doAreaCombatHealth(cid, NORMALDAMAGE, area, pulse2, -min, -max, 255)
end
end

for a = 0, 5 do

local t = {
[0] = {39, {x=p.x, y=p.y-(a+1), z=p.z}},     
[1] = {39, {x=p.x+(a+1), y=p.y, z=p.z}},
[2] = {39, {x=p.x, y=p.y+(a+1), z=p.z}},
[3] = {39, {x=p.x-(a+1), y=p.y, z=p.z}}                            
}   
addEvent(sendAtk, 400*a, cid, t[d][2])
addEvent(doAreaCombatHealth, 400*a, cid, ROCKDAMAGE, t[d][2], pulse1, 0, 0, t[d][1])
end	

elseif spell == "Electro Field" or spell == "Petal Tornado" or spell == "Waterfall" or spell == "Flame Wheel" or spell == "Flare Blitz" then  --alterado v1.8

local p = getThingPos(cid)
local pos1 = {
[1] = {{x = p.x, y = p.y+4, z = p.z}, {x = p.x+1, y = p.y+4, z = p.z}, {x = p.x+2, y = p.y+3, z = p.z}, {x = p.x+3, y = p.y+2, z = p.z}, {x = p.x+4, y = p.y+1, z = p.z}, {x = p.x+4, y = p.y, z = p.z}},
[2] = {{x = p.x, y = p.y+3, z = p.z}, {x = p.x+1, y = p.y+3, z = p.z}, {x = p.x+2, y = p.y+2, z = p.z}, {x = p.x+3, y = p.y+1, z = p.z}, {x = p.x+3, y = p.y, z = p.z}},
[3] = {{x = p.x, y = p.y+2, z = p.z}, {x = p.x+1, y = p.y+2, z = p.z}, {x = p.x+2, y = p.y+1, z = p.z}, {x = p.x+2, y = p.y, z = p.z}},
[4] = {{x = p.x, y = p.y+1, z = p.z}, {x = p.x+1, y = p.y+1, z = p.z}, {x = p.x+1, y = p.y, z = p.z}},
}

local pos2 = {
[1] = {{x = p.x, y = p.y-4, z = p.z}, {x = p.x-1, y = p.y-4, z = p.z}, {x = p.x-2, y = p.y-3, z = p.z}, {x = p.x-3, y = p.y-2, z = p.z}, {x = p.x-4, y = p.y-1, z = p.z}, {x = p.x-4, y = p.y, z = p.z}},
[2] = {{x = p.x, y = p.y-3, z = p.z}, {x = p.x-1, y = p.y-3, z = p.z}, {x = p.x-2, y = p.y-2, z = p.z}, {x = p.x-3, y = p.y-1, z = p.z}, {x = p.x-3, y = p.y, z = p.z}},
[3] = {{x = p.x, y = p.y-2, z = p.z}, {x = p.x-1, y = p.y-2, z = p.z}, {x = p.x-2, y = p.y-1, z = p.z}, {x = p.x-2, y = p.y, z = p.z}},
[4] = {{x = p.x, y = p.y-1, z = p.z}, {x = p.x-1, y = p.y-1, z = p.z}, {x = p.x-1, y = p.y, z = p.z}},
}

local pos3 = {
[1] = {{x = p.x+4, y = p.y, z = p.z}, {x = p.x+4, y = p.y-1, z = p.z}, {x = p.x+3, y = p.y-2, z = p.z}, {x = p.x+2, y = p.y-3, z = p.z}, {x = p.x+1, y = p.y-4, z = p.z}, {x = p.x, y = p.y-4, z = p.z}},
[2] = {{x = p.x+3, y = p.y, z = p.z}, {x = p.x+3, y = p.y-1, z = p.z}, {x = p.x+2, y = p.y-2, z = p.z}, {x = p.x+1, y = p.y-3, z = p.z}, {x = p.x, y = p.y-3, z = p.z}},
[3] = {{x = p.x+2, y = p.y, z = p.z}, {x = p.x+2, y = p.y-1, z = p.z}, {x = p.x+1, y = p.y-2, z = p.z}, {x = p.x, y = p.y-2, z = p.z}},
[4] = {{x = p.x+1, y = p.y, z = p.z}, {x = p.x+1, y = p.y-1, z = p.z}, {x = p.x, y = p.y-1, z = p.z}},
}

local pos4 = {
[1] = {{x = p.x-4, y = p.y, z = p.z}, {x = p.x-4, y = p.y+1, z = p.z}, {x = p.x-3, y = p.y+2, z = p.z}, {x = p.x-2, y = p.y+3, z = p.z}, {x = p.x-1, y = p.y+4, z = p.z}, {x = p.x, y = p.y+4, z = p.z}},
[2] = {{x = p.x-3, y = p.y, z = p.z}, {x = p.x-3, y = p.y+1, z = p.z}, {x = p.x-2, y = p.y+2, z = p.z}, {x = p.x-1, y = p.y+3, z = p.z}, {x = p.x, y = p.y+3, z = p.z}},
[3] = {{x = p.x-2, y = p.y, z = p.z}, {x = p.x-2, y = p.y+1, z = p.z}, {x = p.x-1, y = p.y+2, z = p.z}, {x = p.x, y = p.y+2, z = p.z}},
[4] = {{x = p.x-1, y = p.y, z = p.z}, {x = p.x-1, y = p.y+1, z = p.z}, {x = p.x, y = p.y+1, z = p.z}},
}

local atk = {
--[atk] = {distance, eff, damage}
["Electro Field"] = {41, 207, ELECTRICDAMAGE},
["Petal Tornado"] = {14, 54, GRASSDAMAGE}, 

["Flame Wheel"] = {-1, 6, FIREDAMAGE},     --alterado v1.9
["Flare Blitz"] = {3, 257, FIREDAMAGE},     --alterado v1.9
["Waterfall"] = {-1, 155, WATERDAMAGE},
}

local function sendDist(cid, posi1, posi2, eff, delay)
if posi1 and posi2 and isCreature(cid) then
   addEvent(sendDistanceShootWithProtect, delay, cid, posi1, posi2, eff)   --alterado v1.6
end
end
                                                               
local function sendDano(cid, pos, eff, delay, min, max)
if pos and isCreature(cid) then
   addEvent(doDanoWithProtect, delay, cid, atk[spell][3], pos, 0, -min, -max, eff)  --alterado v1.6
end
end

local function doTornado(cid)
if isCreature(cid) then
for j = 1, 4 do
   for i = 1, 6 do                                                  --41/207  -- 14/54
       addEvent(sendDist, 350, cid, pos1[j][i], pos1[j][i+1], atk[spell][1], i*330)
       addEvent(sendDano, 350, cid, pos1[j][i], atk[spell][2], i*300, min, max)
       addEvent(sendDano, 350, cid, pos1[j][i], atk[spell][2], i*310, 0, 0)
       ---
       addEvent(sendDist, 350, cid, pos2[j][i], pos2[j][i+1], atk[spell][1], i*330)
       addEvent(sendDano, 350, cid, pos2[j][i], atk[spell][2], i*300, min, max)
       addEvent(sendDano, 350, cid, pos2[j][i], atk[spell][2], i*310, 0, 0)
       ----
       addEvent(sendDist, 800, cid, pos3[j][i], pos3[j][i+1], atk[spell][1], i*330)
       addEvent(sendDano, 800, cid, pos3[j][i], atk[spell][2], i*300, min, max)
       addEvent(sendDano, 800, cid, pos3[j][i], atk[spell][2], i*310, 0, 0)
       ---
       addEvent(sendDist, 800, cid, pos4[j][i], pos4[j][i+1], atk[spell][1], i*330)
       addEvent(sendDano, 800, cid, pos4[j][i], atk[spell][2], i*300, min, max)
       addEvent(sendDano, 800, cid, pos4[j][i], atk[spell][2], i*310, 0, 0)
   end
end
end
end

if spell == "Electro Field" then
   addEvent(doMoveInArea2, 1000, cid, 0, electro, ELECTRICDAMAGE, 0, 0, spell, ret)
end

if spell == "Waterfall" then
   addEvent(doMoveInArea2, 1000, cid, 0, electro, WATERDAMAGE, 0, 0, spell, ret)
end

if spell == "Flame Wheel" then   --alterado v1.8
   doTornado(cid)
else
    for b = 0, 2 do
        addEvent(doTornado, b*1500, cid)
    end
end

elseif spell == "Seed Bomb" then                  --alterado v1.6

local master = isSummon(cid) and getCreatureMaster(cid) or cid

local function doFall(cid)
for rocks = 1, 42 do   --62
    addEvent(fall, rocks*35, cid, master, SEED_BOMBDAMAGE, 1, 54)
end
end

for up = 1, 10 do
    addEvent(upEffect, up*75, cid, 1)
end
addEvent(doFall, 450, cid)
addEvent(doMoveInArea2, 1400, cid, 2, BigArea2, SEED_BOMBDAMAGE, min, max, spell)


elseif spell == "Reverse Earthshock" then

local p = getThingPosWithDebug(cid)
p.x = p.x+1
p.y = p.y+1

sendEffWithProtect(cid, p, 151)   --send eff

local function doDano(cid)
local pos = getThingPosWithDebug(cid)

    local function doSendBubble(cid, pos)
		if not isCreature(cid) then return true end
		doSendDistanceShoot(getThingPosWithDebug(cid), pos, 39)
		doSendMagicEffect(pos, 239)
	end
	                                                          --alterado!!
	for a = 1, 20 do
	    local r1 = math.random(-4, 4)
	    local r2 = r1 == 0 and choose(-3, -2, -1, 2, 3) or math.random(-3, 3)
	    --
	    local lugar = {x = pos.x + r1, y = pos.y + r2, z = pos.z}
	    addEvent(doSendBubble, a * 25, cid, lugar)
	end

	addEvent(doDanoWithProtect, 150, cid, ROCKDAMAGE, pos, waterarea, -min, -max, 0)
end

addEvent(doDano, 1250, cid)


elseif spell == "Fury Swipes" then

    doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 23)
	doDanoInTargetWithDelay(cid, target, NORMALDAMAGE, min, max, 152)  
	
	
elseif spell == "Poison Jab" then

    doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 15)
	doDanoInTargetWithDelay(cid, target, POISONDAMAGE, min, max, 153) 

                       
elseif spell == "Cross Poison" then

doMoveInArea2(cid, 153, cross, POISONDAMAGE, -min, -max, spell)


elseif spell == "Hydro Dance" then

       local eff = {155, 154, 53, 155, 53}
       local area = {psy1, psy2, psy3, psy4, psy5}

       setPlayerStorageValue(cid, 3644587, 1)
       addEvent(setPlayerStorageValue, 4*400, cid, 3644587, -1)
       for i = 0, 4 do
           addEvent(doMoveInArea2, i*400, cid, eff[i+1], area[i+1], WATERDAMAGE, min, max, spell)
       end
	   
elseif spell == "Stick Throw" then

local area = {Throw01, Throw02, Throw03, Throw04, Throw03, Throw02, Throw01}

local ret = {}
ret.id = 0
ret.cd = 9
ret.check = 0
ret.eff = 0
ret.spell = spell
ret.cond = "Stun"

stopNow(cid, 2000)
doMoveInArea2(cid, 212, reto5, STEELDAMAGE, min, max, spell, ret)     
	   
elseif spell == "Gyro Ball" then

local ret = {}
ret.id = 0
ret.cd = 9
ret.check = 0
ret.eff = 0
ret.spell = spell
ret.cond = "Stun"

stopNow(cid, 2000)
doMoveInArea2(cid, 156, reto5, STEELDAMAGE, min, max, spell, ret) 

elseif spell == "Rock Tomb" then

local ret = {}
ret.id = target
ret.cd = 9
ret.eff = 0
ret.check = getPlayerStorageValue(target, conds["Slow"])
ret.first = true
ret.cond = "Slow"

        local function doRockFall(cid, frompos, target)
			if not isCreature(target) or not isCreature(cid) then return true end
		    local pos = getThingPosWithDebug(target)
		    local ry = math.abs(frompos.y - pos.y)
		    doSendDistanceShoot(frompos, pos, 39)
		    addEvent(doMoveDano2, ry * 11, cid, target, ROCKDAMAGE, min, max, ret, spell)
		    addEvent(sendEffWithProtect, ry*11, cid, pos, 157)
        end

		local function doRockUp(cid, target)
			if not isCreature(target) or not isCreature(cid) then return true end
		    local pos = getThingPosWithDebug(target)
		    local mps = getThingPosWithDebug(cid)
		    local xrg = math.floor((pos.x - mps.x) / 2)
		    local topos = mps
		    topos.x = topos.x + xrg
		    local rd =  7
		    topos.y = topos.y - rd
		    doSendDistanceShoot(getThingPosWithDebug(cid), topos, 39)
		    addEvent(doRockFall, rd * 49, cid, topos, target)
		end		
    addEvent(doRockUp, 155, cid, target)
    
elseif spell == "Sand Tomb" then

local ret = {}
ret.id = 0
ret.cd = 9
ret.eff = 34
ret.check = 0
ret.spell = spell
ret.cond = "Miss"

doMoveInAreaMulti(cid, 22, 158, bullet, bulletDano, GROUNDDAMAGE, min, max, ret)

elseif spell == "Magnet Bomb" then

local ret = {}
ret.id = 0
ret.cd = 9
ret.eff = 48
ret.check = 0
ret.spell = spell
ret.cond = "Miss"

doMoveInAreaMulti(cid, 22, 171, bullet, bulletDano, ELECTRICDAMAGE, min, max, ret)

elseif spell == "Rain Dance" then

local master = isSummon(cid) and getCreatureMaster(cid) or cid
------------
local ret = {}
ret.id = 0
ret.cd = 9
ret.check = 0
ret.eff = 1
ret.cond = "Silence"
---
local function doFall(cid)
for rocks = 1, 42 do --62
    addEvent(fall, rocks*35, cid, master, WATERDAMAGE, 52, 1)
end
end
---
local function doRain(cid)
if isSummon(cid) then 
   doCureBallStatus(getPlayerSlotItem(getCreatureMaster(cid), 8).uid, "all")
end                                                      --cura status
doCureStatus(cid, "all")
---
setPlayerStorageValue(cid, 253, 1)  --focus
doSendMagicEffect(getThingPosWithDebug(cid), 132)
---
doMoveInArea2(cid, 0, confusion, WATERDAMAGE, 0, 0, spell, ret)
end
---
addEvent(doFall, 200, cid)
addEvent(doRain, 1000, cid)


elseif spell == "Night Slash" then

local p = getThingPosWithDebug(cid)

local t = {
{251, {x = p.x+1, y = p.y-1, z = p.z}},
{253, {x = p.x+2, y = p.y+1, z = p.z}},
{252, {x = p.x+1, y = p.y+2, z = p.z}},
{254, {x = p.x-1, y = p.y+1, z = p.z}},
}

doAreaCombatHealth(cid, DARKDAMAGE, p, scyther5, -min, -max, 165)
for a = 0, 1 do
    for i = 1, 4 do
        addEvent(doSendMagicEffect, a*400, t[i][2], t[i][1])          --alterado v1.8
    end
end
addEvent(doAreaCombatHealth, 400, cid, DARKDAMAGE, p, scyther5, -min, -max, 165)

elseif spell == "Heavy Slam" then

local p = getThingPosWithDebug(cid)

local t = {
{251, {x = p.x+1, y = p.y-1, z = p.z}},
{253, {x = p.x+2, y = p.y+1, z = p.z}},
{252, {x = p.x+1, y = p.y+2, z = p.z}},
{254, {x = p.x-1, y = p.y+1, z = p.z}},
}

doAreaCombatHealth(cid, STEELDAMAGE, p, confusion, -min, -max, 77)
for a = 0, 1 do
    for i = 1, 4 do
        addEvent(doSendMagicEffect, a*400, t[i][2], t[i][1])          --alterado v1.8
    end
end
addEvent(doAreaCombatHealth, 400, cid, STEELDAMAGE, p, confusion, -min, -max, 165)

elseif spell == "Wild Charge" then

local ret = {}                 
ret.id = 0
ret.cd = 9
ret.eff = 48
ret.check = 0
ret.spell = spell
ret.cond = "Stun"

local pos = getThingPosWithDebug(cid)
local areas = {rock5, rock4, rock3, rock2, rock1, rock5, rock4, rock3, rock2, rock1, rock5, rock4, rock3, rock2, rock1}

for i = 0, 14 do
    addEvent(doMoveInArea2, i*320, cid, 48, areas[i+1], ELECTRICDAMAGE, min, max, spell, ret)
    addEvent(doMoveInArea2, i*330, cid, 48, areas[i+1], ELECTRICDAMAGE, 0, 0, spell)
end

elseif spell == "Focus Blast" then

local ret = {}                 
ret.id = 0
ret.cd = 9
ret.eff = 136
ret.check = 0
ret.spell = spell
ret.cond = "Confusion"

local pos = getThingPosWithDebug(cid)
local areas = {rock5, rock4, rock3, rock2, rock1, rock5, rock4, rock3, rock2, rock1, rock5, rock4, rock3, rock2, rock1}

for i = 0, 14 do
    addEvent(doMoveInArea2, i*320, cid, 112, areas[i+1], FIGHTINGDAMAGE, min, max, spell, ret)
    addEvent(doMoveInArea2, i*330, cid, 112, areas[i+1], FIGHTINGDAMAGE, 0, 0, spell)
end

elseif spell == "Jump Kick" then   --ver essa

doMoveInAreaMulti(cid, 42, 113, bullet, bulletDano, FIGHTINGDAMAGE, min, max)

elseif spell == "Lava Plume" then                               --alterado v1.8 \/\/\/

doMoveInArea2(cid, 5, cross, FIREDAMAGE, -min, -max, spell)
doMoveInArea2(cid, 87, cross, FIREDAMAGE, 0, 0, spell)

elseif spell == "Silver Wind" then

doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 39)
doDanoWithProtectWithDelay(cid, target, BUGDAMAGE, min, max, 78, SilverWing)

elseif spell == "Bug Buzz" then 

local ret = {}
ret.id = target
ret.cd = 9
ret.eff = 34
ret.check = 0
ret.spell = spell
ret.cond = "Stun"  

doMoveInArea2(cid, 86, db1, BUGDAMAGE, min, max, spell, ret)
addEvent(doMoveInArea2, 250, cid, 86, db1, BUGDAMAGE, 0, 0, spell)

elseif spell == "Whirlpool" then

local function setSto(cid)
if isCreature(cid) then
   setPlayerStorageValue(cid, 3644587, -1)
end
end

local function doDano(cid)
if isSleeping(cid) then return true end
      doDanoWithProtect(cid, WATERDAMAGE, getThingPosWithDebug(cid), splash, min, max, 89)
end

setPlayerStorageValue(cid, 3644587, 1)
for r = 0, 10 do  
    addEvent(doDano, 600 * r, cid)
end
addEvent(setSto, 600*10, cid)


elseif spell == "Groundshock" then

local function setSto(cid)
	if isCreature(cid) then
	   setPlayerStorageValue(cid, 3644587, -1)
	end
end

local function doDano(cid)
if isSleeping(cid) then return true end
      doDanoWithProtect(cid, WATERDAMAGE, getThingPosWithDebug(cid), splash, min, max, 118)
end

setPlayerStorageValue(cid, 3644587, 1)
for r = 0, 1 do  
    addEvent(doDano, 600 * r, cid)
end
addEvent(setSto, 600*10, cid)

elseif spell == "Iron Head" then

doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 39)
doDanoInTargetWithDelay(cid, target, STEELDAMAGE, -min, -max, 77) 

elseif spell == "Brick Break" then

local ret = {}
ret.id = 0
ret.cd = 9                        
ret.eff = 88
ret.check = 0
ret.first = true
ret.cond = "Paralyze"

local a = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)
local p = getThingPosWithDebug(cid)
local t = {
[0] = {90, {x=p.x+1, y=p.y-1, z=p.z}},
[1] = {90, {x=p.x+2, y=p.y+1, z=p.z}},   
[2] = {90, {x=p.x+1, y=p.y+2, z=p.z}},
[3] = {90, {x=p.x-1, y=p.y+1, z=p.z}},  
}

doMoveInArea2(cid, 0, BrickBeak, FIGHTINGDAMAGE, min, max, spell, ret)
doSendMagicEffect(t[a][2], t[a][1])


elseif spell == "Volcano Burst" then

local pos = getThingPosWithDebug(cid)

doMoveInArea2(cid, 91, inferno1, FIREDAMAGE, 0, 0, spell)
addEvent(doDanoWithProtect, math.random(100, 400), cid, FIREDAMAGE, pos, inferno2, -min, -max, 0)

elseif spell == "Bone Rush" then

local area = {gale1, gale2, gale3, gale4, gale3, gale2, gale1}

for i = 0, 6 do
    addEvent(doMoveInArea2, i*400, cid, 227, area[i+1], ROCKDAMAGE, min, max, spell)
end	

elseif spell == "Hammer Arm" then

local ret = {}
ret.id = 0
ret.cd = 9                        
ret.eff = 88
ret.check = 0
ret.first = true
ret.cond = "Paralyze"

local a = isCreature(target) and getCreatureDirectionToTarget(cid, target) or getCreatureLookDir(cid)
local p = getThingPosWithDebug(cid)
local t = {
[0] = {92, {x=p.x, y=p.y-1, z=p.z}},
[1] = {94, {x=p.x+2, y=p.y, z=p.z}},   
[2] = {95, {x=p.x+1, y=p.y+2, z=p.z}},
[3] = {93, {x=p.x-1, y=p.y, z=p.z}},  
}

doMoveInArea2(cid, 0, BrickBeak, FIGHTINGDAMAGE, min, max, spell, ret)
doSendMagicEffect(t[a][2], t[a][1])


--///////////////////////   PASSIVAS /////////////////////////--

elseif spell == "Counter Helix" then
-- [nome] = {out = outfit girando, efeitos}
local OutFit = {
["Scyther"] = {out = 496, cima = 128, direita = 129, esquerda = 130, baixo = 131},  --scyther
["Scizor"] = {out = 918, cima = 128, direita = 129, esquerda = 130, baixo = 131},  --Scizor
["Shiny Scyther"] = {out = 849, cima = 128, direita = 129, esquerda = 130, baixo = 131}, --Shiny Scyther
["Hitmontop"] = {out = 1193, cima = 128, direita = 129, esquerda = 130, baixo = 131}, --Hitmontop
["Shiny Hitmontop"] = {out = 1451, cima = 128, direita = 129, esquerda = 130, baixo = 131}, --Shiny Hitmontop    
["Pineco"] = {out = 1194, cima = 128, direita = 129, esquerda = 130, baixo = 131}, --pineco
["Forretress"] = {out = 1192, cima = 128, direita = 129, esquerda = 130, baixo = 131}, --Forretress
["Wobbuffet"] = {out = 924, cima = 128, direita = 129, esquerda = 130, baixo = 131},  --wobb
["Alakazam"] = {out = 569, cima = 128, direita = 129, esquerda = 130, baixo = 131},  --alaka
["Kadabra"] = {out = 570, cima = 128, direita = 129, esquerda = 130, baixo = 131},  --kadabra
["Shiny Abra"] = {out = 1257, cima = 128, direita = 129, esquerda = 130, baixo = 131},  --s abra
["Kangaskhan"] = {out = 549, cima = 251, direita = 253, esquerda = 254, baixo = 252},  --test
}
      
	  if isMega(cid) then return true end
	  
      if getPlayerStorageValue(cid, 32623) == 1 then  --proteçao pra n usar a passiva 2x seguidas...
	    setPlayerStorageValue(cid, 32623, 0)  
      return true
      end
	  
      
      local nome1 = doCorrectString(getCreatureName(cid))   --alterado v1.6.1
      local outfitt = OutFit[nome1]   --alterado v1.6.1        

      local function doDamage(cid, min, max)
      if isCreature(cid) then
         if isInArray({"Scyther", "Shiny Scyther", "Pineco"}, nome1) then   --alterado v1.6
            damage = BUGDAMAGE  
         elseif isInArray({"Hitmontop", "Shiny Hitmontop", "Kangaskhan"}, nome1) then               
            damage = FIGHTINGDAMAGE                --alterado v1.6.1
         else                                        
            damage = STEELDAMAGE
         end
         doAreaCombatHealth(cid, damage, getThingPosWithDebug(cid), scyther5, -min, -max, CONST_ME_NONE) --alterado v1.6.1
         ---
         doAreaCombatHealth(cid, null, getThingPos(cid), scythe1, 0, 0, outfitt.cima) --cima
         doAreaCombatHealth(cid, null, getThingPos(cid), scythe2, 0, 0, outfitt.baixo) --baixo
         doAreaCombatHealth(cid, null, getThingPos(cid), scythe3, 0, 0, outfitt.direita) --direita
         doAreaCombatHealth(cid, null, getThingPos(cid), scythe4, 0, 0, outfitt.esquerda)  --esquerda
      end
      end
      
      local function sendEff(cid)
      if isCreature(cid) then
         doAreaCombatHealth(cid, null, getThingPos(cid), scythe1, 0, 0, outfitt.cima) --cima
         doAreaCombatHealth(cid, null, getThingPos(cid), scythe2, 0, 0, outfitt.baixo) --baixo
         doAreaCombatHealth(cid, null, getThingPos(cid), scythe3, 0, 0, outfitt.direita) --direita       --alterado v1.6
         doAreaCombatHealth(cid, null, getThingPos(cid), scythe4, 0, 0, outfitt.esquerda)  --esquerda
      end
      end   

      local function doChangeO(cid)
	  if not isCreature(cid) then return true end
         setPlayerStorageValue(cid, 32623, 0)      
         if isSleeping(cid) and getMonsterInfo(getCreatureName(cid)).lookCorpse ~= 0 then
            doSetCreatureOutfit(cid, {lookType = 0, lookTypeEx = getMonsterInfo(getCreatureName(cid)).lookCorpse}, -1)
         else
             doRemoveCondition(cid, CONDITION_OUTFIT)
         end
      end
      
      local delay = 200 -- não mexe
      local master = isSummon(cid) and getCreatureMaster(cid) or cid                    --alterado v1.6
      local summons = getCreatureSummons(master)                                          
      
      if (isPlayer(master) and #summons >= 2) or (ehMonstro(master) and #summons >= 1) then
         for j = 1, #summons do
             setPlayerStorageValue(summons[j], 32623, 1)      
	         doSetCreatureOutfit(summons[j], {lookType = outfitt.out}, -1)

             for i = 1, 2 do                                                                     --alterado v1.6
                 addEvent(sendEff, delay*i, summons[j])
             end
             addEvent(doChangeO, 2 * 300 + 10, summons[j])
			 for i = 1, 2 do
				 addEvent(doDamage, delay*i,  summons[j], min, max)
			 end
         end
      else
         setPlayerStorageValue(cid, 32623, 1)    
	     setPlayerStorageValue(cid, 98654, 1)		 
         doSetCreatureOutfit(cid, {lookType = outfitt.out}, -1)
   
         for i = 1, 2 do                                                                 --alterado v1.6
             addEvent(doDamage, delay*i, cid, min, max)
         end
         addEvent(doChangeO, 2 * 300 + 10, cid) 
      end
      
elseif spell == "Lava-Counter" then

local function sendStickEff(cid, dir)
    if not isCreature(cid) then return true end
       doAreaCombatHealth(cid, FIREDAMAGE, getPosByDir(getThingPosWithDebug(cid), dir), 0, -min, -max, 5)
	end

	local function doStick(cid)
	if not isCreature(cid) then return true end
	local t = {
	      [1] = SOUTHWEST,
	      [2] = SOUTH,
	      [3] = SOUTHEAST,
	      [4] = EAST,
	      [5] = NORTHEAST,
	      [6] = NORTH,
	      [7] = NORTHWEST,
	      [8] = WEST,
	      [9] = SOUTHWEST,
		}
		for a = 1, 9 do
            addEvent(sendStickEff, a * 140, cid, t[a])
		end
	end

	doStick(cid, false, cid)
	setPlayerStorageValue(cid, 98654, 1)
                 
elseif spell == "Mega Drain" then

local function getCreatureHealthSecurity(cid)
	if not isCreature(cid) then return 0 end
	return getCreatureHealth(cid) or 0
end

   local uid = checkAreaUid(getThingPos(cid), check, 1, 1)
   for _,pid in pairs(uid) do
       if isCreature(cid) and isCreature(pid) and pid ~= cid then
          if isPlayer(pid) and #getCreatureSummons(pid) >= 1 then return false end
		
          local life = getCreatureHealthSecurity(pid)

	      doAreaCombatHealth(cid, GRASSDAMAGE, getThingPos(pid), 0, -min, -max, 14)

	      local newlife = life - getCreatureHealthSecurity(pid)

			 doSendMagicEffect(getThingPos(cid), 14)
		     setPlayerStorageValue(cid, 98654, 1)
			 
	      if newlife >= 1 then
	         doCreatureAddHealth(cid, newlife)
	         doSendAnimatedText(getThingPos(cid), "+"..newlife.."", 32)
          end  

       end
   end
   
elseif spell == "Spores Reaction" then

local random = math.random(1, 3)

   if random == 1 then
      local ret = {}
      ret.id = 0
      ret.cd = math.random(2, 3)
      ret.check = 0                   --alterado v1.6
      ret.first = true
      ret.cond = "Sleep"
	
      doMoveInArea2(cid, 27, confusion, GRASSDAMAGE, 0, 0, "Spores Reaction", ret)
	     setPlayerStorageValue(cid, 98654, 1)
   elseif random == 2 then 
      local ret = {}
      ret.id = 0
      ret.cd = 6
      ret.eff = 0
      ret.check = 0
      ret.spell = spell
      ret.cond = "Stun"
    
      doMoveInArea2(cid, 85, confusion, GRASSDAMAGE, 0, 0, "Spores Reaction", ret)   
   setPlayerStorageValue(cid, 98654, 1)	  
   else
      local ret = {}
      ret.id = 0
      ret.cd = math.random(6, 10)
      ret.check = 0
      local lvl = isSummon(cid) and getMasterLevel(cid) or getPokemonLevel(cid)     --alterado v1.6
      ret.damage = math.floor((getPokemonLevel(cid)+lvl * 3)/2)
      ret.cond = "Poison"                              

      doMoveInArea2(cid, 84, confusion, POISONDAMAGE, 0, 0, "Spores Reaction", ret) 
	     setPlayerStorageValue(cid, 98654, 1)
   end

elseif spell == "Stunning Confusion" then

      if getPlayerStorageValue(cid, 32623) == 1 then  --proteçao pra n usar a spell 2x seguidas...
      return true
      end
      
      local function damage(cid)
      if isCreature(cid) then
         doAreaCombatHealth(cid, PSYCHICDAMAGE, getThingPosWithDebug(cid), bombWee3, -min, -max, 133)
      end
      end
          
      setPlayerStorageValue(cid, 32623, 1)        --proteçao
      for i = 1, 7 do
          addEvent(damage, i*500, cid)
      end
      addEvent(setPlayerStorageValue, 3500, cid, 32623, 0)        --proteçao
	     setPlayerStorageValue(cid, 98654, 1)
      
elseif spell == "Bone-Spin" then

local function sendStickEff(cid, dir)
    if not isCreature(cid) then return true end
       doAreaCombatHealth(cid, GROUNDDAMAGE, getPosByDir(getThingPosWithDebug(cid), dir), 0, -min, -max, 227)
	end

	local function doStick(cid)
	if not isCreature(cid) then return true end
	local t = {
	      [1] = SOUTHWEST,
	      [2] = SOUTH,
	      [3] = SOUTHEAST,
	      [4] = EAST,
	      [5] = NORTHEAST,
	      [6] = NORTH,
	      [7] = NORTHWEST,
	      [8] = WEST,
	      [9] = SOUTHWEST,
		}
		for a = 1, 9 do
            addEvent(sendStickEff, a * 140, cid, t[a])
		end
	end

	doStick(cid, false, cid)
        setPlayerStorageValue(cid, 98654, 1)
                                                                            --alterado v1.4
elseif spell == "Amnesia" then

   if getPlayerStorageValue(cid, 253) >= 1 then return true end
   
   doCreatureSay(cid, "????", 20)              
   doSendMagicEffect(getThingPosWithDebug(cid), 132)
   setPlayerStorageValue(cid, 253, 1)
   setPlayerStorageValue(cid, 98654, 1)
   
elseif spell == "Dragon Fury" then

   if getPlayerStorageValue(cid, 32623) == 1 then
   return true
   end

   setPlayerStorageValue(cid, 32623, 1)
   setPlayerStorageValue(cid, 98654, 1)

   if isInArray({"Persian", "Raticate", "Shiny Raticate"}, getSubName(cid, target)) then  --alterado v1.6.1
      doRaiseStatus(cid, 1.5, 0, 0, 10)
   else                                               --alterado v1.5 
      doRaiseStatus(cid, 1.5, 1.5, 0, 10)     --ver isso
   end
            
   for t = 1, 7 do                  --alterado v1.5
       addEvent(sendMoveEffect, t*1500, cid, 12)
   end
   addEvent(setPlayerStorageValue, 10500, cid, 32623, 0) --alterado v1.8
   
elseif spell == "Electric Charge" then

   if getPlayerStorageValue(cid, 253) >= 1 then
   return true
   end
   
   setPlayerStorageValue(cid, 253, 1)
   setPlayerStorageValue(cid, 98654, 1)
   doSendMagicEffect(getThingPosWithDebug(cid), 207)
   doSendAnimatedText(getThingPosWithDebug(cid), "FOCUS", 144)
   
elseif spell == "Shock-Counter" then

local function sendStickEff(cid, dir)
    if not isCreature(cid) then return true end
       doAreaCombatHealth(cid, ELECTRICDAMAGE, getPosByDir(getThingPosWithDebug(cid), dir), 0, -min, -max, 207)
	end

	local function doStick(cid)
	if not isCreature(cid) then return true end
	local t = {
	      [1] = SOUTHWEST,
	      [2] = SOUTH,
	      [3] = SOUTHEAST,
	      [4] = EAST,
	      [5] = NORTHEAST,
	      [6] = NORTH,
	      [7] = NORTHWEST,
	      [8] = WEST,
	      [9] = SOUTHWEST,
		}
		for a = 1, 9 do
            addEvent(sendStickEff, a * 140, cid, t[a])
		end
	end

	doStick(cid, false, cid)
	setPlayerStorageValue(cid, 98654, 1)
                 
elseif spell == "Mirror Coat" then

    if spell == "Magic Coat" then
      eff = 11
    else
      eff = 135
    end

	doSendMagicEffect(getThingPosWithDebug(cid), eff)
	setPlayerStorageValue(cid, storages.reflect, 5)   
setPlayerStorageValue(cid, 98654, 1)	
	
elseif spell == "Zen Mind" then

   function doCure(cid)
   if not isCreature(cid) then return true end
   if isSummon(cid) then 
      doCureBallStatus(getPlayerSlotItem(getCreatureMaster(cid), 8).uid, "all")
   end
   doCureStatus(cid, "all")
   end
   
   addEvent(doCure, 1000, cid)
   doSetCreatureOutfit(cid, {lookType = 1001}, 2000)
   setPlayerStorageValue(cid, 98654, 1)

elseif spell == "Detect" then
local function retireStatus(cid)
	if not isCreature(cid) then return true end
	setPlayerStorageValue(cid, 9658783, -1)
end

local function doRemoveEffect(cid)
	if not isCreature(cid) then return true end
	doRegainSpeed(cid)
	setPlayerStorageValue(cid, 9658783, 1)  -- nao velar dano
	addEvent(retireStatus, 5000, cid)
end

   doChangeSpeed(cid, -getCreatureSpeed(cid))
   addEvent(doRemoveEffect, 1000, cid)
   pos = getThingPos(cid)
   pos.x = pos.x + 2
   pos.y = pos.y +2
   doSendMagicEffect(pos, 375)
   
elseif spell == "Sturdy" then
	
	local function doKillWildPokeWhiteSecuirty(cid)
			  if not isCreature(cid) then return true end
			  if isSummon(cid) then
				  if isInDuel(getCreatureMaster(cid)) then
				   doRemoveCountPokemon(getCreatureMaster(cid))
				  end
			  end
			  doKillWildPoke(cid, cid)
		  end 
	
	local outfit = 2121
		   if isMega(cid) then 
		       outfit = 1865
		   elseif getCreatureName(cid) == "Sudowoodo" then
		       outfit = 2122
		   end
		   
		   doSetCreatureOutfit(cid, {lookType = outfit}, -1)
		   setPlayerStorageValue(cid, 9658783, 1)  -- nao velar dano
		   addEvent(doKillWildPokeWhiteSecuirty, 6000, cid)
   
elseif spell == "Demon Kicker" then

--[outfit] = outfit chutando,
local hitmonlees = {
["Hitmonlee"] =  652,      --hitmonlee
["Shiny Hitmonlee"] = 878,  --shiny hitmonlee
}
   
   local nome = getCreatureName(cid)  
                                                --alterado v1.6                                        --alterado v1.7
if (not hitmonlees[nome] and isCreature(target)) or (isCreature(target) and math.random(1, 100) <= passivesChances["Demon Kicker"][nome]) then
                                                         
      if getDistanceBetween(getThingPos(cid), getThingPos(target)) > 1 then
      return true
      end
      if getPlayerStorageValue(cid, 32623) == 1 then  --proteçao pra n usar a passiva 2x seguidas...
      return true
      end
      
      if not isSummon(cid) then       --alterado v1.7
         doCreatureSay(cid, string.upper(spell).."!", TALKTYPE_MONSTER)
      end
      
      local function doChangeHitmon(cid)
	  if not isCreature(cid) then return true end
         setPlayerStorageValue(cid, 32623, 0)         --proteçao
         if isSleeping(cid) and getMonsterInfo(getCreatureName(cid)).lookCorpse ~= 0 then
            doSetCreatureOutfit(cid, {lookType = 0, lookTypeEx = getMonsterInfo(getCreatureName(cid)).lookCorpse}, -1)
         else
            doRemoveCondition(cid, CONDITION_OUTFIT)
         end
      end            
       
         setPlayerStorageValue(cid, 32623, 1)       --proteçao
		 setPlayerStorageValue(cid, 98654, 1)
         
         local look = hitmonlees[nome] or getPlayerStorageValue(cid, 21104)  --alterado v1.6
   
         doCreatureSetLookDir(cid, getCreatureDirectionToTarget(cid, target))
         doSetCreatureOutfit(cid, {lookType = look}, -1)   --alterado v1.6
         doTargetCombatHealth(cid, target, FIGHTINGDAMAGE, -min, -max, 255)
         
         addEvent(doChangeHitmon, 700, cid)   		 
end

elseif spell == "Illusion" then

local team = {
["Misdreavus"] = "MisdreavusTeam",
["Shiny Stantler"] = "Shiny StantlerTeam",
["Stantler"] = "StantlerTeam",
}

local function RemoveTeam(cid)
if isCreature(cid) then
  doSendMagicEffect(getThingPosWithDebug(cid), 211)
  doRemoveCreature(cid)
end
end

local function sendEff(cid, master, t)
if isCreature(cid) and isCreature(master) and t > 0 and #getCreatureSummons(master) >= 2 then
   doSendMagicEffect(getThingPosWithDebug(cid), 86, master)
   addEvent(sendEff, 1000, cid, master, t-1)                        --alterado v1.9
end
end

if getPlayerStorageValue(cid, 637500) >= 1 then
return true
end

local master = getCreatureMaster(cid)
local item = getPlayerSlotItem(master, 8)
local life, maxLife = getCreatureHealth(cid), getCreatureMaxHealth(cid)
local name = getItemAttribute(item.uid, "poke")
local pos = getThingPosWithDebug(cid)
local time = 5

doItemSetAttribute(item.uid, "hp", (life/maxLife))

local num = getSubName(cid, target) == "Misdreavus" and 3 or 2
local pk = {}

doTeleportThing(cid, {x=4, y=3, z=10}, true) 

if team[name] then
   pk[1] = cid
   for b = 2, num do
       pk[b] = doSummonCreature(team[name], pos)
       doConvinceCreature(master, pk[b])
   end

   for a = 1, num do
      addEvent(doTeleportThing, math.random(0, 5), pk[a], getClosestFreeTile(pk[a], pos), true)
      addEvent(doAdjustWithDelay, 5, master, pk[a], true, true, true)
      doSendMagicEffect(getThingPosWithDebug(pk[a]), 211)
   end 
   sendEff(cid, master, time)     --alterado v1.9
   setPlayerStorageValue(master, 637501, 1)
   addEvent(setPlayerStorageValue, time * 1000, master, 637501, -2)
   -----
   setPlayerStorageValue(pk[2], 637500, 1)
   addEvent(RemoveTeam, time * 1000, pk[2])
   -----
   setPlayerStorageValue(pk[3], 637500, 1)
   addEvent(RemoveTeam, time * 1000, pk[3])
   ----
   if getSubName(cid, target) == "Scizor" then  
      setPlayerStorageValue(pk[4], 637500, 1) 
      addEvent(RemoveTeam, time * 1000, pk[4])
   end
end


elseif spell == "Demon Puncher" then

   local name = getCreatureName(cid)
                                                                                                             --alterado v1.7
if (not hitmonchans[name] and isCreature(target)) or (isCreature(target) and math.random(1, 100) <= passivesChances["Demon Puncher"][name]) then 
                                                        
       if getDistanceBetween(getThingPosWithDebug(cid), getThingPosWithDebug(target)) > 1 then
       return true
       end
       
       if not isSummon(cid) then       --alterado v1.7
         doCreatureSay(cid, string.upper(spell).."!", TALKTYPE_MONSTER)
       end                                 
         
         if ehMonstro(cid) or not hitmonchans[name] then
            hands = 0
         else
            hands = getItemAttribute(getPlayerSlotItem(getCreatureMaster(cid), 8).uid, "hands")
         end
         
         if not hitmonchans[name] then
            tabela = hitmonchans[getCreatureName(target)][hands]
         else
            tabela = hitmonchans[name][hands]
         end
          
         doSendDistanceShoot(getThingPosWithDebug(cid), getThingPosWithDebug(target), 39)
         doTargetCombatHealth(cid, target, tabela.type, -min, -max, 255)
         
         local alvo = getThingPosWithDebug(target)
         alvo.x = alvo.x + 1                           ---alterado v1.7
         
         if hands == 4 then
            doSendMagicEffect(alvo, tabela.eff)
         else
            doSendMagicEffect(getThingPosWithDebug(target), tabela.eff)
         end
         
         if hands == 3 then
            local ret = {}
            ret.id = target
            ret.cd = 9                     --alterado v1.6
            ret.eff = 43
            ret.check = getPlayerStorageValue(target, conds["Slow"])
            ret.first = true
            ret.cond = "Slow"
         
            doMoveDano2(cid, target, FIGHTINGDAMAGE, 0, 0, ret, spell)
			setPlayerStorageValue(cid, 98654, 1)
         end  
end

elseif string.find(spell:lower(), "mega -") then
		doTransformMega(cid)
	
end
return true 
end

function doBurnPoke(cid, target)
local name = doCorrectString(getCreatureName(cid))
local ret = {}
		ret.id = target
		ret.cd = isMega(cid) and math.random(12, 20) or math.random(6, 15) 
		ret.eff = (isMega(cid) and getMegaID(cid) == "X") and 302 or 15
		ret.color = (isMega(cid) and getMegaID(cid) == "X") and 28 or COLOR_BURN
		ret.check = 0
		local lvl = isSummon(cid) and getMasterLevel(cid) or getPokemonLevelD(name)
		local heldPercent = 1
			if isSummon(cid) then
			   local heldx = getItemAttribute(getPlayerSlotItem(getCreatureMaster(cid), 8).uid, "xHeldItem")
					if heldx then
					local heldName, heldTier = string.explode(heldx, "|")[1], string.explode(heldx, "|")[2]
						  if heldName == "X-Hellfire" then -- dar mais experiencia
							 heldPercent = heldPoisonBurn[tonumber(heldTier)]
						  end
					end
			end
		local dano =  math.floor((getPokemonLevelD(name)+lvl * 3)/2)
		ret.damage = dano + (heldPercent * dano / 100)
		ret.cond = "Burn"  
		ret.im = target
		ret.attacker = cid   
   
		doCondition2(ret)
end

function isMega(cid) 
	if getPlayerStorageValue(cid, storages.isMega) ~= -1 then
		return true
	end
	return false
end

function doTransformMega(cid)
    local name = doCorrectString(getCreatureName(cid))
	local wildMult = 1.5
	local megaID = ""
	if isSummon(cid) then
	    local master = getCreatureMaster(cid)
		if getItemAttribute(getPlayerSlotItem(master, 8).uid, "megaID") and getItemAttribute(getPlayerSlotItem(master, 8).uid, "megaID") ~= "" then
		   megaID = getItemAttribute(getPlayerSlotItem(master, 8).uid, "megaID")
		end
	else 
	   megaID = getPlayerStorageValue(cid, storages.isMegaID)
	end
	local megaName = "Mega " .. name .. (megaID ~= "" and " " .. megaID or "")
	if megasConf[megaName] then
		setPlayerStorageValue(cid, storages.isMega, megaName)
		
		
		doRegainSpeed(cid)	     --alterado!
		local pos = getThingPos(cid)
			  pos.x = pos.x + 1
			  pos.y = pos.y +1
		doSendMagicEffect(pos, 287)
		
		if isSummon(cid) then
		   local master = getCreatureMaster(cid)
		   doUpdateMoves(master)
		   wildMult = 1
		   setPlayerStorageValue(cid, storages.isMegaID, megaID)
		end
		
		setPlayerStorageValue(cid, 1001, megasConf[megaName].offense * wildMult)
		setPlayerStorageValue(cid, 1002, megasConf[megaName].defense * wildMult)
		setPlayerStorageValue(cid, 1003, megasConf[megaName].agility)           
		setPlayerStorageValue(cid, 1005, megasConf[megaName].specialattack * wildMult)
		
		if wildMult == 1.5 then
			local life = megasConf[megaName].wildVity * math.random(10000, 13500)
			local lifeNow = getCreatureMaxHealth(cid) - getCreatureHealth(cid)
				  setCreatureMaxHealth(cid, life) -- perfeita formula, os pokemons "ruins" só precisam de ajustes no pokemonStatus, tabela vitality.
				  doCreatureAddHealth(cid, getCreatureMaxHealth(cid))
				  doCreatureAddHealth(cid, -lifeNow)
				  
		end
		if isInArray({"Charizard", "Blaziken", "Ampharos"}, name) then
		   doPantinOutfit(cid, 0, megaName)
		else
		   doSetCreatureOutfit(cid, {lookType = megasConf[megaName].out}, -1)
		   checkOutfitMega(cid, megaName)
		end
	end
end

function checkChenceToMega(cid)
	local name, chance = doCorrectString(getCreatureName(cid)), math.random(0.1, 100.9)
	local megaID = ""
		  if name == "Charizard" then
			 megaID = math.random(1, 100) < 51 and "Y" or "X"
		  end
	local megaName = "Mega " .. name .. (megaID ~= "" and " " .. megaID or "")
		if megasConf[megaName] and not isMega(cid) then
		   if megasConf[megaName].wildChance >= chance then	
		      setPlayerStorageValue(cid, storages.isMegaID, megaID)
		      doTransformMega(cid)	
		   end
		end
end

function getMegaID(cid)
	return getPlayerStorageValue(cid, storages.isMegaID) ~= -1 and getPlayerStorageValue(cid, storages.isMegaID) or ""
end

function checkOutfitMega(cid, megaName)
	if not isCreature(cid) or not isMega(cid) then return true end
	local name = doCorrectString(getCreatureName(cid))
	if not megasConf[megaName] then return true end
	if getCreatureOutfit(cid).lookType ~= megasConf[megaName].out then
	   doSetCreatureOutfit(cid, {lookType = megasConf[megaName].out}, -1)
	end
	addEvent(checkOutfitMega, 50, cid)
end

function doPantinOutfit(cid, times, megaName)
	if not isCreature(cid) or not isMega(cid) then return true end
    if getCreatureOutfit(cid).lookType == 1875 or getCreatureOutfit(cid).lookType == 2 then return true end
	local name = doCorrectString(getCreatureName(cid))
	if not megasConf[megaName] then return true end
	local outfitIndex = 1
	if times <= 500 then
		outfitIndex = 1
	elseif times > 500 and times <= 1000 then 
	   outfitIndex = 2
	elseif times > 1000 and times <= 1500 then 
	   outfitIndex = 3
	end
	doSetCreatureOutfit(cid, {lookType = megasConf[megaName].out[outfitIndex]}, -1)
	times = times + 50
	if times > 1500 then
	   times = 0
	end
	addEvent(doPantinOutfit, 50, cid, times, megaName)
end

function doRolloutReflected(cid, name)
local RollOuts = {
["Voltorb"] = {lookType = 638},
["Electrode"] = {lookType = 637},
["Sandshrew"] = {lookType = 635},
["Sandslash"] = {lookType = 636},
["Phanpy"] = {lookType = 1005},
["Donphan"] = {lookType = 1007},
["Miltank"] = {lookType = 1006},                
["Golem"] = {lookType = 639},
["Omastar"] = {lookType = 1579},
["Shiny Electrode"] = {lookType = 1387},
["Shiny Golem"] = {lookType = 1403},
["Shiny Voltorb"] = {lookType = 1388},
["Shiny Sandslash"] = {lookType = 1506}
}
    local function setOutfit(cid, outfit)
          if isCreature(cid) and getCreatureCondition(cid, CONDITION_OUTFIT) == true then
             if getCreatureOutfit(cid).lookType == outfit then
                doRemoveCondition(cid, CONDITION_OUTFIT)
                if getCreatureName(cid) == "Ditto" and pokes[getPlayerStorageValue(cid, 1010)] and getPlayerStorageValue(cid, 1010) ~= "Ditto" then
                   if isSummon(cid) then
                      local item = getPlayerSlotItem(getCreatureMaster(cid), 8)
                      doSetCreatureOutfit(cid, {lookType = getItemAttribute(item.uid, "transOutfit")}, -1)   --alterado v1.8
                   end
                end 
             end
          end
    end
	
		  
	if RollOuts[name] then
		doSetCreatureOutfit(cid, RollOuts[name], -1)   --alterado v1.6.1
    end 

	local outfit = getCreatureOutfit(cid).lookType

    local function roll(cid, outfit)
    if not isCreature(cid) then return true end
    if isSleeping(cid) then return true end
       if RollOuts[name] then
          doSetCreatureOutfit(cid, RollOuts[name], -1)  
       end
    end

    setPlayerStorageValue(cid, 3644587, 1)
    addEvent(setPlayerStorageValue, 9000, cid, 3644587, -1)
    for r = 1, 11 do  --8
        addEvent(roll, 750 * r, cid, outfit)
    end
    addEvent(setOutfit, 9050, cid, outfit)
end