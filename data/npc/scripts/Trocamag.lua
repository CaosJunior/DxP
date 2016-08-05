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


if (msgcontains(msg, 'Shiny') or msgcontains(msg, 'shiny')) then --alterado v1.7

selfSay("Voce quer tranformar seu Shiny Magmar em Shiny Magmortar? Voce precisa do Shiny Magmar+50 + 5kk!", cid)
talkState[talkUser] = 1
elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'Yes')) and talkState[talkUser] == 1 then
if getPlayerSlotItem(cid, 8).uid <= 0 then
selfSay("Desculpe, voce nao esta com o pokemon na slot!", cid)
talkState[talkUser] = 0
return true
end 
--alterado v1.2
if #getCreatureSummons(cid) >= 1 then
selfSay("Puxe seu pokemon para pokebola!", cid)
talkState[talkUser] = 0
return true
end

local pb = getPlayerSlotItem(cid, 8).uid

if getItemAttribute(pb, "poke") ~= "Shiny Magmar" then
selfSay("Coloca seu shiny magmar+50 na slot por favor!", cid)
talkState[talkUser] = 0
return true
end

if not getItemAttribute(pb, "boost") or getItemAttribute(pb, "boost") < 50 then
selfSay("Desculpe seu Shiny magmar não esta boosted +50!", cid)
talkState[talkUser] = 0
return true
end
                                          --100000 = 1k, 1000000 = 10k, 10000000 = 100k
           if doPlayerRemoveMoney(cid, 500000009) == true then
              selfSay("So there is it! Enjoy!", cid)
              doItemSetAttribute(pb, "hp", 1)
              doItemSetAttribute(pb, "poke", "Shiny Magmortar")
		      doItemSetAttribute(pb, "description", "Contains a Shiny Magmortar.")
		      doItemEraseAttribute(pb, "boost")
		      doTransformItem(getPlayerSlotItem(cid, 7).uid, fotos["Shiny Magmortar"])

		doItemSetAttribute(pb, "Icone", "yes")	
		doTransformItem(pb, icons[getItemAttribute(pb, "poke")].on)

		      if useKpdoDlls then
		        doCreatureExecuteTalkAction(cid, "/pokeread")
	          end
		      talkState[talkUser] = 0
		      return true
	      else
	          selfSay("Você nao tem dinheiro suficiente!", cid)
	          talkState[talkUser] = 0
	          return true
          end
        end

return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())   
