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

local stoQuest = 9873242 --storage para n pegar o premio 2x
local stoOut = 181644  --storage da roupa

if (msgcontains(msg, 'mission') or msgcontains(msg, 'help')) and (not talkState[talkUser] or talkState[talkUser] == 0) then
   if getPlayerStorageValue(cid, stoQuest) >= 1 then
          selfSay("You already did this quest!", cid)
          talkState[talkUser] = 0
          return true
   end
   selfSay("You need catch atleast 130 pokemons to win the reward, can you do it?", cid)
   talkState[talkUser] = 1
elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) and talkState[talkUser] == 1 then
   if getPlayerStorageValue(cid, stoQuest) >= 1 then
          selfSay("You already did this quest!", cid)
          talkState[talkUser] = 0
          return true
   end
   local list = getCatchList(cid)
   if #list >= 130 then
          selfSay("Thank you very much, take you reward...", cid)
          setPlayerStorageValue(cid, stoOut, 1)
          setPlayerStorageValue(cid, stoQuest, 1)

          doPlayerAddItem(cid, 11638, 1) --box 4
          doPlayerAddItem(cid, 12681, 1)
          talkState[talkUser] = 0
          return true
   else
          selfSay("You haven't caught 100 pokemons yet, come back when you do that...", cid)
          talkState[cid] = 0
          return true
   end
elseif (msgcontains(msg, 'no') or msgcontains(msg, 'nao')) then
   selfSay("So good bye...", cid)
   talkState[cid] = 0
   return true
end
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())