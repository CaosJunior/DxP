local megasStones = {15131, 15134, 15135, 15133, 15136, 15780, 15781, 15783, 15784, 15788, 15789, 15790, 15791}
local megasToPlayer = {
	["Alakazite"] = {id = 15131, megaID = "", pokeName = "Alakazam"},
	["Charizardite X"] = {id = 15134, megaID = "X", pokeName = "Charizard"},
	["Charizardite Y"] = {id = 15135, megaID = "Y", pokeName = "Charizard"},
	["Blastoisinite"] = {id = 15133, megaID = "", pokeName = "Blastoise"},	
	["Gengarite"] = {id = 15136, megaID = "", pokeName = "Gengar"},	
	
	["Pidgeotile"] = {id = 15791, megaID = "", pokeName = "Pidgeot"},
	["Venusaurite"] = {id = 15793, megaID = "", pokeName = "Venusaur"},	
	["Kangaskhanite"] = {id = 15783, megaID = "", pokeName = "Kangaskhan"},
	["Aerodactylite"] = {id = 15786, megaID = "", pokeName = "Aerodactyl"},
	["Tyranitarite"] = {id = 15781, megaID = "", pokeName = "Tyranitar"},
	["Ampharosite"] = {id = 15794, megaID = "", pokeName = "Ampharos"},	
	["Scizorite"] = {id = 15784, megaID = "", pokeName = "Scizor"},	
	
	
	["Aggronite"] = {id = 15780, megaID = "", pokeName = "Aggron"},		
	["Blazikenite"] = {id = 15792, megaID = "", pokeName = "Blaziken"},	
	["Mawlite"] = {id = 15782, megaID = "", pokeName = "Mawlite"},	
	["Gardevoirite"] = {id = 15785, megaID = "", pokeName = "Gardevoir"},		
	["Absolite"] = {id = 15787, megaID = "", pokeName = "Absol"},	
	["Lucarionite"] = {id = 15788, megaID = "", pokeName = "Lucario"},	
	["Sceptilite"] = {id = 15789, megaID = "", pokeName = "Sceptile"},	
	["Swampertile"] = {id = 15790, megaID = "", pokeName = "Swampert"},
}
function onSay(cid, words, param, channel)
	local mega = megasStones[math.random(1, #megasStones)]
		
		for a, b in pairs(megasToPlayer) do
			if mega == b.id then 
				addPokeToPlayer(cid, b.pokeName, 0, nil, "yume", true, a)
				break
			end
		end	
	 return true
end

function getSlot(strings, slot)
	local slot1, slot2, slot3 = strings:explode("|")[1], strings:explode("|")[2], strings:explode("|")[3]
	local ret, flag = "", false
	for a, b in pairs(fotos) do
	   if getPortraitClientID(a) == tonumber(slot1) and slot == 1 then 
		  ret = doCorrectString(a)
		  flag = true
	   elseif getPortraitClientID(a) == tonumber(slot2) and slot == 2  then 
		  ret = doCorrectString(a)
		  flag = true
	   elseif getPortraitClientID(a) == tonumber(slot3) and slot == 3 then 
		  ret = doCorrectString(a)
		  flag = true
	   end
		   if flag then
			  break
		   end	
	end
	return ret
end