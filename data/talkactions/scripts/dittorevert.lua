function onSay(cid, words, param, channel)
if getPlayerSlotItem(cid, 8).uid == 0 then return true end
if not isInArray({"ditto", "shiny ditto"}, getItemAttribute(getPlayerSlotItem(cid, 8).uid, "poke"):lower()) then return true end
		  local poke = getCreatureSummons(cid)
		  if #poke < 1 then return true end
		  if getItemAttribute(getPlayerSlotItem(cid, 8).uid, "poke") == getCreatureName(poke[1]) then return true end
		  doCopyPokemon(poke[1], getItemAttribute(getPlayerSlotItem(cid, 8).uid, "poke"), true)
          return true
end