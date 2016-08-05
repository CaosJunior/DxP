function onSay(cid, words, param, channel)

	local pid = cid

	local t = string.explode(param, ",")
	t[1] = doCorrectString(t[1])
	if not pokes[t[1] ] then
	   doSendMsg(cid, "O pokemon (" .. t[1] .. ") não existe.")
	   return true
	end

	if(t[2]) then

		pid = getPlayerByNameWildcard(t[2])

		if(not pid or (isPlayerGhost(pid) and getPlayerGhostAccess(pid) > getPlayerGhostAccess(cid))) then

			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Player " .. t[2] .. " not found.")

			return true

		end

	end


	local effect = CONST_ME_MAGIC_RED

	local ret = doCreateMonsterNick(pid, t[1], t[1], getThingPos(cid), true)
            if not ret then
			   doSendMsg(cid, "Erro. Comunique esse codigo ao GM. [31121994]")
			   return true
			end

	if(ret ~= RETURNVALUE_NOERROR) then

		effect = CONST_ME_POFF

		doPlayerSendDefaultCancel(cid, ret)

	end


	doSendMagicEffect(getCreaturePosition(cid), effect)

	return true

end
