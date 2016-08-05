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
	  {id = 12166, qt = 200},  -- mimic clothes
	  {id = 12169, qt = 50},  -- buzz tail
	  {id = 12170, qt = 500},  -- water pendant
	  {id = 12171, qt = 200},  -- pot of moss bug
	  {id = 12172, qt = 200},  -- bird beaks
   }
   local rewards = {
      {id = 12232, qt = 5}, --metal stone
      {id = 2160, qt = 20}, --cash
   }
   local stoFinish = 92116
   ---------
   
   if msgcontains(msg, 'help') or msgcontains(msg, 'ajuda') then
      if getPlayerStorageValue(cid, stoFinish) >= 1 then
         selfSay("Sorry, you already had done this quest.", cid)
         talkState[talkUser] = 0
         return true
      end
      selfSay("Ol� meu amigo, voc� pode trazer para mim: 200 mimic clothes, 50 buzz tail, 500 water pendant, 200 pot of moss bug, 200 bird beaks? Vou recompens�-lo!",cid)
      talkState[talkUser] = 1
      return true 
   elseif msgcontains(msg, 'yes') or msgcontains(msg, 'sim') and talkState[talkUser] == 1 then
      if getPlayerItemCount(cid, need[1].id) < need[1].qt then
         selfSay("Voc� n�o me trouxe todos os itens que eu pedi...", cid)
         selfSay("Lembre-se, voc� precisa trazer para mim 200 mimic clothes, 50 buzz tail, 500 water pendant, 200 pot of moss bug, 200 bird beaks...", cid)
         talkState[talkUser] = 0
         return true
      end
      for i = 1, #need do
          doPlayerRemoveItem(cid, need[i].id, need[i].qt)
      end
      for i = 1, #rewards do
          doPlayerAddItem(cid, rewards[i].id, rewards[i].qt)
		                doPlayerAddExperience(cid, 3000000)
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
   