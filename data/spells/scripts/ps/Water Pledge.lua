function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Water Pledge")

return true
end