local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)

if(not npcHandler:isFocused(cid)) then
return false
end

local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

if msgcontains(msg, 'torneio') or msgcontains(msg, 'enter') then

if getPlayerItemCount(cid, torneio.revivePoke) >= 1 then
selfSay('You can not enter the tournament with {revives}, please throw them out.', cid)
return true
end

selfSay('You want to participate in the tournament by '..torneio.price..' gps / dollars?', cid)
talkState[talkUser] = 2


elseif talkState[talkUser] == 2 then

if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then

if os.date("%X") < torneio.startHour or os.date("%X") > torneio.endHour then
selfSay('Registration for the tournament finished, come back later.', cid)
return true
end

if doPlayerRemoveMoney(cid, torneio.price) then
doTeleportThing(cid, torneio.waitPlace)
doPlayerSendTextMessage(cid, 21, "Welcome, this is the waiting room, you wait here while the tournament does not start. Start time: {"..torneio.endHour.."}.")
else

selfSay('You do not have enough money ('..torneio.price..').', cid)
end
else
selfSay('Sure you do not want to participate? Okay, see you next time!', cid)
talkState[talkUser] = 0
end
end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())