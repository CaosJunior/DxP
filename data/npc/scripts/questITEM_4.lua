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
   msg = string.lower(msg)
   ---------
   local need = {
      {id = 12200, qt = 75}, --feathers
   }
   local rewards = {
      {id = 2392, qt = 85}, --ultra ball
      {id = 11453, qt = 1}, --heart stone
   }
   local stoFinish = 92092
   ---------
   
   if msgcontains(msg, 'help') or msgcontains(msg, 'ajuda') then
      if getPlayerStorageValue(cid, stoFinish) >= 1 then
         selfSay("Sorry, you already had done this quest.", cid)
         talkState[talkUser] = 0
         return true
      end
      selfSay("Hello my friend, can you bring to me: 75 Feathers? I will reward you!",cid)
      talkState[talkUser] = 1
      return true 
   elseif msgcontains(msg, 'yes') or msgcontains(msg, 'sim') and talkState[talkUser] == 1 then
      if getPlayerItemCount(cid, need[1].id) < need[1].qt then
         selfSay("You don't brought to me all the items what i asked for...", cid)
         selfSay("Remember, you need to bring to me 75 Feathers...", cid)
         talkState[talkUser] = 0
         return true
      end
      for i = 1, #need do
          doPlayerRemoveItem(cid, need[i].id, need[i].qt)
      end
      for i = 1, #rewards do
          doPlayerAddItem(cid, rewards[i].id, rewards[i].qt)
		                doPlayerAddExperience(cid, 300000)
      end
	  selfSay("thanks you, bye!", cid)
      setPlayerStorageValue(cid, stoFinish, 1)
      talkState[talkUser] = 0
      return true
   end
   return true
end       
                    
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
   