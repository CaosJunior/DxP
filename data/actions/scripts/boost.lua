local ballslot =12355
local ballslot_run = 12352
local stoneslot = 12354
local stoneslot_run = 12353
local button = 12356
local button_run = 12357
function isRunning(id)
if isInArray({button_run, stoneslot_run, ballslot_run}, id) then
return true
end
return false
end
boost_stones = {                              --alterado v1.9 \/
["Bulbasaur"] = {leaf, boostStone},
["Tropius"] = {leaf, boostStone},
["Ivysaur"] = {leaf, boostStone},
["Venusaur"] = {leaf, boostStone},
["Charmander"] = {fire, boostStone},
["Charmeleon"] = {fire, boostStone},
["Charizard"] = {fire, boostStone},
["Squirtle"] = {water, boostStone},
["Wartortle"] = {water, boostStone},
["Blastoise"] = {water, boostStone},
["Caterpie"] = {coccon, boostStone},
["Metapod"] = {coccon, boostStone},
["Butterfree"] = {coccon, boostStone},
["Weedle"] = {coccon, boostStone},
["Kakuna"] = {coccon, boostStone},
["Beedrill"] = {coccon, boostStone},
["Pidgey"] = {heart, boostStone},
["Pidgeotto"] = {heart, boostStone},
["Pidgeot"] = {heart, boostStone},
["Rattata"] = {heart, boostStone},
["Raticate"] = {heart, boostStone},
["Spearow"] = {heart, boostStone},
["Fearow"] = {heart, boostStone},
["Ekans"] = {venom, boostStone},
["Arbok"] = {venom, boostStone},
["Pikachu"] = {thunder, boostStone},
["Raichu"] = {thunder, boostStone},
["Sandshrew"] = {earth, boostStone},
["Sandslash"] = {earth, boostStone},
["Nidoran Female"] = {venom, boostStone},
["Nidorina"] = {venom, boostStone},
["Nidoqueen"] = {venom, earth, boostStone},
["Nidoran Male"] = {venom, boostStone},
["Nidorino"] = {venom, boostStone},
["Nidoking"] = {venom, earth, boostStone},
["Clefairy"] = {heart, boostStone},
["Clefable"] = {heart, boostStone},
["Vulpix"] = {fire, boostStone},
["Ninetales"] = {fire, boostStone},
["Jigglypuff"] = {heart, boostStone},
["Wigglytuff"] = {heart, boostStone},
["Zubat"] = {venom, boostStone},
["Golbat"] = {venom, boostStone},
["Oddish"] = {leaf, venom, boostStone},
["Gloom"] = {leaf, venom, boostStone},
["Vileplume"] = {leaf, venom, boostStone},
["Paras"] = {coccon, leaf, boostStone},
["Parasect"] = {coccon, leaf, boostStone},
["Venonat"] = {coccon, venom, boostStone},
["Venomoth"] = {coccon, venom, boostStone},
["Diglett"] = {earth, boostStone},
["Dugtrio"] = {earth, boostStone},
["Meowth"] = {heart, boostStone},
["Persian"] = {heart, boostStone},
["Psyduck"] = {water, boostStone},
["Golduck"] = {water, enigma, boostStone},
["Mankey"] = {punch, boostStone},
["Primeape"] = {punch, boostStone},
["Growlithe"] = {fire, boostStone},
["Arcanine"] = {fire, boostStone},
["Poliwag"] = {water, boostStone},
["Poliwhirl"] = {water, boostStone},
["Poliwrath"] = {water, punch, boostStone},
["Abra"] = {enigma, boostStone},
["Kadabra"] = {enigma, boostStone},
["Alakazam"] = {enigma, boostStone},
["Machop"] = {punch, boostStone},
["Machoke"] = {punch, boostStone},
["Machamp"] = {punch, boostStone},
["Bellsprout"] = {leaf, venom, boostStone},
["Weepinbell"] = {leaf, venom, boostStone},
["Victreebel"] = {leaf, venom, boostStone},
["Tentacool"] = {water, venom, boostStone},
["Tentacruel"] = {water, venom, boostStone},
["Geodude"] = {earth, rock, boostStone},
["Graveler"] = {earth, rock, boostStone},
["Golem"] = {earth, rock, boostStone},
["Ponyta"] = {fire, boostStone},
["Rapidash"] = {fire, boostStone},
["Slowpoke"] = {water, enigma, boostStone},
["Slowbro"] = {water, enigma, boostStone},
["Magnemite"] = {thunder, boostStone},
["Magneton"] = {thunder, boostStone},
["Magnezone"] = {thunder, boostStone},
["Milotic"] = {water, boostStone},
["Farfetch'd"] = {heart, boostStone},
["Doduo"] = {heart, boostStone},
["Dodrio"] = {heart, boostStone},
["Seel"] = {water, ice, boostStone},
["Dewgong"] = {water, ice, boostStone},
["Grimer"] = {venom, boostStone},
["Muk"] = {venom, boostStone},
["Shellder"] = {water, ice, boostStone},
["Cloyster"] = {water, ice, boostStone},
["Gastly"] = {dark, boostStone},
["Haunter"] = {dark, boostStone},
["Gengar"] = {dark, boostStone},
["Onix"] = {rock, earth, boostStone},
["Drowzee"] = {enigma, boostStone},
["Hypno"] = {enigma, boostStone},
["Krabby"] = {water, boostStone},
["Kingler"] = {water, boostStone},
["Voltorb"] = {thunder, boostStone},
["Electrode"] = {thunder, boostStone},
["Exeggcute"] = {enigma, leaf, boostStone},
["Exeggutor"] = {enigma, leaf, boostStone},
["Cubone"] = {earth, boostStone},
["Marowak"] = {earth, boostStone},
["Hitmonlee"] = {punch, boostStone},
["Hitmonchan"] = {punch, boostStone},
["Lickitung"] = {heart, boostStone},
["Koffing"] = {venom, boostStone},
["Weezing"] = {venom, boostStone},
["Rhyhorn"] = {earth, rock, boostStone},
["Rhydon"] = {earth, rock, boostStone},
["Chansey"] = {heart, boostStone},
["Tangela"] = {leaf, boostStone},
["Kangaskhan"] = {heart, boostStone},
["Horsea"] = {water, boostStone},
["Seadra"] = {water, boostStone},
["Goldeen"] = {water, boostStone},
["Seaking"] = {water, boostStone},
["Staryu"] = {water, boostStone},
["Starmie"] = {water, boostStone},
["Shiny Mantine"] = {water, boostStone},
["Mr. Mime"] = {enigma, boostStone},
["Scyther"] = {coccon, boostStone},
["Jynx"] = {enigma, ice, boostStone},
["Electabuzz"] = {thunder, boostStone},
["Electivire"] = {thunder, boostStone},
["Shiny Electivire"] = {thunder, boostStone},
["Magmar"] = {fire, boostStone},
["Magmortar"] = {fire, boostStone},
["Shiny Magmortar"] = {fire, boostStone},
["Pinsir"] = {coccon, boostStone},
["Tauros"] = {heart, boostStone},
["Magikarp"] = {water, boostStone},
["Gyarados"] = {water, crystal, boostStone},
["Lapras"] = {water, ice, boostStone},
["Ditto"] = {heart, boostStone},
["Shiny Ditto"] = {heart, boostStone},
["Eevee"] = {heart, boostStone},
["Vaporeon"] = {water, boostStone},
["Jolteon"] = {thunder, boostStone},
["Flareon"] = {fire, boostStone},
["Espeon"] = {enigma, boostStone},
["Umbreon"] = {dark, boostStone},
["Absol"] = {dark, boostStone},
["Wailord"] = {water, boostStone},
["Porygon"] = {heart, enigma, boostStone},
["Omanyte"] = {rock, water, boostStone},
["Omastar"] = {rock, water, boostStone},
["Kabuto"] = {rock, water, boostStone},
["Kabutops"] = {rock, water, boostStone},
["Aerodactyl"] = {rock, boostStone},
["Snorlax"] = {heart, boostStone},
["Articuno"] = {ice, boostStone},
["Zapdos"] = {thunder, boostStone},
["Moltres"] = {fire, boostStone},
["Dratini"] = {crystal, boostStone},
["Dragonair"] = {crystal, boostStone},
["Dragonite"] = {crystal, boostStone},
["Salamence"] = {crystal, boostStone},
["Shiny Salamence"] = {crystal, boostStone},
["Mewtwo"] = {enigma, boostStone},
["Mew"] = {enigma, boostStone},

["Shiny Typhlosion"] = {fire, boostStone},
--
["Shiny Bulbasaur"] = {leaf, boostStone},
["Shiny Ivysaur"] = {leaf, boostStone},
["Shiny Venusaur"] = {leaf, boostStone},
["Shiny Charmander"] = {fire, boostStone},
["Shiny Charmeleon"] = {fire, boostStone},
["Shiny Charizard"] = {fire, boostStone},
["Shiny Squirtle"] = {water, boostStone},
["Shiny Wartortle"] = {water, boostStone},
["Shiny Blastoise"] = {water, boostStone},
["Shiny Caterpie"] = {coccon, boostStone},
["Shiny Metapod"] = {coccon, boostStone},
["Shiny Butterfree"] = {coccon, boostStone},
["Shiny Weedle"] = {coccon, boostStone},
["Shiny Kakuna"] = {coccon, boostStone},
["Shiny Beedrill"] = {coccon, boostStone},
["Shiny Pidgey"] = {heart, boostStone},
["Shiny Pidgeotto"] = {heart, boostStone},
["Shiny Pidgeot"] = {heart, boostStone},
["Shiny Rattata"] = {heart, boostStone},
["Shiny Raticate"] = {heart, boostStone},
["Shiny Spearow"] = {heart, boostStone},
["Shiny Fearow"] = {heart, boostStone},
["Shiny Ekans"] = {venom, boostStone},
["Shiny Arbok"] = {venom, boostStone},
["Shiny Pikachu"] = {thunder, boostStone},
["Shiny Raichu"] = {thunder, boostStone},
["Shiny Sandshrew"] = {earth, boostStone},
["Shiny Sandslash"] = {earth, boostStone},
["Shiny Nidoran Female"] = {venom, boostStone},
["Shiny Nidorina"] = {venom, boostStone},
["Shiny Nidoqueen"] = {venom, earth, boostStone},
["Shiny Nidoran Male"] = {venom, boostStone},
["Shiny Nidorino"] = {venom, boostStone},
["Shiny Nidoking"] = {venom, earth, boostStone},
["Shiny Clefairy"] = {heart, boostStone},
["Shiny Clefable"] = {heart, boostStone},
["Shiny Vulpix"] = {fire, boostStone},
["Shiny Ninetales"] = {fire, boostStone},
["Shiny Jigglypuff"] = {heart, boostStone},
["Shiny Wigglytuff"] = {heart, boostStone},
["Shiny Zubat"] = {venom, boostStone},
["Shiny Golbat"] = {venom, boostStone},
["Shiny Oddish"] = {leaf, venom, boostStone},
["Shiny Gloom"] = {leaf, venom, boostStone},
["Shiny Vileplume"] = {leaf, venom, boostStone},
["Shiny Paras"] = {coccon, leaf, boostStone},
["Shiny Parasect"] = {coccon, leaf, boostStone},
["Shiny Venonat"] = {coccon, venom, boostStone},
["Shiny Venomoth"] = {coccon, venom, boostStone},
["Shiny Diglett"] = {earth, boostStone},
["Shiny Dugtrio"] = {earth, boostStone},
["Shiny Meowth"] = {heart, boostStone},
["Shiny Persian"] = {heart, boostStone},
["Shiny Psyduck"] = {water, boostStone},
["Shiny Golduck"] = {water, enigma, boostStone},
["Shiny Mankey"] = {punch, boostStone},
["Shiny Primeape"] = {punch, boostStone},
["Shiny Growlithe"] = {fire, boostStone},
["Shiny Arcanine"] = {fire, boostStone},
["Shiny Poliwag"] = {water, boostStone},
["Shiny Poliwhirl"] = {water, boostStone},
["Shiny Poliwrath"] = {water, punch, boostStone},
["Shiny Abra"] = {enigma, boostStone},
["Shiny Kadabra"] = {enigma, boostStone},
["Shiny Alakazam"] = {enigma, boostStone},
["Shiny Machop"] = {punch, boostStone},
["Shiny Machoke"] = {punch, boostStone},
["Shiny Machamp"] = {punch, boostStone},
["Shiny Bellsprout"] = {leaf, venom, boostStone},
["Shiny Weepinbell"] = {leaf, venom, boostStone},
["Shiny Victreebel"] = {leaf, venom, boostStone},
["Shiny Tentacool"] = {water, venom, boostStone},
["Shiny Tentacruel"] = {water, venom, boostStone},
["Shiny Geodude"] = {earth, rock, boostStone},
["Shiny Graveler"] = {earth, rock, boostStone},
["Shiny Golem"] = {rock, boostStone},
["Shiny Ponyta"] = {fire, boostStone},
["Shiny Rapidash"] = {fire, boostStone},
["Shiny Slowpoke"] = {water, enigma, boostStone},
["Shiny Slowbro"] = {water, enigma, boostStone},
["Shiny Magnemite"] = {thunder, boostStone},
["Shiny Magneton"] = {thunder, boostStone},
["Shiny Farfetch'd"] = {heart, boostStone},
["Shiny Doduo"] = {heart, boostStone},
["Shiny Dodrio"] = {heart, boostStone},
["Shiny Seel"] = {water, ice, boostStone},
["Shiny Dewgong"] = {water, ice, boostStone},
["Shiny Grimer"] = {venom, boostStone},
["Shiny Muk"] = {venom, boostStone},
["Shiny Shellder"] = {water, ice, boostStone},
["Shiny Cloyster"] = {water, ice, boostStone},
["Shiny Gastly"] = {dark, boostStone},
["Shiny Haunter"] = {dark, boostStone},
["Shiny Gengar"] = {dark, boostStone},
["Shiny Onix"] = {rock, earth, boostStone},
["Shiny Drowzee"] = {enigma, boostStone},
["Shiny Hypno"] = {enigma, boostStone},
["Shiny Krabby"] = {water, boostStone},
["Shiny Kingler"] = {water, boostStone},
["Shiny Voltorb"] = {thunder, boostStone},
["Shiny Electrode"] = {thunder, boostStone},
["Shiny Exeggcute"] = {enigma, leaf, boostStone},
["Shiny Exeggutor"] = {enigma, leaf, boostStone},
["Shiny Cubone"] = {earth, boostStone},
["Shiny Marowak"] = {earth, boostStone},
["Shiny Hitmonlee"] = {punch, boostStone},
["Shiny Hitmonchan"] = {punch, boostStone},
["Shiny Hitmontop"] = {punch, boostStone}, --alterado v1.4
["Shiny Lickitung"] = {heart, boostStone},
["Shiny Koffing"] = {venom, boostStone},
["Shiny Weezing"] = {venom, boostStone},
["Shiny Rhyhorn"] = {earth, rock, boostStone},
["Shiny Rhydon"] = {earth, rock, boostStone},
["Shiny Chansey"] = {heart, boostStone},
["Shiny Tangela"] = {leaf, boostStone},
["Shiny Kangaskhan"] = {heart, boostStone},
["Shiny Horsea"] = {water, boostStone},
["Shiny Seadra"] = {water, boostStone},
["Shiny Goldeen"] = {water, boostStone},
["Shiny Seaking"] = {water, boostStone},
["Shiny Staryu"] = {water, boostStone},
["Shiny Starmie"] = {water, boostStone},
["Shiny Mr. Mime"] = {enigma, boostStone},
["Shiny Scyther"] = {coccon, boostStone},
["Shiny Jynx"] = {enigma, ice, boostStone},
["Shiny Electabuzz"] = {thunder, boostStone},
["Shiny Magmar"] = {fire, boostStone},
["Shiny Pinsir"] = {coccon, boostStone},
["Shiny Tauros"] = {heart, boostStone},
["Shiny Magikarp"] = {water, boostStone},
["Shiny Gyarados"] = {water, crystal, boostStone},
["Shiny Lapras"] = {water, ice, boostStone},
["Shiny Ditto"] = {heart, boostStone},
["Shiny Eevee"] = {heart, boostStone},
["Shiny Vaporeon"] = {water, boostStone},
["Shiny Jolteon"] = {thunder, boostStone},
["Shiny Flareon"] = {fire, boostStone},
["Shiny Porygon"] = {heart, enigma, boostStone},
["Shiny Omanyte"] = {rock, water, boostStone},
["Shiny Omastar"] = {rock, water, boostStone},
["Shiny Kabuto"] = {rock, water, boostStone},
["Shiny Kabutops"] = {rock, water, boostStone},
["Shiny Aerodactyl"] = {rock, boostStone},
["Shiny Snorlax"] = {heart, boostStone},
["Shiny Articuno"] = {ice, boostStone},
["Shiny Zapdos"] = {thunder, boostStone},
["Shiny Moltres"] = {fire, boostStone},
["Shiny Dratini"] = {crystal, boostStone},
["Shiny Dragonair"] = {crystal, boostStone},
["Shiny Dragonite"] = {crystal, boostStone},
["Shiny Mewtwo"] = {enigma, boostStone},
["Shiny Mew"] = {enigma, boostStone},
--
["Chikorita"] = {leaf, boostStone},
["Bayleef"] = {leaf, boostStone},
["Meganium"] = {leaf, boostStone},
["Cyndaquil"] = {fire, boostStone},
["Quilava"] = {fire, boostStone},
["Typhlosion"] = {fire, boostStone},
["Totodile"] = {water, boostStone},
["Croconaw"] = {water, boostStone},
["Feraligatr"] = {water, boostStone},
["Sentret"] = {heart, boostStone},
["Furret"] = {heart, boostStone},
["Hoothoot"] = {heart, enigma, boostStone},
["Noctowl"] = {heart, enigma, boostStone},
["Ledyba"] = {coccon, boostStone},
["Ledian"] = {coccon, boostStone},
["Spinarak"] = {coccon, venom, boostStone},
["Ariados"] = {coccon, venom, boostStone},
["Crobat"] = {venom, boostStone},
["Chinchou"] = {water, thunder, boostStone},
["Lanturn"] = {water, thunder, boostStone},
["Pichu"] = {thunder, boostStone},
["Cleffa"] = {heart, boostStone},
["Iglybuff"] = {venom, boostStone},
["Natu"] = {enigma, boostStone},
["Xatu"] = {enigma, boostStone},
["Mareep"] = {thunder, boostStone},
["Flaaffy"] = {thunder, boostStone},
["Ampharos"] = {thunder, boostStone},
["Bellossom"] = {leaf, boostStone},
["Marill"] = {water, boostStone},
["Azulmarill"] = {water, boostStone},
["Sudowoodo"] = {rock, earth, boostStone},
["Politoed"] = {water, earth, boostStone},
["Hoppip"] = {leaf, boostStone},
["Skiploom"] = {leaf, boostStone},
["Jumpluff"] = {leaf, boostStone},
["Aipom"] = {heart, boostStone},
["Sunkern"] = {leaf, boostStone},
["Sunflora"] = {leaf, boostStone},
["Yanma"] = {venom, coccon, boostStone},
["Wooper"] = {water, boostStone},
["Quagsire"] = {water, earth, boostStone},
["Murkrow"] = {dark, boostStone},
["Slowking"] = {enigma, boostStone},
["Misdreavus"] = {dark, boostStone},
["Wobbuffet"] = {enigma, boostStone},
["Girafarig"] = {enigma, boostStone},
["Pineco"] = {coccon, boostStone},
["Forretress"] = {coccon, boostStone},
["Gligar"] = {dark, heart, boostStone},
["Steelix"] = {metal, boostStone},
["Snubbull"] = {heart, boostStone},
["Granbull"] = {heart, boostStone},
["Qwilfish"] = {water, boostStone},
["Shuckle"] = {earth, boostStone},
["Heracross"] = {coccon, boostStone},
["Teddiursa"] = {heart, boostStone},
["Ursaring"] = {heart, boostStone},
["Slugma"] = {fire, boostStone},
["Magcargo"] = {fire, boostStone},
["Swinub"] = {ice, earth, boostStone},
["Piloswine"] = {ice, earth, boostStone},
["Corsola"] = {water, boostStone},
["Remoraid"] = {water, boostStone},
["Octillery"] = {water, boostStone},
["Delibird"] = {ice, heart, boostStone},
["Mantine"] = {water, boostStone},
["Skarmory"] = {metal, boostStone},
["Houndour"] = {fire, dark, boostStone},
["Houndoom"] = {fire, dark, boostStone},
["Kingdra"] = {water, crystal, boostStone},
["Phanpy"] = {earth, boostStone},
["Donphan"] = {earth, boostStone},
["porygon2"] = {enigma, boostStone},
["Stantler"] = {heart, boostStone},
["Smeargle"] = {heart, boostStone},
["Tyrogue"] = {punch, boostStone},
["Hitmontop"] = {punch, boostStone},
["Smoochum"] = {ice, enigma, boostStone},
["Elekid"] = {thunder, boostStone},
["Magby"] = {fire, boostStone},
["Miltank"] = {heart, boostStone},
["Blissey"] = {heart, boostStone},
["Scizor"] = {metal, boostStone},
["Beldum"] = {metal, boostStone},
["Metang"] = {metal, boostStone},
["Metagross"] = {metal, boostStone},
["Raikou"] = {thunder, boostStone},
["Entei"] = {fire, boostStone},
["Suicune"] = {water, boostStone},
["Larvitar"] = {earth, dark, boostStone},
["Pupitar"] = {earth, dark, boostStone},
["Tyranitar"] = {rock, dark, boostStone},
["Lugia"] = {enigma, water, boostStone},
["Ho-oh"] = {enigma, fire, boostStone},
["Celebi"] = {leaf, enigma, boostStone},

["Shiny Chikorita"] = {leaf, boostStone},
["Shiny Bayleef"] = {leaf, boostStone},
["Shiny Meganium"] = {leaf, boostStone},
["Shiny Cyndaquil"] = {fire, boostStone},
["Shiny Quilava"] = {fire, boostStone},
["Shiny Typhlosion"] = {fire, boostStone},
["Shiny Totodile"] = {water, boostStone},
["Shiny Croconaw"] = {water, boostStone},
["Shiny Feraligatr"] = {water, boostStone},
["Shiny Sentret"] = {heart, boostStone},
["Shiny Furret"] = {heart, boostStone},
["Shiny Hoothoot"] = {heart, enigma, boostStone},
["Shiny Noctowl"] = {heart, enigma, boostStone},
["Shiny Ledyba"] = {coccon, boostStone},
["Shiny Ledian"] = {coccon, boostStone},
["Shiny Spinarak"] = {coccon, venom, boostStone},
["Shiny Ariados"] = {coccon, venom, boostStone},
["Shiny Crobat"] = {venom, boostStone},
["Shiny Chinchou"] = {water, thunder, boostStone},
["Shiny Lanturn"] = {water, thunder, boostStone},
["Shiny Pichu"] = {thunder, boostStone},
["Shiny Cleffa"] = {heart, boostStone},
["Shiny Iglybuff"] = {venom, boostStone},
["Shiny Natu"] = {enigma, boostStone},
["Shiny Xatu"] = {enigma, boostStone},
["Shiny Mareep"] = {thunder, boostStone},
["Shiny Flaaffy"] = {thunder, boostStone},
["Shiny Ampharos"] = {thunder, boostStone},
["Shiny Bellossom"] = {leaf, boostStone},
["Shiny Marill"] = {water, boostStone},
["Shiny Azulmarill"] = {water, boostStone},
["Shiny Sudowoodo"] = {rock, earth, boostStone},
["Shiny Politoed"] = {water, earth, boostStone},
["Shiny Hoppip"] = {leaf, boostStone},
["Shiny Skiploom"] = {leaf, boostStone},
["Shiny Jumpluff"] = {leaf, boostStone},
["Shiny Aipom"] = {heart, boostStone},
["Shiny Sunkern"] = {leaf, boostStone},
["Shiny Sunflora"] = {leaf, boostStone},
["Shiny Yanma"] = {venom, coccon, boostStone},
["Shiny Wooper"] = {water, boostStone},
["Shiny Quagsire"] = {water, earth, boostStone},
["Shiny Murkrow"] = {dark, boostStone},
["Shiny Slowking"] = {enigma, boostStone},
["Shiny Misdreavus"] = {dark, boostStone},
["Shiny Wobbuffet"] = {enigma, boostStone},
["Shiny Girafarig"] = {enigma, boostStone},
["Shiny Umbreon"] = {dark, boostStone},
["Shiny Espeon"] = {enigma, boostStone},
["Shiny Pineco"] = {coccon, boostStone},
["Shiny Forretress"] = {coccon, boostStone},
["Shiny Gligar"] = {dark, heart, boostStone},
["Shiny Steelix"] = {metal, boostStone},
["Shiny Snubbull"] = {heart, boostStone},
["Shiny Granbull"] = {heart, boostStone},
["Shiny Qwilfish"] = {water, boostStone},
["Shiny Shuckle"] = {earth, boostStone},
["Shiny Heracross"] = {coccon, boostStone},
["Shiny Teddiursa"] = {heart, boostStone},
["Shiny Ursaring"] = {heart, boostStone},
["Shiny Slugma"] = {fire, boostStone},
["Shiny Magcargo"] = {fire, boostStone},
["Shiny Swinub"] = {ice, earth, boostStone},
["Shiny Piloswine"] = {ice, earth, boostStone},
["Shiny Corsola"] = {water, boostStone},
["Shiny Remoraid"] = {water, boostStone},
["Shiny Octillery"] = {water, boostStone},
["Shiny Delibird"] = {ice, heart, boostStone},
["Shiny Mantine"] = {water, boostStone},
["Shiny Skarmory"] = {metal, boostStone},
["Shiny Houndour"] = {fire, dark, boostStone},
["Shiny Houndoom"] = {fire, dark, boostStone},
["Shiny Kingdra"] = {water, crystal, boostStone},
["Shiny Phanpy"] = {earth, boostStone},
["Shiny Donphan"] = {earth, boostStone},
["Shiny Porygon2"] = {enigma, boostStone},
["Shiny Stantler"] = {heart, boostStone},
["Shiny Smeargle"] = {heart, boostStone},
["Shiny Tyrogue"] = {punch, boostStone},
["Shiny Hitmontop"] = {punch, boostStone},
["Shiny Smoochum"] = {ice, enigma, boostStone},
["Shiny Elekid"] = {thunder, boostStone},
["Shiny Magby"] = {fire, boostStone},
["Shiny Miltank"] = {heart, boostStone},
["Shiny Blissey"] = {heart, boostStone},
["Shiny Scizor"] = {metal, boostStone},
["Shiny Raikou"] = {thunder, boostStone},
["Shiny Entei"] = {fire, boostStone},
["Shiny Suicune"] = {water, boostStone},
["Shiny Larvitar"] = {earth, dark, boostStone},
["Shiny Pupitar"] = {earth, dark, boostStone},
["Shiny Tyranitar"] = {rock, dark, boostStone},
["Shiny Lugia"] = {enigma, water, boostStone},
["Shiny Ho-oh"] = {enigma, fire, boostStone},
["Shiny Celebi"] = {leaf, enigma, boostStone}}

function doRestoreBoostMachine(cid, b_pos, p_pos, s_pos, msg, msg2)
--doSendMagicEffect(p_pos, 247)
if isCreature(cid) then
doCreatureSetNoMove(cid, false)
doPlayerSendTextMessage(cid, 27, msg)
end
local ball_s = getTileItemById(p_pos, ballslot_run)
doTransformItem(ball_s.uid, ballslot)
local stne_s = getTileItemById(s_pos, stoneslot_run)
doTransformItem(stne_s.uid, stoneslot)
local butn_s = getTileItemById(b_pos, button_run)
doTransformItem(butn_s.uid, button)
end
local stones_required = { -- custo base de stones para boostar
[heart] = 1,
[leaf] = 1,
[water] = 1,
[venom] = 1,
[thunder] = 1,
[rock] = 1,
[punch] = 1,
[fire] = 1,
[coccon] = 1,
[crystal] = 1,
[dark] = 1,
[earth] = 1,
[enigma] = 1,
[ice] = 1,
[metal] = 1,
[ancient] = 1,
[boostStone] = 1,
}
local stone_increase = { -- a cada quantos boosts ir� aumentar o custo de stones
[heart] = 4,
[leaf] = 4,
[water] = 4,
[venom] = 4,
[thunder] = 4,
[rock] = 4,
[punch] = 4,
[fire] = 4,
[coccon] = 4,
[crystal] = 4,
[dark] = 4,
[earth] = 4,
[enigma] = 4,
[ice] = 4,
[metal] = 30,
[ancient] = 30,
[boostStone] = 50,
}
function onUse(cid, item, topos, item2, frompos)
if isRunning(item.itemid) then
doPlayerSendCancel(cid, "Wait until boosting finishes.")
return true
end
if item.itemid == button then
local pbpos = topos
pbpos.x = pbpos.x + 1
local ball_slot = getTileItemById(pbpos, ballslot)
local myball = getContainerItem(ball_slot.uid, 0)
for a, b in pairs (pokeballs) do
    if item2.itemid == b.on or item2.itemid == b.off then --edited deixei igual ao do PXG
doPlayerSendCancel(cid, "You need to put a pokeball in the ball slot.")
return true
end
end
local pokemon = getItemAttribute(myball.uid, "poke")
local boost = getItemAttribute(myball.uid, "boost") or 0
if boost >= 50 then
doPlayerSendCancel(cid, "Your pokemon is already at maximum boost.")
return true
end
local stnpos = pbpos
stnpos.x = stnpos.x - 2
local stone_slot = getTileItemById(stnpos, stoneslot)
local stone = getContainerItem(stone_slot.uid, 0)
if stone.uid <= 0 then
doPlayerSendCancel(cid, "You need to put a stone in the stone slot.")
return true
end
if not isStone(stone.itemid) then
doPlayerSendCancel(cid, "Please, put only stones in the stone slot.")
return true
end
if not isInArray(boost_stones[pokemon], stone.itemid) then
local cancelstr = "Sorry, you are not using the correct stone."
if #boost_stones[pokemon] > 1 then
local stonesused = ""
cancelstr = cancelstr.." This pokemon needs "
for su = 1, #boost_stones[pokemon] do
local n = doCorrectString(getItemNameById(boost_stones[pokemon][su]))
if su == #boost_stones[pokemon] then
stonesused = stonesused.." or "..getArticle(n).." "..n..""
elseif su == 1 then
stonesused = stonesused..""..getArticle(n).." "..n..""
else
stonesused = stonesused..", "..n..""
end
end
cancelstr = cancelstr..""..stonesused.." to be boosted."
else
cancelstr = cancelstr.." This pokemon needs a "..doCorrectString(getItemNameById(boost_stones[pokemon][1])).." to be boosted."
end
doPlayerSendCancel(cid, cancelstr)
return true
end
local removeStones = 0
local extraStones = math.floor(boost / stone_increase[stone.itemid])
local required_stones = stones_required[stone.itemid] + extraStones
local boosts = 0
local availableStones = 0
for a = 0, getContainerSize(stone_slot.uid) - 1 do
local it = getContainerItem(stone_slot.uid, a)
if it.uid > 0 then
if not isStone(it.itemid) then
doPlayerSendCancel(cid, "Please, put only stones in the stone slot.")
return true
end
if it.itemid ~= stone.itemid then
doPlayerSendCancel(cid, "Please, put only one type of stone in the stone slot.")
return true
end
availableStones = availableStones + it.type
end
end

for a = 1, availableStones do
if required_stones > 0 then
required_stones = required_stones - 1
if required_stones <= 0 then
boosts = boosts + 1
removeStones = removeStones + stones_required[stone.itemid] + extraStones
if boost + boosts <= 49 then
extraStones = math.floor((boost + boosts) / stone_increase[stone.itemid])
required_stones = stones_required[stone.itemid] + extraStones
end
end
end
end

if required_stones > 0 and boosts == 0 then
doPlayerSendCancel(cid, "You need more stones to boost this pokemon.")
return true
end
for b = 1, removeStones do
local i = getContainerItem(stone_slot.uid, 0)
doChangeTypeItem(i.uid, i.type - 1)
end
	doSetItemAttribute(myball.uid, "boost", boost + boosts)
local msg = "You pokemon are boosted."
local downpos = getThingPos(cid)
downpos.y = downpos.y + 1
local mypos = getThingPos(cid)
doTeleportThing(cid, downpos, false)
doTeleportThing(cid, mypos, false)
doTransformItem(ball_slot.uid, ballslot_run)
doTransformItem(stone_slot.uid, stoneslot_run)
doTransformItem(item.uid, button_run)
doCreatureSetNoMove(cid, true)
doCreatureAddCondition(cid, boostcondition)
addEvent(doRestoreBoostMachine, 3000, cid, getThingPos(item.uid), getThingPos(ball_slot.uid), getThingPos(stone_slot.uid), msg, msg2)
return true
end
end