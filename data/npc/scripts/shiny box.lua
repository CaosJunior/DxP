local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function doBuyPokemonWithCasinoCoins(cid, poke) npcHandler:onSellpokemon(cid) end
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)

if(not npcHandler:isFocused(cid)) then
return false
end

-----------------------------------
--id dos itens{Trace of ghost, Ice orb, Gosme, Pot of Lava, Electric box, Ruby, Water pendant, Bug venom, Bug antenna, Scythe, Pot With Fire, Bone}
local itens = {12194, 12204, 12201, 12202, 12152, 12176, 12188, 12170, 12185, 12184, 12167, 12342, 12208} 
---------
local function checkDex(cid)
local unlock = 0
	for i = 1, #oldpokedex do
		if getPlayerInfoAboutPokemon(cid, oldpokedex[i][1]).dex then
		unlock = unlock + 1
		end
	end
return unlock
end
--------------
local function checkFosseis(cid)
local poke = ""

for a = 1138, 1142 do
    if not getPlayerInfoAboutPokemon(cid, oldpokedex[a-1000][1]).dex then
       if a == 1142 then
          poke = poke..oldpokedex[a-1000][1].."."
       else
          poke = poke..oldpokedex[a-1000][1]..", "
       end
    end       
end
return poke
end
--------------
local function checkItens(cid, itens)
local check = 0
    for i = 1, #itens do
        if getPlayerItemCount(cid, itens[i]) >= 300 then
           check = check + 1
        end       
    end
return check
end
-------------------------------------
if getPlayerStorageValue(cid, 659875) == 6 then
   selfSay("Você ja completou minhas missões...", cid)
   talkState[cid] = 0
   return false 
end   

if msgcontains(msg, 'mission') and getPlayerStorageValue(cid, 659875) == -1 then
    selfSay("você precisa catar 100 pokemons você ja fez issu?", cid)
    talkState[cid] = 1

elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) and talkState[cid] == 1 and getPlayerStorageValue(cid, 659875) == -1 then
local list = getCatchList(cid)
   if #list >= 100 then 
      selfSay("ohh você é muito bom vamos para a próxima missão?...", cid)
      setPlayerStorageValue(cid, 659875, 1)
   else
      selfSay("Você não catou 100 pokemons volte aqui quando tiver catado...", cid)
      talkState[cid] = 0
      return true
   end
   
elseif msgcontains(msg, 'mission') and getPlayerStorageValue(cid, 659875) == 1 then
       selfSay("Você precisa de 100 pokemons em sua pokedex .. você ja tem eles?", cid)
       talkState[cid] = 2
       
elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) and talkState[cid] == 2 and getPlayerStorageValue(cid, 659875) == 1 then

local check = checkDex(cid)
	if check >= 100 then
       selfSay("ohh você é muito bom vamos para a próxima missão?...", cid)
       setPlayerStorageValue(cid, 659875, 2)
    else
       selfSay("Você não possui 100 pokemons em sua pokedex volte quando tiver eles...", cid)
       talkState[cid] = 0
       return true
    end 

elseif msgcontains(msg, 'mission') and getPlayerStorageValue(cid, 659875) == 2 then
       selfSay("Você precisa ter Artiuno, Ditto, Entei and Aerodactyl na sua pokedex você sera capaz de conseguir?", cid)
       talkState[cid] = 3
       
elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) and talkState[cid] == 3 and getPlayerStorageValue(cid, 659875) == 2 then

local check2 = checkFosseis(cid)
       if check2 == "" then
          selfSay("ohh você é muito bom vamos para a próxima missão.", cid)
          setPlayerStorageValue(cid, 659875, 3)
       else
          selfSay("Você não possui esses pokemons em sua dex: "..check2, cid)
          talkState[cid] = 0
          return true
       end
       
elseif msgcontains(msg, 'mission') and getPlayerStorageValue(cid, 659875) == 3 then
       selfSay("You need be atleast level 200 and have level 80 of fishing, can you do it?", cid)
       talkState[cid] = 4       

elseif (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) and talkState[cid] == 4 and getPlayerStorageValue(cid, 659875) == 3 then
       if getPlayerSkill(cid, 6) >= 80 and getPlayerLevel(cid) >= 200 then
          selfSay("Thank you very much, let me know if you want another mission.", cid)
          setPlayerStorageValue(cid, 659875, 4)
       else
          selfSay("You haven't level 80 of fishing or don't have level 200...", cid)
          talkState[cid] = 0
          return true
       end 
          
elseif msgcontains(msg, 'mission') and getPlayerStorageValue(cid, 659875) == 4 then
      selfSay("You need 300 Future orb, 300 Trace of ghost, 300 Ice orb, 300 Gosme, 300 Pot of Lava, 300 Electric box, 300 Ruby, 300 Water pendant, 300 Bug venom, 300 Bug antenna, 300 Scythe, 300 Pot With Fire and 300 Bone, can you bring it?", cid)
      talkState[cid] = 5
  
elseif (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) and talkState[cid] == 5 and getPlayerStorageValue(cid, 659875) == 4 then

local check3 = checkItens(cid, itens)
    if check3 == #itens then
       for a = 1, #itens do
           doPlayerRemoveItem(cid, itens[a], 300)
       end
       selfSay("Thank you very much, let me know if you want another mission.", cid)
       setPlayerStorageValue(cid, 659875, 5)
    else
       selfSay("You don't have some item which i asked for you...", cid)
       talkState[cid] = 0
       return true
    end      

elseif msgcontains(msg, 'mission') and getPlayerStorageValue(cid, 659875) == 5 then
       selfSay("You need atleast 140 pokemons in your pokedex, can you do it?", cid)
       talkState[cid] = 6
       
elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) and talkState[cid] == 6 and getPlayerStorageValue(cid, 659875) == 5 then

local check4 = checkDex(cid)
	if check4 >= 140 then
       selfSay("Thank you very much, take it as a reward...", cid)
       setPlayerStorageValue(cid, 659875, 6)
              doPlayerAddExperience(cid, 5000000)  --premio
       doPlayerAddItem(cid, 12227, 1) --premio
       doPlayerAddItem(cid, 2160, 100) --premio
       doPlayerAddItem(cid, 12618, 5) --premio
    else
       selfSay("You haven't 140 pokemons in your pokedex yet, come back when you do that...", cid)
       talkState[cid] = 0
       return true
    end 
    
elseif (msgcontains(msg, 'no') or msgcontains(msg, 'nao')) then
     selfSay("So good bye...", cid)
     talkState[cid] = 0
     return false 
end

end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())