torneio = {
awardTournament = 2160,
awardAmount = 50,
playerTemple = {x = 1054, y = 1046, z = 7},
tournamentFight = {x = 1050, y = 1044, z = 10},
area = {fromx = 1043, fromy = 1038, fromz = 10, tox = 1058, toy = 1051, toz= 10},
waitPlace = {x = 1068, y = 1051, z = 10},  
waitArea = {fromx = 1062, fromy = 1046, fromz = 10, tox = 1075, toy = 1054, toz= 10},
startHour = "14:55:00",
endHour = "15:00:00",
price = 30000,
revivePoke = 2494,
}

function getPlayersInArea(area)

local players = {}

for x = area.fromx,area.tox do
for y = area.fromy,area.toy do
for z = area.fromz,area.toz do

local m = getTopCreature({x=x, y=y, z=z}).uid

if m ~= 0 and isPlayer(m) then
table.insert(players, m)
end
end
end
end
return players
end