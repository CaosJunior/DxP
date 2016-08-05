function isRocket(cid)                                            
return isCreature(cid) and getPlayerStorageValue(cid, 665450) >= 1  --alterado v1.9
end
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function isOfficer(cid)
return isCreature(cid) and getPlayerStorageValue(cid, 665460) >= 1  --alterado v1.9
end
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function randOutfit(cid, outs)
outfit = getCreatureOutfit(cid)
if getPlayerStorageValue(cid, 665451) >= 1 then
   outfit = {lookType = choose(605, 604), lookHead = math.random(1, 250), lookBody = math.random(1, 250), lookLegs = math.random(1, 250), lookFeet = math.random(1, 250)}
elseif getPlayerStorageValue(cid, 665461) >= 1 then
   outfit = {lookType = choose(1184, 1183), lookHead = math.random(1, 250), lookBody = math.random(1, 250), lookLegs = math.random(1, 250), lookFeet = math.random(1, 250)}
elseif getPlayerStorageValue(cid, 665471) >= 1 then
   outfit = {lookType = choose(1016, 1015), lookHead = math.random(1, 250), lookBody = math.random(1, 250), lookLegs = math.random(1, 250), lookFeet = math.random(1, 250)}
elseif getPlayerStorageValue(cid, 665481) >= 1 then
   outfit = {lookType = choose(outs[1], outs[2]), lookHead = math.random(1, 250), lookBody = math.random(1, 250), lookLegs = math.random(1, 250), lookFeet = math.random(1, 250)}
end         --alterei v1.9 /\
doSetCreatureOutfit(cid, outfit, -1)
end   
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function doCloneOut(npc, outfit)
if isCreature(npc) then
doSetCreatureOutfit(npc, outfit, -1)
end
end
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function beDrunk(target)
if not isCreature(target) then return true end
doChangeSpeed(target, -getCreatureSpeed(target))
doChangeSpeed(target, 300)
if not isSleeping(target) and getPlayerStorageValue(target, 654878) <= 0 then
   doPushCreature(target, math.random(0, 3), 1, 0)
end
doChangeSpeed(target, -300)
addEvent(beDrunk, 2000, target)
end
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function randWalk(cid, cd, check, target)
if not isCreature(cid) then return true end
if check and check ~= getPlayerStorageValue(cid, 154788) then return true end
if getPlayerStorageValue(cid, 154788) >= 2 and cd ~= -1 then return true end 
-------
local alvo = target
-------
setPlayerStorageValue(cid, 154788, getPlayerStorageValue(cid, 154788)+cd)
local a = getPlayerStorageValue(cid, 154788)
if a <= 0 then setPlayerStorageValue(cid, 154788, -1) return true end
-------
doChangeSpeed(cid, -getCreatureSpeed(cid))
doChangeSpeed(cid, 300)
-------
if not isSleeping(cid) and getPlayerStorageValue(cid, 654878) <= 0 then
   doPushCreature(cid, math.random(0, 3), 1, 0)
end
-------
doChangeSpeed(cid, -300)
if isCreature(alvo) then
   doCreatureSetLookDir(cid, getCreatureDirectionToTarget(cid, alvo))
end
-------
addEvent(randWalk, 5000, cid, -1, a, target)
end
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
rocketTalks = {"I will kill you, your pig!!", "HAHA you won't get me!!!", "I will win and disappear!!"}
policeTalks = {"I will get you, thief!!", "So you belong to the team rocket? Come here for i get you!!", "I will kill you, your little thief!!"} 
hunterTalks = {"I will kill you!!", "Wasn't for you be here!", "This field is sacred! Get out of here!!"}
hunterWingeonTalks = {"You will die!", "The force of the air will help me!"}  --alterem aki
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
wildRocket = {
[1] = {{name = "Venusaur", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Blastoise", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Charizard", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Shiny Raticate", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Gengar", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      },
[2] = {{name = "Meganium", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Mantine", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Magmar", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Xatu", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Pidgeot", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      }, 
[3] = {{name = "Muk", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Venomoth", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Electabuzz", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Rhydon", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Ariados", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      },
[4] = {{name = "Shiny Raichu", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Umbreon", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Kingdra", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Shiny Onix", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Slowking", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      },
[5] = {{name = "Shiny Gengar", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Shiny Dodrio", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Scizor", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Thyplosion", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Yanma", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      },     
}
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
wildPolice = {
[1] = {{name = "Crobat", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Ursaring", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Gyarados", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Scyther", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Shiny Seadra", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      },
[2] = {{name = "Snorlax", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Murkrow", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Forretress", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Piloswine", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Venusaur", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      }, 
[3] = {{name = "Kingdra", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Alakazam", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Victreebel", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Golem", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Houndoom", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      },
[4] = {{name = "Magmar", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Nidoking", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Jynx", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Dewgong", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Machamp", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      },
[5] = {{name = "Slowking", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Blastoise", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Meganium", optionalLevel = 30, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Dugtrio", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Hypno", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      },     
}
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
wildCommanderOfficer = {
[1] = {{name = "Donphan", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Porygon2", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Octillery", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Bellossom", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Nidoking", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      },
[2] = {{name = "Sandslash", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Electabuzz", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Jynx", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Tauros", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Venomoth", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      }, 
[3] = {{name = "Lanturn", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Umbreon", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Magcargo", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Ninetales", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Primeape", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      },
[4] = {{name = "Machamp", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Snorlax", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Magneton", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Mantine", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Exeggutor", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      },
[5] = {{name = "Dewgong", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Xatu", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Skarmory", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Hitmonlee", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Hitmonchan", optionalLevel = 30, sex = SEX_MALE, nick = "", ball = "ultra"},
      }, 
}
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
wildCommanderRocket = {
[1] = {{name = "Raichu", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Pidgeot", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Politoed", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Nidoqueen", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Vileplume", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      },
[2] = {{name = "Clefable", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Noctowl", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Forretress", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Golduck", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Dragonair", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      }, 
[3] = {{name = "Victreebel", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Tentacruel", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Togetic", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Espeon", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Heracross", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      },
[4] = {{name = "Girafarig", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},  --alterado v1.6
       {name = "Ursaring", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Piloswine", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Mantine", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Wigglytuff", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      },
[5] = {{name = "Slowking", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Poliwrath", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Farfetch'd", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Cloyster", optionalLevel = 300, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Hitmontop", optionalLevel = 300, sex = SEX_MALE, nick = "", ball = "ultra"},
      },     
}
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
wildHunter = {
[1] = {{name = "Elder Tyranitar", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "normal"}, 
       {name = "Elder Venusaur", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "ultra"},  
       {name = "Evil Cloyster", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Metal Scizor", optionalLevel = 250, sex = SEX_FEMALE, nick = "", ball = "ultra"},
       {name = "Elder Charizard", optionalLevel = 250, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Dragon Machamp", optionalLevel =250, sex = SEX_FEMALE, nick = "", ball = "normal"},
      },
[2] = {{name = "Tribal Xatu", optionalLevel = 250, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Ancient Meganium", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "normal"},   
       {name = "Furious Mantine", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Elder Pinsir", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "ultra"},
       {name = "Charged Raichu", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "ultra"},  
       {name = "Brave Nidoqueen", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "ultra"},
      }, 
[3] = {{name = "Elder Muk", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "ultra"},
       {name = "Brute Ursaring", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "normal"}, 
       {name = "Naturia Venusaur", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "ultra"},  
       {name = "Ancient Dragonite", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Psy Jynx", optionalLevel = 250, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Elder Blastoise", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "normal"},
      },
[4] = {{name = "Elder Tangela", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "ultra"},
       {name = "Octopus Octillery", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "normal"}, 
       {name = "Elder Electabuzz", optionalLevel = 250, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Bone Marowak", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "ultra"}, 
       {name = "Master Stantler", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "super"},
       {name = "Tribal Scyther", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "ultra"},
      },
[5] = {{name = "Hard Golem", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "ultra"},  
       {name = "War Heracross", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "ultra"},
       {name = "Furious Ampharos", optionalLevel = 250, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Lava Magmar", optionalLevel = 250, sex = SEX_FEMALE, nick = "", ball = "ultra"},
       {name = "Taekwondo Hitmonlee", optionalLevel = 250, sex = SEX_FEMALE, nick = "", ball = "normal"},
       {name = "Elder Arcanine", optionalLevel = 250, sex = SEX_MALE, nick = "", ball = "ultra"},  
      },    
}
hunterWingeon = {
[1] = {{name = "Psycraft Shiny Alakazam", optionalLevel = 200, sex = SEX_MALE, nick = "Alakazam", ball = "ultra"},
       {name = "Gardestriker Shiny Snorlax", optionalLevel = 200, sex = SEX_FEMALE, nick = "Snorlax", ball = "ultra"},
       {name = "Malefic Shiny Gengar", optionalLevel = 200, sex = SEX_MALE, nick = "Gengar", ball = "normal"},   
       {name = "Naturia Shiny Scyther", optionalLevel = 200, sex = SEX_MALE, nick = "Scyther", ball = "super"},
       {name = "Orebound Shiny Marowak", optionalLevel = 200, sex = SEX_FEMALE, nick = "Marowak", ball = "normal"},
       {name = "Raibolt Shiny Electabuzz", optionalLevel = 200, sex = SEX_MALE, nick = "Electabuzz", ball = "ultra"},
      },
[2] = {{name = "Wingeon Shiny Pidgeot", optionalLevel = 200, sex = SEX_FEMALE, nick = "Pidgeot", ball = "normal"},
       {name = "Seavell Shiny Tentacruel", optionalLevel = 200, sex = SEX_MALE, nick = "Tentacruel", ball = "normal"},   
       {name = "Volcanic Shiny Arcanine", optionalLevel = 200, sex = SEX_MALE, nick = "Arcanine", ball = "super"},
       {name = "Malefic Shiny Muk", optionalLevel = 200, sex = SEX_MALE, nick = "Muk", ball = "ultra"},
       {name = "Psycraft Shiny Hypno", optionalLevel = 200, sex = SEX_FEMALE, nick = "Hypno", ball = "normal"},
       {name = "Gardestriker Shiny Hitmontop", optionalLevel = 200, sex = SEX_MALE, nick = "Hitmontop", ball = "ultra"},
      }, 
[3] = {{name = "Lance Dragonite", optionalLevel = 200, sex = SEX_FEMALE, nick = "Dragonite", ball = "normal"},
       {name = "Lance Gyarados", optionalLevel = 200, sex = SEX_MALE, nick = "Gyarados", ball = "ultra"},
       {name = "Lance Shiny Dragonair", optionalLevel = 200, sex = SEX_MALE, nick = "Dragonair", ball = "normal"},   
       {name = "Lance Aerodactyl", optionalLevel = 200, sex = SEX_MALE, nick = "Aerodactyl", ball = "super"},
       {name = "Lance Charizard", optionalLevel = 200, sex = SEX_FEMALE, nick = "Charizard", ball = "normal"},
       {name = "Lance Dragonair", optionalLevel = 200, sex = SEX_MALE, nick = "Dragonair", ball = "ultra"},
      },
}
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--