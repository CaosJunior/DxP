local starterpokes = {
["Bulbasaur"] = {x = 47, y = 44, z = 7},
["Squirtle"] = {x = 49, y = 44, z = 7},
["Charmander"] = {x = 51, y = 44, z = 7},
}

local btype = "Icone"

function onUse(cid, item, frompos, item2, topos)


	local pokemon = ""

	for a, b in pairs (starterpokes) do
		if isPosEqualPos(topos, b) then
			pokemon = a
		end
	end
    if pokemon == "" then return true end
	
	doPlayerSendTextMessage(cid, 27, "Você recebeu seu primeiro pokemon e um kit inicial...Boa Sorte em sua Jornada.")

    addPokeToPlayer(cid, pokemon, 0, nil, btype, true)
    doPlayerAddItem(cid, 2392, 30)
    doPlayerAddItem(cid, 12349, 100)
    doPlayerAddItem(cid, 12347, 30)
    doPlayerAddItem(cid, 12344, 10)
    doPlayerAddItem(cid, 2160, 1)
     setPlayerStorageValue(cid, 8955, 1)

	doSendMagicEffect(getThingPos(cid), 29)
	doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
	doSendMagicEffect(getThingPos(cid), 27)
	doSendMagicEffect(getThingPos(cid), 29)
	

return TRUE
end