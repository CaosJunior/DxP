function onSay(cid, words, param, channel)
    if (param == '') then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid param specified.")
    else
        local params = string.explode(param, ",")
        if (not params[2]) then
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid param specified.")
        elseif (not getPlayerByNameWildcard(params[1])) then
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Player " .. param .. " not found.")
        else
            local items, item_params = {}, {}
            for i = 2, #params do
                item_params = string.explode(params[i], "x")
                if (#item_params ~= 2 or tonumber(item_params[1]) <= 0 or tonumber(item_params[2]) <= 0) then
                    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid param specified.")
                else
                    items[tonumber(item_params[2])] = tonumber(item_params[1])
                    print(items[tonumber(item_params[2])])
                end
            end
            if (#item_params > 0) then
                doPlayerAddDepotItems(getPlayerByNameWildcard(params[1]), items)
            end
        end
    end

    return true
end