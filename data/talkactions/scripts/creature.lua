function onSay(cid, words, param, channel)
	local func = doCreateMonster
	local npc = false
	if(words:sub(2, 2) == "n") then
		func = doCreateNpc
		npc = true
	end

	local pid = cid
	local t = string.explode(param, ",")
	t[1] = doCorrectString(t[1])
	--if not pokes[t[1]] and not npc then
	  -- doSendMsg(cid, "O pokemon (" .. t[1] .. ") não existe.")
	  -- return true
	--end
	
	local position = getCreaturePosition(pid)
	local effect = CONST_ME_MAGIC_RED
	local ret = func(t[1], position, false)
	if(tonumber(ret) == nil) then
		effect = CONST_ME_POFF
		doPlayerSendDefaultCancel(cid, (ret == false and RETURNVALUE_NOTPOSSIBLE or RETURNVALUE_NOTENOUGHROOM))
	end

	doSendMagicEffect(position, effect)
	return true
end