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
local configuration = {
add_item = 2152,
add_item2 = 2392,
add_item3 = 2393,
add_item4 = 2678,
remove_item = 12334,  -- magikarp fin
remove_item2 = 12161,  -- water gem
remove_item3 = 12170,  -- water pendant
StoAdd = 52315,
}

--local pos = {x=1024, y=1025, z=7}  -- no usavel

if (msgcontains(msg, 'Help') or msgcontains(msg, 'help')) then  
      if getPlayerStorageValue(cid, configuration.StoAdd) >= 1 then
	  selfSay("Desculpa, não é possível você completar a quest mais de uma vez só!", cid)
	  return true
	  end
selfSay("Olá jogador, eu sou um grande fã de pokemons de aguas e eu estou precisando de alguns itens necessarios para minha coleção dos intens deles, intão eu preciso de 80 remains of magikarps, 50 water gem, 30 water pendant Você pode me ajudar? !", cid)
talkState[talkUser] = 1
return true

elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) and talkState[talkUser] == 1 then
selfSay("hum muito bom, falta pouco para você me ajudar, digite yes para completar minha quest !", cid)
talkState[talkUser] = 2

elseif msgcontains(msg, 'yes') and talkState[talkUser] == 2 then
         if getPlayerItemCount(cid, configuration.remove_item) < 80 then
		 selfSay("Sorry, you dont 80 remains of magikar to complet quest, return to here !", cid)
		 talkState[talkUser] = 0
		 return true
		 end
		  if getPlayerItemCount(cid, configuration.remove_item2) < 50 then
		 selfSay("Sorry, you dont have 50 Water gem to complet quest, return to here..I waiting you drop !", cid)
		 talkState[talkUser] = 0
		 return true
		 end
		  if getPlayerItemCount(cid, configuration.remove_item3) < 30 then
		 selfSay("Sorry, you dont have 30 Water pendants,return to here..I waiting you drop to complet my quest !", cid)
		 talkState[talkUser] = 0
		 return true
		 end
selfSay("Good, you help me, you rewards in you backpack !", cid)
selfSay("Good Bye and good luck ;3", cid)
talkState[talkUser] = 0
doPlayerRemoveItem(cid, configuration.remove_item, 80)
doPlayerRemoveItem(cid, configuration.remove_item2, 50)
doPlayerRemoveItem(cid, configuration.remove_item3, 30)
setPlayerStorageValue(cid, configuration.StoAdd, 1)
doPlayerAddLevel(cid, 2)
doPlayerAddItem(cid, configuration.add_item, 75)
doPlayerAddItem(cid, configuration.add_item2, 45)
doPlayerAddItem(cid, configuration.add_item3, 30)
doPlayerAddItem(cid, configuration.add_item4, 50)
doSendMagicEffect(getThingPos(cid), 29)
          return true
          end
return true
end	


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())	 