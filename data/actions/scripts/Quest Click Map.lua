local config = {
-- [[Action ID ]]     -- [[REWARD => ID, QUANTIDADE ]] --   
[26840]   =     { {{2160, 1}, {2160, 3}, {2160, 2}}, sto = 8314232, lvl = 15, msg = "Poke Ball" }, --[[ PokeBall Quest ]] --
[26841]   =     { {{2160, 1}, {2160, 3}, {2160, 1}}, sto = 8314233, lvl = 30, msg = "Cerulean"  }, --[[ Cerulean Quest ]] --
[26842]   =     { {{2160, 1}, {2160, 3}, {2160, 1}}, sto = 83142348, lvl = 171, msg = "Rock Stone"}, --[[ Pewter   Quest ]] --
}


function onUse(cid, item, frompos, item2, topos)

local lvl = config[item.actionid].lvl
if getPlayerLevel(cid) < lvl then
   sendMsgToPlayer(cid, 22, "you need: level "..lvl.." to complete this quest.")
   return true
end   

local sto = config[item.actionid].sto
if getPlayerStorageValue(cid, sto) == 1 then
   sendMsgToPlayer(cid, 22, "Sorry, you completed this quest.")
   return true
end

local reward = config[item.actionid][1]
for i = 1, #reward do
 doPlayerAddItem(cid, reward[i][1], reward[i][2])
end

local stox = config[item.actionid].sto
local msg = config[item.actionid].msg
setPlayerStorageValue(cid, stox, 1)
doSendMagicEffect(getThingPos(cid), 28)
doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
sendMsgToPlayer(cid, 22, "congratulations, you complete "..msg.." Quest.")
return true
end		 