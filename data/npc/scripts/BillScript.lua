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
local cfsto = {
stoPr = 91230,  -- storage pra ele ir fala com o npc e volta !!
stoCo = 91231,   -- storage q ele falou com a npc tudo certo
StoM = 91232,  -- sto pra prox missão
stoAdd = 91233, -- sto q o npc de ceru deu pra ele q confirmo a msg
}

local storage = 91250   -- sto da quest completada inteira

-- \/ storages da missão 2
local stoTwo = {
sto1 = 91234, -- storage pra poder fala com ash
sto2 = 91235, -- storage q diz q ele falou com ash
sto3 = 91236, -- storage dada pra ele pode pega o clan no pvp
}

if (msgcontains(msg, 'info') or msgcontains(msg, 'information')) then  
                 if getPlayerStorageValue(cid, storage) >= 1 then
	             selfSay("I do not need your help anymore.", cid)
	             return true
	             end       
selfSay("Hello, I'm Bill, I like to know everything about pokemon, I'm needing some help to complete my research over pokemon, want to help me?", cid)
return true
talkState[talkUser] = 1
elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) and talkState[talkUser] == 1 then
selfSay("Okay, I need you to send a message to a friend of mine, she is in cerulean, she call me for a great event pokemons of waterborne more as I am very busy with my research of all Pokemon, I can not go, you can go there telling her that I will not go?", cid)
talkState[talkUser] = 2
elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'ok')) and talkState[talkUser] == 2 then
selfSay("Ok, I'll be waiting for you here.", cid)
setPlayerStorageValue(cid, cfsto.stoPr, 1)
talkState[talkUser] = 3
elseif (msgcontains(msg, 'talk') or msgcontains(msg, 'complete')) and talkState[talkUser] == 3 then
selfSay("You said what i asked?", cid)
talkSta[talkUser] = 4
elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) and talkState[talkUser] == 4 then
                 if getPlayerStorageValue(cid, cfsto.stoAdd) >= 1 then
	             selfSay("Sorry, you did not do what I asked you needed.", cid)
	             return true
	             end       
selfSay("Very good, I am very grateful for helping me with this help I managed to finish my research and can find the formula of gvhd your pokemon stronger, I adptei this as the name of clan, you want to know more about this story?", cid)
setPlayerStorageValue(cid, cfsto.StoM, 1)
talkState[talkUser] = 5
--------------------- 1 * missão /\ -----
--\\--
--- 2 * missão \/ ----
elseif (msgcontains(msg, 'missao') or msgcontains(msg, 'help')) and talkState[talkUser] == 1 then
                 if getPlayerStorageValue(cid, cfsto.stoM) <= 1 then
	             selfSay("Sorry, you even helped me in the first mission!.", cid)
	             return true
	             end           
selfSay("I see a lot of interest on their part, need you Fasse me another favor, this interested?", cid)
talkState[talkUser] = 2
elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) and talkState[talkUser] == 2 then
selfSay("Ok, I'm already almost done my research officer clans, intão I need you to talk to ash he will speak to the attribute needed to finalize the clan, can you bring me this Feedback from the ash?", cid)
talkState[talkUser] = 3
elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) and talkState[talkUser] == 2 then
selfSay("Ok, I hope you do not make me wait too long.", cid)
setPlayerStorageValue(cid, stoTwo.sto1, 1)
talkState[talkUser] = 3
---- \/ entregando a missão
elseif (msgcontains(msg, 'help') or msgcontains(msg, 'help')) and talkState[talkUser] == 1 then
                 if getPlayerStorageValue(cid, stoTwo.sto2) <= 1 then
	             selfSay("Sorry, you even helped me in the msg mission.", cid)
	             return true
	             end           
selfSay("Our really good, I believe you are the best, when you are level 80 you can tonarsse a clan! thank you.", cid)
setPlayerStorageValue(cid, storage, 1)
