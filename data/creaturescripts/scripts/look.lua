local NPCBattle = {
["Brock"] = {artig = "He is", cidbat = "Pewter"},
["Misty"] = {artig = "She is", cidbat = "Cerulean"}, 
["Blaine"] = {artig = "He is", cidbat = "Cinnabar"},
["Sabrina"] = {artig = "She is", cidbat = "Saffron"},         --alterado v1.9 \/ peguem tudo!
["Kira"] = {artig = "She is", cidbat = "Viridian"},
["Koga"] = {artig = "He is", cidbat = "Fushcia"},
["Erika"] = {artig = "She is", cidbat = "Celadon"},
["Surge"] = {artig = "He is", cidbat = "Vermilion"},
}

local shinys = {
["Shiny Abra"] = "Dark Abra",
["Shiny Onix"] = "Crystal Onix",
["Shiny Gyarados"] = "Red Gyarados",
["Shiny Charizard"] = "Elder Charizard",
["Shiny Venusaur"] = "Ancient Venusaur",
["Shiny Blastoise"] = "Ancient Blastoise",
["Shiny Farfetch'd"] = "Elite Farfetch'd",
["Shiny Hitmonlee"] = "Elite Hitmonlee",
["Shiny Himonchan"] = "Elite Hitmonchan",
["Shiny Snorlax"] = "Big Snorlax",
}


function onLook(cid, thing, position, lookDistance)
                                                        
local str = {}
local isTrade = false
if lookDistance == 0 then isTrade = true end -- trade lookDistanc end
			   
if not isCreature(thing.uid) then
   local iname = getItemInfo(thing.itemid)
   if isPokeball(thing.itemid) and getItemAttribute(thing.uid, "poke") then
      local isDittoBall = isInArray({"Ditto", "Shiny Ditto"}, getItemAttribute(thing.uid, "poke")) and true or false
      unLock(thing.uid)
      local lock = getItemAttribute(thing.uid, "lock")        
      local pokename = isDittoBall and getItemAttribute(thing.uid, "copyName") or getItemAttribute(thing.uid, "poke")
      local heldx = getItemAttribute(thing.uid, "xHeldItem")
	  local heldy = getItemAttribute(thing.uid, "yHeldItem")
	  local megaID = getItemAttribute(thing.uid, "megaID")
	  
	  local pokeBallName = getItemAttribute(thing.uid, "ball")
	  if not pokeBallName then doItemSetAttribute(thing.uid, "ball", "poke") pokeBallName = "Poke" end
		 
	  if isGod(cid) then table.insert(str, "ItemID[".. thing.itemid .."].\n") end
      table.insert(str, "You see ".. doCorrectString(pokeBallName) .."ball.")   
      if getItemAttribute(thing.uid, "unique") then               
         table.insert(str, " It's an unique item.")   
      end
		table.insert(str, "\nIt contains "..getArticle(pokename).." "..pokename.. (isDittoBall and " (Ditto)" or "") .. ".\n") 
      if lock and lock > 0 then
         table.insert(str, "It will unlock in ".. os.date("%d/%m/%y %X", lock)..".\n")  
      end
      local boost = getItemAttribute(thing.uid, "boost") or 0
      if boost > 0 then
         table.insert(str, "Boost level: +"..boost..".\n")
      end
	  
      if getItemAttribute(thing.uid, "nick") then
         table.insert(str, "It's nickname is: "..getItemAttribute(thing.uid, "nick")..".\n")
      end
	  
	  local heldName, heldTier = "", ""
	  local heldYName, heldYTier = "", ""
	  
	  if heldx or heldy then
		   if heldx then heldName, heldTier = string.explode(heldx, "|")[1], string.explode(heldx, "|")[2] end
		   if heldy then heldYName, heldYTier = string.explode(heldy, "|")[1], string.explode(heldy, "|")[2] end
		  local heldString = heldName ..  " (tier: " .. heldTier .. ")"
		  local heldYString = heldYName ..  (not isInArray({"Mega", "GHOST"}, heldYTier) and " (tier: " .. heldYTier .. ")" or "")
			  if heldx and heldy then
				table.insert(str, "Holding: " .. heldString .. " and " .. heldYString .. ". ")
			  elseif heldx then
				table.insert(str, "Holding: "..heldString..". ")
			  elseif heldy then
				table.insert(str, "Holding: "..heldYString ..". ")
			  end
	  end
      doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
      return false
      
   elseif getItemAttribute(thing.uid, "pokeName") and string.find(getItemAttribute(thing.uid, "pokeName"), "fainted") then     
	  local lootName = getItemAttribute(thing.uid, "pokeName")
	  if isGod(cid) then table.insert(str, "ItemID[".. thing.itemid .."].\n") end
	  
      table.insert(str, "You see a "..string.lower(lootName)..". ")     
      if isContainer(thing.uid) then
         table.insert(str, "(Vol: "..getContainerCap(thing.uid)..")")
      end
	  if getItemAttribute(thing.uid, "corpseowner") then
		 if getItemAttribute(thing.uid, "corpseowner") == "asçdlkasçldkaçslkdçaskdçaslkdçlsakdçkaslç" then
			table.insert(str, "\nSuicidou-se.")
		 else
	        table.insert(str, "\nEle foi morto por: ("..getItemAttribute(thing.uid, "corpseowner")..")")
		 end
	  end
      doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
      return false

   elseif isContainer(thing.uid) then     --containers

	  if isGod(cid) then table.insert(str, "ItemID[".. thing.itemid .."].\n") end
   
      if getItemAttribute(thing.uid, "iname") then
	     table.insert(str, "You see "..iname.article.." "..iname.name..". (Vol:"..getContainerCap(thing.uid)..").")
         table.insert(str, getItemAttribute(thing.uid, "iname")..".")
      else   
         table.insert(str, "You see "..iname.article.." "..iname.name..". (Vol:"..getContainerCap(thing.uid)..").")
      end
      if getPlayerGroupId(cid) >= 4 and getPlayerGroupId(cid) <= 6 then
         table.insert(str, "\nItemID: ["..thing.itemid.."]")     
         local pos = getThingPos(thing.uid)
         table.insert(str, "\nPosition: [X: "..pos.x.."][Y: "..pos.y.."][Z: "..pos.z.."]")  
      end
      doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
      return false
      
   elseif getItemAttribute(thing.uid, "unique") then  
	
		if isGod(cid) then table.insert(str, "ItemID[".. thing.itemid .."].\n") end
		
      local p = getThingPos(thing.uid)
   
      table.insert(str, "You see ")
      if thing.type > 1 then
         table.insert(str, thing.type.." "..iname.plural..".")
      else
         table.insert(str, iname.article.." "..iname.name..".")
      end
      table.insert(str, " It's an unique item.\n"..iname.description)
      
      if getPlayerGroupId(cid) >= 4 and getPlayerGroupId(cid) <= 6 then
         table.insert(str, "\nItemID: ["..thing.itemid.."]")
         table.insert(str, "\nPosition: ["..p.x.."]["..p.y.."]["..p.z.."]")
      end
   
      sendMsgToPlayer(cid, MESSAGE_INFO_DESCR, table.concat(str))
      return false
   else
      return true
   end
end

local npcname = getCreatureName(thing.uid)
if ehNPC(thing.uid) and NPCBattle[npcname] then    --npcs duel
   table.insert(str, "You see "..npcname..". "..NPCBattle[npcname].artig.." leader of the gym from "..NPCBattle[npcname].cidbat..".")
   doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
   return false
end
if getPlayerStorageValue(thing.uid, 697548) ~= -1 then    
   table.insert(str, getPlayerStorageValue(thing.uid, 697548))                                   
   local pos = getThingPos(thing.uid)
   if youAre[getPlayerGroupId(cid)] then
      table.insert(str, "\nPosition: [X: "..pos.x.."][Y: "..pos.y.."][Z: "..pos.z.."]")
   end
   doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))  
   return false
end

if not isPlayer(thing.uid) and not isMonster(thing.uid) then    --outros npcs
   table.insert(str, "You see "..getCreatureName(thing.uid)..".")
   doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
   return false
end

if isPlayer(thing.uid) then     --player
   doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, getPlayerDesc(cid, thing.uid, false))  
return false
end

if getCreatureName(thing.uid) == "Evolution" then return false end

if not isSummon(thing.uid) then   --monstros
   
   table.insert(str, "You see a wild "..string.lower(getCreatureName(thing.uid))..".\n")
   if isGod(cid) then
      table.insert(str, "Hit Points: "..getCreatureHealth(thing.uid).." / "..getCreatureMaxHealth(thing.uid)..".\n")
   end
   doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
   return false

elseif isSummon(thing.uid) and not isPlayer(thing.uid) then  --summons

   local boostlevel = getItemAttribute(getPlayerSlotItem(getCreatureMaster(thing.uid), 8).uid, "boost") or 0
   local isDittoBall = isInArray({"Ditto", "Shiny Ditto"}, getItemAttribute(getPlayerSlotItem(getCreatureMaster(thing.uid), 8).uid, "poke")) and true or false
   if getCreatureMaster(thing.uid) == cid then
      local myball = getPlayerSlotItem(cid, 8).uid
      table.insert(str, "You see your "..doCorrectString(getCreatureName(thing.uid)).. (isDittoBall and " (Ditto)" or "") ..".")
      if boostlevel > 0 then
         table.insert(str, "\nBoost level: +"..boostlevel..".")
      end
      table.insert(str, "\n"..getPokemonHappinessDescription(thing.uid))
      doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
   else
      local health = "\nHit points: "..getCreatureHealth(thing.uid).."/"..getCreatureMaxHealth(thing.uid).."."
      doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You see a "..doCorrectString(getCreatureName(thing.uid)).. (isDittoBall and " (Ditto)" or "") ..".\nIt belongs to "..getCreatureName(getCreatureMaster(thing.uid)).."." .. (isGod(cid) and health or "") )
   end
   return false
end
return true
end