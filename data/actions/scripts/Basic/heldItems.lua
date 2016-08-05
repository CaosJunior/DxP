local helds = {
	["X-Attack"] = {t1 = 15559, t2 = 15560, t3 = 15561, t4 = 15562, t5 = 15563, t6 = 15564, t7 = 15565},	
	["X-Block"] = {t1 = 15566, t2 = 15567, t3 = 15568, t4 = 15569, t5 = 15570, t6 = 15571, t7 = 15572},
	["X-Boost"] = {t1 = 15573, t2 = 15574, t3 = 15575, t4 = 15576, t5 = 15577, t6 = 15578, t7 = 15579}, 
	["X-Critical"] = {t1 = 15580, t2 = 15581, t3 = 15582, t4 = 15583, t5 = 15584, t6 = 15585, t7 = 15586}, 
	["X-Defense"] = {t1 = 15587, t2 = 15588, t3 = 15589, t4 = 15590, t5 = 15591, t6 = 15592, t7 = 15593}, 
	["X-Experience"] = {t1 = 15594, t2 = 15595, t3 = 15596, t4 = 15597, t5 = 15598, t6 = 15599, t7 = 15600}, 
	["X-Hellfire"] = {t1 = 15601, t2 = 15602, t3 = 15603, t4 = 15604, t5 = 15605, t6 = 15606, t7 = 15607}, 
	["X-Haste"] = {t1 = 15608, t2 = 15609, t3 = 15610, t4 = 15611, t5 = 15612, t6 = 15613, t7 = 15614}, 
	["X-Lucky"] = {t1 = 15615, t2 = 15616, t3 = 15617, t4 = 15618, t5 = 15619, t6 = 15620, t7 = 15621}, 
	["X-Poison"] = {t1 = 15622, t2 = 15623, t3 = 15624, t4 = 15625, t5 = 15626, t6 = 15627, t7 = 15628}, 
	["X-Return"] = {t1 = 15629, t2 = 15630, t3 = 15631, t4 = 15632, t5 = 15633, t6 = 15634, t7 = 15635}, 
	["X-Vitality"] = {t1 = 15636, t2 = 15637, t3 = 15638, t4 = 15639, t5 = 15640, t6 = 15641, t7 = 15642},
	
	-- Megas
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
	
	["Y-Ghost"] = {id = 15643, megaID = "", pokeName = "none"},	
}

function onUse(cid, item, frompos, item2, topos) 
	
	
	local nick = getPokeballName(item2.uid)
	local heldName = getItemNameById(item.itemid)
	local heldTier = "", 0
	if not isPokeball(item2.itemid) then
	   return doPlayerSendCancel(cid, MSG_NAO_E_POSSIVEL)
	end
	
	if #getCreatureSummons(cid) > 0 or isRiderOrFlyOrSurf(cid) then
		doSendMsg(cid, "Retorne seu pokemon para equipalo com o held item.")
		return true
	end
	
	for a, b in pairs(helds) do
		if string.find(heldName, a) then -- Achei o heldName
		
			if b.id == item.itemid then
			local msg = ""
			    if b.pokeName == "none" then -- held items Y-Ghost
				    doItemSetAttribute(item2.uid, "yHeldItem", a .. "|GHOST")
				    msg = "O " .. heldName .. " foi adicionado a pokebola que contém: " .. nick .. "."
				else
				    if nick ~= b.pokeName then doSendMsg(cid, "Este pokemon não pode usar o " .. heldName .. ".") return true end
					doItemSetAttribute(item2.uid, "yHeldItem",	a .. "|MEGA")
					if b.megaID ~= "" then
					   doItemSetAttribute(item2.uid, "megaID",	b.megaID)
					end
				    msg = "Paranbéns. Agora seu: "  .. nick .. " pode transforma-se em Mega " .. nick .. (b.megaID ~= "" and " " .. b.megaID or "") .."."
				end
					doSendMsg(cid, msg)
				if not isGod(cid) then
				   doRemoveItem(item.uid, 1)
				   doSendMagicEffect(getThingPos(cid), 13)
				end
				return true
			end
		    
			if b.t1 == item.itemid then
				heldTier = 1
			elseif b.t2 == item.itemid then
				heldTier = 2
			elseif b.t3 == item.itemid then
				heldTier = 3
			elseif b.t4 == item.itemid then
				heldTier = 4
			elseif b.t5 == item.itemid then
				heldTier = 5
			elseif b.t6 == item.itemid then
				heldTier = 6
			elseif b.t7 == item.itemid then
				heldTier = 7
			end
			
			--- X-Boost
			-- Caso tenha o X-Boost e queira remover o boost
				if getItemAttribute(item2.uid, "xHeldItem") then
					local oldHeldBooster = string.explode(getItemAttribute(item2.uid, "xHeldItem"), "|")[1]
					local oldHeldBoosterTier = string.explode(getItemAttribute(item2.uid, "xHeldItem"), "|")[2]
						-- Nao adicionar outro held igual ao instalado
						
							if oldHeldBooster == a and tonumber(oldHeldBoosterTier) == heldTier then
							   doSendMsg(cid, "Você não pode usar um held item do mesmo tier duas vezes em um mesmo pokemon.")
							   return true 
							end
					
					if oldHeldBooster == "X-Boost" then
					   local boostLevel = heldBoost[tonumber(string.explode(getItemAttribute(item2.uid, "xHeldItem"), "|")[2])]
					   local ballBoost = getItemAttribute(item2.uid, "boost") or 0
					   local boost = ballBoost - boostLevel 
					   if (boost < 0) then boost = 0 end
					   doItemSetAttribute(item2.uid, "boost", boost)
					end
					
					if oldHeldBooster == "X-Vitality" then
						local pokeLifeMax = pokes[nick].life 
						local boost = getItemAttribute(item2.uid, "boost") or 0
						local masterLevel = getPlayerLevel(cid)
						local life = pokeLifeMax + (pokes[nick].vitality * (masterLevel + boost)) * 12.2
						setBallHealth(item2.uid, life, life)
						portraitSendLifeOTC(cid, item2)
					end
					
					doSendMsg(cid, "O antigo " .. oldHeldBooster .. " (tier: " .. oldHeldBoosterTier .. ") foi removido.")
				end
				
				if a == "X-Boost" then
				   local boostLevel = heldBoost[heldTier]
				   local ballBoost = getItemAttribute(item2.uid, "boost") or 0
				   local boost = ballBoost + boostLevel
				   if (boost > 50) then boost = 50 end
				   doItemSetAttribute(item2.uid, "boost", boost)
				end
				
				if a == "X-Vitality" then
					local heldBonusVitality = heldVitality[tonumber(heldTier)]
					local pokeLifeMax = pokes[nick].life
					local boost = getItemAttribute(item2.uid, "boost") or 0
					local masterLevel = getPlayerLevel(cid)
					local life = (pokeLifeMax + (pokes[nick].vitality * (masterLevel + boost)) * 12.2) * (heldBonusVitality / 100 + 1)
					setBallHealth(item2.uid, life-1, life-1)
					portraitSendLifeOTC(cid, item2)
				end
			
		doItemSetAttribute(item2.uid, "xHeldItem",	a .. "|" .. heldTier)
		doSendMsg(cid, "O " .. heldName .. " foi adicionado a pokebola que contém: " .. nick .. ".")
			if not isGod(cid) then
			   doRemoveItem(item.uid, 1)
			   doSendMagicEffect(getThingPos(cid), 13)
			end
		end
	end
	
	return true
end