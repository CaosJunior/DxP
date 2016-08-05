function onSay(cid, words, param)
local player = getPlayerByName(param)  
local t = string.explode(param, ",")  
if words == "/checkdays" then  

if(param == '') then
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Command requires param.") return true end

if not isPlayer(player) then
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Player not found.") return true end

return doPlayerPopupFYI(cid, "Player checked have "..getPlayerPremiumDays(player).." days of Premium Account!")  
end

if words == "/addpremium" then  

local t = string.explode(param, ",")  
local player = getPlayerByNameWildcard(t[1])

if not tonumber(t[2]) then  
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid param specified.") return true end  

if(not player)then
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Player not found.") return true end

doPlayerAddPremiumDays(player, tonumber(t[2]))
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You has been added "..tonumber(t[2]).." days of Premium Account to the player! ")  
doRemoveCreature(player)
end

if words == "/removedays" then
local t = string.explode(param, ",")  
local player = getPlayerByNameWildcard(t[1])

if not tonumber(t[2]) then  
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid param specified.") return true end  

if(not player)then
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Player not found.") return true end

doPlayerRemovePremiumDays(player, tonumber(t[2]))
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You has been removed "..tonumber(t[2]).." Premium Account Days of the player!")  

end
return true
end