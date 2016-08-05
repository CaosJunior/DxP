local damages = {GROUNDDAMAGE, ELECTRICDAMAGE, ROCKDAMAGE, FLYDAMAGE, BUGDAMAGE, FIGHTINGDAMAGE, DRAGONDAMAGE, POISONDAMAGE, DARKDAMAGE, STEELDAMAGE}
local fixdmgs = {PSYCHICDAMAGE, COMBAT_PHYSICALDAMAGE, GRASSDAMAGE, FIREDAMAGE, WATERDAMAGE, ICEDAMAGE, NORMALDAMAGE, GHOSTDAMAGE}
local ignored = {POISONEDDAMAGE, BURNEDDAMAGE}                --alterado v1.6
local cannotkill = {BURNEDDAMAGE, POISONEDDAMAGE}

function onStatsChange(cid, attacker, type, combat, value)
if isWatchingTv(cid) then return false end -- TV Block
--------------------- healarea ---------------------
if type == STATSCHANGE_HEALTHGAIN then
	if cid == attacker then
	return true
	end
	if isSummon(cid) and isSummon(attacker) and canAttackOther(cid, attacker) == "Cant" then
	return false
	end
	if isWild(cid) and isWild(attacker) then -- monstros se curarem
	return true 
	end
return true
end
--------------------- healarea ---------------------
if isSleeping(attacker) then return false end
if isPlayer(cid) and isSummon(attacker) and canAttackOther(cid, attacker) == "Cant" then return false end
if getPlayerStorageValue(cid, 9658783) == 1 then return false end
if combat == FLYSYSTEMDAMAGE then return false end
if isPlayer(cid) and getCreatureOutfit(cid).lookType == 814 then return false end -- TV
if (isPlayer(cid) and #getCreatureSummons(cid) >= 1 and not getTileInfo(getThingPos(getCreatureSummons(cid)[1])).protection) or isPlayer(attacker) then return false end -- seguranca do player nao atacar
if isGod(cid)  then return false end -- god nao morrer o.O
if isWild(cid) and isWild(attacker) then return false end -- monstro nao atacar monstro, mas deixar pokemons do shared team baterem
if getTileInfo(getThingPos(cid)).protection then return false end
-- duel system e outros
if isSummon(cid) and isSummon(attacker) then
	local p1, p2 = getCreatureMaster(cid), getCreatureMaster(attacker)
	if not CanAttackerInDuel(p1, p2) then
	   return false
	end
end
if isSummon(attacker) and isPlayer(cid) then
	return false -- quandotiver pvp colocar storage do pvp aqui
end

if not (isCreature(attacker)) then return true end
local raceCombat = typeTable[getElementByCombat(combat)] 
local spellNameFromAttacker = getPlayerStorageValue(attacker, 21102)

	-- player morte e ataques
	if isPlayer(cid) and (#getCreatureSummons(cid) <= 0 or #getCreatureSummons(cid) >= 1 and getTileInfo(getThingPos(getCreatureSummons(cid)[1])).protection) then
	
		local color = 180
		if (combat == 128 or combat == 1) and spellNameFromAttacker == -1  then
			value = -(getOffense(attacker) * 100)
		else
			if not typeTable[getMoveType(getCreatureName(attacker), spellNameFromAttacker)] then
				color = 180
			else
			    color = typeTable[getMoveType(getCreatureName(attacker), spellNameFromAttacker)].color or 180
			end
		end


		if value >= getCreatureHealth(cid) then
			value = getCreatureHealth(cid)
		end
		
		value = math.ceil(value)
	
	   if (value*-1) >= getCreatureHealth(cid) then
		  doKillPlayer(cid, attacker, (value*-1))
		  return false
	   end
	   doSendAnimatedText(getThingPosWithDebug(cid), (value * -1), color) 
	   doCreatureAddHealth(cid, value)
	   setPlayerStorageValue(attacker, 21102, -1) -- reseta a spellName do pokemon atacante
	   return false
	end
	-- player morte e ataques


if not isPlayer(cid) then
-- valores do atacante


	if isPokePassive(cid) and isSummon(attacker) then
	   doSetPokemonAgressiveToPlayer(cid, getCreatureMaster(attacker))
	end
	
	local myName = doCorrectString(getCreatureName(cid))
	if isInArray(specialabilities["evasion"], myName) and isSummon(cid) then 
	   local target = cid
	   if getCreatureTarget(getCreatureMaster(cid)) == attacker then 
		   if math.random(1, 100) <= passivesChances["Evasion"][myName] then                                                                                      
			  if isCreature(attacker) then  --alterado v1.6 
				 doSendMagicEffect(getThingPosWithDebug(target), 211)
				 doSendAnimatedText(getThingPosWithDebug(target), "TOO BAD", 215)                                 
				 doTeleportThing(target, getClosestFreeTile(target, getThingPosWithDebug(attacker)), false)
				 doSendMagicEffect(getThingPosWithDebug(target), 211)
				 doFaceCreature(target, getThingPosWithDebug(attacker)) 
				 return false    
			  end
			end   
		end
	end

	---- cor do dano
	
		--[[if (combat == 128 or combat == 1) and spellNameFromAttacker == -1  then
			
		else
			raceCombat = typeTable[getMoveType(getCreatureName(attacker), spellNameFromAttacker)]
		end]] -- alterado
		
		raceCombat = typeTable[getPokemonType(attacker).type1]
	
	---- cor do dano
	local critical, criticalValue = false, 0
	local returnDamage = false

	------------- Helds 
	if isSummon(cid) then
		local heldx = getItemAttribute(getPlayerSlotItem(getCreatureMaster(cid), 8).uid, "xHeldItem")
		if heldx then
		local heldName, heldTier = string.explode(heldx, "|")[1], string.explode(heldx, "|")[2]
		
			  if heldName == "X-Block" and isSummon(cid) then 	     -- bloquear alguns ataques
				local chance = heldBlockChance[tonumber(heldTier)]
				if (math.random(1, 100) <= chance) then
					doSendAnimatedText(getThingPos(cid), "BLOCKED", 215)
				end
			  end
			  
			  if heldName == "X-Return" and isSummon(cid) then 	     -- bloquear alguns ataques
				local chance = heldReturn[tonumber(heldTier)]
				if (math.random(1, 100) <= chance) then
					returnDamage = true
					returnDamageValue = heldReturn[tonumber(heldTier)]
				end
			  end
			  
		end
	end
	
	if isSummon(attacker) then
		local heldx = getItemAttribute(getPlayerSlotItem(getCreatureMaster(attacker), 8).uid, "xHeldItem")
		if heldx then
		local heldName, heldTier = string.explode(heldx, "|")[1], string.explode(heldx, "|")[2]
		
			  if heldName == "X-Critical" then -- dar critico nos ataques
				local chance = heldCriticalChance[tonumber(heldTier)]
				if (math.random(1, 100) <= chance) then
					critical = true
					criticalValue = math.random(50, 100)
				end
			  end
			  
		end
	end
	------------- Helds 
	
	if isReflect(attacker) then
		local valueReflected = getPlayerStorageValue(attacker, 21105)
		if valueReflected > 0 then
		   removeReflect(attacker)
		   value = valueReflected
		   doCreatureAddHealth(cid, -math.floor(value))
		   doSendAnimatedText(getThingPos(cid), (value == 0 and "" or value), COLOR_GRASS)
		   if isSummon(cid) then doSendLifePokeToOTC(getCreatureMaster(cid)) end
		    if value >= getCreatureHealth(cid) then
				if isSummon(cid) then
					if isInDuel(getCreatureMaster(cid)) then
					   doRemoveCountPokemon(getCreatureMaster(cid))
					end
				end
			doKillWildPoke(attacker, cid)
			return false
			end
		   return false
		end
	end
	
	------------------------------------POTIONS-------------------------------------------
		if isSummon(cid) then
		   if getPlayerStorageValue(cid, 173) >= 1 then
			 setPlayerStorageValue(cid, 173, -1)  --alterado v1.6
			 doSendAnimatedText(getThingPos(cid), "LOST HEAL", 144)
		   end
		end
		
	local boost_def, boost_attk = (0.7 * getPokemonBoost(cid)) / 100, (0.5 * getPokemonBoost(attacker)) / 100
	
	if(combat == 128 or combat == 1) and spellNameFromAttacker == -1 then -- ataque basico
	   doSendMagicEffect(getThingPos(cid), 3)
	   value = getEffectvineCombat(cid, attacker, value)
		if value == 0 then 
		   return false
		else
		   value = value * getOffense(attacker) -- buff ataque system 
		   local name = doCorrectString(getCreatureName(attacker))
		   if pokes[name] and pokes[name].level <= 5 and value ~= 0 then 
			  value = -math.random(pokes[name].offense, pokes[name].offense+5)
		   end
		end
	else -- magia
	   value = getEffectvineSpell(attacker, spellNameFromAttacker, value, cid) -- checagem de efetividades de magia
	   if value == 0 then 
		   return false
		else
		   value = value * (1 + getSpecialAttack(attacker) / 100)
		end
	end	
	
		if spellNameFromAttacker ~= -1 and value == 0 then value = -doForceDanoSpeel(attacker, spellNameFromAttacker) end
		if value == 0 then value = -getEffectvineCombat(cid, attacker, getOffense(attacker)) end -- rever isto.. colocar dano base do xml
	
		value = value - (value * (getDefense(cid) / 100)) -- buff deff system, defendendo por %
		
		-------- boost system
		value = (value) + (boost_def * (value * -1))
		value = (value - getMasterLevel(attacker)) - (boost_attk * (value * -1))
		-------- boost system
		
		value = math.ceil(value * -1)
		if value >= getCreatureHealth(cid) then value = getCreatureHealth(cid) end
		
		if value < 0 then 
		   value = value * -1
		end
		
	
		-------- xp por dano
		if isSummon(attacker) and not isSummon(cid) then
			addPlayerDano(cid, getCreatureMaster(attacker), value)
		end
		-------- xp por dano
		
		if critical then -- X-Critical system
		    value = value * 2 + criticalValue	
		    doSendAnimatedText(getThingPos(cid), (value == 0 and "" or value) .. "K", COLOR_BURN)
		else
			doSendAnimatedText(getThingPos(cid), (value == 0 and "" or value), raceCombat.color)
		end
		
		if returnDamage then
			local valueToReturn = math.ceil(value * (returnDamageValue / 100))
			if valueToReturn > getCreatureHealth(attacker) then 
				valueToReturn = getCreatureHealth(attacker) -1
			end
			
			if valueToReturn > 1 then
				value = value - valueToReturn
				doSendAnimatedText(getThingPos(attacker), (valueToReturn == 0 and "" or valueToReturn), 31)
				doSendMagicEffect(getThingPos(attacker), 3)
				doCreatureAddHealth(attacker, -valueToReturn)
			end
		end
		
		local spellName = getPlayerStorageValue(attacker, 21102)
		setPlayerStorageValue(attacker, 21102, -1) -- reseta a spellName do pokemon atacante
		
		if(isReflect(cid))then -- reflect system igual GBA
		   if spellName ~= -1 then 
			   if not isInArray({"Team Claw", "Team Slice"}, spellName) then
				  doSendMagicEffect(getThingPosWithDebug(cid), 135)
				  doSendAnimatedText(getThingPosWithDebug(cid), "REFLECT", COLOR_GRASS)
				  addEvent(docastspell, 100, cid, spellName)
				  if getCreatureName(cid) == "Wobbuffet" then
					 doRemoveCondition(cid, CONDITION_OUTFIT)    
				  end
				  setPlayerStorageValue(cid, 21099, -1)                    --alterado v1.6
				  setPlayerStorageValue(cid, 21100, 1)
				  setPlayerStorageValue(cid, 21101, attacker)
				  setPlayerStorageValue(cid, 21103, getTableMove(attacker, spellName).f)
				  setPlayerStorageValue(cid, 21104, getCreatureOutfit(attacker).lookType)
				  setPlayerStorageValue(cid, 21105, value)
				  if spellName == "Rollout" then
					 doRolloutReflected(cid, doCorrectString(getCreatureName(attacker)))
				  end
				  return false
			   end
			end
        end 
		
		if getCreatureName(cid) == "Kangaskhan" and math.random(1, 100) < 25 and isMega(cid) then
		   docastspell(cid, "Groundshock", 0, 0)
		end
			
	if value >= getCreatureHealth(cid) then
		if isSummon(cid) then
			if isInArray({"Aggron", "Sudowoodo", "Mega Aggron"}, getCreatureName(cid)) then
			   doCreatureAddHealth(cid, -(getCreatureHealth(cid)-1))
			   docastspell(cid, "Sturdy", 0, 0)
			   if isSummon(cid) then doSendLifePokeToOTC(getCreatureMaster(cid)) end
			   return false
			end
		end
		doKillWildPoke(attacker, cid)
		return false
	end
	    --------------Passiva Lifesteal Clobat------------
		  if isInArray({"crobat", "shiny crobat"}, getCreatureName(attacker):lower())and (combat == 128 or combat == 1) and spellNameFromAttacker == -1 then                    
		    doCreatureAddHealth(attacker, math.floor(value))
		    doSendAnimatedText(getThingPos(attacker), "+ "..math.floor(value), 30)
	      end
	    --------------------------------------------
	doCreatureAddHealth(cid, -value)
	doCastPassive(cid)
	
	if not isSummon(cid) and not isMega(cid) then -- virar mega
	   checkChenceToMega(cid)
	end
	
	if isSummon(cid) then
		-- otclient life
		doSendLifePokeToOTC(getCreatureMaster(cid))
		-- otclient life
	end
end	

	return false
end

function getMasterLevel(cid)
	if isSummon(cid) then
	   return getPlayerLevel(getCreatureMaster(cid))
	end
	return 0
end