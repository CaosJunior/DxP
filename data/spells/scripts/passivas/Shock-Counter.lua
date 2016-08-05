function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Shock-Counter")

return true
end