function onSay(cid, words, param, channel)
	local storBro = getPlayerStorageValue(cid, storages.BrotherHoodMember)
	local oldCount = getPlayerStorageValue(cid, storages.PLAYERCONTRACTSCOUNTS)
	if storBro == -1 then 
	   doSendMsg(cid, "Você não é membro da Duelist Brotherhood.")
	   return true 
	elseif storBro == 1 then
	   doSendMsg(cid, "Você já concluiu ".. oldCount .."/1000 contrato".. (oldCount > 1 and "s" or "") .." no nivel " .. getPlayerRankNivel(cid) .. ".")
	elseif storBro == 2 then	
	   doSendMsg(cid, "Você já concluiu ".. oldCount .."/5 contrato".. (oldCount > 1 and "s" or "") .." lendarios .")
	else
	   doSendMsg(cid, "Você já concluiu a Duelist Brotherhood Quest.")
	end
   return true
end
