local focus = 0
local talk_start = 0
local target = 0
local following = false
local attacking = false
local talkState = {}
function onThingMove(creature, thing, oldpos, oldstackpos)
end
function onCreatureAppear(creature)
end
function onCreatureDisappear(cid, pos)
if focus == cid then
selfSay('Good bye sir!')
focus = 0
talk_start = 0
end
end

function onCreatureTurn(creature)
end
function msgcontains(txt, str)
return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end
function sellPokemon(cid, name, price)
local pokename = name
local bp = getPlayerSlotItem(cid, CONST_SLOT_BACKPACK)
local itemsball = getItemsInContainerById(bp.uid, 2222)
local itemsultra = getItemsInContainerById(bp.uid, 2220)
for _, pok in pairs(itemsball) do
if string.lower(getItemAttribute(pok, "poke"):sub(9, findLetter(getItemAttribute(pok, "poke"), "'")-1)) == pokename then
if(doPlayerRemoveMoney(cid, 20000000)) then
doRemoveItem(pok, 1)
local health = 7800 -- Health do poke
local maxhealth = 7800 -- Maximo de health do poke
local description = "Contains a Elite Hitmonlee."
local poke1 = "This is Elite Hitmonlee's pokeball. HP = ["..health.."/"..maxhealth.."]"
item = doCreateItemEx(2219)
doItemSetAttribute(item, "poke", poke1)
doItemSetAttribute(item, "nome", "Elite Hitmonlee")
doItemSetAttribute(item, "description", description)
doPlayerAddItemEx(cid, item, true)
doTransformItem(item, 2222)
selfSay('Thank You for letting me train him.')
return true
end
end
end
for _, pok in pairs(itemsultra) do
if string.lower(getItemAttribute(pok, "poke"):sub(9, findLetter(getItemAttribute(pok, "poke"), "'")-1)) == pokename then
if(doPlayerRemoveMoney(cid, 20000000)) then
doRemoveItem(pok, 1)
local health = 7800 -- Health do poke
local maxhealth = 7800 -- Maximo de health do poke
local description = "Contains a Elite Hitmonlee."
local poke1 = "This is Elite Hitmonlee's pokeball. HP = ["..health.."/"..maxhealth.."]"
item = doCreateItemEx(2219)
doItemSetAttribute(item, "poke", poke1)
doItemSetAttribute(item, "nome", "Elite Hitmonlee")
doItemSetAttribute(item, "description", description)
doPlayerAddItemEx(cid, item, true)
doTransformItem(item, 2220)
selfSay('Thank You for letting me train him.')
return true
end
end
end
selfSay('Hey, you do not have that pokemon or the amount of money we agreed!')
end
function sellPokemonn(cid, name, price)
local pokename = name
local bp = getPlayerSlotItem(cid, CONST_SLOT_BACKPACK)
local itemsball = getItemsInContainerById(bp.uid, 2222)
local itemsultra = getItemsInContainerById(bp.uid, 2220)
for _, pok in pairs(itemsball) do
if string.lower(getItemAttribute(pok, "poke"):sub(9, findLetter(getItemAttribute(pok, "poke"), "'")-1)) == pokename then
if(doPlayerRemoveMoney(cid, 20000000)) then
doRemoveItem(pok, 1)
local health = 7800 -- Health do poke
local maxhealth = 7800 -- Maximo de health do poke
local description = "Contains a Elite Hitmonchan."
local poke1 = "This is Elite Hitmonchan's pokeball. HP = ["..health.."/"..maxhealth.."]"
item = doCreateItemEx(2219)
doItemSetAttribute(item, "poke", poke1)
doItemSetAttribute(item, "nome", "Elite Hitmonchan")
doItemSetAttribute(item, "description", description)
doPlayerAddItemEx(cid, item, true)
doTransformItem(item, 2222)
selfSay('Thank You for letting me train him.')
return true
end
end
end
for _, pok in pairs(itemsultra) do
if string.lower(getItemAttribute(pok, "poke"):sub(9, findLetter(getItemAttribute(pok, "poke"), "'")-1)) == pokename then
if(doPlayerRemoveMoney(cid, 20000000)) then
doRemoveItem(pok, 1)
local health = 7800 -- Health do poke
local maxhealth = 7800 -- Maximo de health do poke
local description = "Contains a Elite Hitmonchan."
local poke1 = "This is Elite Hitmonchan's pokeball. HP = ["..health.."/"..maxhealth.."]"
item = doCreateItemEx(2219)
doItemSetAttribute(item, "poke", poke1)
doItemSetAttribute(item, "nome", "Elite Hitmonchan")
doItemSetAttribute(item, "description", description)
doPlayerAddItemEx(cid, item, true)
doTransformItem(item, 2220)
selfSay('Thank You for letting me train him.')
return true
end
end
end
selfSay('Hey, you do not have that pokemon or the amount of money we agreed!')
end
function onCreatureSay(cid, type, msg)
local msg = string.lower(msg)
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
if (msgcontains(msg, 'bye') and focus == cid) then
selfSay('See you around then!')
focus = 0
elseif (msgcontains(msg, 'hi') and (focus == 0) and (focus ~= cid) and (getDistanceToCreature(cid) <= 4)) then selfSay('Welcome! I train pokemons fighters, you have a fighter pokemon?.') focus = cid talkState[talkUser] = 1 talk_start = os.clock() elseif (msgcontains(msg, 'machamp') and talkState[talkUser] == 1 and focus == cid) then selfSay('It is impossible to defend against punches and chops distributed by his four arms. It has a great fighting spirit.') elseif (msgcontains(msg, 'thx') and talkState[talkUser] == 1 and focus == cid) then selfSay('Its nothing, tell me if you need something more.') talkState[talkUser] = 1 ---------------------------------------------------------------- elseif (msgcontains(msg, 'machoke') and talkState[talkUser] == 1 and focus == cid) then selfSay('It has a powerful body, uses a belt to power savings to regulate their movements.') elseif (msgcontains(msg, 'thx') and talkState[talkUser] == 1 and focus == cid) then selfSay('Its nothing, tell me if you need something more.') talkState[talkUser] = 1 ---------------------------------------------------------------- elseif (msgcontains(msg, 'machop') and talkState[talkUser] == 1 and focus == cid) then selfSay('A very good pokemon for intense workouts, has a great facility to master all forms of martial arts.') elseif (msgcontains(msg, 'thx') and talkState[talkUser] ~= 1 and focus == cid) then selfSay('Its nothing, tell me if you need something more.') talkState[talkUser] = 1 ---------------------------------------------------------------- elseif (msgcontains(msg, 'poliwrath') and talkState[talkUser] == 1 and focus == cid) then selfSay('Has developed muscles, the muscles used for quick attacks despite being in the water.') elseif (msgcontains(msg, 'thx') and talkState[talkUser] == 1 and focus == cid) then selfSay('Its nothing, tell me if you need something more.') talkState[talkUser] = 1 ---------------------------------------------------------------- elseif (msgcontains(msg, 'primeape') and talkState[talkUser] == 1 and focus == cid) then selfSay('An angry pokemon. gets even more furious when he lost a fight.') elseif (msgcontains(msg, 'thx') and talkState[talkUser] == 1 and focus == cid) then selfSay('Its nothing, tell me if you need something more.') talkState[talkUser] = 1 ---------------------------------------------------------------- elseif (msgcontains(msg, 'hitmonlee') and talkState[talkUser] == 1 and focus == cid) then selfSay('Interesting! Is a pokemon with legs fast and hard, has devastating kicks. Always wanted to train one of these, if you want I can train him for a sum of 200k. Accepted?') talkState[talkUser] = "hitmonlee" elseif (msgcontains(msg, 'yes') and talkState[talkUser] == "hitmonlee" and focus == cid) then sellPokemon(cid, "hitmonlee", 1) talkState[talkUser] = 1 ---------------------------------------------------------------- elseif (msgcontains(msg, 'hitmonchan') and talkState[talkUser] == 1 and focus == cid) then selfSay('Is a great boxer, a man who never gives up. I always wanted to train one of these. For an amount of 200k I can transform it into a great boxer. Accepted?') talkState[talkUser] = "hitmonchan" elseif (msgcontains(msg, 'yes') and talkState[talkUser] == "hitmonchan" and focus == cid) then sellPokemonn(cid, "hitmonchan", 1) talkState[talkUser] = 1 end end function onThink() if focus == 0 then selfTurn(1) else argx, argy, argz = selfGetPosition() dir = getDirectionTo({x=argx,y=argy,z=argz}, getThingPos(focus)) if dir == 7 then dir = 0 elseif dir == 6 then dir = 3 elseif dir == 5 then dir = 1 elseif dir == 4 then dir = 3 end selfTurn(dir) end if (os.clock() - talk_start) > 59 then
if focus ~= 0 then
selfSay('We have been talking for too much time!')
focus = 0
end
end
if focus ~= 0 then
a, b, c = selfGetPosition()
if c ~= getThingPos(focus).z then
focus = 0
end
end
if focus ~= 0 then
if getDistanceToCreature(focus) > 4 then
selfSay('Come back to sell me pokemons!')
focus = 0
end
end
return true
end