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

local reward_starter = {
{12344, 1},
{12348, 20},
{12349, 15},
{2394, 25},
{2392, 2},
}

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
local Choose = {"pidgey", "oddish", "bellsprout", "spearow", "hoppip", "sukern", "sentret", "remoraid"}

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
		   selfSay("Ok, talk {Choose poke or escolhe poke} and complete this mission!", cid)
           doPlayerSetTown(cid, places[city])
		   talkState[talkUser] = 4
		   -- alterado a baixo \/
		elseif msgcontains(msg, "choose poke") or msgcontains(msg, "escolhe poke") and talkState[talkUser] == 4 then
        selfSay("Are you using the {NEW} client or {OLD} client?", cid)	
        talkState[talkUser] = 5	
		elseif msgcontains(msg, "old") or msgcontains(msg, "antigo") and talkState[talkUser] == 5 then   
		selfSay("Ok, chose you new pokemon, Pokes Kanto! {Pidgey, Oddish, Spearow, Bellsprout}, or Pokes Johto! {Hoppip, Remoraid, Sukern, Sentret}, So what you want?", cid)
		talkState[talkUser] = 6
		elseif isInArray(Choose, msg) and talkState[talkUser] == 6 then
		addPokeToPlayer(cid, msg, 0, -1, 'normal', true)
		doSendMagicEffect(getThingPos(cid), 21)
		selfSay("Ok, good luck on your journey.", cid)
        for i = 1, #reward_starter do
        doPlayerAddItem(cid, reward_starter[i][1], reward_starter[i][2])
        end
        setPlayerStorageValue(cid, sto_city, 2)
		doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)), false)
		talkState[talkUser] = 0
		elseif msgcontains(msg, "new") or msgcontains(msg, "novo") and talkState[talkUser] == 4 then  -- botei talkState 4 reve pra min ce ta certo
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