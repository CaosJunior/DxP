function onCastSpell(cid, var) --fixed by Ricardoroxx to DXP

	if isSummon(cid) then return true end
	
	local team = {
	["Xatu"] = "XatuTeam",
	["Shiny Xatu"] = "Shiny XatuTeam",
	["Yanma"] = "YanmaTeam",	
	}
	
	local function sleep(n)
		local t = os.clock()
		while os.clock() - t <= n do			
		end
	end
		
		
	function adjustLife(cid, health)
		if isCreature(cid) then		   
		   doCreatureAddHealth(cid,  getCreatureMaxHealth(cid))
		   doCreatureAddHealth(cid,  -(math.abs(health)))
		end
	end   
	
	function setStorage(cid, storage)
	if isCreature(cid) then
	   if getPlayerStorageValue(cid, storage) >= 1 then
		  setPlayerStorageValue(cid, storage, 0)
	   end
	end
	end

	local function RemoveTeam(cid)
	if isCreature(cid) then
	  local p = getThingPos(cid)
	  doSendMagicEffect(p, 211)
	  doRemoveCreature(cid)
	end
	end
   
   --local function setGender(cid, gender)  Inativado by Ricardorox (o server n tem função gender) mas se for preciso ativar algum dia está ai.
   --      if not isCreature(cid) then return true end
   --      doCreatureSetSkullType(cid, gender)
   --end  

         
   if getPlayerStorageValue(cid, 637500) >= 1 or getPlayerStorageValue(cid, 637501) >= 1 then
   return true
   end  
	
	local name = getCreatureName(cid)
	name = doCorrectString(name)	
    local master = cid
    local pos = getThingPos(cid)                  
    local time = 6
    local life = getCreatureHealth(cid)
    local maxLife = getCreatureMaxHealth(cid)
    --local gender = getPokemonGender(cid) Inativo by Ricardorox
    local random = math.random(0, 5)
    --local dir = getCreatureLookDir(cid)
	local num = (name == "Xatu") and 4 or 3 or 5
	local pk = {}
	--local teste = getCreatureSummons(master)	
	doCreatureSay(cid, "Double Team!", TALKTYPE_MONSTER)	
    ---------
    
    ---------
-----------------------------------FIXED-BY-RICARDOROXX--------------------------------------------------	
if team[name] then

  pk[1] = cid
  doSendMagicEffect(getThingPos(pk[1]), 211) 
  doDisapear(pk[1])  
  doTeleportThing(pk[1], {x=random, y=random, z=10}, false)
  addEvent(doTeleportThing, random, pk[1], getClosestFreeTile(pk[1], pos), false)   
  doAppear(pk[1])
  doSendMagicEffect(getThingPos(pk[1]), 211)
  
  --for i = 2, num do
	   pk[num] = doCreateMonsterNick(pk[1], name, retireShinyName(name), getThingPos(pk[1]), false)
	   --??--	   
       doTeleportThing(pk[num], getClosestFreeTile(pk[num], pos), false)	   
	   addEvent(adjustLife, 150, pk[num], life-maxLife)
	   setPlayerStorageValue(pk[num], 510, name)
       doSendMagicEffect(getThingPos(pk[num]), 211)
   --end   
   setPlayerStorageValue(pk[1], 637501, 1)
   addEvent(setStorage, time * 1000, pk[1], 637501)
   ---
   setPlayerStorageValue(pk[2], 637500, 1)
   addEvent(RemoveTeam, time * 1000, pk[2])
   ---
   setPlayerStorageValue(pk[3], 637500, 1)
   addEvent(RemoveTeam, time * 1000, pk[3])   
   ---
   ---
    if getPlayerStorageValue(cid, 9658783) >= 1 then          --\Ricardoroxx/
       doBuff2(pk, getPlayerStorageValue(cid, 36847), 0, false, "Future Sight", true) --Função alterada de doBuffSyst
       doBuff2(pk, getPlayerStorageValue(cid, 36847), 0, false, "Psychic Sight", true) -- para doBuff2 (creio eu que seja mais atual)
    end
   if name == "Xatu" then
     setPlayerStorageValue(pk[4], 637500, 1)
     addEvent(RemoveTeam, time * 1000, pk[4])
   end
end
	
---------------------------------------------------/fixed----------------------------------	
	
--	pokeSourceCode = doCreateMonsterNick(master, getCreatureName(cid), retireTeamName(retireShinyName(s[getCreatureName(cid)])), getThingPos(cid), false)
--    local pk = getCreatureSummons(master)[1]
  --addEvent(setGender, 20, cid, gender) inativado by Ricardorox
  --setCreatureMaxHealth(pk, maxLife)
--	local health = (math.abs(life-maxLife))
--	doCreatureAddHealth(pk, health)
    ---------
--    doTeleportThing(pk, getClosestFreeTile(pk, pos), false)
--    doTeleportThing(cid, getClosestFreeTile(cid, pos), false)
--    doCreatureSetLookDir(pk, dir)
--    doCreatureSetLookDir(cid, dir)
--    doSendMagicEffect(getThingPos(pk), 211)
--    doSendMagicEffect(getThingPos(cid), 211)
--    if getPlayerStorageValue(cid, 9658783) >= 1 then          --\Ricardoroxx/
--       doBuff2(pk, getPlayerStorageValue(cid, 36847), 0, false, "Future Sight", true) --Função alterada de doBuffSyst
--       doBuff2(pk, getPlayerStorageValue(cid, 36847), 0, false, "Psychic Sight", true) -- para doBuff2 (creio eu que seja mais atual)
--    end
    --------
--    setPlayerStorageValue(pk, 637500, 1)
--    setPlayerStorageValue(master, 637501, 1)
--    addEvent(RemoveTeam, time*1000, pk)
--    addEvent(setPlayerStorageValue, time*1000, master, 637501, -1)

return true
end