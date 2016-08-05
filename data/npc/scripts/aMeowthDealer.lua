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


if msgcontains(msg, 'coin') or msgcontains(msg, 'meowth coin') then
    selfSay("I have a good offer for you, 2 meowth coins for 1000Dollars, what do you think?", cid)
    talkState[cid] = 1
elseif msgcontains(msg, 'yes') or msgcontains(msg, 'Yes') and talkState[cid] == 1 then
    if doPlayerRemoveMoney(cid, 100000) then --1k 
       selfSay("So there is it! Good luck at the event!", cid)
       doPlayerAddItem(cid, 6527, 2)                              --alterado v1.2
       talkState[cid] = 0
       return true
    else
       selfSay("You don't have enough money!", cid)
       talkState[cid] = 0
       return true
    end
end

return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())