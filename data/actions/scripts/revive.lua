local storage = 121212 --storage da quest

function onUse(cid, item, frompos, item2, topos)

if getPlayerStorageValue(cid, storage) == 0 then
   doPlayerSendCancel(cid, "You already have used the limit of revives for this quest.")
   return true
elseif getPlayerStorageValue(cid, 990) >= 1 then
   doPlayerSendCancel(cid, "You can't use revive during gym battles.")
   return true
elseif isInDuel(cid) then
   doPlayerSendCancel(cid, "You can't do that while a duel.") --alterado v1.6
   return true
elseif isPlayer(item2.uid) then
   doPlayerSendCancel(cid, "Please, use revive only on pokeballs.")
   return true
end

for a, b in pairs (pokeballs) do
    if not item2.itemid == b.on or not item2.itemid == b.off then
           doPlayerSendCancel(cid, "Please, use revive only on pokeballs.")
           return true
    end
end

local pokeball = getPlayerSlotItem(cid, 8)
for a, b in pairs (pokeballs) do
    if item2.itemid == b.on or item2.itemid == b.off then --edited deixei igual ao do PXG
           doTransformItem(item2.uid, b.on)
           doSetItemAttribute(item2.uid, "hpToDraw", 0)
           for c = 1, 15 do
                   local str = "move"..c
                   setCD(item2.uid, str, 0)
           end
           setCD(item2.uid, "control", 0)
           setCD(item2.uid, "blink", 0) --alterado v1.6
           doSendMagicEffect(getThingPos(cid), 13)
           doRemoveItem(item.uid, 1)
           doCureBallStatus(getPlayerSlotItem(cid, 8).uid, "all")
           doCureStatus(cid, "all", true)
           cleanBuffs2(item2.uid) --alterado v1.5
           
           if getPlayerStorageValue(cid, storage) > 0 then
                  setPlayerStorageValue(cid, storage, getPlayerStorageValue(cid, storage)-1)
           end
		   doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_POKEMON_HEALTH, getBallMaxHealth(cid, item2).."|"..getBallMaxHealth(cid, item2))
           return true
    end
end
return true
end