local focus = 0
local talk_start = 0
local conv = 0
local cost = 0
local pname = ""
local baseprice = 0
local pokePrice = {
["Charmander"] = 3000,
["Charmeleon"] = 8000, 
["Charizard"] = 18000,
["Bulbasaur"] =  3000,
["Ivysaur"] =  8000,
["Venusaur"] =  18000,
["Squirtle"] =  3000,
["Wartortle"] =  8000,
["Blastoise"] =  18000,
["Caterpie"] =  50,
["Metapod"] =  250,
["Butterfree"] =  2000,
["Weedle"] =  50,
["Kakuna"] =  250,
["Beedrill"] =  2000,
["Pidgey"] =  60,
["Pidgeotto"] =  1500,
["Pidgeot"] =  11500,
["Rattata"] =  5,
["Raticate"] =  2000,
["Spearow"] =  100,
["Fearow"] =  5100,
["Ekans"] =  300,
["Arbok"] =  3000,
["Pikachu"] =  8000,
["Raichu"] =  18000,
["Sandshrew"] =  1000,
["Sandslash"] =  11000,
["Nidoran Female"] =  125,
["Nidorina"] =  2250,
["Nidoqueen"] =  12250,
["Nidoran Male"] =  125,
["Nidorino"] =  2250,
["Nidoqueen"] = 12250,
["Clefairy"] =  8000,
["Clefable"] =  18000,
["Vulpix"] =  1000,
["Ninetales"] = 11000,
["Jigglypuff"] =  8000,
["Wigglytuff"] =  18000,
["Zubat"] =  120,
["Golbat"] =  3000,
["Oddish"] =  80,
["Gloom"] =  2250,
["Vileplume"] =  12000,
["Paras"] =  60,
["Parasect"] =  7250, 
["Venonat"] =  1500,
["Venomoth"] =  7250,
["Diglett"] =  200,
["Dugtrio"] =  3000,
["Meowth"] =  300,
["Persian"] =  3000,
["Psyduck"] =  1500,
["Golduck"] =  11500,
["Mankey"] =  300,
["Primeape"] =  7250,
["Growlithe"] =  3500,
["Arcanine"] =  60000,
["Poliwag"] =  80,
["Poliwhirl"] =  3000,
["Poliwrath"] =  13000,
["Abra"] =  800,
["Kadabra"] =  5800,
["Alakazam"] =  16000,
["Machop"] =  2000,
["Machoke"] =  7000,
["Machamp"] =  17000,
["Bellsprout"] =  80,
["Wepinbell"] =  2250,
["Victreebel"] =  12000,
["Tentacool"] =  300,
["Tentacruel"] =  10000,
["Geodude"] =  300,
["Graveler"] =  5000,
["Golem"] =  15000,
["Ponyta"] =  1500,
["Rapidash"] =  6500,
["Slowpoke"] =  400,
["Slowbro"] =  8000,
["Magnemite"] =  400,
["Magneton"] =  5400,
["Farfetch'd"] =  7000,
["Doduo"] =  600,
["Dodrio"] =  5600,
["Seel"] =  2000,
["Dewgong"] = 12000,
["Grimer"] =  300,
["Muk"] =  11000,
["Shellder"] =  200,
["Cloyster"] =  10200,
["Gastly"] =  3000,
["Haunter"] =  8000,
["Gengar"] =  18000,
["Onix"] =  6000,
["Drowzee"] =  1000,
["Hypno"] =  6000,
["Krabby"] =  200,
["Kingler"] =  5200,
["Voltorb"] =  250,
["Electrode"] =  3000,
["Exeggute"] =  200,
["Exeggutor"] =  10000,
["Cubone"] =  1000,
["Marowak"] =  11000,
["Hitmonlee"] =  20000,
["Hitmonchan"] =  20000,
["Lickitung"] =  60000,
["Koffing"] =  300,
["Weezing"] =  3000,
["Rhyhorn"] =  3000,
["Rhydon"] =  13000,
["Chansey"] =  40000,
["Tangela"] =  10000,
["Kangaskhan"] = 120000,
["Horsea"] =  200,
["Seadra"] =  5500,
["Goldeen"] =  200,
["Seaking"] =  3000,
["Staryu"] =  400,
["Starmie"] =  3000,
["Mr. Mime"] =  120000,
["Scyther"] =  120000,
["Jynx"] =  120000,
["Electabuzz"] =  120000,
["Magmar"] =  120000,
["Pinsir"] =  9000,
["Tauros"] =  5000,
["Magikarp"] =  5,
["Gyarados"] =  5000,
["Lapras"] =  120000,
["Ditto"] =  70000,
["Eevee"] =  45000,
["Vaporeon"] =  50000,
["Jolteon"] =  50000,
["Flareon"] =  50000,
["Porygon"] =  60000,
["Omanyte"] =  20000,
["Omastar"] =  75000,
["Kabuto"] =  2000,
["Kabutops"] =  75000,
["Aerodactyl"] =  2000000,
["Snorlax"] =  200000,
["Dratini"] =  15000,
["Dragonair"] =  65000,
["Dragonite"] =  125000,
 
-- Segunda Geração

["Chikorita"] = 3000,
["Bayleef"] = 8000,
["Meganium"] = 18000,
["Cydaquil"] = 3000,
["Quilava"] = 8000,
["Typhlosion"] = 18000,
["Totodile"] = 3000,
["Croconaw"] = 8000,
["Feraligatr"] = 18000,
["Sentret"] = 250,
["Furret"] = 3000,
["Hoothoot"] = 1500,
["Noctowl"] = 11500,
["Ledyba"] = 250,
["Ledian"] = 3000,
["Spinarak"] = 250,
["Ariados"] = 3000,
["Crobat"] = 58000,
["Chinchou"] = 1000,
["Lanturn"] = 6000,
["Pichu"] = 3000,
["Cleffa"] = 3000,
["Igglybuff"] = 3000,
["Togepi"] = 15000,
["Togetic"] = 25000,
["Natu"] = 3000,
["Xatu"] = 130000,
["Mareep"] = 3000,
["Flaaffy"] = 8000,
["Ampharos"] = 18000,
["Bellossom"] = 12000,
["Marill"] = 3000,
["Azumarill"] = 13000,
["Sudowoodo"] = 120000,
["Politoed"] = 8000,
["Hoppip"] = 80,
["Skiploom"] = 2250,
["Jumpluff"] = 12000,
["Aipom"] = 8000,
["Sunkern"] = 50,
["Sunflora"] = 5000,
["Yanma"] = 9000,
["Wooper"] = 2000,
["Quagsire"] = 12000,
["Espeon"] = 50000,
["Umbreon"] = 50000,
["Murkrow"] = 10000,
["Slowking"] = 11000,
["Misdreavus"] = 100000,
["Wobbuffet"] = 200000,
["Girafarig"] = 120000,
["Pineco"] = 300,
["Forretress"] = 10000,
["Dunsparce"] = 3000,
["Gligar"] = 8000,
["Steelix"] = 110000,
["Snubbull"] = 22500,
["Granbull"] = 12500,
["Qwilfish"] = 10000,
["Scizor"] = 220000,
["Shuckle"] = 3500,
["Heracross"] = 120000,
["Sneasel"] = 10000,
["Teddiursa"] = 80000,
["Ursaring"] = 150000,
["Slugma"] = 1000,
["Magcargo"] = 11000,
["Swinub"] = 1000,
["Piloswine"] = 11000,
["Corsola"] = 9000,
["Remoraid"] = 200,
["Octillery"] = 10000,
["Delibird"] = 10000,
["Mantine"] = 120000,
["Skarmory"] = 120000,
["Houndour"] = 35000,
["Houndoom"] = 13500,
["kingdra"] = 70000,
["Phanpy"] = 3000,
["Donphan"] = 13000,
["Porygon2"] = 120000,
["Stantler"] = 10000,
["Tyrogue"] = 150000,
["Hitmontop"] = 50000,
["Smoochum"] = 45000,
["Elikid"] = 45000,
["Magby"] = 45000,
["Miltank"] = 120000,
["Blissey"] = 140000,
["Larvitar"] = 15000,
["Pupitar"] = 65000,
["Electivire"] = 125000,
["Magmortar"] = 125000,
["Tyranitar"] = 125000,
-- shiny --
["Shiny Fearow"] = 1500000,
["Shiny Vileplume"] = 1500000,
["Shiny Golem"] = 1500000,
["Shiny Nidoking"] = 1500000,
["Shiny Hypno"] = 1500000,
["Shiny Vaporeon"] = 1500000,
["Shiny Jolteon"] = 1500000,
["Shiny Flareon"] = 1500000,
["Shiny Hitmontop"] = 1500000,
}
local gastostones = {
[0] = 0,
[1] = 1,
[2] = 2,
[3] = 3,
[4] = 4,
[5] = 6,
[6] = 8,
[7] = 10,
[8] = 12,
[9] = 15,
[10] = 18,
[11] = 21,
[12] = 24,
[13] = 28,
[14] = 32,
[15] = 36,
[16] = 40,
[17] = 45,
[18] = 50,
[19] = 55,
[20] = 60,
[21] = 66,
[22] = 72,
[23] = 78,
[24] = 84,
[25] = 91,
[26] = 98,
[27] = 105,
[28] = 112,
[29] = 120,
[30] = 128,
[31] = 136,
[32] = 144,
[33] = 153,
[34] = 162,
[35] = 171,
[36] = 180,
[37] = 190,
[38] = 200,
[39] = 210,
[40] = 220,
[41] = 231,
[42] = 242,
[43] = 253,
[44] = 264,
[45] = 276,
[46] = 288,
[47] = 300,
[48] = 312,
[49] = 325,
[50] = 338,
}
function sellPokemon(cid, name, price)

	local bp = getPlayerSlotItem(cid, CONST_SLOT_BACKPACK)
    if #getCreatureSummons(cid) >= 1 then
       selfSay("Back your pokemon to do that!")
       focus = 0                                --alterado v1.8
       return true
    end
    local storages = {17000, 63215, 17001, 13008, 5700}   --alterado v1.8
    for s = 1, #storages do
        if getPlayerStorageValue(cid, storages[s]) >= 1 then
           selfSay("You can't do that while is Flying, Riding, Surfing, Diving or mount a bike!") 
           focus = 0 
           return true
        end
    end
    if getPlayerSlotItem(cid, 8).uid ~= 0 then 
	local boosts = getItemAttribute(getPlayerSlotItem(cid, 8).uid, "boost") or 0
		local precocertos = ((gastostones[boosts] * 10) * 100000)
       if string.lower(getItemAttribute(getPlayerSlotItem(cid, 8).uid, "poke")) == string.lower(name) then
          if not getItemAttribute(getPlayerSlotItem(cid, 8).uid, "unique") then  --alterado v1.6
             selfSay("Wow! Thanks for this wonderful "..name.."! Take yours "..price.." dollars. Would you like to sell another pokemon?")
             doPlayerAddMoney(cid, (price * 100) + precocertos)
			 doRemoveItem(getPlayerSlotItem(cid, 8).uid, 1)              --alterado v1.6
             doTransformItem(getPlayerSlotItem(cid, CONST_SLOT_LEGS).uid, 2395)
             return true
          end
       end
    end   
       
	for a, b in pairs(pokeballs) do
		local balls = getItemsInContainerById(bp.uid, b.on)
		for _, ball in pairs (balls) do
			local boost = getItemAttribute(ball, "boost") or 0
	local precocerto = ((gastostones[boost] * 5) * 100000)
			if string.lower(getItemAttribute(ball, "poke")) == string.lower(name) then
				if not getItemAttribute(ball, "unique") then --alterado v1.6
                   selfSay("Wow! Thanks for this wonderful "..getItemAttribute(ball, "poke").."! Take yours "..price.." dollars. Would you like to sell another pokemon?")
				   				   doPlayerAddMoney(cid, (price * 100) + precocerto)
				   doRemoveItem(ball, 1)
	               return true
                end
			end
		end
	end

	selfSay("You don't have a "..name..", make sure it is in your backpack and it is not fainted and it is not in a Unique Ball!")  --alterado v1.6
return false
end

function onCreatureSay(cid, type, msg)

	local msg = string.lower(msg)

	if string.find(msg, "!") or string.find(msg, ",") then
	return true
	end

	if focus == cid then
		talk_start = os.clock()
	end

	if msgcontains(msg, 'hi') and focus == 0 and getDistanceToCreature(cid) <= 3 then
		selfSay('Welcome to my store! I buy pokemons of all species, just tell me the name of the pokemon you want to sell.')
		focus = cid
		conv = 1
		talk_start = os.clock()
		cost = 0
		pname = ""
	return true
	end

	if msgcontains(msg, 'bye') and focus == cid then
		selfSay('See you around then!')
		focus = 0
	return true
	end

	if msgcontains(msg, 'yes') and focus == cid and conv == 4 then
		selfSay('Tell me the name of the pokemon you would like to sell.')
		conv = 1
	return true
	end

	if msgcontains(msg, 'no') and conv == 4 and focus == cid then
		selfSay('Ok, see you around then!')
		focus = 0
	return true
	end

	local common = {"rattata", "caterpie", "weedle", "magikarp"}

	if conv == 1 and focus == cid then
		for a = 1, #common do
			if msgcontains(msg, common[a]) then
				selfSay('I dont buy such a common pokemon!')
			return true
			end
		end
	end

	if msgcontains(msg, 'no') and conv == 3 and focus == cid then
		selfSay('Well, then what pokemon would you like to sell?')
		conv = 1
	return true
	end

	if (conv == 1 or conv == 4) and focus == cid then
		local name = doCorrectPokemonName(msg)
		local pokemon = pokes[name]
		if not pokemon then
			selfSay("Sorry, I don't know what pokemon you're talking about! Are you sure you spelled it correctly?")
		return true
		end

        baseprice = pokePrice[name] or math.floor(pokemon.level * 150)  --alterado v1.6

        cost = baseprice
        pname = name
        selfSay("Are you sure you want to sell a "..name.." for "..cost.." dollars + boost?")
        conv = 3       
	end

	if isConfirmMsg(msg) and focus == cid and conv == 3 then
		if sellPokemon(cid, pname, cost) then
			conv = 4
		else
			conv = 1
		end
	return true
	end

end

local intervalmin = 38
local intervalmax = 70
local delay = 25
local number = 1
local messages = {"Buying some beautiful pokemons! Come here to sell them!",
		  "Wanna sell a pokemon? Came to the right place!",
		  "Buy pokemon! Excellent offers!",
		  "Tired of a pokemon? Why don't you sell it to me then?",
		 }

function onThink()

	if focus == 0 then
		selfTurn(1)
			delay = delay - 0.5
			if delay <= 0 then
				selfSay(messages[number])
				number = number + 1
					if number > #messages then
						number = 1
					end
				delay = math.random(intervalmin, intervalmax)
			end
		return true
	else

	if not isCreature(focus) then
		focus = 0
	return true
	end

		local npcpos = getThingPos(getThis())
		local focpos = getThingPos(focus)

		if npcpos.z ~= focpos.z then
			focus = 0
		return true
		end
		if (os.clock() - talk_start) > 70 then
			focus = 0
			selfSay("I have other clients too, talk to me when you feel like selling a pokemon.")
		end

		if getDistanceToCreature(focus) > 3 then
			selfSay("Good bye then and thanks!")
			focus = 0
		return true
		end

		local dir = doDirectPos(npcpos, focpos)	
		selfTurn(dir)
	end


return true
end 