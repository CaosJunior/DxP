local coins = {
[12416] = {to = 2148},
[2148] = {to = 2152, from = 12416}, 
[2152] = {to = 2160, from = 2148}, 
[2160] = {from = 2152},
}

function onUse(cid, item, fromPosition, itemEx, toPosition)

	if(getPlayerFlagValue(cid, PLAYERFLAG_CANNOTPICKUPITEM)) then
		return false
	end

	local coin = coins[item.itemid]
	if(not coin) then
		return false
	end

	if(coin.to ~= nil and item.type == ITEMCOUNT_MAX) then
		doChangeTypeItem(item.uid, item.type - item.type)
		doPlayerAddItem(cid, coin.to, 1)
	elseif(coin.from ~= nil) then
		doChangeTypeItem(item.uid, item.type - 1)
		doPlayerAddItem(cid, coin.from, ITEMCOUNT_MAX)
	end
	
	return true
end