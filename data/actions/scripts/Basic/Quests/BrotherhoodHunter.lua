function onUse(cid, item, frompos, item2, topos) 

	if item.itemid == 16177 then
	   doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_PLAYER_SHOW_TRADE_HELD, "open")
	   return true
	end

	if not isBrotherHoodMember(cid) then 
	   doSendMsg(cid, "Você não é um membro da Duelist BrotherHood.")
	   return true
	end
	
	local citys = {
			[13000] = "Saffron",
	       	      }
	
	local playerRankBrother = getPlayerStorageValue(cid, storages.BrotherHoodMemberRANK)
	local desc = getNPCDescByCity(citys[item.actionid], playerRankBrother)
	if desc == nil then
	   doSendMsg(cid, "O desafio (".. playerRankBrother ..") desta cidade ja foi concluido.")
	else
	  doSendMsg(cid, "O seu proximo desafio (".. playerRankBrother ..") " .. desc)
	end

end
