function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Sketch 7")

return true
end