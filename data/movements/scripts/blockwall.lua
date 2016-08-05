function onStepIn(cid, item, position, fromPosition)

local ghosts = {"Gastly", "Haunter", "Gengar", "Shiny Gengar", "Misdreavus", "Shiny Abra"}--alterado v1.6

if isSummon(cid) and isInArray(ghosts, getCreatureName(cid)) then
  return true
else                                                                  --alterado v1.6
  doTeleportThing(cid, fromPosition, false)
end
end