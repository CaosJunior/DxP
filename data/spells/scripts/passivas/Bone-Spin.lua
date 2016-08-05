function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Bone-Spin")

return true
end