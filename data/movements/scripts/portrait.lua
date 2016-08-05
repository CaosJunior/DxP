function onEquip (cid, item, slot)

	if not cid then return true end
	if item.uid <= 0 then return true end

	if not getItemAttribute(item.uid, "poke") then
	return true
	end
	
	portraitSendLifeOTC(cid, item)
	
	for i, x in pairs(fotos) do
		if string.lower(getItemAttribute(item.uid, "poke")) == string.lower(i) then
			doTransformItem(getPlayerSlotItem(cid, 7).uid, fotos[i])
		return true
		end
	end
	
	
end

function onDeEquip(cid, item, slot)

	if not cid then return true end
	if item.uid <= 0 then 
	return true 
	end

	if not getItemAttribute(item.uid, "poke") then
	return true
	end

	doTransformItem(getPlayerSlotItem(cid, CONST_SLOT_LEGS).uid, 2395)
	doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_POKEMON_HEALTH, "0|0")
end