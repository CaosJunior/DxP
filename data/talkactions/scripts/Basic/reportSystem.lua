function onSay(cid, words, param)

if param ~= "" then
return true
end

local t = string.explode(param, ",")

doSendMsg(cid, t[2])

return true
end