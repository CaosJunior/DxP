function onSay(cid, words, param, channel) -- Scrip por Avazquez, para blacktibia.org
 local t = string.explode(param, ",")
  if t[1] ~= nil and t[2] ~= nil then
  local list = {}
  for i, tid in ipairs(getPlayersOnline()) do -- Scrip por Avazquez, para blacktibia.org
  list[i] = tid
  end
  for i = 1, #list do
  					if getPlayerGroupId(cid) == 3 then--when God
					return true
					elseif getPlayerGroupId(cid) == 1 then--when Gamemaster
				    return false
					end					
						doPlayerAddItem(list[i],t[1],t[2])
      end -- Scrip por Avazquez, para blacktibia.org
  doBroadcastMessage(getPlayerName(cid) .. " Regaló: " .. t[2] .." ".. getItemNameById(t[1]) .. " para todos los players online!")
  else
  doPlayerPopupFYI(cid, "No parm...\nSend:\n /itemadd itemid,how_much_items\nexample:\n /itemadd 2160,10")
  end
 return true
 end -- Scrip por Avazquez, para blacktibia.org