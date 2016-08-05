function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Sketch 6")

return true
end