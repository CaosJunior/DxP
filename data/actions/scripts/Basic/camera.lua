function onUse(cid, item, frompos, item2, topos)
	if item.itemid == 12330 then
		if isInChannelsArray(cid) then 
			doSendMsg(cid, "Você já tem um canal aberto.") 
			return true 
		end
	
		if getPlayerStorageValue(cid, 99284) == 2 then
			doPlayerSendCancel(cid, "Tienes que cerrar el chat privado para poder Gravar.")
		return true
		end

		if getPlayerStorageValue(cid, 99284) == 1 then
			doPlayerSendCancel(cid, "Tu ya estas al aire! Tu Canal de Tv es: "..getPlayerStorageValue(cid, 99285).."")
			doPlayerSendChannel(cid, getPlayerChannelId(cid), getPlayerStorageValue(cid, 99285))
		return true
		end

		if not isPremium(cid) then
			doPlayerSendCancel(cid, "Solo premmium account pueden gravar videos.")
		return true
		end
		doCreateChannelTVs(cid)
	else
		if isInChannelsArray(cid) then 
			doSendMsg(cid, "Você não pode assistir enquanto filma.") 
			return true 
		end
		if isRiderOrFlyOrSurf(cid) then 
		   doSendMsg(cid, "Desmonte seu pokemon primeiro para assistir.")
		   return true 
		end
		doOpenChannelTVs(cid)
	end
	

end