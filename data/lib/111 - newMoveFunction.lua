function doDamageInTarget(cid, target, dMin, dMax, effect, dType) -- refeita 
	if not isCreature(cid) or not isCreature(target) then return true end 
	local dano = math.random(dMin, dMax)

	doCreatureAddHealth(target, -dano, effect, typeTable[dType].color)

end

function doDamageInTargetWithDelay(cid, target, dMin, dMax, effect, dType) -- refeita 
	if not isCreature(cid) or not isCreature(target) then return true end 
	local const_distance_delay = 56
	
	local delay = getDistanceBetween(getThingPos(cid), getThingPos(target)) * const_distance_delay
    addEvent(doDamageInTarget, delay, cid, target, dMin, dMax, effect, dType)

end