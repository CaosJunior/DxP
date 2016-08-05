fightcondition = createConditionObject(CONDITION_INFIGHT)
setConditionParam(fightcondition, CONDITION_PARAM_TICKS, 5000)

ordercondition = createConditionObject(CONDITION_EXHAUST)
setConditionParam(ordercondition, CONDITION_PARAM_TICKS, 500)

movecondition = createConditionObject(CONDITION_EXHAUST)
setConditionParam(movecondition, CONDITION_PARAM_TICKS, 250)

confusioncondition = createConditionObject(CONDITION_DRUNK)
setConditionParam(confusioncondition, CONDITION_PARAM_TICKS, 1000)

invisiblecondition = createConditionObject(CONDITION_INVISIBLE)
setConditionParam(invisiblecondition, CONDITION_PARAM_TICKS, -1)

bebo = createConditionObject(CONDITION_DRUNK)
setConditionParam(bebo, CONDITION_PARAM_TICKS, -1)
