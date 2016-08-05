function onSay(cid, words, param)
    if not tonumber(param) then return true end
    doPlayerSendCancel(cid, "#getSto# ".. getPlayerStorageValue(cid, tonumber(param)))
    return true
    end  