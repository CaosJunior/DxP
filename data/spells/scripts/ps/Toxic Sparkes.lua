function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Toxic Sparkes")

return true
end