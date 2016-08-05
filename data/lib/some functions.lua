function getStringOfTaskArray(array)
   if type(array) ~= 'table' or not next(array) then return "" end
   
   local result = {}
    for _, value in ipairs(array) do
	    local thing, num = (type(value[1]) == 'string' and value[1] or getItemNameById(value[1])), value[2]
		table.insert(result, (_ == 1 and "" or ", ")..num.." "..thing..(num == 1 and "" or "s"))
    end
	result[#result] = " and"..(result[#result]:sub(2,#result[#result]))
	return table.concat(result)
end

function getVitalityByMaster(cid)
if not isCreature(cid) then return 0 end
local ball = getPlayerSlotItem(cid, 8).uid
if not ball or ball <= 1 or not pokes[getItemAttribute(ball, 'poke')] then return true end
   return pokes[getItemAttribute(ball, 'poke')].vitality * (getPlayerLevel(cid) + (getItemAttribute(ball, 'boost') or 0))
end

function onPokeHealthChange(cid, zerar)
   if not isCreature(cid) then return true end
   if zerar then doPlayerSendCancel(cid, '#ph#,0,0') end
   local ball = getPlayerSlotItem(cid, 8).uid
   if not ball or ball <= 1 or not pokes[getItemAttribute(ball, 'poke')] then return true end
   
   if #getCreatureSummons(cid) >= 1 and getPlayerStorageValue(cid, 212124) <= 0 then   --alterado v1.6
      local pokemon = getCreatureSummons(cid)[1]
      local pokelife = (getCreatureHealth(pokemon) / getCreatureMaxHealth(pokemon))
      doItemSetAttribute(ball, "hp", pokelife)
   end
   
      local rd = 1 - (tonumber(getItemAttribute(ball, "hp")))
   local maxHp = HPperVITsummon * getVitalityByMaster(cid) 
   local hp = maxHp -(maxHp * rd)   
   doPlayerSendCancel(cid, '#ph#,'.. math.floor(hp) ..','.. math.floor(maxHp))
end

function addPokeToPlayer(cid, pokemon, boost, gender, ball, unique, mega)             --alterado v1.9 \/ peguem ele todo...
local genders = {
["male"] = 4,
["female"] = 3,
[1] = 4,
[0] = 3,
[4] = 4,
[3] = 3,
}
if not isCreature(cid) then return false end

local pokemon = doCorrectString(pokemon)
if not pokes[pokemon] then return false end

   local GENDER = (gender and genders[gender]) and genders[gender] or getRandomGenderByName(pokemon)
   local btype = (ball and pokeballs[ball]) and ball or isShinyName(pokemon) and "shinypoke" or "poke"
   local happy = 250
   
   id = pokeballs[pokemon:lower()].on
	local cap = getPlayerFreeCap(cid)
   if (getPlayerFreeCap(cid) <= 1 and not isInArray({5, 6}, getPlayerGroupId(cid))) or not hasSpaceInContainer(getPlayerSlotItem(cid, 3).uid) then 
      item = doCreateItemEx(id)
   else
      item = addItemInFreeBag(getPlayerSlotItem(cid, 3).uid, id, 1)   
   end
   if not item then return false end

   doItemSetAttribute(item, "poke", pokemon)
   doItemSetAttribute(item, "hpToDraw", 0)
   doSetItemAttribute(item, "hands", 0)
   doItemSetAttribute(item, "ball", btype)
   doItemSetAttribute(item, "reverseIcon", btype)
   doSetAttributesBallsByPokeName(cid, item, pokemon)
	
   if boost and tonumber(boost) and tonumber(boost) > 0 and tonumber(boost) <= 50 then
      doItemSetAttribute(item, "boost", boost)
   end
   if unique then
      doItemSetAttribute(item, "unique", getCreatureName(cid))
   end
                                                                             
   if (cap <= 1 and not isInArray({5, 6}, getPlayerGroupId(cid))) or not hasSpaceInContainer(getPlayerSlotItem(cid, 3).uid) then
	   if mega then
		  doItemSetAttribute(item, "yHeldItem",	mega .. "|MEGA")
	   end
      doPlayerSendMailByName(getCreatureName(cid), item, 1)
      sendMsgToPlayer(cid, 27, "You are already holding six pokemons, so your new pokemon was sent to your depot.")
   end
   doTransformItem(item, id)
   doTransformItem(item, pokeballs[pokemon:lower()].on)	
   if mega then
      doItemSetAttribute(item, "yHeldItem",	mega .. "|MEGA")
   end
return true
end 
---------------------------

function unLock(ball)                                                             
if not ball or ball <= 0 then return false end
if getItemAttribute(ball, "lock") and getItemAttribute(ball, "lock") > 0 then
   local vipTime = getItemAttribute(ball, "lock")
   local timeNow = os.time()
   local days = math.ceil((vipTime - timeNow)/(24 * 60 * 60))
   if days <= 0 then
      doItemEraseAttribute(ball, "lock")    
      doItemEraseAttribute(ball, "unique")
      return true
   end
end
return false
end

function getGuildMembersOnline(GuildId)
local players = {}
for _, pid in pairs(getPlayersOnline()) do
    if getPlayerGuildId(pid) == tonumber(GuildId) then
       table.insert(players, pid)
    end
end                                                   --by Vodkart
return #players > 0 and players or false
end

function getGuildMembers(GuildId)
local players,query = {},db.getResult("SELECT `name` FROM `players` WHERE `rank_id` IN (SELECT `id` FROM `guild_ranks` WHERE `guild_id` = " .. GuildId .. ");")
if (query:getID() ~= -1) then  
   repeat
         table.insert(players,query:getDataString("name"))
   until not query:next()                           --by Vodkart
   query:free()
end
return #players > 0 and players or false
end 
--/////////////////////////////////////////////////////////////////////////////////---
function sendMsgToPlayer(cid, tpw, msg)      --alterado v1.7 \/\/\/
if not isCreature(cid) or not tpw or not msg then return true end
return doPlayerSendTextMessage(cid, tpw, msg)
end

function getPlayerDesc(cid, thing, TV)
if (not isCreature(cid) or not isCreature(thing)) and not TV then return "" end

if isRecording(cid) and isWatchingTv(thing) then
    thing = cid
end

local pos = getThingPos(thing)
local ocup = youAre[getPlayerGroupId(thing)]
local rank = (getPlayerStorageValue(thing, 86228) <= 0) and "a Pokemon Trainer" or lookClans[getPlayerStorageValue(thing, 86228)][getPlayerStorageValue(thing, 862281)]
local name = thing == cid and "yourself" or getCreatureName(thing)     
local art = thing == cid and "You are" or (getPlayerSex(thing) == 0 and "She is" or "He is")

local str = {}  
 if isWatchingTv(cid) and isWatchingTv(thing) and (getThingPos(cid).x == getThingPos(thing).x and getThingPos(cid).y == getThingPos(thing).y and getThingPos(cid).z == getThingPos(thing).z) then  
    local watchedPlayer = getPlayerStorageValue(cid, storages.playerIsTvWhosWatching)
    table.insert(str, "You see " .. watchedPlayer .. ".")
	return table.concat(str) 
end
   

table.insert(str, "You see "..name..". "..art.." ")
local townName = getTownName(getPlayerTown(thing))
    if not townName then
	  townName = "Server para Testes"
	end
if youAre[getPlayerGroupId(thing)] then
   table.insert(str, (ocup).." and "..rank.." from ".. townName..".")       
else
   table.insert(str, (rank).." from ".. townName..".")
end
if getPlayerGuildId(thing) > 0 then
   table.insert(str, " "..art.." "..getPlayerGuildRank(thing).." from the "..getPlayerGuildName(thing)..".")
end
if isWatchingTv(thing) then
   table.insert(str, " "..art.." watching TV.")
end
if isGod(cid) then 
    local rarePokes = #getRarePokeballs(thing, getPlayerSlotItem(thing, 3).uid) 
	local ballsCount = 0
	local arg = rarePokes > 1 and "s" or ""
		  ballsCount = #getPokeballsInContainer(getPlayerSlotItem(thing, 3).uid)
		  if getPlayerSlotItem(thing, 8).uid ~= 0 and isPokeball(getPlayerSlotItem(thing, 8).itemid) then
		     ballsCount = ballsCount+1
		  end
		  if getPlayerSlotItem(thing, 10).uid ~= 0 and isPokeball(getPlayerSlotItem(thing, 10).itemid) then
		     ballsCount = ballsCount+1
		  end
		  
		if getCreatureName(thing) == "[GM] WhyLose" then
			table.insert(str, "\nEle é Main Jax.")
		elseif getCreatureName(thing) == "[GM] Stigal" then
			table.insert(str, "\nJoga a lanterna SUPORTE LIXO.")
		elseif getCreatureName(thing) == "[GM] Lord Sorte" then
			table.insert(str, "\nCabra da peste.")
		elseif getCreatureName(thing) == "[ADM] Sapphire" then
			table.insert(str, "\nO DEUS.")
		end
	   
    table.insert(str, "\nLevel: [" .. getPlayerLevel(thing) .. "]" .. (rarePokes > 0 and ", " or " e ") .. ballsCount .. " pokemon" .. (ballsCount > 1 and "s" or "") .. (rarePokes > 0 and " e " .. rarePokes .. " deles shiny" .. arg .. "." or ".")) 
end
table.insert(str, ((isPlayer(cid) and youAre[getPlayerGroupId(cid)]) and "\nPosition: [X: "..pos.x.."][Y: "..pos.y.."][Z: "..pos.z.."]" or "")) 

return table.concat(str) 
end
-------------------------------------------------------------------------------------------------   /\/\
function getLivePokeballs(cid, container, duel) 
    if not isCreature(cid) then return {} end     
	if not isContainer(container) then return {} end
	local items = {}
	---
	local ballSlot = getPlayerSlotItem(cid, 8)
    if ballSlot.uid ~= 0 then
       for a, b in pairs (pokeballs) do
           if ballSlot.itemid == b.on or ballSlot.itemid == b.use then
              if duel and getPlayerLevel(cid) >= (pokes[getItemAttribute(ballSlot.uid, "poke")].level + getPokeballBoost(ballSlot)) then
                 table.insert(items, ballSlot.uid)                                                                      --alterado v1.8
              elseif not duel then
                 table.insert(items, ballSlot.uid)
              end
           end
       end
    end
    --- 
	---
	local ballSlot = getPlayerSlotItem(cid, 10)
    if ballSlot.uid ~= 0 then
       for a, b in pairs (pokeballs) do
           if ballSlot.itemid == b.on then
              if duel and getPlayerLevel(cid) >= (pokes[getItemAttribute(ballSlot.uid, "poke")].level + getPokeballBoost(ballSlot)) then
                 table.insert(items, ballSlot.uid)                                                                      --alterado v1.8
              elseif not duel then
                 table.insert(items, ballSlot.uid)
              end
           end
       end
    end
    ---     
	if isContainer(container) and getContainerSize(container) > 0 then      
		for slot=0, (getContainerSize(container)-1) do
			local item = getContainerItem(container, slot)
				if isContainer(item.uid) then
					local itemsbag = getPokeballsInContainer(item.uid)
					for i=0, #itemsbag do
						if not isInArray(items, itemsbag[i]) then
                           table.insert(items, itemsbag[i])
                        end
					end
				elseif isPokeball(item.itemid) then
				    for a, b in pairs (pokeballs) do
                        if item.itemid == b.on then
                           if duel and getPlayerLevel(cid) >= (pokes[getItemAttribute(item.uid, "poke")].level + getPokeballBoost(item)) then    
					          table.insert(items, item.uid)                                            --alterado v1.8
                           elseif not duel then
                              table.insert(items, item.uid)
                           end
	                    end
                    end
				end
		end
	end
return items
end

function getRarePokeballs(cid, container) 
    if not isCreature(cid) then return {} end     
	if not isContainer(container) then return {} end
	local items = {}
	---
	local ballSlot = getPlayerSlotItem(cid, 8)
    if ballSlot.uid ~= 0 then
       for a, b in pairs (pokeballs) do
           if ballSlot.itemid == b.on or ballSlot.itemid == b.use or ballSlot.itemid == b.off then
		     if string.find(getItemAttribute(ballSlot.uid, "poke"):lower(), "shiny") then
                table.insert(items, ballSlot.uid)
			 end
           end
       end
    end
    --- 
	---
	local ballSlot = getPlayerSlotItem(cid, 10)
    if ballSlot.uid ~= 0 then
       for a, b in pairs (pokeballs) do
           if ballSlot.itemid == b.on or ballSlot.itemid == b.use or ballSlot.itemid == b.off then
              if string.find(getItemAttribute(ballSlot.uid, "poke"):lower(), "shiny") then
                table.insert(items, ballSlot.uid)
			 end
           end
       end
    end
    ---     
	if isContainer(container) and getContainerSize(container) > 0 then      
		for slot=0, (getContainerSize(container)-1) do
			local item = getContainerItem(container, slot)
				if isContainer(item.uid) then
					local itemsbag = getPokeballsInContainer(item.uid)
					for i=0, #itemsbag do
						if not isInArray(items, itemsbag[i]) then
                           table.insert(items, itemsbag[i])
                        end
					end
				elseif isPokeball(item.itemid) then
				    for a, b in pairs (pokeballs) do
                        if item.itemid == b.on or item.itemid == b.use or item.itemid == b.off then
                           if string.find(getItemAttribute(item.uid, "poke"):lower(), "shiny") then
							  table.insert(items, item.uid)
						   end
	                    end
                    end
				end
		end
	end
return items
end

function addItemInFreeBag(container, item, num)
if not isContainer(container) or not item then return false end                                             
if not num or num <= 0 then num = 1 end                                            --alterado v1.6.1
if getContainerSize(container) < getContainerCap(container) then
   return doAddContainerItem(container, item, num)
else
   for slot = 0, (getContainerSize(container)-1) do
       local container2 = getContainerItem(container, slot)
       if isContainer(container2.uid) and getContainerSize(container2.uid) < getContainerCap(container2.uid) then
          return doAddContainerItem(container2.uid, item, num)
       end
   end
end
return false
end
------------------------------------------------------------------------------------------------------
function pokeHaveReflect(cid)
if not isCreature(cid) then return false end
local table = getTableMove(getCreatureName(cid), "Reflect")
if table and table.name then     --alterado v1.6
   return true 
end
return false
end
------------------------------------------------------------------------------------------------------
function nextHorario(cid)
    horarioAtual = os.date("%X")
    horario = string.explode(horarioAtual, ":")
    
    for i = 1, #horas do
        horarioComparacao = horas[i]
        horarioComp = string.explode(horarioComparacao, ":")
        ---------------
        if tonumber(horarioComp[1]) > tonumber(horario[1]) then
           return horarioComparacao                                
        elseif tonumber(horarioComp[1]) == tonumber(horario[1]) and tonumber(horario[2]) < tonumber(horarioComp[2]) then
           return horarioComparacao
        end
    end 
    return horas[1]                                  
end                                                               

function getTimeDiff(timeDiff)
local dateFormat = {
{'hour', timeDiff / 60 / 60}, --6%
{'min', timeDiff / 60 % 60},
}
local out = {}                                   
for k, t in ipairs(dateFormat) do
    local v = math.floor(t[2])
    if(v > -1) then
         table.insert(out, (k < #dateFormat and '' or ' and ') .. v .. '' .. (v <= 1 and t[1] or t[1].."s"))
    end
end
if tonumber(dateFormat[1][2]) == 0 and tonumber(dateFormat[2][2]) == 0 then
   return "seconds"
end
return table.concat(out)
end

function getTimeDiff2(timeDiff)
local dateFormat = {
{'hour', timeDiff / 60 / 60}, --6%
{'min', timeDiff / 60 % 60},
{'sec', timeDiff % 60},
}
local out = {}                                  
for k, t in ipairs(dateFormat) do
    local v = math.floor(t[2])
    if(v > 0) then
         table.insert(out, (k < #dateFormat and ' ' or ' and ') .. v .. '' .. (v <= 1 and t[1] or t[1].."s"))
    end
end
return table.concat(out)
end 

function showTimeDiff(timeComp)
local b = string.explode(os.date("%X"), ":")
local c = string.explode(timeComp, ":")
    ---
    local d, m, y = os.date("%d"), os.date("%m"), os.date("%Y")
    local hAtual, mAtual = tonumber(b[1]), tonumber(b[2])
    local hComp, mComp = tonumber(c[1]), tonumber(c[2])
    ---
    local t = os.time{year= y, month= m, day= d, hour= hAtual, min= mAtual}
    local t1 = os.time{year= y, month= m, day= d, hour= hComp, min= mComp}
    ---                                                                       
    comparacao = t1-t
    if hComp < hAtual then
       v = os.time{year= y, month= m, day= d, hour= 24, min= 0}
       v2 = os.time{year= y, month= m, day= d, hour= 0, min= 0}
       comparacao = (v-t)+(t1-v2)
    end
return getTimeDiff(comparacao)
end
-------------------------------------------------------------------------
function cleanCMcds(item)
if item ~= 0 then
   for c = 1, 15 do              --alterado v1.5
      local str = "cm_move"..c
      setCD(item, str, 0)
   end
end
end

function ehNPC(cid)   --alterado v1.9
return isCreature(cid) and not isPlayer(cid) and not isSummon(cid) and not isMonster(cid)
end

function ehMonstro(cid)
local eh = false
    if not isSummon(cid) and not ehNPC(cid) and not isPlayer(cid) then
        eh = true
    end
    return eh
end                                                      --alterado v1.9.1 /\

function doAppear(cid) --Faz um poke q tava invisivel voltar a ser visivel...
if not isCreature(cid) then return true end 
doRemoveCondition(cid, CONDITION_INVISIBLE)
doRemoveCondition(cid, CONDITION_OUTFIT)
doCreatureSetHideHealth(cid, false)
	if isMega(cid) then
	   checkOutfitMega(cid, getPlayerStorageValue(cid, storages.isMega))
	end
end

function doDisapear(cid)   --Faz um pokemon ficar invisivel
if not isCreature(cid) then return true end
doCreatureAddCondition(cid, permanentinvisible)
doCreatureSetHideHealth(cid, true)
doSetCreatureOutfit(cid, {lookType = 2}, -1)
end

function hasTile(pos)    --Verifica se tem TILE na pos
pos.stackpos = 0
if getTileThingByPos(pos).itemid >= 1 then
   return true
end
return false
end

function getThingFromPosWithProtect(pos)  --Pega uma creatura numa posiçao com proteçoes
if hasTile(pos) then
   if isCreature(getRecorderCreature(pos)) then
      return getRecorderCreature(pos)
   else
      pos.stackpos = 253
      pid = getThingfromPos(pos).uid
   end
else
   pid = getThingfromPos({x=2,y=1,z=15,stackpos=253}).uid -- mudar essa posicao
end
return pid
end

function getTileThingWithProtect(pos)    --Pega um TILE com proteçoes
if hasTile(pos) then
pos.stackpos = 0
   pid = getTileThingByPos(pos)
else
    pid = getThingfromPos({x=2,y=1,z=15,stackpos=253}).uid -- mudar essa posicao
end
return pid
end

function canAttackOther(cid, pid)         --Function q verifica se um poke/player pode atacar outro poke/player

if not isCreature(cid) or not isCreature(pid) then return "Cant" end

local master1 = isSummon(cid) and getCreatureMaster(cid) or cid
local master2 = isSummon(pid) and getCreatureMaster(pid) or pid
   
   ----             
        if CanAttackerInDuel(master1, master2) and not isPlayer(cid) then
            return "Can"
         end
   ----              pvp system
   if getPlayerStorageValue(master1, 6598754) >= 1 and getPlayerStorageValue(master2, 6598755) >= 1 then
      return "Can" 
   end
   if getPlayerStorageValue(master1, 6598755) >= 1 and getPlayerStorageValue(master2, 6598754) >= 1 then  ---estar em times diferentes
      return "Can"
   end
   ----
   if ehMonstro(cid) and ehMonstro(pid) then 
      return "Can"
   end

return "Cant"
end
   
      
function stopNow(cid, time)   
if not isCreature(cid) or not tonumber(time) or isSleeping(cid) then return true end
                                                        --alterado v1.9.1 \/
local function podeMover(cid)                         
if isPlayer(cid) then 
   mayNotMove(cid, false) 
elseif isCreature(cid) then 
   doRegainSpeed(cid) 
end
end

if isPlayer(cid) then mayNotMove(cid, true) else doChangeSpeed(cid, -getCreatureSpeed(cid)) end
addEvent(podeMover, time, cid)
end

function doReduceStatus(cid, off, def, agi)   --reduz os status
if not isCreature(cid) then return true end
local A = getOffense(cid)
local B = getDefense(cid)
local C = getSpeed(cid)

if off > 0 then
   setPlayerStorageValue(cid, 1001, A - off)
end
if def > 0 then
   setPlayerStorageValue(cid, 1002, B - def)
end
if agi > 0 then
   setPlayerStorageValue(cid, 1003, C - agi)
   if getCreatureSpeed(cid) ~= 0 then
      doRegainSpeed(cid)
   end                                              --alterado v1.5  functions arrumadas...
end
end

function doRaiseStatus(cid, off, def, agi, time)  
if not isCreature(cid) then return true end
local A = getOffense(cid)
local B = getDefense(cid)
local C = getSpeed(cid)

if off > 0 then
   setPlayerStorageValue(cid, 1001, A * off)
end
if def > 0 then
   setPlayerStorageValue(cid, 1002, B * def)
end
if agi > 0 then
   setPlayerStorageValue(cid, 1003, C + agi)
   if getCreatureSpeed(cid) ~= 0 then
      doRegainSpeed(cid)
   end
end

local D = getOffense(cid)
local E = getDefense(cid)
local F = getSpeed(cid)
---------------------------
local G = D - A
local H = E - B
local I = F - C

addEvent(doReduceStatus, time*1000, cid, G, H, I)
end


function BackTeam(cid)          
  if isCreature(cid) then
     local summon = getCreatureSummons(cid)   --alterado v1.6
     for i = 2, #summon do
         doSendMagicEffect(getThingPos(summon[i]), 211)
         doRemoveCreature(summon[i])
     end
     setPlayerStorageValue(cid, 637501, -1)
  end  
end
    
function choose(...) -- by mock
    local arg = {...}
    return arg[math.random(1,#arg)]
end

function AddPremium(cid, days)
local function removerPlayer(cid)
if isCreature(cid) then
   doRemoveCreature(cid)
end
end

db.executeQuery("UPDATE `accounts` SET `premdays` = '"..days.."' WHERE `accounts`.`id` = ".. getPlayerAccountId(cid) ..";")
doPlayerSendTextMessage(cid,25,"Você será kickado em 5 segundos.")    
addEvent(removerPlayer, 5*1000, cid)     
return TRUE
end

function isShiny(cid) 
return isCreature(cid) and string.find(getCreatureName(cid), "Shiny")  --alterado v1.9
end

function isShinyName(name)        
return tostring(name) and string.find(doCorrectString(name), "Shiny") --alterado v1.9
end

function doConvertTypeToStone(type, string)
local t = {
["fly"] = {heart, "heart"},
["flying"] = {heart, "heart"},
["normal"] = {heart, "heart"},
["fire"] = {fire, "fire"},
["grass"] = {leaf, "leaf"},
["leaf"] = {leaf, "leaf"},
["water"] = {water, "water"},
["poison"] = {venom, "venom"},
["venom"] = {venom, "venom"},
["electric"] = {thunder, "thunder"},
["thunder"] = {thunder, "thunder"},
["rock"] = {rock, "rock"},
["fight"] = {punch, "punch"},
["fighting"] = {punch, "punch"},
["bug"] = {coccon, "coccon"},
["dragon"] = {crystal, "crystal"},
["dark"] = {dark, "dark"},
["ghost"] = {dark, "dark"},
["ground"] = {earth, "earth"},
["earth"] = {earth, "earth"},
["psychic"] = {enigma, "enigma"},
["steel"] = {metal, "metal"},
["ancient"] = {ancient, "ancient"},
["metal"] = {metal, "metal"},
["ice"] = {ice, "ice"},
["boost"] = {boostStone, "boost"},  --alterado v1.9
}

if string then
return t[type][2]
else
return t[type][1]
end
end

function doConvertStoneIdToString(stoneID)
local t = {
[11453] = "Heart Stone",
[11441] = "Leaf Stone",
[11442] = "Water Stone",
[11443] = "Venom Stone",
[11444] = "Thunder Stone",
[11445] = "Rock Stone",
[11446] = "Punch Stone", 
[11447] = "Fire Stone",               --alterado v1.6
[11448] = "Cocoon Stone", 
[11449] = "Crystal Stone",
[11450] = "Darkess Stone", 
[11451] = "Earth Stone",
[11452] = "Enigma Stone",
[11454] = "Ice Stone", 
[12244] = "Ancient Stone",
[12232] = "Metal Stone",
[12401] = "Shiny Fire Stone",
[12402] = "Shiny Water Stone",
[12403] = "Shiny Leaf Stone",
[12404] = "Shiny Heart Stone",
[12405] = "Shiny Enigma Stone",
[12406] = "Shiny Rock Stone",
[12407] = "Shiny Venom Stone", 
[12408] = "Shiny Ice Stone",
[12409] = "Shiny Thunder Stone",
[12410] = "Shiny Crystal Stone",
[12411] = "Shiny Cocoon Stone",
[12412] = "Shiny Darkness Stone",
[12413] = "Shiny Punch Stone",
[12414] = "Shiny Earth Stone",
[boostStone] = "Boost Stone",  --alterado v1.9
}
if t[stoneID] then
return t[stoneID]
else
return ""
end
end

function isStone(id)
if id >= leaf and id <= ice then
return true
end
if id == boostStone then  --alterado v1.9
return true
end
if id == 12232 or id == 12244 or id == 12244 or id == 12245 then
return true                                 
end
if (id >= sfire and id <= searth) or id == 12417 or id == 12419 then
return true 
end
return false
end

function isWater(id)
return tonumber(id) and id >= 4820 and id <= 4825 --alterado v1.9
end

function getTopCorpse(position)
local pos = position
for n = 1, 255 do
    pos.stackpos = n
    local item = getTileThingByPos(pos)
    if item.itemid >= 2 and (string.find(getItemNameById(item.itemid), "fainted ") or string.find(getItemNameById(item.itemid), "defeated ")) then
       return getTileThingByPos(pos)
    end
end
return null
end

bpslot = CONST_SLOT_BACKPACK

function hasPokemon(cid)
	if not isCreature(cid) then return false end
	if getCreatureMana(cid) <= 0 then return false end
	if #getCreatureSummons(cid) >= 1 then return true end
	local item = getPlayerSlotItem(cid, CONST_SLOT_FEET)
	local bp = getPlayerSlotItem(cid, bpslot)
	for a, b in pairs (pokeballs) do
        if item.itemid == b.on or item.itemid == b.use then
        return true                              --alterado v1.4
        end
        if #getItemsInContainerById(bp.uid, b.on) >= 1 then
        return true
        end
	end
return false
end

function isNpcSummon(cid)
return isNpc(getCreatureMaster(cid))
end

function getPokemonHappinessDescription(cid)
	if not isCreature(cid) then return true end
	local str = {}
	if getPokemonGender(cid) == SEX_MALE then
		table.insert(str, "He")
	elseif getPokemonGender(cid) == SEX_FEMALE then
		table.insert(str, "She")
	else
		table.insert(str, "It")
	end
	local h = getPlayerStorageValue(cid, 1008)
	if h >= tonumber(getConfigValue('PokemonStageVeryHappy')) then
		table.insert(str, " is very happy with you!")
	elseif h >= tonumber(getConfigValue('PokemonStageHappy')) then
		table.insert(str, " is happy.")
	elseif h >= tonumber(getConfigValue('PokemonStageOK')) then
		table.insert(str, " is unhappy.")
	elseif h >= tonumber(getConfigValue('PokemonStageSad')) then
		table.insert(str, " is sad.")
	elseif h >= tonumber(getConfigValue('PokemonStageMad')) then
		table.insert(str, " is mad.")
	else
		table.insert(str, " is very mad at you!")
	end
return table.concat(str)
end

function doSetItemAttribute(item, key, value)
doItemSetAttribute(item, key, value)
end

function deTransform(cid, check)
	if not isCreature(cid) then return true end

	local m = getCreatureMaster(cid)
	local p = getPlayerSlotItem(m, 8)

	if getItemAttribute(p.uid, "transTurn") ~= check then return true end

	setPlayerStorageValue(cid, 1010, getCreatureName(cid) == "Ditto" and "Ditto" or "Shiny Ditto")        --edited
	doRemoveCondition(cid, CONDITION_OUTFIT)
	doSendMagicEffect(getThingPos(cid), 184)
	doCreatureSay(cid, "DITTO!", TALKTYPE_MONSTER)
	doItemSetAttribute(p.uid, "transBegin", 0)
	doItemSetAttribute(p.uid, "transLeft", 0)
	doItemEraseAttribute(p.uid, "transName")
	adjustStatus(cid, p.uid, true, true, true)
end

function isTransformed(cid)
return isCreature(cid) and not isInArray({-1, "Ditto", "Shiny Ditto"}, getPlayerStorageValue(cid, 1010))  --alterado v1.9
end

function doSendFlareEffect(pos)
	local random = {28, 29, 79}
	doSendMagicEffect(pos, random[math.random(1, 3)])
end

function isDay()
	local a = getWorldTime()
	if a >= 360 and a < 1080 then
	return true
	end
return false
end

function doPlayerSendTextWindow(cid, p1, p2)
	if not isCreature(cid) then return true end
	local item = 460
	local text = ""
	if type(p1) == "string" then
		doShowTextDialog(cid, item, p1)
	else
		doShowTextDialog(cid, p1, p2)
	end
end

function getClockString(tw)
	local a = getWorldTime()
	local b = a / 60
	local hours = math.floor(b)
	local minut = a - (60 * hours)

	if not tw then
		if hours < 10 then
			hours = "0"..hours..""
		end
		if minut < 10 then
			minut = "0"..minut..""
		end
	return hours..":"..minut
	else
		local sm = "a.m"
		if hours >= 12 then
			hours = hours - 12
			sm = "p.m"
		end
		if hours < 10 then
			hours = "0"..hours..""
		end
		if minut < 10 then
			minut = "0"..minut..""
		end
	return hours..":"..minut.." "..sm
	end
end

function doCorrectPokemonName(poke)
return doCorrectString(poke)
end

function doCorrectString(str)
if str == nil then return "" end
if type(str) ~= "string" then return "" end
local name = str:explode(" ")  --alterado v1.9
local final = {}
for _, s in ipairs(name) do
    table.insert(final, s:sub(1, 1):upper()..s:sub(2, #s):lower())
end
return table.concat(final, (name[2] and " " or ""))
end   

function getHappinessRate(cid)
	if not isCreature(cid) then return 1 end
	local a = getPlayerStorageValue(cid, 1008)
		if a == -1 then return 1 end
	if a >= getConfigValue('PokemonStageVeryHappy') then
		return happinessRate[5].rate
	elseif a >= getConfigValue('PokemonStageHappy') then
		return happinessRate[4].rate
	elseif a >= getConfigValue('PokemonStageOK') then
		return happinessRate[3].rate
	elseif a >= getConfigValue('PokemonStageSad') then
		return happinessRate[2].rate
	else
		return happinessRate[1].rate
	end
return 1
end

function doBodyPush(cid, target, go, pos)
	if not isCreature(cid) or not isCreature(target) then
		doRegainSpeed(cid)
		doRegainSpeed(target)
	return true
	end
		if go then
			local a = getThingPos(cid)
			doChangeSpeed(cid, -getCreatureSpeed(cid))
				if not isPlayer(target) then
					doChangeSpeed(target, -getCreatureSpeed(target))
				end
			doChangeSpeed(cid, 800)
			doTeleportThing(cid, getThingPos(target))
			doChangeSpeed(cid, -800)
			addEvent(doBodyPush, 350, cid, target, false, a)
		else
			doChangeSpeed(cid, 800)
			doTeleportThing(cid, pos)
			doRegainSpeed(cid)
			doRegainSpeed(target)
		end
end

function doReturnPokemon(cid, pokemon, pokeball, effect, hideeffects, blockevo)

    --////////////////////////////////////////////////////////////////////////////////////////--
	checkDuel(cid)                                                                      --alterado v1.6 duel system
    --////////////////////////////////////////////////////////////////////////////////////////--
    
    if #getCreatureSummons(cid) > 1 and getPlayerStorageValue(cid, 212124) <= 0 then     --alterado v1.6
       if getPlayerStorageValue(cid, 637501) == -2 or getPlayerStorageValue(cid, 637501) >= 1 then  
          BackTeam(cid)       
       end
    end
    -----------------
	local edit = true


	local happy = getPlayerStorageValue(pokemon, 1008)
	local hunger = getPlayerStorageValue(pokemon, 1009)
	local pokelife = (getCreatureMaxHealth(pokemon) - getCreatureHealth(pokemon))

	if edit then
		doItemSetAttribute(pokeball.uid, "happy", happy)
		doItemSetAttribute(pokeball.uid, "hunger", hunger)
		doItemSetAttribute(pokeball.uid, "hpToDraw", pokelife)
	end
	
	local pos = getThingPos(pokemon)
	doSendMagicEffect(pos, effect)
	
    local hasNick = getItemAttribute(pokeball.uid, "nick") and true or false
	local pokename = retireShinyName(getCreatureName(pokemon, true))

	local mbk = gobackmsgs[math.random(1, #gobackmsgs)].back:gsub("doka", (hasNick and getItemAttribute(pokeball.uid, "nick") or pokename))
	doTransformItem(pokeball.uid, pokeballs[getPokeballType(pokeball.itemid)].on)
	doCreatureSay(cid, mbk, TALKTYPE_ORANGE_1)

	doRemoveCreature(pokemon)

	

end

local EFFECTS = {
	--[OutfitID] = {Effect}
	["Magmar"] = 35,                --alterado v1.5
	["Shiny Magmar"] = 35,
	["Magby"] = 35,
	["Jynx"] = 17,   
	["Smoochum"] = 17, 
	["Shiny Jynx"] = 17,    
	["Piloswine"] = 205,  --alterado v1.8
    ["Swinub"] = 205, 
    ["Stantler"] = 205, 
    ["Shiny Stantler"] = 205, 
}

function doGoPokemon(cid, item)

	if getPlayerStorageValue(cid, 17000) >= 1 or getPlayerStorageValue(cid, 17001) >= 1 or getPlayerStorageValue(cid, 63215) >= 1 then
	return true
	end
---------------------------------------------------------------
local ballName = getItemAttribute(item.uid, "poke")

   btype = getPokeballType(item.itemid)                   

	local effect = pokeballs[btype].effect
		if not effect then
			effect = 21
		end
-----------------------------------------------------------------
	if item.uid ~= getPlayerSlotItem(cid, CONST_SLOT_FEET).uid then
		doPlayerSendCancel(cid, "You must put your pokeball in the correct place!")
	return TRUE
	end

	local thishp = getItemAttribute(item.uid, "hp")

	if thishp <= 0 then
		if isInArray(pokeballs[btype].all, item.itemid) then
			doTransformItem(item.uid, pokeballs[btype].off)
			doItemSetAttribute(item.uid, "hp", 0)
			doPlayerSendCancel(cid, "This pokemon is fainted.")
		    return true
		end
	end

	local pokemon = getItemAttribute(item.uid, "poke")

	if not pokes[pokemon] then
	return true
	end

----------------------- Sistema de nao poder carregar mais que 3 pokes lvl baixo e + q 1 poke de lvl medio/alto ---------------------------------
if not isInArray({5, 6}, getPlayerGroupId(cid)) then
   local balls = getPokeballsInContainer(getPlayerSlotItem(cid, 3).uid)      --alterado v1.9 \/
   local low = {}
   local lowPokes = {"Rattata", "Caterpie", "Weedle", "Oddish", "Pidgey", "Paras", "Poliwag", "Bellsprout", "Magikarp", "Hoppip", "Sunkern"}
   if #balls >= 1 then
      for _, uid in ipairs(balls) do
          local nome = getItemAttribute(uid, "poke")
          if not isInArray(lowPokes, pokemon) and nome == pokemon then
             return doPlayerSendTextMessage(cid, 27, "Sorry, but you can't carry two pokemons equals!")
          else
             if nome == pokemon then
                table.insert(low, nome)
             end
          end
      end
   end
if #low >= 3 then
   return doPlayerSendTextMessage(cid, 27, "Sorry, but you can't carry more than three pokemons equals of low level!")
end   
end
---------------------------------------------------------------------------------------------------------------------------------------------------

	local x = pokes[pokemon]
	local boosts = getItemAttribute(item.uid, "boost") or 0

	if getPlayerLevel(cid) < (x.level + boosts) then   --alterado v1.8 \/
	doPlayerSendCancel(cid, "You need level "..(x.level + boosts).." to use this pokemon.")
	return true
	end
	
	--------------------------------------------------------------------------------------
	shinysClan = {
	["Shiny Fearow"] = {4, "Wingeon"},
	["Shiny Flareon"] = {1, "Volcanic"},
	["Shiny Vaporeon"] = {2, "Seavel"}, 
	["Shiny Jolteon"] = {9, "Raibolt"},
	["Shiny Hypno"] = {7, "Psycraft"},
	["Shiny Golem"] = {3, "Orebound"},         
	["Shiny Vileplume"] = {8, "Naturia"},
	["Shiny Nidoking"] = {5, "Malefic"},
	["Shiny Hitmontop"] = {6, "Gardestrike"},   
	}
	
	if shinysClan[pokemon] and (getPlayerGroupId(cid) < 4 or getPlayerGroupId(cid) > 6) then --alterado v1.9
	   if getPlayerStorageValue(cid, 86228) ~= shinysClan[pokemon][1] then
	      doPlayerSendCancel(cid, "You need be a member of the clan "..shinysClan[pokemon][2].." to use this pokemon!")
	      return true   
       elseif getPlayerStorageValue(cid, 862281) ~= 5 then
          doPlayerSendCancel(cid, "You need be atleast rank 5 to use this pokemon!")
	      return true
       end
    end
    --------------------------------------------------------------------------------------

	pokeSourceCode = doCreateMonsterNick(cid, pokemon, pokemon, getThingPos(cid), true)
            if not pokeSourceCode then
			   doSendMsg(cid, "Erro. Comunique esse codigo ao GM. [31121994]")
			   return true
			end

	local pk = getCreatureSummons(cid)[1]
	if not isCreature(pk) then return true end
	
	------------------------passiva hitmonchan------------------------------
	if isSummon(pk) then                                                  --alterado v1.8 \/
       if pokemon == "Shiny Hitmonchan" or pokemon == "Hitmonchan" then
          if not getItemAttribute(item.uid, "hands") then
             doSetItemAttribute(item.uid, "hands", 0)
          end
          local hands = getItemAttribute(item.uid, "hands")
          doSetCreatureOutfit(pk, {lookType = hitmonchans[pokemon][hands].out}, -1)
       end
    end
	-------------------------------------------------------------------------
    ---------movement magmar, jynx-------------
    if EFFECTS[getCreatureName(pk)] then     
       markPosEff(pk, getThingPos(pk))
       sendMovementEffect(pk, EFFECTS[getCreatureName(pk)], getThingPos(pk))   
    end
    --------------------------------------------------------------------------  

	if getCreatureName(pk) == "Ditto" then

		local left = getItemAttribute(item.uid, "transLeft")
		local name = getItemAttribute(item.uid, "transName")

		if left and left > 0 then
			setPlayerStorageValue(pk, 1010, name)
			doSetCreatureOutfit(pk, {lookType = getItemAttribute(item.uid, "transOutfit")}, -1)
			addEvent(deTransform, left * 1000, pk, getItemAttribute(item.uid, "transTurn"))
			doItemSetAttribute(item.uid, "transBegin", os.clock())
		else
			setPlayerStorageValue(pk, 1010, "Ditto")
		end
	end

	if isGhostPokemon(pk) then doTeleportThing(pk, getPosByDir(getThingPos(cid), math.random(0, 7)), false) end

	doCreatureSetLookDir(pk, 2)

	adjustStatus(pk, item.uid, true, true, true)
	doAddPokemonInOwnList(cid, pokemon)

	doTransformItem(item.uid, item.itemid+1)

	local pokename = getPokeName(pk) --alterado v1.7

	local mgo = gobackmsgs[math.random(1, #gobackmsgs)].go:gsub("doka", pokename)
	doCreatureSay(cid, mgo, TALKTYPE_ORANGE_1)

	doSendMagicEffect(getCreaturePosition(pk), effect)

    unLock(item.uid) --alterado v1.8

	if useKpdoDlls then
		doUpdateMoves(cid)
	end
end

function isPosEqualPos(pos1, pos2, checkstackpos)
	if pos1.x ~= pos2.x or pos1.y ~= pos2.y and pos1.z ~= pos2.z then
	return false
	end
	if checkstackpos and pos1.stackpos and pos2.stackpos and pos1.stackpos ~= pos2.stackpos then
	return false
	end
return true
end

function getRandomGenderByName(name)
local rate = newpokedex[name]
	if not rate then return 0 end
	rate = rate.gender
	if rate == 0 then
		gender = 3
	elseif rate == 1000 then
		gender = 4
	elseif rate == -1 then
		gender = 0
	elseif math.random(1, 1000) <= rate then
		gender = 4
	else
		gender = 3
	end
return gender
end

function getRecorderPlayer(pos, cid)
	local ret = 0
	if cid and isPosEqual(getThingPos(cid), pos) then   --alterado v1.9
	   return cid
	end
	local s = {}
	s.x = pos.x
	s.y = pos.y
	s.z = pos.z
		for a = 0, 255 do
			s.stackpos = a
			local b = getTileThingByPos(s).uid
			if b > 1 and isPlayer(b) and getCreatureOutfit(b).lookType ~= 814 then
				ret = b
			end
		end
return ret
end

function getRecorderCreature(pos, cid)
	local ret = 0
	if cid and isPosEqual(getThingPos(cid), pos) then   --alterado v1.9
	   return cid
	end
	local s = {}
	s.x = pos.x
	s.y = pos.y
	s.z = pos.z
		for a = 0, 255 do
			s.stackpos = a
			local b = getTileThingByPos(s).uid
			if b > 1 and isCreature(b) and getCreatureOutfit(b).lookType ~= 814 then
				ret = b
			end
		end
return ret
end

function doCreatureSetOutfit(cid, outfit, time)
	doSetCreatureOutfit(cid, outfit, time)
end

function doMagicalFlower(cid, away)
	if not isCreature(cid) then return true end
	for x = -3, 3 do
		for y = -3, 3 do
		local a = getThingPos(cid)
		a.x = a.x + x
		a.y = a.y + y
			if away then
				doSendDistanceShoot(a, getThingPos(cid), 21)
			else
				doSendDistanceShoot(getThingPos(cid), a, 21)
			end
		end
	end
end		

function isItemPokeball(item)         --alterado v1.9 \/
if not item then return false end
for a, b in pairs (pokeballs) do
	if isInArray(b.all, item) then return true end
	if item >= 12861 and item <= 13781 then
	return true
	end
	if item >= 13797 and item <= 13823 then
	return true
	end
        if item >= 10975 and item <= 10977 then
        return true
	end
	if item >= 13836 and item <= 13850 then
	return true
	end
	if item >= 13851 and item <= 13856 then
	return true
	end
	if item >= 13859 and item <= 13861 then
	return true
	end
	if item >= 13902 and item <= 13904 then
	return true
	end
	if item >= 13919 and item <= 13930 then
	return true
	end
end
return false
end

function isPokeball(item)
if not item then return false end
for a, b in pairs (pokeballs) do
	if isInArray(b.all, item) then return true end
	if item >= 12861 and item <= 13781 then
	return true
	end
	if item >= 13797 and item <= 13823 then
	return true
	end
        if item >= 10975 and item <= 10977 then
        return true
	end
	if item >= 13836 and item <= 13856 then
	return true
	end
end
return false
end
function getPokeballType(id)
	for a, b in pairs (pokeballs) do
		if isInArray(b.all, id) then
			return a
		end
	end
return "none"
end

randomdiagonaldir = {
[NORTHEAST] = {NORTH, EAST},
[SOUTHEAST] = {SOUTH, EAST},
[NORTHWEST] = {NORTH, WEST},
[SOUTHWEST] = {SOUTH, WEST}}

function doFaceOpposite(cid)
local a = getCreatureLookDir(cid)
local d = {
[NORTH] = SOUTH,
[SOUTH] = NORTH,
[EAST] = WEST,
[WEST] = EAST,
[NORTHEAST] = SOUTHWEST,
[NORTHWEST] = SOUTHEAST,
[SOUTHEAST] = NORTHWEST,
[SOUTHWEST] = NORTHEAST}
doCreatureSetLookDir(cid, d[a])
end

function doFaceRandom(cid)
local a = getCreatureLookDir(cid)
local d = {
[NORTH] = {SOUTH, WEST, EAST},
[SOUTH] = {NORTH, WEST, EAST},
[WEST] = {SOUTH, NORTH, EAST},
[EAST] = {SOUTH, WEST, NORTH}}
doChangeSpeed(cid, 1)
doCreatureSetLookDir(cid, d[a][math.random(1, 3)])
doChangeSpeed(cid, -1)
end

function getFaceOpposite(dir)
local d = {
[NORTH] = SOUTH,
[SOUTH] = NORTH,
[EAST] = WEST,
[WEST] = EAST,
[NORTHEAST] = SOUTHWEST,
[NORTHWEST] = SOUTHEAST,
[SOUTHEAST] = NORTHWEST,
[SOUTHWEST] = NORTHEAST}
return d[dir]
end

function getResistance(cid, combat)
	if isPlayer(cid) then return false end
local poketype1 = pokes[getCreatureName(cid)].type
local poketype2 = pokes[getCreatureName(cid)].type2
local multiplier = 1
	if effectiveness[combat].super and isInArray(effectiveness[combat].super, poketype1) then
		multiplier = multiplier * 2
	end
	if poketype2 and effectiveness[combat].super and isInArray(effectiveness[combat].super, poketype2) then
		multiplier = multiplier * 2
	end
	if effectiveness[combat].weak and isInArray(effectiveness[combat].weak, poketype1) then
		multiplier = multiplier * 0.5
	end
	if poketype2 and effectiveness[combat].weak and isInArray(effectiveness[combat].weak, poketype2) then
		multiplier = multiplier * 0.5
	end
	if effectiveness[combat].non and isInArray(effectiveness[combat].non, poketype1) then
		multiplier = multiplier * 0
	end
	if poketype2 and effectiveness[combat].non and isInArray(effectiveness[combat].non, poketype2) then
		multiplier = multiplier * 0
	end

	if multiplier == 0.25 then
		multiplier = 0.5
	elseif multiplier == 4 then
		multiplier = 2
	end

return multiplier
end

function getCreatureDirectionToTarget(cid, target, ranged)
	if not isCreature(cid) then return true end
	if not isCreature(target) then return getCreatureLookDir(cid) end
	local dirs = {
	[NORTHEAST] = {NORTH, EAST},
	[SOUTHEAST] = {SOUTH, EAST},
	[NORTHWEST] = {NORTH, WEST},
	[SOUTHWEST] = {SOUTH, WEST}}
	local x = getDirectionTo(getThingPos(cid), getThingPos(target), false)
		if x <= 3 then return x
		else
			local xdistance = math.abs(getThingPos(cid).x - getThingPos(target).x)
			local ydistance = math.abs(getThingPos(cid).y - getThingPos(target).y)
				if xdistance > ydistance then
					return dirs[x][2]
				elseif ydistance > xdistance then
					return dirs[x][1]
				elseif isInArray(dirs[x], getCreatureLookDir(cid)) then
					return getCreatureLookDir(cid)
				else
					return dirs[x][math.random(1, 2)]
				end
		end
end

function getSomeoneDescription(cid)
	if isPlayer(cid) then return getPlayerNameDescription(cid) end
return getMonsterInfo(getCreatureName(cid)).description
end
	

function isGhostPokemon(cid)
	if not isCreature(cid) then return false end
	local ghosts = {"Gastly", "Haunter", "Gengar", "Shiny Gengar", "Misdreavus", "Shiny Abra"}
return isInArray(ghosts, getCreatureName(cid))
end

function updateGhostWalk(cid)
	if not isCreature(cid) then return false end
	local pos = getThingPos(cid)
	pos.x = pos.x + 1
	pos.y = pos.y + 1
	local ret = getThingPos(cid)
	doTeleportThing(cid, pos, false)
	doTeleportThing(cid, ret, false)
return true
end

function doRemoveElementFromTable(t, e)
	local ret = {}
	for a = 1, #t do
		if t[a] ~= e then
		table.insert(ret, t[a])
		end
	end
return ret
end

function doFaceCreature(sid, pos)
if not isCreature(sid) then return true end
	if getThingPos(sid).x == pos.x and getThingPos(sid).y == pos.y then return true end
	local ret = 0

	local ld = getCreatureLookDir(sid)
	local dir = getDirectionTo(getThingPos(sid), pos)
	local al = {
	[NORTHEAST] = {NORTH, EAST},
	[NORTHWEST] = {NORTH, WEST},
	[SOUTHEAST] = {SOUTH, EAST},
	[SOUTHWEST] = {SOUTH, WEST}}

	if dir >= 4 and isInArray(al[dir], ld) then return true end

	doChangeSpeed(sid, 1)
		if dir == 4 then
			ret = math.random(2, 3)
		elseif dir == 5 then
			ret = math.random(1, 2)
		elseif dir == 6 then
			local dirs = {0, 3}
			ret = dirs[math.random(1, 2)]
		elseif dir == 7 then
			ret = math.random(0, 1)
		else
			ret = getDirectionTo(getThingPos(sid), pos)
		end
doCreatureSetLookDir(sid, ret)
doChangeSpeed(sid, -1)
return true
end

function doCreatureAddCondition(cid, condition)
if not isCreature(cid) then return true end
doAddCondition(cid, condition)
end

function doCreatureRemoveCondition(cid, condition)
if not isCreature(cid) then return true end
doRemoveCondition(cid, condition)
end

function setCD(item, tipo, tempo)

	if not tempo or not tonumber(tempo) then
		doItemEraseAttribute(item, tipo)
	return true
	end

	doItemSetAttribute(item, tipo, "cd:"..(tempo + os.time()).."")
return tempo + os.time()
end

function getCD(item, tipo, limite)

	if not getItemAttribute(item, tipo) then
	return 0
	end

	local string = getItemAttribute(item, tipo):gsub("cd:", "")
	local number = tonumber(string) - os.time()

	if number <= 0 then
	return 0
	end

	if limite and limite < number then
		return 0
	end

return number
end

function doSendMoveEffect(cid, target, effect)
if not isCreature(cid) or not isCreature(target) then return true end
doSendDistanceShoot(getThingPos(cid), getThingPos(target), effect)
return true
end

function doSetItemActionId(uid, actionid)
doItemSetAttribute(uid, "aid", actionid)
return true
end

function threeNumbers(number)
	if number <= 9 then
	return "00"..number..""
	elseif number <= 99 then
	return "0"..number..""
	end
return ""..number..""
end

function isBr(cid)
if getPlayerStorageValue(cid, 105505) ~= -1 then
return true
end
return false
end

function isBeingUsed(ball)            
if not ball then return false end
for a, b in pairs (pokeballs) do           --alterado v1.9
    if b.use == ball then return true end
end
return false
end

function doRemoveTile(pos)-- Script by mock
pos.stackpos = 0
local sqm = getTileThingByPos(pos)
doRemoveItem(sqm.uid,1)
end

function hasSqm(pos)
pos.stackpos = 0
local f = getTileThingByPos(pos)
if f.itemid ~= 0 and f.itemid ~= 1 then
return true
end
return false
end

function getPosDirs(p, dir) -- By MatheusMkalo
return dir == 1 and {x=p.x-1, y=p.y, z=p.z} or dir == 2 and {x=p.x-1, y=p.y+1, z=p.z} or dir == 3 and {x=p.x, y=p.y+1, z=p.z} or dir == 4 and {x=p.x+1, y=p.y+1, z=p.z} or dir == 5 and {x=p.x+1, y=p.y, z=p.z} or dir == 6 and {x=p.x+1, y=p.y-1, z=p.z} or dir == 7 and {x=p.x, y=p.y-1, z=p.z} or dir == 8 and {x=p.x-1, y=p.y-1, z=p.z}
end

function canWalkOnPos(pos, creature, pz, water, sqm, proj)
if not pos then return false end
if not pos.x then return false end
if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid <= 1 and sqm then return false end
if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid == 919 then return false end
if isInArray({4820, 4821, 4822, 4823, 4824, 4825}, getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid) and water then return false end
if getTopCreature(pos).uid > 0 and creature then return false end
if getTileInfo(pos).protection and pz then return false end
    local n = not proj and 3 or 2                                    --alterado v1.6
    for i = 0, 255 do
        pos.stackpos = i                           
        local tile = getTileThingByPos(pos)        
        if tile.itemid ~= 0 and i ~= 253 and not isCreature(tile.uid) then     --edited
            if hasProperty(tile.uid, n) or hasProperty(tile.uid, 7) then
                return false
            end
        end
    end   
return true
end

function canWalkOnPos2(pos, creature, pz, water, sqm, proj)     --alterado v1.6
if not pos then return false end
if not pos.x then return false end
if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid <= 1 and sqm then return false end
if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid == 919 then return false end
if isInArray({4820, 4821, 4822, 4823, 4824, 4825}, getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid) and water then return false end
if getTopCreature(pos).uid > 0 and creature then return false end
if getTileInfo(pos).protection and pz then return false end
    --[[local n = not proj and 3 or 2
    for i = 0, 255 do
        pos.stackpos = i                           --edited pra retirar um bug.. ;x
        local tile = getTileThingByPos(pos)        
        if tile.itemid ~= 0 and i ~= 253 and not isCreature(tile.uid) then     --edited
            if hasProperty(tile.uid, n) or hasProperty(tile.uid, 7) then
                return false
            end
        end
    end ]]  
return true
end

function getFreeTile(pos, cid)
	if canWalkOnPos(pos, true, false, true, true, false) then
		return pos
	end
	local positions = {}
	for a = 0, 7 do
		if canWalkOnPos(getPosByDir(pos, a), true, false, true, true, false) then
		table.insert(positions, pos)
		end
	end
	if #positions >= 1 then
		if isCreature(cid) then
			local range = 1000
			local ret = getThingPos(cid)
			for b = 1, #positions do
				if getDistanceBetween(getThingPos(cid), positions[b]) < range then
					ret = positions[b]
					range = getDistanceBetween(getThingPos(cid), positions[b])
				end
			end
			return ret
		else
			return positions[math.random(#positions)]
		end
	end
return getThingPos(cid)
end

function isWalkable(pos, creature, proj, pz, water)-- by Nord
    if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid == 0 then return false end
    if isWater(getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid) and water then return false end
    if getTopCreature(pos).uid > 0 and creature then return false end
    if getTileInfo(pos).protection and pz then return false, true end
    local n = not proj and 3 or 2
    for i = 0, 255 do
        pos.stackpos = i
        local tile = getTileThingByPos(pos)
        if tile.itemid ~= 0 and not isCreature(tile.uid) then
            if hasProperty(tile.uid, n) or hasProperty(tile.uid, 7) then
                return false
            end
        end
    end
    return true
end


function isPlayerSummon(cid, uid)
return getCreatureMaster(uid) == cid  --alterado v1.9
end

function getItemsInContainerById(container, itemid) -- Function By Kydrai
local items = {}
if isContainer(container) and getContainerSize(container) > 0 then
   for slot=0, (getContainerSize(container)-1) do
       local item = getContainerItem(container, slot)
       if isContainer(item.uid) then
          local itemsbag = getItemsInContainerById(item.uid, itemid)
          for i=0, #itemsbag do
              table.insert(items, itemsbag[i])
          end
       else
          if itemid == item.itemid then
             table.insert(items, item.uid)
          end
       end
   end
end
return items
end

function getPokeballsOnInContainer(container) -- Function By Kydrai
	if not isContainer(container) then return {} end
	local items = {}
	if isContainer(container) and getContainerSize(container) > 0 then
		for slot=0, (getContainerSize(container)-1) do
			local item = getContainerItem(container, slot)
				if isContainer(item.uid) then
					local itemsbag = getPokeballsOnInContainer(item.uid)
					for i=0, #itemsbag do
						table.insert(items, itemsbag[i])
					end
				elseif isPokeballOn(item) then
					table.insert(items, item.uid)
				end
		end
	end
return items
end

function getPokeballsInContainer(container) -- Function By Kydrai
	if not isContainer(container) then return {} end
	local items = {}
	if isContainer(container) and getContainerSize(container) > 0 then
		for slot=0, (getContainerSize(container)-1) do
			local item = getContainerItem(container, slot)
				if isContainer(item.uid) then
					local itemsbag = getPokeballsInContainer(item.uid)
					for i=0, #itemsbag do
						table.insert(items, itemsbag[i])
					end
				elseif isPokeball(item.itemid) then
					table.insert(items, item.uid)
				end
		end
	end
return items
end

function getItensUniquesInContainer(container)    --alterado v1.6
if not isContainer(container) then return {} end
local items = {}
if isContainer(container) and getContainerSize(container) > 0 then
   for slot=0, (getContainerSize(container)-1) do
       local item = getContainerItem(container, slot)
       if isContainer(item.uid) then
          local itemsbag = getItensUniquesInContainer(item.uid)
          for i=0, #itemsbag do
	          table.insert(items, itemsbag[i])
          end
       elseif getItemAttribute(item.uid, "unique") then
          table.insert(items, item)
       end
   end
end
return items
end

function hasSpaceInContainer(container)                --alterado v1.6
if not isContainer(container) then return false end
if getContainerSize(container) < getContainerCap(container) then return true end

for slot = 0, (getContainerSize(container)-1) do
    local item = getContainerItem(container, slot)
    if isContainer(item.uid) then
       if hasSpaceInContainer(item.uid) then
          return true
       end
    end
end
return false
end

function doPlayerAddItemStacking(cid, itemid, quant) -- by mkalo
local item = getItemsInContainerById(getPlayerSlotItem(cid, 3).uid, itemid)
local piles = 0
if #item > 0 then
   for i,x in pairs(item) do
       if getThing(x).type < 100 then
          local it = getThing(x)
          doTransformItem(it.uid, itemid, it.type+quant)
          if it.type+quant > 100 then
             doPlayerAddItem(cid, itemid, it.type+quant-100)
          end
       else
          piles = piles+1
       end
   end
else
   return doPlayerAddItem(cid, itemid, quant)
end
if piles == #item then
   doPlayerAddItem(cid, itemid, quant)
end
end

function getPlayerInArea(fromPos, toPos) -- by jhon992
local online = getPlayersOnline()
local players = {}
for i=1, #online do
    if isInArea(getPlayerPosition(online[i]), fromPos, toPos) then
        players[#players+1] = online[i]
    end
end
return players
end
function isPlayerOnline(uid)
	return isInArray(getPlayersOnline(), uid)
end

function doRegenerateWithY(cid, sid)
if isPlayerOnline(cid) then
local ball = getPlayerSlotItem(cid, 8) or getPlayerSlotItem(getCreatureMaster(cid), 8)
local Tiers = {
[1] = {bonus = Regen1},
[2] = {bonus = Regen2},
[3] = {bonus = Regen3},
[4] = {bonus = Regen4},
[5] = {bonus = Regen5},
[6] = {bonus = Regen6},
[7] = {bonus = Regen7},
}
if isPlayer(cid) and #getCreatureSummons(cid) > 0 then
local Tier = getItemAttribute(ball.uid, "heldy")
if Tier and Tier > 0 and Tier < 8 then
if not getCreatureCondition(cid, CONDITION_INFIGHT) then
if getCreatureHealth(sid) < getCreatureMaxHealth(sid) then
addEvent(function() doCreatureAddHealth(sid,Tiers[Tier].bonus) doSendAnimatedText(getThingPos(sid), "+ "..Tiers[Tier].bonus, 30) end, 0)
end
addEvent(doRegenerateWithY, 1000, cid, sid)  
else
addEvent(doRegenerateWithY, 1000, cid, sid)
end
end   
end
end 
end

function doCureWithY(cid, sid)
if isPlayerOnline(cid) then
local ball = getPlayerSlotItem(cid, 8) or getPlayerSlotItem(getCreatureMaster(cid), 8)
local Tiers = {
[8] = {chance = Cure1},
[9] = {chance = Cure2},
[10] = {chance = Cure3},
[11] = {chance = Cure4},
[12] = {chance = Cure5},
[13] = {chance = Cure6},
[14] = {chance = Cure7},
}
local Tier = getItemAttribute(ball.uid, "heldy")
if isPlayer(cid) and #getCreatureSummons(cid) > 0  and Tier then
if Tier > 7 and Tier < 15 then
if math.random(1,100) <= Tiers[Tier].chance then
doCureStatus(sid, "all")
doSendMagicEffect(getThingPosWithDebug(sid), 14)
end
addEvent(doCureWithY, 1000, cid, sid)  
end
end
end   
end
       