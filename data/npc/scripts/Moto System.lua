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
local posis = {
--[pos do npc] = {pos inicial, pos final},

--saffron -- fuchsia
[{x = 1161, y = 1041, z = 10}] = {posIni = {x = 1165, y = 1034, z = 10}, posFinal = {x = 1192, y = 1372, z = 10}},

--fuchsia -- saffron
[{x = 1178, y = 1369, z = 10}] = {posIni = {x = 1190, y = 1371, z = 10}, posFinal = {x = 1164, y = 1036, z = 10}}, 

--saffron -- cerulean
[{x = 1149, y = 1032, z = 10}] = {posIni = {x = 1146, y = 1036, z = 10}, posFinal = {x = 1135, y = 912, z = 10}},

--cerulean -- saffron
[{x = 1138, y = 907, z = 10}] = {posIni = {x = 1133, y = 913, z = 10}, posFinal = {x = 1147, y = 1038, z = 10}}, 

--cerulean -- pewter
[{x = 1130, y = 900, z = 10}] = {posIni = {x = 1129, y = 909, z = 10}, posFinal = {x = 717, y = 878, z = 10}},

--pewter -- cerulean
[{x = 724, y = 880, z = 10}] = {posIni = {x = 715, y = 877, z = 10}, posFinal = {x = 1130, y = 907, z = 10}},
}

for npcPos, pos in pairs(posis) do
    if isPosEqualPos(getThingPos(getNpcCid()), npcPos) then 
       posInicial = pos.posIni   
       posFinal = pos.posFinal
       break
    end
end
if not posInicial then selfSay("A error has occored!", cid) print("A error has occored, npc travel aren't in the correct place!") return false end

local outfit = getPlayerSex(cid) == 0 and {lookType = 1393} or {lookType = 1394}
local msg = msg:lower()
local outfit = getPlayerSex(cid) == 0 and {lookType = 1482} or {lookType = 1481}
local msg = msg:lower()
------------------------------------------------------------------------------
if msgcontains(msg, 'ride') then

   ------------------------- Se nao usarem um serv pokemon podem tirar essa parte! -------------------------------------------
   local storages = {17000, 63215, 17001, 13008, 5700}
   for s = 1, #storages do
       if getPlayerStorageValue(cid, storages[s]) >= 1 then
          return selfSay("You can't do that while is Flying, Riding, Surfing, Diving or mount a bike!", cid) and true 
       end
   end
   if #getCreatureSummons(cid) >= 1 then
      return selfSay("Return your pokemon!", cid) and true
   end
   --------------------------------------------------------------------------------------------------------------------------
   selfSay("This route goes to Citys, are you sure?", cid)
   talkState[talkUser] = 1
   return true
elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'Yes')) and talkState[talkUser] == 1 then
   selfSay("Ok! Right on time!", cid)
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