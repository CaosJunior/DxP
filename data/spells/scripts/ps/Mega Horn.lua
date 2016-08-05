function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Mega Horn")

return true
end