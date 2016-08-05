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
msg = msg:lower()

local places = {
["saffron"] = 1,
["cerulean"] = 2,
["lavender"] = 3,
["fuchsia"] = 4,
["celadon"] = 5, 
["viridian"] = 6, 
["vermilion"] = 7, 
["pewter"] = 8,                      
["cinnabar"] = 10,
}
local sto_Oak = 13600
local sto_city = 13611
       
        if msgcontains(string.lower(msg), 'city') or msgcontains(string.lower(msg), 'help') then
           if getPlayerStorageValue(cid, sto_city) == 1 then
              selfSay("Please choose now your new pokemon!", cid)
              doPlayerSendCancel(cid, "#cnp#")
              talkState[talkUser] = 0
              return true
           elseif getPlayerStorageValue(cid, sto_city) == 2 then
              return true
           elseif getPlayerStorageValue(cid, sto_Oak) < 1 then
              selfSay("Go talk with the Delia first!", cid)
              return true
           else
              selfSay("You can choose your beginner town between: {Saffron, Cerulean, Lavender, Fuchsia, Celadon, Viridian, Vermilion, Pewter or Cinnabar}.", cid) 
              talkState[talkUser] = 2
              return true
           end
        elseif places[msg] and talkState[talkUser] == 2 then
           city = msg
           selfSay("Are you sure which you want to begin in {".. doCorrectString(msg) .."}?", cid) 
           talkState[talkUser] = 3
           return true
       elseif msgcontains(msg, "yes") or msgcontains(msg, "sim") and talkState[talkUser] == 3 then   
           selfSay("OK then... Now your beginner town is ".. doCorrectString(city)..".", cid)
           doPlayerSetTown(cid, places[city])
           setPlayerStorageValue(cid, sto_city, 1)
              selfSay("Please choose now your new pokemon!", cid)
              doPlayerSendCancel(cid, "#cnp#")
           talkState[talkUser] = 0
           return true
        elseif msgcontains(msg, "no") or msgcontains(msg, "No") and talkState[talkUser] == 3 then  
           selfSay("Ok then... say again what city you want to begin!", cid)
           talkState[talkUser] = 0
           return true 
        end

return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())             