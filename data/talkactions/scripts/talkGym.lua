function onSay(cid, words, param)
    if gymbadges[param] then
        doPlayerSendCancel(cid, "#getBadges# "..param.." "..getPlayerItemCount(cid, gymbadges[param]))
    end
    return true
end