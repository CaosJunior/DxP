function onAttack(cid, target)

    if isSummon(target) and getDistanceBetween(getThingPos(target), getThingPos(getCreatureMaster(target))) > 1 then
            doMonsterSetTarget(cid, getCreatureMaster(target))
    elseif isPlayer(target) and #getCreatureSummons(target) > 0 then
            for _, summon in pairs(getCreatureSummons(target)) do
                    if getDistanceBetween(getThingPos(target), getThingPos(summon)) <= 1 then
                            doMonsterSetTarget(cid, summon)
                            break
                    end
            end
    end
    
return true
end