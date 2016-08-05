local tileClans = {33800, 33801, 33802, 33803, 33804, 33805, 33806, 33807, 33808}
               --   psy    ore    win    nat    sea   gard   male    rai   volc
function onStepIn(cid, item, pos)
if isSummon(cid) then
return false
end
--
local storage = 171877
if isInArray(tileClans, item.actionid) then
   storage = 171878
end
--
local b = getPlayerStorageValue(cid, storage)
--
if #getCreatureSummons(cid) >= 1 then
   for i = 1, #getCreatureSummons(cid) do
       doTeleportThing(getCreatureSummons(cid)[i], getTownTemplePosition(b), false)
   end
end 
doTeleportThing(cid, getTownTemplePosition(b), false)
setPlayerStorageValue(cid, storage, -1)
return true
end