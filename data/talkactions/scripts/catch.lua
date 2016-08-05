function onSay(cid, words, param, channel)

local t = getCatchList(cid)

for b = 1, #oldpokedex do
	for a = 1, #t do
	if isPokemonInOwnList(player, oldpokedex[y][1]) then
				str = str.."\n["..threeNumbers(y).."] - "..oldpokedex[y][1].."   (•)"
				lnl = lnl + 1
			else
				str = str.."\n["..threeNumbers(y).."] - "..oldpokedex[y][1]..""
			end