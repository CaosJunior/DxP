require("socket")

ip = {"127.0.0.1"}
tab = {
['{x=150, y=50, z=7}'] = 'songs/song1.ogg',
['{x=170, y=70, z=7}'] = 'songs/song2.ogg',
['{x=180, y=120, z=7}'] = 'songs/song3.ogg',
['{x=190, y=150, z=7}'] = 'songs/song4.ogg'

}
talk = {"222", "222"}
count = 0

client = socket.connect(ip[1], 8110)

function checkPos(ip)

arq = io.open('data/lib/changer.txt', 'r')
str = arq:read("*all")
arq:close()
n = nil

sep = 1
for i = 1, #str do
	if string.sub(str, i, i) == "/" then
		if string.sub(str, sep, i-1) == ip[1] then
			n = string.sub(str, i+1, string.find(str, "|", i+1)-1)
		end
	elseif string.sub(str, i, i) == "|" then
		sep = i+1
	end
end

return n
end

function ret()

while true do
	recpt = client:receive"*l"
	if recpt then
		str = string.find(recpt, "/")
		str2 = string.find(recpt, "/", str+1)
		acc = string.sub(recpt, 1, str-1)
		pass = string.sub(recpt, str+1, str2-1)
		if talk[1] == acc and talk[2] == pass then
			client:send("Confirm\n")
			break
		else
			client:send("incorrect\n")
		end
	end
end

end

if client then
	ret()
	while true do
		posi = checkPos(ip)
		if posi == "DEFAULT_NO_POS" then
			pos = posi
			msg, sta = client:send(posi .. "\n")
		end
		if posi ~= pos and tab[posi] then
			pos = posi
			msg, sta = client:send(tab[pos] .. "\n")
		end
		if posi then
			if count > 0 then
				count = 0
			end
		else
			count = count +1
			if count == 5 then
				client:send("Finish\n")
				os.exit()
			end
		end
		if sta == "closed" then
			os.exit()
		end
	end
end