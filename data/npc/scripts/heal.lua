local posis = {   --[storage da city] = {pos da nurse na city},
[897530] = {x = 1054, y = 1050, z = 7},   --saffron                   --alterado v1.9 \/
[897531] = {x = 1061, y = 900, z = 7},    --cerulean
[897532] = {x = 1203, y = 1040, z = 7},    --lavender
[897533] = {x = 1213, y = 1321, z = 7},    --fuchsia
[897534] = {x = 860, y = 1094, z = 6},    --celadon
[897535] = {x = 706, y = 1083, z = 7},    --viridian
[897536] = {x = 1073, y = 1233, z = 7},    --vermilion
[897537] = {x = 723, y = 844, z = 7},    --pewter
[897538] = {x = 848, y = 1394, z = 7},    --cinnabar
[897539] = {x = 1429, y = 1597, z = 6},    --snow
[897540] = {x = 258, y = 429, z = 7},    --golden

[897541] = {x = 243, y = 1028, z = 7}, -- Hammlin
[897542] = {x = 268, y = 1163, z = 7}, -- Shamouti
[897543] = {x = 252, y = 1260, z = 6}, -- Ascordbia
[897544] = {x = 2612, y = 985, z = 7}, -- Vip 1
[897545] = {x = 2680, y = 675, z = 7}, -- Vip 2
[897546] = {x = 2559, y = 444, z = 5}, -- Vip 3

[897546] = {x = 2559, y = 444, z = 5}, -- Pallet
[897546] = {x = 652, y = 1171, z = 7}, -- Coliseum

[897546] = {x = 1163, y = 1450, z = 13}, -- Outland north
[897546] = {x = 1509, y = 1290, z = 13}, -- outland west
[897546] = {x = 1152, y = 1068, z = 13}, -- outland sul
}

function onThingMove(creature, thing, oldpos, oldstackpos)
end

function onCreatureAppear(creature)
end

function onCreatureDisappear(cid, pos)
if focus == cid then
selfSay('Good bye sir!')
focus = 0
talk_start = 0
end
end

function onCreatureTurn(creature)
end

function msgcontains(txt, str)
return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end

function onCreatureSay(cid, type, msg)
local msg = string.lower(msg)
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

for a, b in pairs(gobackmsgs) do
	local gm = string.gsub(b.go, "doka!", "")
	local bm = string.gsub(b.back, "doka!", "")
if string.find(string.lower(msg), string.lower(gm)) or string.find(string.lower(msg), string.lower(bm)) then
return true
end
end

if((msgcontains(msg, 'hi') or msgcontains(msg, 'heal') or msgcontains(msg, 'help')) and (getDistanceToCreature(cid) <= 3)) then

 	if exhaustion.get(cid, 9211) then
	selfSay('Por Favor espere um momento para eu por curar novamente seus Pokemons!')
	return true
   	end

	if not getTileInfo(getThingPos(cid)).protection and nurseHealsOnlyInPZ then
		selfSay("Por Favor, entre no Centro Pokemon para eu poder curar seus Pokemons!")
	return true
	end
	
	if isInDuel(cid) then
	   selfSay("Não possu curar seus Pokemons enquanto você está em Duel!")   --alterado v1.6.1
    return true 
    end
    

	exhaustion.set(cid, 9211, 1)

	doCreatureAddHealth(cid, getCreatureMaxHealth(cid)-getCreatureHealth(cid))
	doCureStatus(cid, "all", true)
	doSendMagicEffect(getThingPos(cid), 103)

	local mypb = getPlayerSlotItem(cid, 8)
	doSetItemAttribute(mypb.uid, "hpToDraw", 0)
	
	 if isRiderOrFlyOrSurf(cid) then 
	    demountPokemon(cid, true)
		doRemoveCondition(cid, CONDITION_OUTFIT)
		doRegainSpeed(cid)
	 end
	local s = getCreatureSummons(cid)
	local healthMax = 0
	if #s >= 1 then
		healthMax = getCreatureMaxHealth(s[1])
		doReturnPokemon(cid, s[1], mypb, pokeballs[getPokeballType(mypb.itemid)].effect)
		doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_POKEMON_HEALTH, healthMax.."|"..healthMax)
	end
	
		if mypb.itemid ~= 0 and isPokeball(mypb.itemid) then  --alterado v1.3
			doSetItemAttribute(mypb.uid, "hpToDraw", 0)
			doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_POKEMON_HEALTH, getBallMaxHealth(cid, mypb).."|"..getBallMaxHealth(cid, mypb))
			
			for c = 1, 15 do
				local str = "move"..c
				setCD(mypb.uid, str, 0)
			end
			if getItemAttribute(mypb.uid, "happy") and getItemAttribute(mypb.uid, "happy") < baseNurseryHappiness then
				doItemSetAttribute(mypb.uid, "happy", baseNurseryHappiness)
			end
			if getPlayerStorageValue(cid, 17000) <= 0 and getPlayerStorageValue(cid, 17001) <= 0 and getPlayerStorageValue(cid, 63215) <= 0 then
				for a, b in pairs (pokeballs) do
					if isInArray(b.all, mypb.itemid) then
					   doTransformItem(mypb.uid, b.on)
					end
				end
			end
		end
	

	local bp = getPlayerSlotItem(cid, CONST_SLOT_BACKPACK)

    local balls = getPokeballsInContainer(bp.uid)
    if #balls >= 1 then
       for _, uid in ipairs(balls) do
           doItemSetAttribute(uid, "hp", 1)
		   doSetItemAttribute(uid, "hpToDraw", 0)
           for c = 1, 15 do
               local str = "move"..c
               setCD(uid, str, 0)   
           end
           if getItemAttribute(uid, "hunger") and getItemAttribute(uid, "hunger") > baseNurseryHunger then
              doItemSetAttribute(uid, "hunger", baseNurseryHunger)
           end
           if getItemAttribute(uid, "happy") and getItemAttribute(uid, "happy") < baseNurseryHappiness then
              doItemSetAttribute(uid, "happy", baseNurseryHappiness)
           end
           local this = getThing(uid)
           for a, b in pairs (pokeballs) do
		       if isInArray(b.all, this.itemid) then
	              doTransformItem(uid, b.on)
               end
           end
        end
    end
    selfSay('Todos os seus Pokemons foram curados, boa Sorte em sua jornada!')
	doCreatureSetSkullType(cid, 0)
end
end