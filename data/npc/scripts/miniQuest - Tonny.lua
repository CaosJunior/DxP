function onCreatureTurn(creature)
end

function msgcontains(txt, str)
return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end

local talkState = {}
local focus = 0
local talk_start = 0
local lookNpcDir = getNPCXMLLOOKDIR(getNPCXMLNAME(getThis()))

function onCreatureSay(cid, type, msg)
local msg = string.lower(msg)
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
local storageQuest = storages.miniQuests.tonny.QuestStor
local storageMission = storages.miniQuests.tonny.StatusMission
local missions = 
{
	[2] = {itens = {{12173, 10}, {12175, 10}}, questNum = "primeira", expe = 1000, rewards = {{2152, 10}}, pokes = {""}},
	[3] = {itens = {{12177, 50}, {12171, 30}}, questNum = "segunda", expe = 2000, rewards = {{2152, 10}}, pokes = {""}},
}
local statusMission = getPlayerStorageValue(cid, storageMission)
local questStor = getPlayerStorageValue(cid, storageMission)
local itens = ""
local itensLose = ""

if not (getDistanceToCreature(cid) <= 3) then
	return true
end

if msgcontains(string.lower(msg), 'hi') then
	if focus ~= 0 then
	   selfSay(getCreatureName(cid) .. ' aguarde...')
	   return true
	else
		focus = cid
		talk_start = os.clock()
	end
end



if statusMission == 20 and msgcontains(string.lower(msg), 'hi') then	
   selfSay('Você ja me ajudou.')	
   talkState[talkUser] = 0
   focus = 0
   tchau = true
   return true	
end



if questStor > 0 then -- Ja tem a questNum
	    if msgcontains(string.lower(msg), 'hi') then
			for a, b in pairs(missions[statusMission].itens) do
				itens = itens .. getItemNameById(b[1]) .. "(" .. b[2].. ")" .. (#b == a and "." or ", ")
			end
			
				selfSay('Oi! Estou precisando dos seguintes itens: ' .. itens .. " Trouxe?")
				talkState[talkUser] = 1
				
		elseif msgcontains(string.lower(msg), 'yes') and talkState[talkUser] == 1 then
			local naoVender = false
			for a, b in pairs(missions[statusMission].itens) do
				itemCount = getPlayerItemCount(cid, b[1])
				if not (itemCount >= b[2]) then
				   itensLose = itensLose .. getItemNameById(b[1]) .. "(" .. b[2] - itemCount .. ")" .. (#b == a and "." or ", ")
				   naoVender = true
				end
			end

				if not naoVender then
					for a, b in pairs(missions[statusMission].itens) do
					    doPlayerRemoveItem(cid, b[1], b[2])
					end
				end
				
				if naoVender then
					selfSay('Desculpe, mas aqui faltam: ' .. itensLose .. " Volte quando tiver todos.")	
					talkState[talkUser] = 0
					focus = 0
					tchau = true
					return true
				end
				
				doPlayerAddExp(cid, missions[statusMission].expe)
				doSendAnimatedText(getThingPos(cid), missions[statusMission].expe, 215)
				
				for a, b in pairs(missions[statusMission].rewards) do -- Adiciona o itens de recompensas
					doPlayerAddItem(cid, b[1], b[2])
				end
				
				for i = 1, #missions[statusMission].pokes do -- Adiciona os pokes de recompensa
					if missions[statusMission].pokes[i] ~= "" then
					   addPokeToPlayer(cid,  missions[statusMission].pokes[i], 0, nil, "poke")
					end
				end
				
				selfSay('Obrigado!')
				talkState[talkUser] = 0
				statusMission = getPlayerStorageValue(cid, storageMission)
				if missions[statusMission+1] ~= nil then
					setPlayerStorageValue(cid, storageMission, statusMission+1)
					statusMission = getPlayerStorageValue(cid, storageMission)
				    for a, b in pairs(missions[statusMission].itens) do
						itens = itens .. getItemNameById(b[1]) .. "(" .. b[2].. ")" .. (#b == a and "." or ", ")
					end
			
					selfSay('Agora está na ' .. missions[statusMission].questNum .. ' missão e preciso dos seguintes itens: ' .. itens .. " Boa sorte!")
				else
					setPlayerStorageValue(cid, storageMission, 20)
					selfSay('Todas missões feitas.')
					talkState[talkUser] = 0
				end
				focus = 0
				tchau = true
			    return true
		end
else

		if((msgcontains(string.lower(msg), 'hi') or  msgcontains(string.lower(msg), 'help')) and (getDistanceToCreature(cid) <= 3)) then

			selfSay('Oi! Deseja me ajudar?')
			talkState[talkUser] = 1
			
			
		elseif msgcontains(string.lower(msg), 'yes') and getDistanceToCreature(cid) <= 3 and talkState[talkUser] == 1 then	
				if questStor <= 0 then
					setPlayerStorageValue(cid, storageQuest, 1)
					setPlayerStorageValue(cid, storageMission, 1)
					statusMission = 2
				end
				
			
			for a, b in pairs(missions[statusMission].itens) do
				itens = itens .. getItemNameById(b[1]) .. "(" .. b[2].. ")" .. (#b == a and "." or ", ")
			end
			
			selfSay('Okay. Você está na ' .. missions[statusMission].questNum .. ' missão e preciso dos seguintes itens: ' .. itens .. " Boa sorte!")
			setPlayerStorageValue(cid, storageMission, 2)
			talkState[talkUser] = 3
			focus = 0
			tchau = true
			return true
		end
end
end

function onThink()
	if focus  ~= 0 then
		if getDistanceToCreature(focus) > 3 then
			tchau = true
			focus = 0
		end

		if (os.clock() - talk_start) > 15 then
			if focus > 0 then
				tchau = true
				focus = 0
			end
		end
		doNpcSetCreatureFocus(focus)
	end

		if tchau then
			tchau = false
			doCreatureSetLookDir(getThis(), lookNpcDir)
			selfSay('Tchau.')
		end
end