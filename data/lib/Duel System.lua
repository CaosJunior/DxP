storagesDuel = {52480, 52481, 52482, 52482, 52483, 52484, 52485, 6598754}
--[[ Lista das storages Duel!
52480 = sto de duelo e do modo de duel;
52481 = sto de pokes no duel;
52482 = sto do seu time;
52483 = sto do time adversario;
52484 = sto de aceitaçao de duel e do começo do duel;
52485 = sto do nome do 'invitador';
6598754 = sto do canAttackOther; 
]]

function beginDuel(cid, n)
if getPlayerStorageValue(cid, 52482) == -1 or getPlayerStorageValue(cid, 52483) == -1 then
return true
end
local t1 = string.explode(getPlayerStorageValue(cid, 52482), ",")
local t2 = string.explode(getPlayerStorageValue(cid, 52483), ",")
local sto2, sto3 = getPlayerStorageValue(cid, 52482), getPlayerStorageValue(cid, 52483)

if n == 0 then
   for i = 1, #t1 do
       local pid, sid = getPlayerByName(t1[i]), getPlayerByName(t2[i])
       if isCreature(pid) and getPlayerStorageValue(pid, 52480) >= 1 then
          setPlayerStorageValue(pid, 6598754, 5)
          setPlayerStorageValue(pid, 52482, sto2)
          setPlayerStorageValue(pid, 52483, sto3)
          setPlayerStorageValue(pid, 52484, 10)
       end
       ---
       if isCreature(sid) and getPlayerStorageValue(sid, 52480) >= 1 then
          setPlayerStorageValue(sid, 6598754, 10)
          setPlayerStorageValue(sid, 52482, sto2)
          setPlayerStorageValue(sid, 52483, sto3)
          setPlayerStorageValue(sid, 52484, 10)
       end
       ---
       doSendAnimatedText(getThingPosWithDebug(pid), "START", 215)
       doSendAnimatedText(getThingPosWithDebug(sid), "START", 215)
   end  
   return true                                                    
else  
   for i = 1, #t1 do
       local pid, sid = getPlayerByName(t1[i]), getPlayerByName(t2[i]) 
       if isCreature(pid) and getPlayerStorageValue(pid, 52480) >= 1 then
          doSendAnimatedText(getThingPosWithDebug(pid), (n == 6 and "" or ""..n.."!"), 215)
       end
       if isCreature(sid) and getPlayerStorageValue(sid, 52480) >= 1 then
          doSendAnimatedText(getThingPosWithDebug(sid), (n == 6 and "" or ""..n.."!"), 215)
       end
   end
   n = n-1
end
addEvent(beginDuel, 1000, cid, n)
end


function removeFromTableDuel(cid, value)
if not isCreature(cid) then return true end
local t1 = string.explode(getPlayerStorageValue(cid, 52482), ",")
local t2 = string.explode(getPlayerStorageValue(cid, 52483), ",") 

table.remove(t1, table.find(t1, value) or -1)
table.remove(t2, table.find(t2, value) or -1)
---
local str1, str2 = "", ""
for i = 1, 3 do
    if t1[i] then  str1 = str1..(t1[i] or "").."," end
    if t2[i] then  str2 = str2..(t2[i] or "").."," end
end
setPlayerStorageValue(cid, 52482, str1) 
setPlayerStorageValue(cid, 52483, str2)
return true
end

function isDuelingAgainst(cid, pid)
if not isCreature(cid) or not isCreature(pid) then return false end
-----
local t1 = string.explode(getPlayerStorageValue(cid, 52482), ",")
local t2 = string.explode(getPlayerStorageValue(cid, 52483), ",")
-----
local name1, name2 = getCreatureName(cid), getCreatureName(pid)
-----
if table.find(t1, name1) ~= nil and table.find(t2, name2) ~= nil then
   return true
elseif table.find(t2, name1) ~= nil and table.find(t1, name2) ~= nil then
   return true
end
return false
end

function doEndDuel(cid, desisto)
if isCreature(cid) then
if getPlayerStorageValue(cid, 52482) ~= -1 then
   t1 = string.explode(getPlayerStorageValue(cid, 52482), ",")
   t2 = string.explode(getPlayerStorageValue(cid, 52483), ",")
end

local invit = getPlayerByName(getPlayerStorageValue(cid, 52485))
if isCreature(invit) then
   table1 = string.explode(getPlayerStorageValue(invit, 52482), ",") 
   table2 = string.explode(getPlayerStorageValue(invit, 52483), ",")
end

if getPlayerStorageValue(cid, 52484) ~= 10 then
   if getPlayerStorageValue(cid, 52482) ~= -1 then
      for a = 1, 3 do
          local pid, sid = getPlayerByName(t1[a]), getPlayerByName(t2[a])
          if isCreature(pid) then doCreatureSetSkullType(pid, 0) doRemoveCondition(pid, CONDITION_INFIGHT) end
          if isCreature(sid) then doCreatureSetSkullType(sid, 0) doRemoveCondition(sid, CONDITION_INFIGHT) end 
          for i = 1, #storagesDuel do
              if isCreature(pid) then setPlayerStorageValue(pid, storagesDuel[i], -1) end
              if isCreature(sid) then setPlayerStorageValue(sid, storagesDuel[i], -1) end
          end
      end
   else
       for i = 1, #storagesDuel do
           setPlayerStorageValue(cid, storagesDuel[i], -1)
       end
       doCreatureSetSkullType(cid, 0) 
       doRemoveCondition(cid, CONDITION_INFIGHT)
       ---------------------------------   
       if table2 then
          local numero = 0
          for i = 1, #table2 do
              local ppid = getPlayerByName(table2[i])              
              if not isCreature(ppid) or getPlayerStorageValue(ppid, 52480) ~= -1 then
                 numero = numero+1
              end
          end
          if numero == 0 then doEndDuel(invit) sendMsgToPlayer(invit, 20, "The opponents are give up! Duel is canceled!") end
       end
       --------------------------------
   end
   if desisto then doSendAnimatedText(getThingPosWithDebug(cid), "GIVE UP", COLOR_BLUE) end
   return true
end 

   for a = 1, #t1 do
       local pid, sid = getPlayerByName(t1[a]), getPlayerByName(t2[a])
       removeFromTableDuel(pid, getCreatureName(cid))
       removeFromTableDuel(sid, getCreatureName(cid))
   end 
   
   local t3 = string.explode(getPlayerStorageValue(cid, 52482), ",")
   local t4 = string.explode(getPlayerStorageValue(cid, 52483), ",")
   if (#t3 == 0 and #t4 >= 1) or (#t4 == 0 and #t3 >= 1) then  
      
      for j = 1, (#t3 > 0 and #t3 or #t4) do
          local winner = #t3 > 0 and getPlayerByName(t3[j]) or getPlayerByName(t4[j])
          if isCreature(winner) then
             addEvent(doSendAnimatedText, 500, getThingPosWithDebug(winner), "WIN", COLOR_ELECTRIC) 
             for i = 1, #storagesDuel do
                 setPlayerStorageValue(winner, storagesDuel[i], -1)
             end
             doCreatureSetSkullType(winner, 0)
             doRemoveCondition(winner, CONDITION_INFIGHT)
          end
      end
      addEvent(doSendAnimatedText, 500, getThingPosWithDebug(cid), "LOSE", COLOR_BURN)
      for i = 1, #storagesDuel do
          setPlayerStorageValue(cid, storagesDuel[i], -1)
      end
      doCreatureSetSkullType(cid, 0)
      doRemoveCondition(cid, CONDITION_INFIGHT)
      
   else 
      for i = 1, #storagesDuel do
          setPlayerStorageValue(cid, storagesDuel[i], -1)
      end
      doCreatureSetSkullType(cid, 0)
      doRemoveCondition(cid, CONDITION_INFIGHT)
      if desisto then
         doSendAnimatedText(getThingPosWithDebug(cid), "GIVE UP", COLOR_BLUE)
      else
         addEvent(doSendAnimatedText, 500, getThingPosWithDebug(cid), "LOSE", COLOR_BURN)
      end
   end
end
end

function checkDuel(cid)
if getPlayerStorageValue(cid, 52484) ~= 10 then return true end
if getPlayerStorageValue(cid, 52481) >= 1 then
   setPlayerStorageValue(cid, 52481, getPlayerStorageValue(cid, 52481)-1)
   doSendAnimatedText(getThingPosWithDebug(cid), "POKE DOWN", 65)
end
if getPlayerStorageValue(cid, 52481) == 0 then           
   doEndDuel(cid)
end         
end
--/////////////////////////////////////////////////////////////////////////////////////////////--