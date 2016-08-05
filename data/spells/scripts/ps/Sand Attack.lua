function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Sand Attack")

return true
end