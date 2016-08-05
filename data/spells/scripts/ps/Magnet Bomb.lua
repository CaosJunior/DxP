function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Magnet Bomb")

return true
end