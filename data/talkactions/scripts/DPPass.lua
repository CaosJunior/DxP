function doFindItemInPos(ids,pos) -- By Undead Slayer
   local results = {}

   for _ = 0, 255 do
       local findPos = {x = pos.x, y = pos.y, z = pos.z, stackpos = _}
       if isInArray(ids, getThingFromPos(findPos).itemid) then
          table.insert(results, getThingfromPos(findPos))
       end
   end

   return results
end

function isItemInRange(cp, range, ids)
    local extr1 = {x = cp.x - range, y = cp.y -range, z = cp.z}
    local extr2 = {x = cp.x + range, y = cp.y + range, z = cp.z}
    for i = 1, (extr2.y-extr1.y)+1 do
        for s = 1, (extr2.x-extr1.x)+1 do
            local f = {x=extr1.x+s-1, y=extr1.y+i-1, z=extr1.z, stackpos=0}
            local posz = doFindItemInPos(ids, f)
            if (#posz > 0) then
               return true
            end
        end
     end
return false
end

function onSay(cid, words, param)
	local limit, timeleft = 5, 30
	local param2 = string.explode(param, ",")

	if getPlayerStorageValue(cid, 58295) == 0 then
		article = ","
	else
		article = "s,"
	end

	if not (param2[1]) then

	elseif (param2[1] == "pass") then
		if (getPlayerStorageValue(cid, 96474) ~= -1) then
			return doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Your locker already have a password.")
		elseif not tonumber(param2[2]) then
			return doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "The password can only contain numbers.") 
		end

		setPlayerStorageValue(cid, 58295, 0)
		setPlayerStorageValue(cid, 96474, tonumber(param2[2]))
	return doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Password successfully established!")

	elseif (param2[1]:lower() == "passchange") then
		if (getPlayerStorageValue(cid, 96474) == -1) then
			return doPlayerSendCancel(cid, "You do not have a password.")
		elseif getPlayerStorageValue(cid, 58295) >= limit then
			return doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Too many wrong attempts, you will have to wait "..timeleft.." seconds to try again.")
		elseif not tonumber(param2[2]) or not tonumber(param2[3]) then
			return doPlayerSendCancel(cid, "Your password can only contain numbers.") 
		elseif (getPlayerStorageValue(cid, 96474) ~= -1) and (tonumber(param2[2]) ~= tonumber(getPlayerStorageValue(cid, 96474))) then
			return doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Incorrect password.")
		end

		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Your password was successfully changed!")
	return setPlayerStorageValue(cid, 96474, tonumber(param2[3]))

	elseif (param2[1]:lower() == "remove") then
		if (getPlayerStorageValue(cid, 96474) == -1) then
			return doPlayerSendCancel(cid, "You do not have a password.")
		elseif getPlayerStorageValue(cid, 58295) >= limit then
			return doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Too many wrong attempts, you will have to wait "..timeleft.." seconds to try again.")
		elseif not tonumber(param2[2]) then
			return doPlayerSendCancel(cid, "Passwords can only contain numbers.") 
		elseif (getPlayerStorageValue(cid, 96474) ~= -1) and (tonumber(param2[2]) ~= tonumber(getPlayerStorageValue(cid, 96474))) then
			return doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Incorrect password.")
		end

		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Your password has been successfully removed!")
	return setPlayerStorageValue(cid, 96474, -1)
	end

	if tonumber(param2[1]) and tonumber(param2[1]) == tonumber(getPlayerStorageValue(cid, 96474)) then
		local tile = getThingPos(cid)
		tile.stackpos = 0
		local tile = getThingFromPos(tile)
		doItemSetAttribute(tile.uid, "aid", 96475)
		setPlayerStorageValue(cid, 58295, 0)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Correct password!")
	return setPlayerStorageValue(cid, 96475, param)
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Incorrect password.")
	end
	return true
end