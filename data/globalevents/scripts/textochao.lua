local config = {
    positions = {
        ["OutlandSul"] = { x = 1026, y = 1074, z = 13 },   
        ["OutlandNorte"] = { x = 1022, y = 1074, z = 13 }, 
        ["OutlandLeste"] = { x = 1030, y = 1074, z = 13 },
        ["Outlands"] = { x = 1026, y = 1068, z = 13 }, 

        ["BoostMachines"] = { x = 1032, y = 1055, z = 13 },
        ["Coliseum"] = { x = 1032, y = 1057, z = 13 },

        ["Sala de Eventos"] = { x = 1044, y = 1047, z = 5 },
		["AREA VIP"] = { x = 1053, y = 1044, z = 5 },

        ["Teleportes"] = { x = 959, y = 1066, z = 13 },
    }
}

function onThink(cid, interval, lastExecution)
    for text, pos in pairs(config.positions) do
        doSendAnimatedText(pos, text, math.random(1, 255))
    end
    
    return TRUE
end  