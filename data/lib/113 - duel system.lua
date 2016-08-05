--lose, deslogar, render e perder por tempo
duelTable = {
	targetName = 55000,
	pokeballsCount = 55001,
	giveUP = 55002,
	infoBalls = 55003,
	wins = 55004,
	loses = 55005,
	isInDuel = 55006,
	timeToPuch = 60,
	acceptedDuel = 55007
}

function alertToPuchPokeball(p1, lose)
if not isCreature(p1) then return true end
   if not lose then
      doSendMsg(p1, "Você tem 1 minuto para puxar um pokemon ou perderar o duelo.")
	  addEvent(alertToPuchPokeball, duelTable.timeToPuch * 1000, p1, true)
   else
      if #getCreatureSummons(p1) <= 0 then
	     local p2 = getPlayerByName(getPlayerAdvers(p1)) 
		 doWin(p2)
	     doLoser(p1)
	     doSendMsg(p2, "O jogador " .. getCreatureName(p1) .. ", expirou o tempo de espera do duelo e você ganhou.")
      end
	end
end

function checkGiveUp(cid)
if getPlayerStorageValue(cid, duelTable.giveUP) >= 1 and getCreatureSkullType(cid) == SKULL_WHITE then --- player 1 desistiu/puxou poke/ poke morreu antes comecar o duel
	   local p2 = getPlayerByName(getPlayerAdvers(cid))
	   doWin(p2)
	   doGiveUP(cid) 
	end
end

function isInDuel(p1)
if not isCreature(p1) then return true end
   if getPlayerStorageValue(p1, duelTable.isInDuel) >= 1 then 
    return true 
   end
   return false
end

function CanAttackerInDuel(p1, p2)
if not isCreature(p1) or not isCreature(p2) then return true end
   if getPlayerStorageValue(p1, duelTable.isInDuel) >= 1 and getPlayerAdvers(p1) == getCreatureName(p2) and getPlayerAdvers(p2) == getCreatureName(p1) then 
    return true 
   end
   return false
end

function doRemoveCountPokemon(p1)
if not isCreature(p1) then return true end
	setPlayerStorageValue(p1, duelTable.pokeballsCount, getPlayerStorageValue(p1, duelTable.pokeballsCount) -1)
	doSendAnimatedText(getThingPos(p1), "POKEDOWN!", 215) -- corzinha
	
	
	
	if getPokemonsCount(p1) == 0 then
	   local p2 = getPlayerByName(getPlayerAdvers(p1))
	   doWin(p2)
	   doLoser(p1)
	   doLoogoutInDuel(p1)
	else
	   alertToPuchPokeball(p1, false)
    end	   
end

function doLoogoutInDuel(p1)
if not isCreature(p1) then return true end
local p2 = getPlayerByName(getPlayerAdvers(p1))
doEreaseDuel(p1)
if not p2 then 
   return true
elseif not isInDuel(p1) and isCreature(p2) then
	doEreaseDuel(p2)
end
	if getCreatureSkullType(p1) == SKULL_WHITE then
		doWin(p2)
		doGiveUP(p1)
	end
end

function doWin(p1)
if not isCreature(p1) then return true end
	doSendAnimatedText(getThingPos(p1), "WIN!", 215)
	setPlayerStorageValue(p2, duelTable.wins, getPlayerStorageValue(p1, duelTable.wins) +1)
	doSendMsg(p1, "Voce ganhou o duelo.")
	doEreaseDuel(p1)
end

function doGiveUP(p1) 
if not isCreature(p1) then return true end
	doSendAnimatedText(getThingPos(p1), "GIVE UP!", COLOR_WATER)
	setPlayerStorageValue(p1, duelTable.loses, getPlayerStorageValue(p1, duelTable.loses) +1)
	doSendMsg(p1, "Voce desistiu o duelo.")
	doEreaseDuel(p1)
end

function doLoser(p1)
if not isCreature(p1) then return true end
   doSendAnimatedText(getThingPos(p1), "LOSER!", 180)
   setPlayerStorageValue(p1, duelTable.loses, getPlayerStorageValue(p1, duelTable.loses) +1)
   doSendMsg(p1, "Voce perdeu o duelo.")
   doEreaseDuel(p1)
end

function getPokemonsCount(p1)
	return getPlayerStorageValue(p1, duelTable.pokeballsCount)
end

function getPlayerAdvers(cid) return getPlayerStorageValue(cid, duelTable.targetName) end

function doIniteDuel(p1, p2, pokeballsCount) -- checar as pokebolas
if not isCreature(p1) or not isCreature(p2) then return true end
if #getLivePokeballs(p1, getPlayerSlotItem(p1, 3).uid, true) < pokeballsCount then  doSendMsg(p1, "Você não tem a quantidade de pokemon exigida para este duelo.") return true end
if #getCreatureSummons(p1) <= 0 then doSendMsg(p1, "Puxe um pokemon para invitar o jogador (" .. getCreatureName(p2) .. ").") return true end
if getCreatureSkullType(p1) == SKULL_WHITE then
    doSendMsg(p1, "Você já está em um duel.")
	return true
elseif getCreatureSkullType(p1) == 1 then
    doSendMsg(p1, "Você já convidou um player. Aguarde a reposta dele.")
	return true
elseif getCreatureSkullType(p1) == 2 then
    doSendMsg(p1, "Você já foi convidou para um duel.")
	return true
end
if getCreatureSkullType(p2) == SKULL_WHITE then
	doSendMsg(p1, "Este player já está em um duel.")
	return true
elseif getCreatureSkullType(p2) == 1 then
	doSendMsg(p1, "Este player está convidando um player para duel.")
	return true
elseif getCreatureSkullType(p2) == 2 then
	doSendMsg(p1, "Este player já foi convidando para um duel.")
	return true
end

if getTileInfo(getThingPos(getCreatureSummons(p1)[1])).protection then
    doSendMsg(p1, "Retire seu pokemon da pz para convidar alguem para o duel.")
	return true
end
if getTileInfo(getThingPos(p1)).protection then
    doSendMsg(p1, "Saia da pz para convidar alguem para o duel.")
	return true
end
if getDistanceBetween(getThingPos(p2), getThingPos(p1)) > 3 then
   doSendMsg(p1, "Chegue mais perto de seu adversário.")
   return true
end

	setPlayerStorageValue(p1, duelTable.targetName, getPlayerName(p2))
	setPlayerStorageValue(p1, duelTable.infoBalls, pokeballsCount)
	setPlayerStorageValue(p2, duelTable.targetName, getPlayerName(p1))
	local balls = pokeballsCount .. " pokeball" .. (pokeballsCount > 1 and "s" or "")
	
	doCreatureSetSkullType(p1, 1) 
    doCreatureSetSkullType(p2, 2)
	
	doSendMsg(p1, "O jogador (" .. getCreatureName(p2) .. ") foi convidado para o duelo de ".. balls ..". Aguarde a resposta.")
	doSendMsg(p2, "O jogador (" .. getCreatureName(p1) .. ") lhe convidou para um duelo de ".. balls ..".")
	doSendMsg(p2, "Você tem 15 segundos para aceitar o duelo.")
	addEvent(doNotAcceotedDuel, 15 * 1000, p1, p2)
end

function isInvitedDuel(p1, p2)
if not isCreature(p1) or not isCreature(p2) then return true end
	if getPlayerAdvers(p1) == getCreatureName(p2) then
	   return true
    end
	return false
end

function acceptDuel(p1, p2, pokeballsCount)
if not isCreature(p1) or not isCreature(p2) then return true end
if #getLivePokeballs(p1, getPlayerSlotItem(p1, 3).uid, true) < pokeballsCount then  
    doSendMsg(p1, "Você não tem a quantidade de pokemon exigida para este duelo.") 
	doNotAcceotedDuel(p1, p2)
	return true
elseif #getLivePokeballs(p2, getPlayerSlotItem(p2, 3).uid, true) < pokeballsCount then  
    doSendMsg(p2, "Você não tem a quantidade de pokemon exigida para este duelo.") 
	doNotAcceotedDuel(p2, p1)
	return true	
end
if #getCreatureSummons(p1) <= 0 then 
   doNotAcceotedDuel(p1, p2)
   return true 
elseif #getCreatureSummons(p2) <= 0 then 
   doNotAcceotedDuel(p2, p1)
   return true 
end
	
	setPlayerStorageValue(p1, duelTable.pokeballsCount, pokeballsCount) -- quantidade de pokeballs 
	setPlayerStorageValue(p2, duelTable.pokeballsCount, pokeballsCount) -- quantidade de pokeballs 
	
	setPlayerStorageValue(p1, duelTable.isInDuel, 1) -- quantidade de pokeballs 
	setPlayerStorageValue(p2, duelTable.isInDuel, 1) -- quantidade de pokeballs 
    
	doSendAnimatedText(getThingPos(p1), "START!", 215)
	doSendAnimatedText(getThingPos(p2), "START!", 215)
	setPlayerStorageValue(p1, duelTable.giveUP, 0)
	setPlayerStorageValue(p2, duelTable.giveUP, 0)
end

function doPantinNoDuel(p1, p2, pokeballsCount, count)
if not isCreature(p1) or not isCreature(p2) then return true end
if not isInvitedDuel(p1, p2) then return true end
if #getLivePokeballs(p1, getPlayerSlotItem(p1, 3).uid, true) < pokeballsCount then  
   doSendMsg(p1, "Você não tem a quantidade de pokemon exigida para este duelo.") 
   return true 
end

if getCreatureSkullType(p1) ~= SKULL_WHITE and #getCreatureSummons(p1) <= 0 then doSendMsg(p1, "Puxe um pokemon para aceitar o jogador (" .. getCreatureName(p2) .. ").") return true end	

if getTileInfo(getThingPos(p1)).protection then
    doSendMsg(p1, "Saia da pz para convidar alguem para o duel.")
	return true
end

if getTileInfo(getThingPos(getCreatureSummons(p1)[1])).protection then
    doSendMsg(p1, "Retire seu pokemon da pz para aceitar este duel.")
	return true
end
if getDistanceBetween(getThingPos(p2), getThingPos(p1)) > 3 then
   doSendMsg(p1, "Chege mais perto de seu adversário.")
   return true
end
	
	if count == 0 then
	   acceptDuel(p1, p2, pokeballsCount)
	   return true
	end
	
	setPlayerStorageValue(p1, duelTable.acceptedDuel, 1)
	setPlayerStorageValue(p2, duelTable.acceptedDuel, 1)
	doSendAnimatedText(getThingPos(p1), count.."!", 215)
	doSendAnimatedText(getThingPos(p2), count.."!", 215)
	setPlayerStorageValue(p1, duelTable.giveUP, 1)
	setPlayerStorageValue(p2, duelTable.giveUP, 1)
	addEvent(doPantinNoDuel, 1000, p1, p2, pokeballsCount, count-1)
	doCreatureSetSkullType(p1, SKULL_WHITE) 
	doCreatureSetSkullType(p2, SKULL_WHITE) 
end

function doNotAcceotedDuel(p1, p2)
if not isCreature(p1) or not isCreature(p2) then return true end
--if getPlayerStorageValue(p1, duelTable.acceptedDuel) == 0 or getPlayerStorageValue(p2, duelTable.acceptedDuel) == 0 then return true end -- caso o duelo acabe antes dacontagem de tempo de por poke pra fora
if getPlayerStorageValue(p1, duelTable.acceptedDuel) >= 1 and getPlayerStorageValue(p2, duelTable.acceptedDuel) >= 1 then return true end
if getCreatureSkullType(p1) ~= 1 then
   return true
end
	doEreaseDuel(p1)
	doEreaseDuel(p2)
	doSendMsg(p1, "O player (" .. getCreatureName(p2) .. ") não aceitou o duelo.")
	doSendMsg(p2, "Duelo cancelado.")
	doCreatureSetSkullType(p1, 0) 
    doCreatureSetSkullType(p2, 0)
end

function doEreaseDuel(p1)

	setPlayerStorageValue(p1, duelTable.acceptedDuel, 0)
    setPlayerStorageValue(p1, duelTable.pokeballsCount, 0) -- quantidade de pokeballs  
	setPlayerStorageValue(p1, duelTable.targetName, 0) -- quantidade de pokeballs 
	setPlayerStorageValue(p1, duelTable.giveUP, 0)
	setPlayerStorageValue(p1, duelTable.isInDuel, 0)
	doCreatureSetSkullType(p1, SKULL_NONE)
	doCreatureSetSkullType(p1, SKULL_NONE) 
    
end