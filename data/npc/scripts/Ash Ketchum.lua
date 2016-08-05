local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function doBuyPokemonWithCasinoCoins(cid, poke) npcHandler:onSellpokemon(cid) end
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)

if(not npcHandler:isFocused(cid)) then
return false
end

local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

if msgcontains(string.lower(msg), 'help') or msgcontains(string.lower(msg), 'ajuda') then
   if getPlayerStorageValue(cid, 748513) == 1 then 
      selfSay("So you have some message from my mother?", cid)
      talkState[talkUser] = 1
   else
      selfSay("I don't need any help!", cid)
      return true
   end
elseif (msgcontains(string.lower(msg), 'yes') or msgcontains(string.lower(msg), 'sim')) and talkState[talkUser] == 1 then 
   selfSay("Wow my mother is waiting for me... I had forgotten which i would help her today... Thanks so much, take this reward!", cid)
   setPlayerStorageValue(cid, 748513, 2) 
   doPlayerAddExp(cid, 100000)
   doPlayerAddItem(cid, 2160, 20)
   talkState[talkUser] = 0  
end

return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())