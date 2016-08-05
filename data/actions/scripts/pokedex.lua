local function checkDex(cid)
local unlock = 0
	for i = 1, #oldpokedex do
		if getPlayerInfoAboutPokemon(cid, oldpokedex[i][1]).dex then
		   unlock = unlock + 1
		end
	end
return unlock
end

local rate = 50
local rewards = {
[10] = {{2160, 1}, {11638, 1}, {12344, 5}},
[20] = {{2160, 1}, {11638, 1}, {12344, 5}},
[30] = {{2160, 1}, {11638, 1}, {12344, 5}},
[40] = {{2160, 1}, {11639, 1}, {12344, 10}},
[50] = {{2160, 2}, {11639, 1}, {12344, 10}},
[60] = {{2160, 2}, {11639, 1}, {12344, 15}},
[70] = {{2160, 2}, {11640, 1}, {12344, 15}},
[80] = {{2160, 2}, {11640, 1}, {12344, 20}},
[90] = {{2160, 3}, {11640, 1}, {12344, 20}},
[100] = {{2160, 3}, {11640, 1}, {12344, 25}},
[120] = {{2160, 3}, {11640, 1}, {12344, 30}},
[150] = {{2160, 3}, {11641, 1}, {12344, 30}},
[180] = {{2160, 3}, {11641, 1}, {12344, 30}},
[210] = {{2160, 5}, {11641, 1}, {12344, 30}},
[250] = {{2160, 5}, {11641, 1}, {12344, 30}},
}
local sto = 63999

function onUse(cid, item, fromPos, item2, toPos)
 
if not isCreature(item2.uid) or isWatchingTv(cid) then
return true
end

local poke = getCreatureName(item2.uid)

	if isMonster(item2.uid) then
	local name = doCorrectString(getCreatureName(item2.uid))
       local this = newpokedex[name]
	   local myball = 0
	   if isSummon(item2.uid) then
	      myball = getPlayerSlotItem(getCreatureMaster(item2.uid), 8)
       end
       if not getPlayerInfoAboutPokemon(cid, poke).dex then
	      local exp = this.level * rate
          doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have unlocked ".. getCreatureName(item2.uid).." in your pokedex!")
	      doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have gained "..exp.." experience points.")
          doSendMagicEffect(getThingPos(cid), 210)
          doPlayerAddExperience(cid, exp)
          doAddPokemonInDexList(cid, poke)
       else
		  local name = doCorrectString(getCreatureName(item2.uid))
          doShowPokedexRegistration(cid, name, myball, item2)
       end
	return true
	end

if not isPlayer(item2.uid) then return true end

	local kanto = 0
	local johto = 0
                                    --alterado v1.7 \/\/
	for i = 1, #oldpokedex do
		if getPlayerInfoAboutPokemon(item2.uid, oldpokedex[i][1]).dex then
		   if i <= 151 then
              kanto = kanto+1
           elseif i >= 209 then
              johto = johto+1
           end
		end
	end                                                      --alterado v1.6

	local player = getRecorderPlayer(toPos, cid)

	if cid == player then
	    doPlayerSendTextMessage(cid, 27, "You has unlocked "..kanto.." kanto's and "..johto.." johto's pokémons until now.") 
        doPlayerSetVocation(cid, 9) --alterado v1.6
        openChannelDialog(cid)
	end

return true
end