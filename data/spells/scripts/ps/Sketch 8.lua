function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Sketch 8")

return true
end