local position = {x = 529, y = 1162, z = 8} --posici�n al que quieres que lleve

function onUse(cid, item, item2, fromPosition, toPosition, itemEx, toPosition)
     if (getCreatureCondition(cid, CONDITION_INFIGHT) == FALSE) then
      doTeleportThing(cid, position)
        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_TELEPORT)

     else 
     doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
     doCreatureSay(cid, "Espere o Battle sair para poder usar isso!", TALKTYPE_ORANGE_1)
     end
    return true
    end