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
["snow"] = 11, 
["ascordbia"] = 15, 
["hammlin"] = 16,                      
["shamouti"] = 17,
}
       
        if msgcontains(string.lower(msg), 'city') or msgcontains(string.lower(msg), 'citys') then
           if getPlayerStorageValue(cid, 9658754) == 1 then
              selfSay("You already choose your beginner town!", cid)
              return true
           else
              selfSay("You can choose your beginner town between: {Saffron, Cerulean, Lavender, Fuchsia, Celadon, Viridian, Vermilion, Pewter, Cinnabar, Snow, Ascordbia, Hammlin, Shamouti}.", cid) 
              return true
           end
        elseif places[string.lower(msg)] then
           city = string.lower(msg)
           selfSay("Are you sure which you want to begin in {".. doCorrectString(msg) .."}?", cid) 
           talkState[talkUser] = 2
           return true
       elseif msgcontains(msg, "yes") or msgcontains(msg, "Yes") and talkState[talkUser] == 2 then   
           if getPlayerStorageValue(cid, 9658754) == 1 then
              selfSay("You already choose your beginner town!", cid)
              talkState[talkUser] = 0
              return true
           else
              selfSay("OK then... Now your beginner town is ".. doCorrectString(city)..". Good luck in your jorney!", cid)
              doPlayerSetTown(cid, places[city])
              setPlayerStorageValue(cid, 9658754, 1)
              talkState[talkUser] = 0
              return true
           end
        elseif msgcontains(msg, "no") or msgcontains(msg, "No") and talkState[talkUser] == 2 then  
           selfSay("Ok then... say again what city you want to begin!", cid)
           talkState[talkUser] = 0
           return true 
        end

return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())             