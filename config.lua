accountManager = false
namelockManager = false
newPlayerChooseVoc = false
newPlayerSpawnPosX = 1021
newPlayerSpawnPosY = 1019
newPlayerSpawnPosZ = 7
newPlayerTownId = 1
newPlayerLevel = 10
newPlayerMagicLevel = 0
generateAccountNumber = false

lightInterval = 7500
lightChange = 1
startupTime = 351
startupLight = 40

limitPokeballs = 7				
minHappinessEffectDelay = 25	
maxHappinessEffectDelay = 40	
PokemonStageVeryHappy = 0			
maximumHunger = -1		
stateHunger = -1			
useTeleportWithFly = false
dropHappyDuringBattles = false	

	--adicionadas
	  ghostPokemonNames = "Gastly, Haunter, Gengar"

allowBlockSpawn = false
	
rateGymSpellInterval = 0.10

redSkullLength = 30000 * 24 * 60 * 60
blackSkullLength = 45000 * 24 * 60 * 60
dailyFragsToRedSkull = 3
weeklyFragsToRedSkull = 5
monthlyFragsToRedSkull = 10
dailyFragsToBlackSkull = dailyFragsToRedSkull
weeklyFragsToBlackSkull = weeklyFragsToRedSkull
monthlyFragsToBlackSkull = monthlyFragsToRedSkull
dailyFragsToBanishment = dailyFragsToRedSkull
weeklyFragsToBanishment = weeklyFragsToRedSkull
monthlyFragsToBanishment = monthlyFragsToRedSkull
blackSkulledDeathHealth = 40
blackSkulledDeathMana = 0
useBlackSkull = true
useFragHandler = true
advancedFragList = false

notationsToBan = 3
warningsToFinalBan = 4
warningsToDeletion = 5
banLength = 7 * 24 * 60 * 60
killsBanLength = 7 * 24 * 60 * 60
finalBanLength = 30 * 24 * 60 * 60
ipBanishmentLength = 1 * 24 * 60 * 60
broadcastBanishments = true
maxViolationCommentSize = 200
violationNameReportActionType = 2
autoBanishUnknownBytes = false

worldType = "pvp"
protectionLevel = 1000
pvpTileIgnoreLevelAndVocationProtection = true
pzLocked = 5 * 1000
huntingDuration = 60 * 1000
criticalHitChance = 7
criticalHitMultiplier = 1
displayCriticalHitNotify = false
removeWeaponAmmunition = true
removeWeaponCharges = true
removeRuneCharges = true
whiteSkullTime = 150000 * 60 * 1000
noDamageToSameLookfeet = false
showHealingDamage = false
showHealingDamageForMonsters = false
fieldOwnershipDuration = 5 * 1000
stopAttackingAtExit = false
oldConditionAccuracy = false
loginProtectionPeriod = 10 * 1000
deathLostPercent = 1
stairhopDelay = 0 * 1000
pushCreatureDelay = 1 * 1000
deathContainerId = 0
gainExperienceColor = 215
addManaSpentInPvPZone = true
squareColor = 0
allowFightback = true

worldId = 0
ip = "127.0.0.1" -- "25.68.80.168"
bindOnlyConfiguredIpAddress = false
loginPort = 7171
gamePort = 7172
adminPort = 7171
statusPort = 7171
loginTries = 10
retryTimeout = 5 * 1000
loginTimeout = 60 * 1000
maxPlayers = 90	-- codificado e limitado para 7
motd = "Bem Vindo ao DarkXPoke!"
displayOnOrOffAtCharlist = false
onePlayerOnlinePerAccount = false
allowClones = true
serverName = "DarkXPoke"
loginMessage = "Bem Vindo Ao DarkXPoke!"
statusTimeout = 5 * 60 * 1000
replaceKickOnLogin = true
forceSlowConnectionsToDisconnect = false
loginOnlyWithLoginServer = false
premiumPlayerSkipWaitList = true

sqlType = "mysql"
sqlHost = "localhost"
sqlPort = 3306
sqlUser = "root"
sqlPass = "SENHA MYSQL AQUI"
sqlDatabase = "dxp"
sqlFile = "DarkXPoke.s3db"
sqlKeepAlive = 0
mysqlReadTimeout = 10
mysqlWriteTimeout = 10
encryptionType = "sha1"

deathListEnabled = true
deathListRequiredTime = 1 * 60 * 1000
deathAssistCount = 19
maxDeathRecords = 10

ingameGuildManagement = true
levelToFormGuild = 40
premiumDaysToFormGuild = 0
guildNameMinLength = 2
guildNameMaxLength = 25

highscoreDisplayPlayers = 15
updateHighscoresAfterMinutes = 60

buyableAndSellableHouses = true
houseNeedPremium = true
bedsRequirePremium = true
levelToBuyHouse = 1
housesPerAccount = 0
houseRentAsPrice = true -- 
housePriceAsRent = false
housePriceEachSquare = 2975
houseRentPeriod = "never"
houseCleanOld = 0 -- tava 0
guildHalls = false

timeBetweenActions = 500
timeBetweenExActions = 500
hotkeyAimbotEnabled = true

mapName = "DarkXPoke"
mapAuthor = "Three"
randomizeTiles = true
storeTrash = false
cleanProtectedZones = true
mailboxDisabledTowns = "1"

defaultPriority = "high"
niceLevel = 5
coresUsed = "-1"

optimizeDatabaseAtStartup = true
removePremiumOnInit = true
confirmOutdatedVersion = false

formulaLevel = 5.0
formulaMagic = 1.0
bufferMutedOnSpellFailure = false
spellNameInsteadOfWords = false
emoteSpells = false

allowChangeOutfit = true
allowChangeColors = true
allowChangeAddons = true
disableOutfitsForPrivilegedPlayers = false
addonsOnlyPremium = false

dataDirectory = "data/"
bankSystem = true
displaySkillLevelOnAdvance = false
promptExceptionTracerErrorBox = true
separateViplistPerCharacter = false
maximumDoorLevel = 500
maxMessageBuffer = 10000000

saveGlobalStorage = false
useHouseDataStorage = false
storePlayerDirection = false

checkCorpseOwner = true
monsterLootMessage = 3
monsterLootMessageType = 22

ghostModeInvisibleEffect = false
ghostModeSpellEffects = false

idleWarningTime = 14 * 60 * 1000
idleKickTime = 15 * 60 * 1000
expireReportsAfterReads = 1
playerQueryDeepness = 2
maxItemsPerPZTile = 0
maxItemsPerHouseTile = 0

freePremium = true
premiumForPromotion = true

blessingOnlyPremium = true
blessingReductionBase = 30
blessingReductionDecreament = 5
eachBlessReduction = 8

experienceStages = true
rateExperience = 1000
premiumrateExperience = 2000
ratePremiumExperience = 2000
rateExperienceFromPlayers = 200
rateSkill = 1
rateMagic = 1.0
rateLoot = 15
rateSpawn = 1

rateMonsterHealth = 1.0
rateMonsterMana = 1.0
rateMonsterAttack = 1.0
rateMonsterDefense = 1.0

minLevelThresholdForKilledPlayer = 0.9
maxLevelThresholdForKilledPlayer = 1.1

rateStaminaLoss = 1
rateStaminaGain = 3
rateStaminaThresholdGain = 12
staminaRatingLimitTop = 41 * 60
staminaRatingLimitBottom = 14 * 60
rateStaminaAboveNormal = 1.0
rateStaminaUnderNormal = 1.0
staminaThresholdOnlyPremium = true

experienceShareRadiusX = 30
experienceShareRadiusY = 30
experienceShareRadiusZ = 1
experienceShareLevelDifference = 20
extraPartyExperienceLimit = 30
extraPartyExperiencePercent = 20
experienceShareActivity = 2 * 60 * 1000

globalSaveEnabled = false
globalSaveHour = 8
shutdownAtGlobalSave = true
cleanMapAtGlobalSave = false

deSpawnRange = 2
deSpawnRadius = 25

maxPlayerSummons = 1
teleportAllSummons = true
teleportPlayerSummons = true

ownerName = "Taiger"
ownerEmail = ""
url = ""
location = "Brazil"
displayGamemastersWithOnlineCommand = false

adminLogsEnabled = false
displayPlayersLogging = false
prefixChannelLogs = ""
runFile = ""
outLogName = ""
errorLogName = ""
truncateLogsOnStartup = false