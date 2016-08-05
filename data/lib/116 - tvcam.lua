function doCreateChannelTVs(cid)
if not isCreature(cid) then return true end
	doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_TV_CAM, "doCreate")
end

function doOpenChannelTVs(cid)
if not isCreature(cid) then return true end
	doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_TV_CAM, "openAllTVS|" .. getAllChannelsTvs())
end

function createChannel(cid, buffer)
if getGlobalStorageValue(storages.globalsTV) == -1 then setGlobalStorageValue(storages.globalsTV, "") end
if buffer:explode("/")[2]:len() < 6 then 
   doSendMsg(cid, "O canal deve ter no minimo 6 caracteres.")
   return true
elseif buffer:explode("/")[2]:len() > 11 then 
	doSendMsg(cid, "O canal deve ter no maximo 11 caracteres.")
    return true
end
setGlobalStorageValue(storages.globalsTV, getGlobalStorageValue(storages.globalsTV) .. "/" .. getCreatureName(cid))
if not isCreature(cid) then return true end
	doCreatePrivateChannel(cid)
	local horas, mins, secs = os.date("*t").hour, os.date("*t").min, os.date("*t").sec
	setPlayerStorageValue(cid, storages.TVHoras, horas)
	setPlayerStorageValue(cid, storages.TVMins, mins)
	setPlayerStorageValue(cid, storages.TVSecs, secs)
	setPlayerStorageValue(cid, storages.playerTVName, buffer:explode("/")[2])
	setPlayerStorageValue(cid, storages.playerTVPass, buffer:explode("/")[3])
	doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_TV_CAM, "contar:" .. buffer:explode("/")[2])
end

function doResetPlayerTVSystem(cid)
	setPlayerStorageValue(cid, storages.TVHoras, -1)
	setPlayerStorageValue(cid, storages.TVMins, -1)
	setPlayerStorageValue(cid, storages.TVSecs, -1)
	setPlayerStorageValue(cid, storages.playerIsTvWatching, -1)
	setPlayerStorageValue(cid, storages.playerTVName, -1)
	setPlayerStorageValue(cid, storages.playerTVPass, -1)
	setPlayerStorageValue(cid, storages.playerListWatchs, -1)
	setPlayerStorageValue(cid, storages.playerIsTvWatching, -1)
	setPlayerStorageValue(cid, storages.playerIsTvWhosWatching, -1)
	setPlayerStorageValue(cid, storages.playerIsTvInitialPos, -1)
	doSendPlayerExtendedOpcode(cid, 126, "nao")
end

function closeInClientChannmel(cid)
if not isCreature(cid) then return true end
	removeAllPlayerInTheChannel(cid)
	doRemoveIntoPrivateChannel(cid, getCreatureName(cid))
	removePlayerInTheChannel(cid)
	doSendMsg(cid, "Você fechou seu canal.")
	doResetPlayerTVSystem(cid)
end

function closeInServerChannmel(cid)
if not isCreature(cid) then return true end
	removeAllPlayerInTheChannel(cid)
	--doRemoveIntoPrivateChannel(cid, getCreatureName(cid))
	removePlayerInTheChannel(cid)
	doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_TV_CAM, "closeGraveando")
	doSendMsg(cid, "Você fechou seu canal.")
	doResetPlayerTVSystem(cid)
end

function isInChannelsArray(cid)
	if not isCreature(cid) then return false end
    local name = getCreatureName(cid)
	local channelsArray = getGlobalStorageValue(storages.globalsTV)
	local ret = false
	if channelsArray == -1 then return ret end
		channelsArray = channelsArray:explode("/")
	for i = 1, #channelsArray do
		if name == channelsArray[i] then
		   ret = true
		   break
		end
	end
	return ret
end

function removePlayerInTheChannel(cid)
	if not isCreature(cid) then return false end
    local name = getCreatureName(cid)
	local channelsArray = getGlobalStorageValue(storages.globalsTV)
	local ret = ""
	if channelsArray == -1 then return ret end
		channelsArray = channelsArray:explode("/")
	for i = 1, #channelsArray do
		if name ~= channelsArray[i] then
		   ret = ret .. "/" .. channelsArray[i]
		end
	end
	setGlobalStorageValue(storages.globalsTV, ret)
end

function getPlayerChannelName(cid)
	if getPlayerStorageValue(cid, storages.playerTVName) ~= -1 then
	   return getPlayerStorageValue(cid, storages.playerTVName)
	end
	return ""
end

function getAllChannelsTvs()
	local channelsArray = getGlobalStorageValue(storages.globalsTV)
	local ret = ""
	if channelsArray == -1 then return ret end
	channelsArray = channelsArray:explode("/")
	
	for i = 1, #channelsArray do
		local player = getCreatureByName(channelsArray[i])
		if isCreature(player) then
		   ret = ret .. channelsArray[i] .. "/" .. getPlayerChannelName(player).. "/" .. getPlayerStorageValue(player, storages.playerTVPass) .. "|"
		end
	end
	return ret
end

function isRecording(cid)
if not isCreature(cid) then return true end
	if getPlayerStorageValue(cid, storages.playerTVName) ~= -1 then
		return true 
	end
	return false
end

function isWatchingTv(cid)
if not isCreature(cid) then return true end
	if getPlayerStorageValue(cid, storages.playerIsTvWatching) == -1 then
		return false 
	end
	return true
end

function movePlayerListWatchingMe(cid, toPos)
if type(getPlayerStorageValue(cid, storages.playerListWatchs)) ~= "string" then return true end
	local listWatchs = getPlayerStorageValue(cid, storages.playerListWatchs):explode("/")
	for i = 1, #listWatchs do
	   local player = getCreatureByName(listWatchs[i])
	   if isCreature(player) then
		  doTeleportThing(player, toPos, true)
	   end
	end
end

function doWatch(cid, watched)
if not isCreature(cid) or not isCreature(watched) then return true end
	local listWatchs = getPlayerStorageValue(watched, storages.playerListWatchs)
	local myName = getCreatureName(cid)
		  if type(listWatchs) ~= "string" then
			 setPlayerStorageValue(watched, storages.playerListWatchs, "")
			 listWatchs = getPlayerStorageValue(watched, storages.playerListWatchs)
		  end
		  setPlayerStorageValue(watched, storages.playerListWatchs, addStringIntoString(listWatchs, myName))
		  doInviteToPrivateChannel(watched, myName)
		  setPlayerStorageValue(cid, storages.playerIsTvWatching, 1)
		  setPlayerStorageValue(cid, storages.playerIsTvWhosWatching, getCreatureName(watched))
		  local pos = getThingPos(cid)
		  setPlayerStorageValue(cid, storages.playerIsTvInitialPos, "/" .. pos.x .. "," .. pos.y .. "," .. pos.z .. "/")
		  
		  local out, oldDir, oldPos = getCreatureOutfit(cid), getCreatureLookDir(cid), getThingPos(cid)
		  
		  doCreatureSetHideHealth(cid, true)
		  doSetCreatureOutfit(cid, {lookType = 6}, -1)
		  doSendPlayerExtendedOpcode(cid, 126, "sim")
		  if not isGod(cid) then
		     setPlayerGroupId(cid, 5)
		  end
		  doChangeSpeed(cid, -getCreatureSpeed(cid))
		  doChangeSpeed(cid, getCreatureSpeed(watched))
		  doSendPlayerExtendedOpcode(watched, opcodes.OPCODE_TV_CAM, "add")
		  doCreatureSetNoMove(cid, true)
		  doTeleportThing(cid, getThingPos(watched), false)
		  doSummonNPCWatch(cid, out, oldDir, oldPos)
end

function removeAllPlayerInTheChannel(cid)
if type(getPlayerStorageValue(cid, storages.playerListWatchs)) ~= "string" then return true end
	local listWatchs = getPlayerStorageValue(cid, storages.playerListWatchs):explode("/")
	for i = 1, #listWatchs do
	   local player = getCreatureByName(listWatchs[i])
	   if isCreature(player) then
		  doRetirePlayerToChannel(player)
	   end
	end
	doResetPlayerTVSystem(cid)
end

function doRetirePlayerToChannel(cid)
   setPlayerStorageValue(cid, storages.playerIsTvWatching, -1)
   doSendPlayerExtendedOpcode(cid, 126, "nao")
   doRemoveCondition(cid, CONDITION_OUTFIT)
   doCreatureSetHideHealth(cid, false)
   doRegainSpeed(cid)
   if not isGod(cid) then
      setPlayerGroupId(cid, 1)
   end
   doCreatureSetNoMove(cid, false)
   doRegainSpeed(cid)
   local npc = getCreatureByName(getCreatureName(cid).."  ")
	local olddir = 0
	if isCreature(npc) then
		olddir = getCreatureLookDir(npc)
		local pos = getThingPos(npc)
		doRemoveCreature(npc)
	end
   local initialPos = getPlayerStorageValue(cid, storages.playerIsTvInitialPos):explode("/")
   local pos = initialPos[1]:explode(",")
	     doTeleportThing(cid, {x = pos[1], y = pos[2], z = pos[3]}, false)
	     doCreatureSetLookDir(cid, olddir)
   local PlayerWatched = getCreatureByName(getPlayerStorageValue(cid, storages.playerIsTvWhosWatching))
	   if isCreature(PlayerWatched) then
		  local watchers = getPlayerStorageValue(PlayerWatched, storages.playerListWatchs)
		  local removeString = removeStringIntoString(watchers, getCreatureName(cid))
				setPlayerStorageValue(PlayerWatched, storages.playerListWatchs, removeString)
				doSendPlayerExtendedOpcode(PlayerWatched, opcodes.OPCODE_TV_CAM, "remove")
				doRemoveIntoPrivateChannel(PlayerWatched, getCreatureName(cid))
	   end
end

function removeStringIntoString(str1, str2)
	local channelsArray = str1
	local ret = ""
	if channelsArray == -1 then return ret end
		channelsArray = channelsArray:explode("/")
	for i = 1, #channelsArray do
		if str2 ~= channelsArray[i] then
		   ret = ret .. "/" .. channelsArray[i]
		end
	end
	return ret
end

function addStringIntoString(str1, str2)
	local ret = str1
	if ret == -1 then return "/" end
		ret = ret .. "/" .. str2
	return ret
end

function doSummonNPCWatch(cid, out, oldDir, oldPos)
if isGod(cid) then return true end
local dir = "data/npc/TVNPC.xml"
	local a = io.open(dir, "a+")
	local b = a:read("*all")
	a:close()
	local o = out
	local olddir = oldDir
	local oldpos = oldPos

	local npcname = 'name="'..getCreatureName(cid)..'  "'
	local npchealth = 'health now="'..getCreatureHealth(cid)..'" max="'..getCreatureMaxHealth(cid)..'"'
	local npcoutfit = 'look type="'..o.lookType..'" head="'..o.lookHead..'" body="'..o.lookBody..'" legs="'..o.lookLegs..'" feet="'..o.lookFeet..'"'

	b = string.gsub(b, 'name="(.-)"', npcname)
	b = string.gsub(b, 'health now="(.-)" max="(.-)"', npchealth)
	b = string.gsub(b, 'look type="(.-)" head="(.-)" body="(.-)" legs="(.-)" feet="(.-)"', npcoutfit)

	local c = io.open(dir, "w")
	c:write(b)
	c:close()

	local n = doCreateNpc("TVNPC", oldpos)
	doCreatureSetLookDir(n, olddir)
	setPlayerStorageValue(n, 9891, getPlayerSex(cid))
	setPlayerStorageValue(n, 697548, getPlayerDesc(n, cid, true)) --alterado v1.7
end