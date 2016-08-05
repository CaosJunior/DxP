--[[Storages
22545 = player q entra na arena              (normal)
22546 = monstros na arena                    (normal)
22547 = waves                                (global)
22548 = qnts monstros tem na arena           (global)                     
22549 = nome dos players q vao pra arena     (global)
22550 = qnts players tem na arena            (global)
22551 = waves para cada player               (normal)
]]
------------------------------------------------------------------------------------------------------------------
function doWave(start)                                                            --alterado v1.8 \/
if getGlobalStorageValue(22550) >= 1 and getGlobalStorageValue(22548) <= 0 then
   if start then
      doBroadcastMessage("The Golden Arena are started!")    
   end
   local wave = getGlobalStorageValue(22547) <= 0 and 1 or getGlobalStorageValue(22547)
   local players = creaturesInGolden(GoldenUpper, GoldenLower, true)
   for i = 1, #posisGolden do
       if wavesGolden[wave][i] ~= "" then                         
          local monster = doSummonCreature(wavesGolden[wave][i], posisGolden[i])   
          doSetMonsterPassive(monster)               
          doWildAttackPlayer(monster, players[math.random(#players)])         
          doSendMagicEffect(getThingPos(monster), 21)
          setPlayerStorageValue(monster, 22546, 1)
          local sto = getGlobalStorageValue(22548) <= 0 and 0 or getGlobalStorageValue(22548)
          setGlobalStorageValue(22548, sto+1)
       end
   end 
   for a = 1, #players do
       setPlayerStorageValue(players[a], 22551, wave) 
   end   
   setGlobalStorageValue(22547, wave+1) 
else
    if start then                                                    
       doBroadcastMessage("Golden Arena não começou por não ter nenhum player registrado!")
       return true
    end
end
end
------------------------------------------------------------------------------------------------------------------
function puxaParticipantes()
local s = ""
if getGlobalStorageValue(22549) ~= -1 then
   s = string.explode(getGlobalStorageValue(22549), ",")
end

if type(s) ~= 'table' or s == "" then
return true                        --alterado v1.8 \/
end

for i = 1, #s do
    local sid = getPlayerByName(s[i])
    if isCreature(sid) then
       doTeleportThing(sid, getClosestFreeTile(sid, posGolden))  --pos pra onde os players vao ser teleportados quando a golden começar!
       doSendMagicEffect(getThingPos(sid), 21)
       setPlayerStorageValue(sid, 22545, 1)
       setGlobalStorageValue(22550, (getGlobalStorageValue(22550) <= 0 and 0 or getGlobalStorageValue(22550))+1)
    end
end
setGlobalStorageValue(22549, -1)
end
------------------------------------------------------------------------------------------------------------------
function endGoldenArena(onStart)
for sto = 22547, 22550 do
    setGlobalStorageValue(sto, -1)
end
addEvent(creaturesInGolden, 150, GoldenUpper, GoldenLower, false, true, true)
if not onStart then
   doBroadcastMessage("The Golden Arena are finished!")
end
end
------------------------------------------------------------------------------------------------------------------
function creaturesInGolden(upper, lower, player, remove, clean) -- function by Vodkart and edited by Slicer
local players = {}   
   for x = upper.x - 1, lower.x + 1 do
       for y = upper.y - 1, lower.y + 1 do                                         
           local pos = {x = x, y = y, z = upper.z}
           local m = getTopCreature(pos).uid
           if remove ~= false and m ~= 0 and ehMonstro(m) then doRemoveCreature(m) end
           if clean ~= false and hasTile(pos) then doCleanTile(pos, false) end  --alterado v1.8
           if player ~= false and m ~= 0 and isPlayer(m) and getPlayerStorageValue(m, 22545) == 1 then table.insert(players, m) end 
       end
   end
   if player ~= false then return players end
end
------------------------------------------------------------------------------------------------------------------
function installRankGolden()                                                          --alterado v1.8 \/
if db.getResult("SELECT `Golden` FROM `players`;"):getID() ~= -1 then return true end
    
   if db.executeQuery("ALTER TABLE `players` ADD `Golden` integer not null default 0;") then
      if db.executeQuery("UPDATE `players` SET `Golden` = '10000' WHERE `id` = 1;") then  
         print("Table 'Golden' added with success!")
      end
   end
return true
end
------------------------------------------------------------------------------------------------------------------    
function getPlayerRecordWaves(cid)
if not isCreature(cid) then return 0 end
local pid = getPlayerGUID(cid)
local query = db.getResult("SELECT `Golden` FROM `players` WHERE `id` = "..pid..";")

if query:getID() == -1 then
return 0
end
return query:getDataInt("Golden")
end
------------------------------------------------------------------------------------------------------------------
function setPlayerRecordWaves(cid)             
if not isCreature(cid) then return false end
local waves = getPlayerStorageValue(cid, 22551)
local acc = getPlayerGUID(cid)
if waves > getPlayerRecordWaves(cid) then
   if db.executeQuery("UPDATE `players` SET `Golden` = '"..waves.."' WHERE `id` = "..acc..";") then
      setPlayerStorageValue(cid, 22551, -1)
      return true
   end
end
return false
end
------------------------------------------------------------------------------------------------------------------
function getRankGolden()                                                                      --alterado v1.9 \/
local query = db.getResult("SELECT `id`, `Golden` FROM `players` ORDER BY `Golden` DESC;")
local str = {}
table.insert(str, "Rank of the Golden Arena:\n\n")

if query:getID() ~= -1 then
   for i = 1, 10 do
      if not(query:next()) or query:getDataInt("Golden") == 0 then
         table.insert(str, i.."° None - 0 wave.\n")
      else
         local s = tonumber(query:getDataInt("Golden")) > 1 and "s" or "" 
         table.insert(str, i.."° "..getPlayerNameByGUID(query:getDataString("id")).." - "..query:getDataInt("Golden").." wave"..s..".\n")
      end
   end 
query:free()
end
return table.concat(str)
end
------------------------------------------------------------------------------------------------------------------