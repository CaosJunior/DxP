-- http://www.xtibia.com/forum/topic/203430-npc-travel-por-rota/
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 
         posInicial = nil
         posFinal = nil
         npcHandler:onCreatureDisappear(cid) 
end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
function creatureSayCallback(cid, type, msg)
if(not npcHandler:isFocused(cid)) then
return false
end
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
---------------------- CONFIGS --------------------------------------
local posis = {                                        -- 1194 854 10
--[pos do npc] = {pos inicial, pos final},
--rota de cerulean para lavender
[{x = 1100, y = 754, z = 7}] = {posIni = {x = 1103, y = 754, z = 7}, posFinal = {x = 1049, y = 657, z = 7}}, 
--"pallet" to cinnabar
[{x = 782, y = 1217, z = 7}] = {posIni = {x = 784, y = 1220, z = 7}, posFinal = {x = 721, y = 1278, z = 7}}, 
--Cinnabar para pallet
[{x = 718, y = 1279, z = 7}] = {posIni = {x = 719, y = 1278, z = 7}, posFinal = {x = 699, y = 1200, z = 7}},
-- Pallet para estação do lado >
[{x = 742, y = 1202, z = 7}] = {posIni = {x = 742, y = 1204, z = 7}, posFinal = {x = 779, y = 1202, z = 7}},
}

local premium = true

for npcPos, pos in pairs(posis) do
    if isPosEqualPos(getThingPos(getNpcCid()), npcPos) then 
       posInicial = pos.posIni   
       posFinal = pos.posFinal
       break
    end
end
if not posInicial then selfSay("A error has occored!", cid) print("A error has occored, npc travel aren't in the correct place!") return false end

local outfit = getPlayerSex(cid) == 0 and {lookType = 1480} or {lookType = 1479}
local msg = msg:lower()
------------------------------------------------------------------------------
if msgcontains(msg, 'travel') then
       if isPlayer(cid) and not isPremium(cid) and premium == true then
        sendMsgToPlayer(cid, 27, "Only premium members are allowed to travel.")
        return true
        end
   ------------------------- Se nao usarem um serv pokemon podem tirar essa parte! -------------------------------------------
   local storages = {17000, 63215, 17001, 13008, 5700}
   for s = 1, #storages do
       if getPlayerStorageValue(cid, storages[s]) >= 1 then
          return selfSay("You can't do that while is Flying, Riding, Surfing, Diving or mount a bike!", cid) and true 
       end
   end
   if #getCreatureSummons(cid) >= 1 then
      return selfSay("Call your pokemon back to your pokeball.", cid) and true
   end
   --------------------------------------------------------------------------------------------------------------------------
   selfSay("What? Do you want to go to hunts, my Lapras can do that! Wanna surf?", cid)
   talkState[talkUser] = 1
   return true
elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'Yes')) and talkState[talkUser] == 1 then
   selfSay("Ok! Right on time, go Lapras!", cid)
   doTeleportThing(cid, posInicial, false)
   doSendMagicEffect(getThingPos(cid), 21)
   mayNotMove(cid, true)
   setPlayerStorageValue(cid, 75846, 1)
   doSetCreatureOutfit(cid, outfit, -1)
   moveTravel(cid, posFinal)
   talkState[talkUser] = 0
   return true
end
return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())