function onSay(cid, words, param)

local typess = {
[1] = "normal",
[2] = "great",
[3] = "super",
[4] = "ultra"
}

if param == "" then
doPlayerSendCancel(cid, 'Command needs parameters, function structure: "/cb [Pokemon Name], [boost], [Gender]".')
return 0
end

local t = string.explode(param, ",")

local name = ""
local gender = 0
local btype = typess[math.random(1, 4)]                --"normal"
local typeee = typess[math.random(1, 4)]
		
	if t[1] == "shiny mr" then
		createBall(cid, "Shiny Mr. Mime", 0)
		return true
	end

if t[1] then
	local n = string.explode(t[1], " ")
	local str = string.sub(n[1], 1, 1)
	local sta = string.sub(n[1], 2, string.len(n[1]))
	name = ""..string.upper(str)..""..string.lower(sta)..""
	if n[2] then
	str = string.sub(n[2], 1, 1)
	sta = string.sub(n[2], 2, string.len(n[2]))
	name = name.." "..string.upper(str)..""..string.lower(sta)..""
	end
	if not pokes[name] then
	doPlayerSendCancel(cid, "Sorry, a pokemon with the name "..name.." doesn't exists.")
	return true
	end
print(""..name.." ball has been created by "..getPlayerName(cid)..".")
end

	createBall(cid, name, t[2])
return 1
end

function createBall(cid, name, boost)
local mypoke = pokes[name]
local happy = 255

local item = doCreateItemEx(2219)
doItemSetAttribute(item, "ball", "poke")
doSetAttributesBallsByPokeName(cid, item, name)
if boost and tonumber(boost) > 0 and tonumber(boost) <= 50 then
   doItemSetAttribute(item, "boost", tonumber(boost))
end
doItemSetAttribute(item, "happy", happy)
if name == "Shiny Hitmonchan" or name == "Hitmonchan" then
   doItemSetAttribute(item, "hands", 0)
end
doItemSetAttribute(item, "description", "Contains a "..name..".")
doItemSetAttribute(item, "fakedesc", "Contains a "..name..".")
local x = pokeballs[name:lower()] or pokeballs[doCorrectString(name)]
	    doPlayerAddItemEx(cid, item, true)		
	    doTransformItem(item, x.on)	
end

