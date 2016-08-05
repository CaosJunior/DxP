function onStartup()

	db.executeQuery("UPDATE `players` SET `online` = 0 WHERE `world_id` = " .. getConfigValue('worldId') .. ";")
    endGoldenArena(true)   --alterado v1.7
    --installRankGolden()

return true
end