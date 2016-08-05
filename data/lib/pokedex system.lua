local skills = specialabilities                                    --alterado v1.9 \/ peguem tudo!

function doAddPokemonInDexList(cid, poke)
if getPlayerInfoAboutPokemon(cid, poke).dex then return true end
	poke = doCorrectString(poke)
	local a = newpokedex[poke]                                              
	local b = getPlayerStorageValue(cid, a.storage)
	setPlayerStorageValue(cid, a.storage, b.." dex,")
end

function getPokemonEvolutionDescription(name, next)
	local kev = poevo[name]
	local stt = {}
	if isInArray(specialevo, name) then
       if name == "Poliwhirl" then
          if next then
             return "\nPoliwrath or Politoed, requires level 65."
          end   
          table.insert(stt, "Evolve Stone: Water Stone and Punch Stone or Water Stone and Earth Stone\n\n")
          table.insert(stt, "Evolutions:\nPoliwrath, requires level 65.\nPolitoed, requires level 65.")
       elseif name == "Gloom" then
          if next then
             return "\nVileplume or Bellossom, requires level 50."
          end
          table.insert(stt, "Evolve Stone: 2 Leaf Stone or Leaf Stone and Venom Stone\n\n")
          table.insert(stt, "Evolutions:\nVileplume, requires level 50.\nBellossom, requires level 50.")
       elseif name == "Slowpoke" then
          if next then
             return "\nSlowbro, requires level 45.\nSlowking, requires level 100."
          end
          table.insert(stt, "Evolve Stone: Enigma Stone or Ancient Stone\n\n")
          table.insert(stt, "Evolutions:\nSlowbro, requires level 45.\nSlowking, requires level 100.")
       elseif name == "Eevee" then
          if next then
             return "\nVaporeon, requires level 55.\nJolteon, requires level 55.\nFlareon, requires level 55.\nUmbreon, requires level 55.\nEspeon, requires level 55."
          end
          table.insert(stt, "Evolve Stone: Water Stone or Thunder Stone or Fire Stone or Darkness Stone or Enigma Stone\n\n")
          table.insert(stt, "Evolutions:\nVaporeon, requires level 55.\nJolteon, requires level 55.\nFlareon, requires level 55.\nUmbreon, requires level 55.\nEspeon, requires level 55.")
       elseif name == "Tyrogue" then
          if next then
             return "\nHitmonlee, requires level 60.\nHitmonchan, requires level 60.\nHitmontop, requires level 60."
          end
          table.insert(stt, "Evolve Stone: Punch Stone\n\n")   
          table.insert(stt, "Evolutions:\nHitmonlee, requires level 60.\nHitmonchan, requires level 60.\nHitmontop, requires level 60.")
       end
    elseif kev then
       if next then
          table.insert(stt, "\n"..kev.evolution..", requires level "..kev.level..".")
          return table.concat(stt)
       end
       local id = tonumber(kev.stoneid)
       local id2 = tonumber(kev.stoneid2)
       local stone = ""
       if tonumber(kev.count) == 2 then
          stone = doConvertStoneIdToString(id).." (2x)"
       else
          stone = id2 == 0 and doConvertStoneIdToString(id) or doConvertStoneIdToString(id).." and "..doConvertStoneIdToString(id2)
       end
       table.insert(stt, "Evolve Stone: "..stone.."\n\n")
       table.insert(stt, "Evolutions:\n"..kev.evolution..", requeris level "..kev.level..".")
       table.insert(stt, getPokemonEvolutionDescription(kev.evolution, true))
    else
        if not next then
           table.insert(stt, "Evolutions:\nIt doen't evolve.")
        end
    end   
return table.concat(stt)
end

local function getMoveDexDescr(name, number)
	local x = movestable[name]
	if not x then return "" end
	
	local z = "\n"
	local tables = {x.move1, x.move2, x.move3, x.move4, x.move5, x.move6, x.move7, x.move8, x.move9, x.move10, x.move11, x.move12}
	local y = tables[number]
	if not y then return "" end

local txt = ""..z..""..y.name.." - m"..number.." - level "..y.level.." - "..(y.t) 
return txt
end      
                                                                                                                                 --alterado v1.8
local skillcheck = {"fly", "ride", "surf", "teleport", "rock smash", "cut", "dig", "light", "blink", "control mind", "transform", "levitate_fly"}
local passivas = {
["Shock Counter"] = {"Electabuzz", "Shiny Electabuzz", "Elekid", "Raikou", tpw = "electric"},
["Lava-Counter"] = {"Magmar", "Magby", "Entei", tpw = "fire"},
["Counter Helix"] = {"Scyther", "Shiny Scyther", tpw = "bug"},
["Giroball"] = {"Pineco", "Forretress", tpw = "steel"},
["Counter Claw"] = {"Scizor", tpw = "bug"},
["Counter Spin"] = {"Hitmontop", "Shiny Hitmontop", tpw = "fighting"},
["Demon Kicker"] = {"Hitmonlee", "Shiny Hitmonlee", tpw = "fighting"},
["Demon Puncher"] = {"Hitmonchan", "Shiny Hitmonchan", tpw = "unknow"},               --alterado v1.6
["Stunning Confusion"] = {"Psyduck", "Golduck", "Wobbuffet", tpw = "psychic"},
["Groundshock"] = {"Kangaskhan", tpw = "normal"},
["Electric Charge"] = {"Pikachu", "Raichu", "Shiny Raichu", tpw = "electric"},
["Melody"] = {"Wigglytuff", tpw = "normal"},
["Dragon Fury"] = {"Dratini", "Dragonair", "Dragonite", "Shiny Dratini", "Shiny Dragonair", "Shiny Dragonite", tpw = "dragon"},
["Fury"] = {"Persian", "Raticate", "Shiny Raticate", tpw = "normal"},
["Mega Drain"] = {"Oddish", "Gloom", "Vileplume", "Kabuto", "Kabutops", "Parasect", "Tangela", "Shiny Vileplume", "Shiny Tangela", tpw = "grass"},
["Spores Reaction"] = {"Oddish", "Gloom", "Vileplume", "Shiny Vileplume", tpw = "grass"},
["Amnesia"] = {"Wooper", "Quagsire", "Swinub", "Piloswine", tpw = "psychic"},
["Zen Mind"] = {"Slowking", tpw = "psychic"}, 
["Mirror Coat"] = {"Wobbuffet", tpw = "psychic"},
["Lifesteal"] = {"Zubat", "Golbat", "Crobat", "Shiny Zubat", "Shiny Golbat", "Shiny Crobat", tpw = "poison"},
["Evasion"] = {"Scyther", "Scizor", "Hitmonlee", "Hitmonchan", "Hitmontop", "Tyrogue", "Shiny Scyther", "Shiny Hitmonchan", "Shiny Hitmonlee", "Shiny Hitmontop", "Ledian", "Ledyba", "Sneasel", tpw = "normal"},
["Foresight"] = {"Machamp", "Shiny Hitmonchan", "Shiny Hitmonlee", "Shiny Hitmontop", "Hitmontop", "Hitmonlee", "Hitmonchan", tpw = "fighting"},
["Levitate"] = {"Gengar", "Haunter", "Gastly", "Misdreavus", "Weezing", "Koffing", "Unown", "Shiny Gengar", tpw = "ghost"},

["Bone Spin"] = {"Cubone", "Marowak", "Shiny Cubone", "Shiny Marowak", tpw = "rock"},
}


function doShowPokedexRegistration(cid, pokemon, ball, item2)


local myball = ball
local name = pokemon 

local v = fotos[name]
local stt = {}

table.insert(stt, "Name: "..name.."\n")

if pokes[name].type2 and pokes[name].type2 ~= "no type" then
   table.insert(stt, "Type: "..pokes[name].type.."/"..pokes[name].type2)
else
    table.insert(stt, "Type: "..pokes[name].type)
end

if virtual then
   table.insert(stt, "\nRequired level: "..pokes[name].level.."\n")
else
   table.insert(stt, "\nRequired level: ".. getPokemonLevelD(name) .."\n")  --alterado v1.9
end

table.insert(stt, "\n"..getPokemonEvolutionDescription(name).."\n")

table.insert(stt, "\nMoves:")

if name == "Ditto" then
   table.insert(stt, "\nIt doesn't use any moves until transformed.")
else
   for a = 1, 15 do
      table.insert(stt, getMoveDexDescr(name, a))
   end
end

for e, f in pairs(passivas) do
   if isInArray(passivas[e], name) then
      local tpw = passivas[e].tpw
      if name == "Pineco" and passivas[e] == "Giroball" then
         tpw = "bug"
      end
      table.insert(stt, "\n"..e.." - passive - "..tpw)
   end
end
            
table.insert(stt, "\n\nAbility:\n") 
local abilityNONE = true                   --alterado v1.8 \/
			
for b, c in pairs(skills) do
   if isInArray(skillcheck, b) then
      if isInArray(c, name) then
         table.insert(stt, (b == "levitate_fly" and "Levitate" or doCorrectString(b)).."\n")
         abilityNONE = false
      end
   end
end
if abilityNONE then
   table.insert(stt, "None")
end
		
if string.len(table.concat(stt)) > 8192 then
   print("Error while making pokedex info with pokemon named "..name..".\n   Pokedex registration has more than 8192 letters (it has "..string.len(stt).." letters), it has been blocked to prevent fatal error.")
   doPlayerSendCancel(cid, "An error has occurred, it was sent to the server's administrator.") 
return true
end	

doShowTextDialog(cid, v, table.concat(stt))
end