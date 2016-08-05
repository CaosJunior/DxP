function onSay(cid, words, param, channel)

if param and (param == "horarios" or param == "Horarios") then

   local hours = ""
   local c = 0
   for i = 1, #horas do
       hours = hours..((i == #horas and c ~= 0) and " and " or i ~= 1 and ", " or "")..horas[i]  --alterado v1.7
       c = c+1
   end
   hours = hours.." hours."
   doPlayerSendTextMessage(cid, 20, "The golden arena occurs at "..hours)
   timeDiff = showTimeDiff(nextHorario(cid))                                                         
   doPlayerSendTextMessage(cid, 20, "Next Event in "..timeDiff..".")   --alterado v1.3 
end

return true
end