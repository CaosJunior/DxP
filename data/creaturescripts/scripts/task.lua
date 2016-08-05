function onKill(cid, target)

local continue = true

if ehMonstro(target) then
   for i = 91001, (91000+maxTasks) do
       local sto = getPlayerStorageValue(cid, i)
       if type(sto) == "string" then
          local array = getArrayFromStorage(cid, i)
          if arrayHasContent(array) then
             for e, f in pairs(array) do
                 for a = 1, #f do
                     if tostring(f[a][1]) == getCreatureName(target) and tonumber(f[a][2]) >= 1 then
                        if getDamageMapPercent(cid, target) < 0.5 then
                           continue = false
                        elseif (pokes[getPlayerStorageValue(cid, 854787)] and getCreatureName(getCreatureSummons(cid)[1]) ~= getPlayerStorageValue(cid, 854787)) then
                           if npcsTask[tostring(e).."_1"] then
                              continue = false             --task clan
                           end
                        elseif e == "Agatha" and getCreatureName(target) == "Shiny Abra" and not isInRange(getThingPos(target), Agatha.fromPos, Agatha.toPos) then
                           continue = false    --alterado v1.9 agatha quest
                        end
                        if continue then
                           f[a][2] = f[a][2]-1
                           if f[a][2] == 0 then
                              sendMsgToPlayer(cid, 20, tostring(e)..": Quest Done!")
                           else   
                              sendMsgToPlayer(cid, 20, tostring(e)..": You need to kill more "..f[a][2].." "..f[a][1]..(f[a][2] == 1 and "." or "s."))
                           end
                           setStorageArray(cid, i, array)
                        end
                        continue = true
                     end
                 end
             end
          end
       end
   end
end   

return true
end