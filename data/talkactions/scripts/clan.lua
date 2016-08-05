function onSay(cid, words, param, channel)

if param == "" then
return sendMsgToPlayer(cid, 20, "Estao faltam os parametros! [clan name], [rank]")
end
local t = string.explode(param, ",")
local clans = {'Volcanic', 'Seavell', 'Orebound', 'Wingeon', 'Malefic', 'Gardestrike', 'Psycraft', 'Naturia', 'Raibolt', "Ironhard"}
if not isInArray(clans, t[1]) then
   return sendMsgToPlayer(cid, 20, t[1].." nao é uma clan valido!")
elseif not tonumber(t[2]) then
   return sendMsgToPlayer(cid, 20, "Parametros errados! [clan name], [rank].")
end

local rank = tonumber(t[2])
local clan = t[1]

    if getPlayerStorageValue(cid, 92823) < 1 then -- 7575 -- 92823
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Essa é sua primeira vez mudando de clan. Nas próximas, terá o custo de 10 diamonds.")
        doPlayerSendTextMessage(cid, 27, "Agora você pertence ao clan "..clan..", rank: "..rank.."")
        setPlayerClan(cid, clan)
		setPlayerClans(cid, clan)
        setPlayerClanRank(cid, rank)
    else
        if getPlayerItemCount(cid, 2145) < 10 then
            return doPlayerSendCancel(cid, "Você precisa de 10 diamonds para mudar de clan.")
        else
            return doPlayerSendCancel(cid, "Sorry, not possible.")
        end
        if(getPlayerLevel(cid) < 120) then
            return doPlayerSendCancel(cid, "Você estar no level 120.")
        else
            return doPlayerSendCancel(cid, "Sorry, not possible.")
        end
        doPlayerSendTextMessage(cid, 27, "Agora você pertence ao clan "..clan..", rank: "..rank.."")
        doPlayerRemoveItem(cid, 2145, 10)
        setPlayerClan(cid, clan)
        setPlayerClanRank(cid, rank)
    end
    return true

end