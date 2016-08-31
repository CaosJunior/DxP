function onPrepareDeath(cid, lastHitKiller, mostDamageKiller)
  if isPlayer(cid) then
	  return doCreatureSetDropLoot(cid, false)	  
  end
return true
end
