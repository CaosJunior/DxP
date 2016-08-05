function onCreatureTurn(creature)
end

function msgcontains(txt, str)
return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end

local talkState = {}
local focus = 0
local talk_start = 0
local lookNpcDir = getNPCXMLLOOKDIR(getNPCXMLNAME(getThis()))
local tchau = false
local opcoesDiarias = {}
local hora = os.date("%d") -- mudar para dias
local dia = os.date("%d")
local strinSay1 = ""
local stringSay2 = ""
local expToGive1 = 1000
local expToGive2 = 1000
local strinSay1, strinSay2 = "", ""

function onCreatureSay(cid, type, msg)
local msg = string.lower(msg)
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
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


local getNpcTaskName = getPlayerStorageValue(cid, storages.miniQuests.storNpcTaskName3)
local pokeTask1 = getPlayerStorageValue(cid, storages.miniQuests.storPokeNameTask3)
local pokeCountTask1 = tonumber(getPlayerStorageValue(cid, storages.miniQuests.storPokeCountTask3))
local minhaHora = getPlayerStorageValue(cid, storages.miniQuests.storDayTask3)
	
if tonumber(minhaHora) ~= tonumber(hora) then 
	setPlayerStorageValue(cid, storages.miniQuests.storNpcTaskName3, -1)
	setPlayerStorageValue(cid, storages.miniQuests.storPokeNameTask3, -1)
	setPlayerStorageValue(cid, storages.miniQuests.storPokeCountTask3, -1)
	setPlayerStorageValue(cid, storages.miniQuests.storDayTask3, -1)
end

local getNpcTaskName = getPlayerStorageValue(cid, storages.miniQuests.storNpcTaskName3)
local pokeTask1 = getPlayerStorageValue(cid, storages.miniQuests.storPokeNameTask3)
local pokeCountTask1 = tonumber(getPlayerStorageValue(cid, storages.miniQuests.storPokeCountTask3))
local minhaHora = getPlayerStorageValue(cid, storages.miniQuests.storDayTask3)

if pokeTask1 == "amanha" and msgcontains(string.lower(msg), 'hi') then
   selfSay("Você já terminou minha task diaria.")
   talkState[talkUser] = 0
   tchau = true
   focus = 0
   return true	
end   

if ((pokeTask1 == strinSay1 or pokeTask1 == strinSay2) and getNpcTaskName == getCreatureName(getThis())) and msgcontains(string.lower(msg), 'hi') then	
   
   local expToGive = expToGive1
	   if pokeTask1 == strinSay2 then	
		  expToGive = expToGive2
	   end	
   if pokeCountTask1 <= 0 then
	   selfSay('Aqui está sua recompensa.')	
	   doPlayerAddExp(cid, expToGive)
	   doSendAnimatedText(getThingPos(cid), expToGive, 215)
	   setPlayerStorageValue(cid, storages.miniQuests.storPokeNameTask3, "amanha")
   elseif pokeCountTask1 > 0 then
       selfSay('Ainda faltam ' .. pokeCountTask1 .. ' ' .. pokeTask1 .. (pokeCountTask1 > 1 and "s" or '') .. '.') 
   end	   
   
   talkState[talkUser] = 0
   tchau = true
   focus = 0
   return true	
end

count = 0

	if((msgcontains(string.lower(msg), 'hi') or  msgcontains(string.lower(msg), 'help')) and (getDistanceToCreature(cid) <= 3)) then
	
		local stringToSay1 = ""
		for i = 1, #opcoesDiarias[1] do
			local pokeCount = opcoesDiarias[1][i][2]
			local pokeWord = pokeCount > 1 and "s" or ""
			stringToSay1 = stringToSay1 .. pokeCount .. " " .. opcoesDiarias[1][i][1] .. pokeWord .. (i == 1 and "" or " e ")
		end
		
		local stringToSay2 = ""
		for i = 1, #opcoesDiarias[2] do
			local pokeCount = opcoesDiarias[2][i][2]
			local pokeWord = pokeCount > 1 and "s" or ""
			stringToSay2 = stringToSay2 .. pokeCount .. " " .. opcoesDiarias[2][i][1] .. pokeWord .. (i == 1 and "" or " e ")
		end
		
		selfSay('Olá! Minhas tasks são do nivel Hard. Você pode matar ' .. stringToSay1 .. " ou " .. stringToSay2 .. ".")
		talkState[talkUser] = 1
		
		
	elseif msgcontains(string.lower(msg), string.lower(strinSay1)) or msgcontains(string.lower(msg), string.lower(strinSay2)) and getDistanceToCreature(cid) <= 3 and talkState[talkUser] == 1 then	
		local pokeCounts = 0
		if msgcontains(string.lower(msg), string.lower(strinSay1)) then
			setPlayerStorageValue(cid, storages.miniQuests.storNpcTaskName3, getCreatureName(getThis()))
			setPlayerStorageValue(cid, storages.miniQuests.storPokeNameTask3, opcoesDiarias[1][1][1])
			setPlayerStorageValue(cid, storages.miniQuests.storPokeCountTask3, opcoesDiarias[1][1][2])
			setPlayerStorageValue(cid, storages.miniQuests.storDayTask3, hora)
			pokeCounts = opcoesDiarias[1][1][2]
		else
			setPlayerStorageValue(cid, storages.miniQuests.storNpcTaskName3, getCreatureName(getThis()))
			setPlayerStorageValue(cid, storages.miniQuests.storPokeNameTask3, opcoesDiarias[2][1][1])
			setPlayerStorageValue(cid, storages.miniQuests.storPokeCountTask3, opcoesDiarias[2][1][2])
			setPlayerStorageValue(cid, storages.miniQuests.storDayTask3, hora)
			pokeCounts = opcoesDiarias[2][1][2]
		end

		selfSay('Okay. Manterei contato com você. Boa sorte com os ' .. pokeCounts.. ' ' .. msg .. (pokeCounts > 1 and 's' or '') .. '.')
		talkState[talkUser] = 0
		focus = 0
		tchau = true
		return true
	end
end


local tablePoke = diarias.Hard 
local dificult = 3
function onThink()
	-- resetar tasks
	if hora ~= os.date("%d") then
	   opcoesDiarias = {}
	   tablePoke = diarias.Hard 
	   hora = os.date("%d")
	end
	
	if #opcoesDiarias == 0 then -- vamos iniciar as opcoesDiarias
		
		local sorteio1 = math.random(1, #tablePoke)
		local op1 = tablePoke[sorteio1]
				   table.remove(tablePoke, sorteio1)
				   strinSay1 = op1
				   
		local sorteio2 = math.random(1, #tablePoke)
		local op2 = tablePoke[sorteio2]
				   table.remove(tablePoke, sorteio2)
				   strinSay2 = op2
				   	
		local pokeCount1 = math.random(20, 100)	* dificult
		local pokeCount2 = math.random(20, 100)	* dificult
		opcoesDiarias[1] = { {op1, pokeCount1} }
		opcoesDiarias[2] = { {op2, pokeCount2} }
		
		expToGive1 = 1000 * pokeCount1
		expToGive2 = 1000 * pokeCount2
	end

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