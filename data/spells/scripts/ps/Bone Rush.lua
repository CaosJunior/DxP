function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Bone Rush")

return true
end