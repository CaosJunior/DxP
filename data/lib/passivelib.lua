function isPokePassive(cid)
if not isCreature(cid) then return false end
	if isWild(cid) and isInArray(passivepokemons, doCorrectString(getCreatureName(cid)))  then
	   return true 
	end
	return false
end

function doSetPokemonAgressiveToPlayer(cid, target)
if not isCreature(cid) or not isCreature(target) then return false end
	setPokemonPassive(cid, false)
	setPlayerStorageValue(cid, 505, getCreatureName(target))
if getCreatureTarget(cid) >= 1 then return false end
	if #getCreatureSummons(target) > 0 then
	   doMonsterSetTarget(cid, getCreatureSummons(target)[1])
	else
	   doMonsterSetTarget(cid, target)
	end
end

function getPokemonAttackedPassive(cid)
if not isCreature(cid) then return false end
local stor = getPlayerStorageValue(cid, 505)
    if stor ~= 0 then
       return stor
	else
	   return ""
	end
end

function setPokemonPassive(cid, passive)
if not isCreature(cid) then return false end
	if passive then 
		setPlayerStorageValue(cid, 504, 0)
		setPlayerStorageValue(cid, 505, 0)		
	else 
		setPlayerStorageValue(cid, 504, 1) 
	end
end

function onWalkSetTargetPassive(cid)
if not isCreature(cid) then return false end
if getCreatureTarget(cid) >= 1 then return false end
local rangeX, rangeY = 7, 7
local spectators = getSpectators(getCreaturePosition(cid), rangeX, rangeY, false)
local attackerName = getPokemonAttackedPassive(cid)
local playerID = getPlayerByName(attackerName)

if not isCreature(playerID) then
	return false
end
if getCreatureTarget(cid) ~= playerID and attackerName ~= "" then
	return false
end

if spectators then
        for _, spectator in ipairs(spectators) do
            if isPlayer(spectator) and spectator ~= cid and (attackerName ~= "" and attackerName == getCreatureName(spectator)) and isWalkable(getThingPos(spectator), false, true, true, true) then
				setPlayerStorageValue(cid, 504, 1)
				if #getCreatureSummons(spectator) > 0 then
				   doMonsterSetTarget(cid, getCreatureSummons(spectator)[1])
				else
				   doMonsterSetTarget(cid, spectator)
				end
				break
			else
				setPlayerStorageValue(cid, 504, 0)
				doPokemonSetNoTarget(cid)
            end
        end
    end
end


function doPokemonSetNoTargets(cid)
if not isCreature(cid) then return false end
	local name = getCreatureName(cid)
	local monsterT = doCreateMonsterNick(cid, name, name, getThingPos(cid), false)
	doRemoveCreature(cid)
end
----