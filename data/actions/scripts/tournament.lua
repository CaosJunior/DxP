function onUse(cid, item)

if #getPlayersInArea(torneio.area) > 1 then
doPlayerSendTextMessage(cid, 20 ,"Finish with others first, young warrior!") return true end

doTeleportThing(cid, torneio.playerTemple)
doPlayerSendTextMessage(cid, 21, "Young warrior Congratulations, you won the tournament, and won one "..getItemNameById(torneio.awardTournament).." as a reward.")
doPlayerAddItem(cid, torneio.awardTournament, torneio.awardAmount)
return true
end