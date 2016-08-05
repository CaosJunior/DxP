local market = {
[1] = {emeralds = 10, vipdays = 30},
[2] = {emeralds = 18, vipdays = 60},
[3] = {emeralds = 25, vipdays = 90},
[4] = {emeralds = 15, pokemon = "Ditto"},
[5] = {emeralds = 3, blessings = 2},
[6] = {emeralds = 6, blessings = 5},
[7] = {emeralds = 5},
}

local OPCODE_EMERALD_SHOP = opcodes.OPCODE_EMERALD_SHOP

function onExtendedOpcode(cid, opcode, buffer)
	local t = string.explode(buffer, "|")
	if opcode == OPCODE_EMERALD_SHOP then
		if t[1] == "Market" then	
			if tonumber(t[2]) >= 1 and tonumber(t[2]) <= 3 then
				doPlayerAddPremiumDays(cid, market[tonumber(t[2])].vipdays)
			elseif tonumber(t[2]) == 4 then
				doPlayerAddPoke(cid, market[tonumber(t[2])].pokemon, "poke")
			elseif tonumber(t[2]) >= 5 and tonumber(t[2]) <= 6 then
				for blessings = 1, market[tonumber(t[2])].blessings do
					if getPlayerBlessing(cid, market[tonumber(t[2])].blessings) then
						return doSendPlayerExtendedOpcode(cid, OPCODE_EMERALD_SHOP, "You already have the blessing.")
					end
					doPlayerAddBlessing(cid, blessings)
				end
			elseif tonumber(t[2]) == 7 then
				doPlayerSetSex(cid, (getPlayerSex(cid) == 0 and 1 or 0))
			end
		end
		return doPlayerRemoveItem(cid, 2149, market[tonumber(t[2])].emeralds) and doSendPlayerExtendedOpcode(cid, OPCODE_EMERALD_SHOP, "True")
	end
end