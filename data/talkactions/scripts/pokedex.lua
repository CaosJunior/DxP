




function onSay(cid, words, param, channel)

	if param == "" then
		doPlayerSendCancel(cid, "Por Favor, digite /dex <name of pokemon> para ver se possui ele em sua dex.")
	return true
	end

	if string.lower(param) == "nidoran" then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Type either \"Nidoran Male\" or \"Nidoran Female\".")
	return true
	end

	for a = 1, 264 do
		if string.lower(param) == string.lower(oldpokedex[a][1]) then
			if getPlayerInfoAboutPokemon(cid, oldpokedex[a][1]).dex then
				doShowPokedexRegistration(cid, oldpokedex[a][1])
			else
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Esse pokemon ainda não foi descoberto.")
				
			end
		return true
		end
	end

	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Nome errado de pokemon.")

return true
end