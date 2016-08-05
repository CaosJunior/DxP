function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Meteor Mash")

return true
end