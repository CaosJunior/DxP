function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Aqua Ring")

return true
end