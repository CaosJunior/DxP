local function sendBrokesMsg2(cid, name, str)                       --alterado v1.9 \/ TUDO!!
if not isCreature(cid) then return false end
local storage = getPlayerStorageValue(cid, str)
if storage == -1 then
   return sendMsgToPlayer(cid, 27, "Você ainda não gastou nenhuma ball para capturar esse pokemon!")
end

local t = "normal = (.-), great = (.-), super = (.-), ultra = (.-), saffari = (.-), dark = (.-), magu = (.-), sora = (.-), yume = (.-), dusk = (.-), tale = (.-), moon = (.-), net = (.-), premier = (.-), tinker = (.-), fast = (.-), heavy = (.-);"
local msg = {}
table.insert(msg, "Você ja gastou: ")

for n, g, s, u, s2, d, magu, sora, yume, dusk, tale, moon, net, premier, tinker, fast, heavy in storage:gmatch(t) do
    if tonumber(n) and tonumber(n) > 0 then 
       table.insert(msg, tostring(n).." Poke ball".. (tonumber(n) > 1 and "s" or "")) 
	   countN = tonumber(n)
    end
    if tonumber(g) and tonumber(g) > 0 then 
       table.insert(msg, (#msg > 1 and ", " or "").. tostring(g).." Great ball".. (tonumber(g) > 1 and "s" or "")) 
	   countG = tonumber(g)
    end
	if tonumber(s) and tonumber(s) > 0 then 
       table.insert(msg, (#msg > 1 and ", " or "").. tostring(s).." Ultra ball".. (tonumber(s) > 1 and "s" or "")) 
	   countS = tonumber(s)
    end
    if tonumber(u) and tonumber(u) > 0 then 
       table.insert(msg, (#msg > 1 and ", " or "").. tostring(u).." Ultra ball".. (tonumber(u) > 1 and "s" or "")) 
	   countU = tonumber(u)
    end
    if tonumber(s2) and tonumber(s2) > 0 then 
       table.insert(msg, (#msg > 1 and ", " or "").. tostring(s2).." Saffari ball".. (tonumber(s2) > 1 and "s" or "")) 
	   countS2 = tonumber(s2)
    end
	
	if tonumber(magu) and tonumber(magu) > 0 then 
       table.insert(msg, (#msg > 1 and ", " or "").. tostring(magu).." Magu ball".. (tonumber(magu) > 1 and "s" or "")) 
	   maguCount = tonumber(magu)
    end
	
	if tonumber(sora) and tonumber(sora) > 0 then 
       table.insert(msg, (#msg > 1 and ", " or "").. tostring(sora).." Sora ball".. (tonumber(sora) > 1 and "s" or "")) 
	   soraCount = tonumber(sora)
    end
	
	if tonumber(yume) and tonumber(yume) > 0 then 
       table.insert(msg, (#msg > 1 and ", " or "").. tostring(yume).." Yume ball".. (tonumber(yume) > 1 and "s" or "")) 
	   yumeCount = tonumber(yume)
    end
	
	if tonumber(dusk) and tonumber(dusk) > 0 then 
       table.insert(msg, (#msg > 1 and ", " or "").. tostring(dusk).." Dusk ball".. (tonumber(dusk) > 1 and "s" or "")) 
	   duskCount = tonumber(dusk)
    end
	
	if tonumber(tale) and tonumber(tale) > 0 then 
       table.insert(msg, (#msg > 1 and ", " or "").. tostring(tale).." Tale ball".. (tonumber(tale) > 1 and "s" or "")) 
	   taleCount = tonumber(tale)
    end
	
	if tonumber(moon) and tonumber(moon) > 0 then 
       table.insert(msg, (#msg > 1 and ", " or "").. tostring(moon).." Moon ball".. (tonumber(moon) > 1 and "s" or "")) 
	   moonCount = tonumber(moon)
    end
	
	if tonumber(net) and tonumber(net) > 0 then 
       table.insert(msg, (#msg > 1 and ", " or "").. tostring(net).." Net ball".. (tonumber(net) > 1 and "s" or "")) 
	   netCount = tonumber(net)
    end
	
	if tonumber(premier) and tonumber(premier) > 0 then 
       table.insert(msg, (#msg > 1 and ", " or "").. tostring(premier).." Premier ball".. (tonumber(premier) > 1 and "s" or "")) 
	   premierCount = tonumber(premier)
    end
	
	if tonumber(tinker) and tonumber(tinker) > 0 then 
       table.insert(msg, (#msg > 1 and ", " or "").. tostring(tinker).." Tinker ball".. (tonumber(tinker) > 1 and "s" or "")) 
	   tinkerCount = tonumber(tinker)
    end
	
	if tonumber(fast) and tonumber(fast) > 0 then 
       table.insert(msg, (#msg > 1 and ", " or "").. tostring(fast).." Fast ball".. (tonumber(fast) > 1 and "s" or "")) 
	   fastCount = tonumber(fast)
    end
	
	if tonumber(heavy) and tonumber(heavy) > 0 then 
       table.insert(msg, (#msg > 1 and ", " or "").. tostring(heavy).." Heavy ball".. (tonumber(heavy) > 1 and "s" or "")) 
	   heavyCount = tonumber(heavy)
    end
end
if #msg == 1 then
   return doPlayerSendTextMessage(cid, 27, "Você ainda não gastou nenhuma ball para catar um "..name..".")
end
if string.sub(msg[#msg], 1, 1) == "," then
   msg[#msg] = " and".. string.sub(msg[#msg], 2, #msg[#msg])
end
table.insert(msg, " tentando capturar um "..name..".")
return sendMsgToPlayer(cid, 27, table.concat(msg))
end

function onSay(cid, words, param)

if(param == '') then
    doPlayerSendTextMessage(cid, 27, "Coloque um nome de pokemon.")
    return true
end

if newpokedex[doCorrectPokemonName(param)] then
   local storage = newpokedex[doCorrectPokemonName(param)].stoCatch
   local name = doCorrectPokemonName(param)
   sendBrokesMsg2(cid, name, storage)
else
   doPlayerSendTextMessage(cid, 27, "Este pokemon não existe.")
end
return true
end