local condition = createConditionObject(CONDITION_DROWN)
setConditionParam(condition, CONDITION_PARAM_PERIODICDAMAGE, 0)
setConditionParam(condition, CONDITION_PARAM_TICKS, -1)
setConditionParam(condition, CONDITION_PARAM_TICKINTERVAL, 2000)

function onStepIn(cid, item, position, fromPosition)
	--[[if(isPlayer(cid)) then
		doAddCondition(cid, condition)

	  if #getCreatureSummons(cid) > 0 then
	     doRegainSpeed(getCreatureSummons(cid)[1])
	  end
	  doRegainSpeed(cid)	
	end
	return true]]--
end

function onStepOut(cid, item, position, fromPosition)
	--[[doRemoveCondition(cid, CONDITION_DROWN)

	if #getCreatureSummons(cid) > 0 then
	     doRegainSpeed(getCreatureSummons(cid)[1])
	  end
	  doRegainSpeed(cid)
	return true]]--
end
