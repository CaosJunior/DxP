fightcondition = createConditionObject(CONDITION_INFIGHT)
setConditionParam(fightcondition, CONDITION_PARAM_TICKS, 18 * 1000)

boostcondition = createConditionObject(CONDITION_INFIGHT)
setConditionParam(boostcondition, CONDITION_PARAM_TICKS, 3 * 1000)

stronginvisible = createConditionObject(CONDITION_INVISIBLE)
setConditionParam(stronginvisible, CONDITION_PARAM_TICKS, 5 * 1000)

weakinvisible = createConditionObject(CONDITION_INVISIBLE)
setConditionParam(weakinvisible, CONDITION_PARAM_TICKS, 3 * 1000)

permanentinvisible = createConditionObject(CONDITION_INVISIBLE)
setConditionParam(permanentinvisible, CONDITION_PARAM_TICKS, -1)

thunderwavecondition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(thunderwavecondition, CONDITION_PARAM_TICKS, 6200)
setConditionFormula(thunderwavecondition, -0.62, 0, -0.62, 0)


stunsporecondition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(stunsporecondition, CONDITION_PARAM_TICKS, 9200)
setConditionFormula(stunsporecondition, -0.75, 0, -0.75, 0)


wildexhaust = createConditionObject(CONDITION_EXHAUST)
setConditionParam(wildexhaust, CONDITION_PARAM_TICKS, 135)

playerexhaust = createConditionObject(CONDITION_EXHAUST)
setConditionParam(playerexhaust, CONDITION_PARAM_TICKS, 250)

furyragecondition = createConditionObject(CONDITION_HASTE)
setConditionParam(furyragecondition, CONDITION_PARAM_TICKS, 10000)
setConditionFormula(furyragecondition, -0.68, -0.68, -0.68, -0.68)


rollspeedcondition = createConditionObject(CONDITION_HASTE)
setConditionParam(rollspeedcondition, CONDITION_PARAM_TICKS, 8300)
setConditionFormula(rollspeedcondition, -0.50, -0.50, -0.50, -0.50)