-- configuração
-----------------
quizcenter = {x=859,y=1276,z=3} 	-- posição central da arena
wrongteleport = quizcenter	 	-- posição pra onde o player será teleportado caso erre
wrongteleport.x = wrongteleport.x - 1
limitetempo = 14 			-- tempo para responder
respostaspraganhar = 15			-- número de respostas corretas para vencer
-----------------


-- tabela de respostas do Quizmaster ao acertar a pergunta
correct = {
"CORRECT!",
"RIGHT ANSWER!",
"THAT'S RIGHT!",
"LUCKY!?",
"SMART!",
"EXCELLENT!",
"PERFECT!",
"RIGHT!",
"FINE!",
"GOOD!",
"GREAT!",
}

-- tabela de respostas do Quizmaster ao errar a pergunta
wrong = {
"Here's what you win: NOTHING!",
"USELESS CREATURE!",
"GET LOST!",
"YOU LOST!",
"LEARN MATH!",
"WRONG!",
"INCORRECT!",
"VANISH!",
}

function quizWin(cid)
	local pos = getThingPos(cid)
	doSendMagicEffect(pos, 10)
	doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)), false)
	doCreatureSetLookDir(cid, 2)
	doSendMagicEffect(getThingPos(cid), 10)
	doCreatureSetNoMove(cid, false)
	doRemoveCondition(cid, CONDITION_INFIGHT)
-- funções extra aqui, pode colocar coisas como doPlayerAddMoney(cid, 10000) etc...
end

function quizLose(cid)
	local pos = getThingPos(cid)
	doSendMagicEffect(pos, 2)
	doTeleportThing(cid, wrongteleport, false)
	doCreatureSetLookDir(cid, 2)
	doSendMagicEffect(getThingPos(cid), 10)
	doCreatureSetNoMove(cid, false)
	doRemoveCondition(cid, CONDITION_INFIGHT)
end

fight = createConditionObject(CONDITION_INFIGHT)
setConditionParam(fight, CONDITION_PARAM_TICKS, -1)

function startQuizTimer(cid)
local quizofdeathNpc = getCreatureByName("Quizmaster ")
if getPlayerStorageValue(quizofdeathNpc, 2) ~= cid then
setPlayerStorageValue(quizofdeathNpc, 5, 0)
return true
end
if getPlayerStorageValue(quizofdeathNpc, 5) == -1 then
setPlayerStorageValue(quizofdeathNpc, 5, 0)
end
local cor = 0
if getPlayerStorageValue(quizofdeathNpc, 5) >= 6 then
cor = 180
else
cor = 25
end
local mytime = limitetempo - getPlayerStorageValue(quizofdeathNpc, 5)
if mytime == 0 then
	doQuizClearField()
	addEvent(doQuizmasterSay, 600, "TIME UP!", cid)
	doSendDistanceShoot(getThingPos(quizofdeathNpc), getThingPos(cid), 31)
	addEvent(quizLose, 800, cid)
	setPlayerStorageValue(quizofdeathNpc, 5, 0)
return true
end
doSendAnimatedText(getThingPos(cid), ""..mytime.."", cor)
setPlayerStorageValue(quizofdeathNpc, 5, getPlayerStorageValue(quizofdeathNpc, 5) + 1)
addEvent(startQuizTimer, 1000, cid)
end

function isCorrect(answer)
local quizofdeathNpc = getCreatureByName("Quizmaster ")
	if tonumber(answer) == nil then
	return false
	end
	if getPlayerStorageValue(quizofdeathNpc, 1) == tonumber(answer) then
	return true
	end
return false
end

local esqx = 3
local dirx = 3
local down = 7

function makeQuizSummonWalk(cid)
if not isCreature(cid) then return true end
local quizofdeathNpc = getCreatureByName("Quizmaster ")
local t = {}
local npcpos = getThingPos(quizofdeathNpc)
local minlx = npcpos.x - esqx
local maxlx = npcpos.x + dirx
local minly = npcpos.y + 1
local maxly = minly + 5
for a = 0, 3 do
	local pos = getPosByDir(getThingPos(cid), a)
	local pos2 = getPosByDir(getThingPos(cid), a)
		pos2.stackpos = 253
	if pos.x >= minlx and pos.x <= maxlx and pos.y >= minly and pos.y <= maxly then
		if getTopCreature(pos).uid > 0 then
			if math.random(1, 30) <= 3 then
			table.insert(t, pos)
			end
		else
		table.insert(t, pos)
		end
	end
end
doChangeSpeed(cid, 105)
if #t > 0 then
doTeleportThing(cid, t[math.random(1, #t)], true)
end
doChangeSpeed(cid, -105)
addEvent(makeQuizSummonWalk, math.random(400, 3200), cid)
end

function doCreateQuizSummon(m, pos)
local x = doCreateMonster(m, pos)
if not isCreature(x) then return true end
doSendMagicEffect(getThingPos(x), 17)
local random = math.random(1, 3)
local color = 0
local outfit1 = getCreatureOutfit(x)
	if random == 1 then
	color = 94
	elseif random == 2 then
	color = 88
	elseif random == 3 then
	color = 82
	end
	outfit1.lookHead = color
	outfit1.lookBody = color
	outfit1.lookLegs = color
	outfit1.lookFeet = color
doSetCreatureOutfit(x, outfit1, -1)
makeQuizSummonWalk(x)
end

function doMakeQuestion(cid)
local quizofdeathNpc = getCreatureByName("Quizmaster ")
local tab = {"Archer", "Knight", "Mage", "Thing"}
local col = {"RED", "GREEN", "BLUE"}
local unit = tab[math.random(1, 4)]
local color = col[math.random(1, 3)]
local randoma = math.random(7, 15)
local randomb = math.random(7, 15)
local randomc = math.random(7, 15)
local position = {}
setPlayerStorageValue(quizofdeathNpc, 5, 0)
for x = -esqx, dirx do
	for y = 1, down do
	local pos = getThingPos(quizofdeathNpc)
	pos.x = pos.x + x
	pos.y = pos.y + y
	table.insert(position, pos)
end
end
for a = 1, randoma do
	local it = math.random(1, #position)
	doCreateQuizSummon("Quiz of Death 1", position[it])
	table.remove(position, it)
end
for b = 1, randomb do
	local it = math.random(1, #position)
	doCreateQuizSummon("Quiz of Death 2", position[it])
	table.remove(position, it)
end
for c = 1, randomc do
	local it = math.random(1, #position)
	doCreateQuizSummon("Quiz of Death 3", position[it])
	table.remove(position, it)
end
doQuizmasterSay("How many "..color.." "..unit.."s?", cid)
local mycolor = 0
if color == "RED" then
	mycolor = 94
elseif color == "BLUE" then
	mycolor = 88
elseif color == "GREEN" then
	mycolor = 82
elseif color == "ORANGE" then
	mycolor = 77
end
	local ans = getSpectators(getThingPos(quizofdeathNpc), 10, 10)
	local count = 0
	for a = 1, #ans do
	if isInArray(tab, getCreatureName(ans[a])) and (getCreatureName(ans[a]) == unit or unit == "Thing") and getCreatureOutfit(ans[a]).lookHead == mycolor then
	count = count + 1
	end
	end
setPlayerStorageValue(quizofdeathNpc, 1, ""..count.."")
setPlayerStorageValue(quizofdeathNpc, 4, 3)
end

function doQuizClearField()
local quizofdeathNpc = getCreatureByName("Quizmaster ")
local t = getSpectators(quizcenter, 10, 10)
for a = 1, #t do
	doRemoveQuizSummon(t[a])
end
setPlayerStorageValue(quizofdeathNpc, 5, 0)
end

function doQuizmasterSay(text, player)
local quizofdeathNpc = getCreatureByName("Quizmaster ")
	if not getPlayerStorageValue(quizofdeathNpc, 2) == player then return true end
doCreatureSay(quizofdeathNpc, text, 1)
end

function doQuizmasterShowTutorial()
local quizofdeathNpc = getCreatureByName("Quizmaster ")
setPlayerStorageValue(quizofdeathNpc, 1, "")
addEvent(quizTutorial, 3700, 1)
addEvent(quizTutorial, 10000, 2)
addEvent(doQuizmasterSay, 13600, "Well, let's begin. FIRST QUESTION:", cid)
addEvent(doMakeQuestion, 14700, getPlayerStorageValue(quizofdeathNpc, 2))
addEvent(startQuizTimer, 14800, getPlayerStorageValue(quizofdeathNpc, 2))
end

function doRemoveQuizSummon(cid)
if not isInArray({"Archer", "Mage", "Knight"}, getCreatureName(cid)) or isPlayer(cid) then return true end
doSendMagicEffect(getThingPos(cid), 2)
doRemoveCreature(cid)
end

function quizTutorial(number)
local quizofdeathNpc = getCreatureByName("Quizmaster ")

local pos = getThingPos(quizofdeathNpc)
	pos.y = pos.y + 2

if number ==  1 then

	pos.x = pos.x - 2
	local x = doCreateMonster("Quiz of Death 1", pos)
		doCreatureSetLookDir(x, 2)
		addEvent(doRemoveQuizSummon, 5800, x)
		doSendMagicEffect(pos, 17)
	pos.x = pos.x + 2
	local y = doCreateMonster("Quiz of Death 2", pos)
		doCreatureSetLookDir(y, 2)
		addEvent(doRemoveQuizSummon, 5800, y)
		doSendMagicEffect(pos, 17)
	pos.x = pos.x + 2
	local z = doCreateMonster("Quiz of Death 3", pos)
		addEvent(doRemoveQuizSummon, 5800, z)
		doCreatureSetLookDir(z, 2)
		doSendMagicEffect(pos, 17)
doQuizmasterSay("I am going to ask you a question about how many archers, knights or mages you can see in my field.", cid)

elseif number == 2 then

doQuizmasterSay("But be careful, they can have different colors...", cid)
local x = doCreateMonster("Quiz of Death 1", pos)
local outfit1 = getCreatureOutfit(x)
local outfit2 = getCreatureOutfit(x)
local outfit3 = getCreatureOutfit(x)
local outfit4 = getCreatureOutfit(x)
	outfit1.lookHead = 94
	outfit1.lookBody = 94
	outfit1.lookLegs = 94
	outfit1.lookFeet = 94
doCreatureSetLookDir(x, 2)
addEvent(doSetCreatureOutfit, 1000, x, outfit1, -1)
	outfit2.lookHead = 88
	outfit2.lookBody = 88
	outfit2.lookLegs = 88
	outfit2.lookFeet = 88
addEvent(doSetCreatureOutfit, 1600, x, outfit2, -1)
	outfit3.lookHead = 82
	outfit3.lookBody = 82
	outfit3.lookLegs = 82
	outfit3.lookFeet = 82
addEvent(doSetCreatureOutfit, 2200, x, outfit3, -1)
addEvent(doRemoveCreature, 2800, x)
addEvent(doSendMagicEffect, 2800, pos, CONST_ME_POFF)
doSendMagicEffect(pos, 17)

end
end














