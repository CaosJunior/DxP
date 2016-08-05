-- ///////////////////////////////////////////////////
-- //// Fly System By Darkhaos ////
-- ////////////////////// V. 0.2 /////////////////////
-- ////////////////// Contact: Otland/////////////////
-- ///////////////////////////////////////////////////

FLY_STORAGE = getConfigValue("flyStorage")

flyBlackSQM = false
nonFlyableBorder = {7576, 7577}
changeSpeed = true
flySpeed = 800
waterSpeed = 150

ITEM_FLYTILE = 460
ITEM_WATERTILE = 4625
FLY_OUTFIT = {lookType = 239, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookTypeEx = 0, lookAddons = 0}
WATER = {4608, 4609, 4610, 4611, 4612, 4613, 4614, 4615, 4616, 4617, 4618, 4619}
WATER_BORDERS = {4620, 4621, 4622, 4623, 4624, 4625,
         4632, 4633, 4634, 4635, 4636, 4637, 4638, 4639, 4640, 4641, 4642, 4643,
         4644, 4645, 4646, 4647, 4648, 4649, 4650, 4651, 4652, 4653, 4654, 4655, 4656, 4657, 4658, 4659, 4660, 4661, 4662, 4663,
         4664, 4665, 4666}

RANGEX = 1
RANGEY = 1 

storPos = {x = 1200, y = 1201, z = 1202}

function isWalkable(pos, creature, proj, pz)
if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid == 0 then return false end
if getTopCreature(pos).uid > 0 and creature then return false end
if getTileInfo(pos).protection and pz then return false, true end
local n = not proj and 3 or 2
for i = 0, 255 do
pos.stackpos = i
local tile = getTileThingByPos(pos)
if tile.itemid ~= 0 and not isCreature(tile.uid) then
if hasProperty(tile.uid, n) or hasProperty(tile.uid, 7) then
return false
end
end
end
return true
end

function getAreaToRemove(pos1, pos2)
local t = getDirectionTo(pos1, pos2)
local pos =
{
[0] =
{
{x = pos1.x + 1, y = pos1.y + 1, z = pos1.z},
{x = pos1.x, y = pos1.y + 1, z = pos1.z},
{x = pos1.x - 1, y = pos1.y + 1, z = pos1.z}
},
[2] =
{
{x = pos1.x + 1, y = pos1.y - 1, z = pos1.z},
{x = pos1.x, y = pos1.y - 1, z = pos1.z},
{x = pos1.x - 1, y = pos1.y - 1, z = pos1.z}
},
[1] =
{
{x = pos1.x - 1, y = pos1.y - 1, z = pos1.z},
{x = pos1.x - 1, y = pos1.y, z = pos1.z},
{x = pos1.x - 1, y = pos1.y + 1, z = pos1.z}
},
[3] =
{
{x = pos1.x + 1, y = pos1.y - 1, z = pos1.z},
{x = pos1.x + 1, y = pos1.y, z = pos1.z},
{x = pos1.x + 1, y = pos1.y + 1, z = pos1.z}
},
[7] =
{
{x = pos1.x - 1, y = pos1.y - 1, z = pos1.z},
{x = pos1.x - 1, y = pos1.y, z = pos1.z},
{x = pos1.x - 1, y = pos1.y + 1, z = pos1.z},
{x = pos1.x, y = pos1.y + 1, z = pos1.z},
{x = pos1.x + 1, y = pos1.y + 1, z = pos1.z}
},
[6] = 
{
{x = pos1.x + 1, y = pos1.y - 1, z = pos1.z},
{x = pos1.x + 1, y = pos1.y, z = pos1.z},
{x = pos1.x + 1, y = pos1.y + 1, z = pos1.z},
{x = pos1.x, y = pos1.y + 1, z = pos1.z},
{x = pos1.x - 1, y = pos1.y + 1, z = pos1.z}
},
[5] =
{
{x = pos1.x - 1, y = pos1.y - 1, z = pos1.z},
{x = pos1.x - 1, y = pos1.y, z = pos1.z},
{x = pos1.x - 1, y = pos1.y + 1, z = pos1.z},
{x = pos1.x, y = pos1.y - 1, z = pos1.z},
{x = pos1.x + 1, y = pos1.y - 1, z = pos1.z}
},
[4] =
{
{x = pos1.x - 1, y = pos1.y - 1, z = pos1.z},
{x = pos1.x, y = pos1.y - 1, z = pos1.z},
{x = pos1.x + 1, y = pos1.y - 1, z = pos1.z},
{x = pos1.x + 1, y = pos1.y, z = pos1.z},
{x = pos1.x + 1, y = pos1.y + 1, z = pos1.z}
}
}
return pos[t]
end

function doCreateTile(pos)
doAreaCombatHealth(0, 0, pos, 0, 0, 0, 2)
end