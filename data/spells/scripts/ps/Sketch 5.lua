function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Sketch 5")

return true
end