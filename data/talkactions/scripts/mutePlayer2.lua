local v = {}
for k = 1, 24 do
table.insert(v, k, createConditionObject(MUTED_TRADE))
setConditionParam(v[k], CONDITION_PARAM_TICKS, k*60*60*1000) --horas
end

function onSay(cid, words, param)

if (words == "/muted") then
   if getPlayerGroupId(cid) >= 3 and getPlayerGroupId(cid) <= 6 then
      local t = string.explode(param, ",")  
      if param == '' then  
         doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid param specified.")  
         return true 
      end  
      local player, time = getPlayerByName(t[1]), t[2] 
      if not isPlayer(player) then 
         doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Player with this name doesn\'t exist or is offline.")  
         return TRUE  
      end
         doPlayerSendTextMessage(cid, 20, "You muted Player "..t[1].." for "..time.." hour(s).")
         doAddCondition(player, v[tonumber(time)])
         setPlayerStorageValue(player, 900059, os.time()+time*60*60)
         if t[3] then
             doPlayerSendTextMessage(player, 20, "You have been muted by "..getPlayerName(cid).." for "..time.." hour(s).\n Reason: "..t[3])
         else
             doPlayerSendTextMessage(player, 20, "You have been muted by "..getPlayerName(cid).." for "..time.." hour(s).")
         end
   end
elseif (words == "/desmute") then
   if param == '' then  
      doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid param specified.")  
      return true 
   end  
   local player = getPlayerByName(param)
   if(not isPlayer(player))then 
      doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Player not found.") 
      return true 
   end
   if getCreatureCondition(player, MUTED_TRADE) == false then 
      doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "This player is not muted.") 
      return true 
   end
   doPlayerSendTextMessage(cid, 20, "You desmuted player "..param..".")
   doRemoveCondition(player, MUTED_TRADE)
   setPlayerStorageValue(player, 900059, -1)
   doPlayerSendTextMessage(player, 20, "You have been desmuted.")
end
return true  
end  