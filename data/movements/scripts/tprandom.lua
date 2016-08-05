function onStepIn(cid, item, position, fromPosition)
location = {
{x=519, y=1531, z=9}, -- Adicione uma coordenada
{x=574, y=1532, z=9}, -- Adicione uma coordenada
{x=630, y=1532, z=9}, -- Adicione uma coordenada
}

return doTeleportThing(cid, location[math.random(#location)])
end