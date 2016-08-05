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

--[[function getStringOfTaskArray(array)
   if type(array) ~= 'table' or not next(array) then return "" end
   
   local result = {}
    for _, value in ipairs(array) do
	    local thing, num = (type(value[1]) == 'string' and value[1] or getItemNameById(value[1])), value[2]
		table.insert(result, (_ == 1 and "" or ", ")..num.." "..thing..(num == 1 and "" or "s"))
    end
	result[#result] = " and"..(result[#result]:sub(2,#result[#result]))
	return table.concat(result)
end]] 

---------------------- [CONFIG] --------------------------- 

local reward = { {2160, 1}, {2160, 3}, {2160, 4}, {2160, 5} }
local remove = { {2394, 1}, {2394, 1}, {2394, 1}, {2394, 1} }


local level = 20
local sto = 3184293

---------------------- [ E N D ] --------------------------- 

         if msgcontains(msg, 'help') or msgcontains(msg, 'ajuda') then
		   if getPlayerLevel(cid) < level then
		      selfSay("you need level: "..level.." to help me..", cid)
			  talkState[talkUser] = 0
			  return true
			end
		      if getPlayerStorageValue(cid, sto) == 1 then
			     selfSay("I do not need your help.", cid)
				 talkState[talkUser] = 0
				 return true
			  end
		    selfSay("you need to bring to me: ("..getStringOfTaskArray(remove).."). you collected all the items needed?!", cid)
			talkState[talkUser] = 2
		  return true
		    elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'Yes')) and talkState[talkUser] == 2 then
                for _, x in pairs(remove) do
                   if getPlayerItemCount(cid, x[i][1]) >= x[i][2] then
				   selfSay("you need to bring to me: ("..getStringOfTaskArray(remove)..") Come back when you join all thoses item!", cid)
				   talkState[talkUser] = 0
				   end
				   return true
                end	
               for _, x in pairs(remove) do
                   doPlayerRemoveItem(cid, x[i][1], x[i][2])
               end					
			selfSay("Oh, very good..take this as a reward: ("..getStringOfTaskArray(reward)..").", cid)
               for _, x in pairs(reward) do
                   doPlayerAddItem(cid, x[i][1], x[i][2])
               end			   
			setPlayerStorageValue(cid, sto, 1)
			talkState[talkUser] = 0
			return true
			end
			return true
		 end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())