function getStingOfTask(cid, npc)
if not isCreature(cid) then return "" end
local str = {}
local c = 0
local nome = (npc and type(npc) == "string") and npc or (npc and isCreature(npc)) and getCreatureName(npc) or "" 
for i = 91001, (91000+maxTasks) do
    if getPlayerStorageValue(cid, i) ~= -1 and tostring(getPlayerStorageValue(cid, i)) then
       local array = getArrayFromStorage(cid, i)
       if arrayHasContent(array) then
          for e, f in pairs(array) do
              if (not npc) or (nome ~= "" and e == nome) then
                 for a = 1, #f do 
                     local poke = f[a][1]
                     local num = f[a][2]
                     if tonumber(num) >= 1 then
                        table.insert(str, ((a ~= 1 and c ~= 0) and ", " or "")..num.." "..poke..(num == 1 and "" or "s"))
                        c = c+1
                     end 
                 end
                 table.insert(str, ".\n")
              end
          end
       end
    end
end
return table.concat(str)
end

function arrayHasContent(array)
if type(array) ~= "table" then return false end
return next(array) and true or false
end

function getMyTaskSto(cid, npc)
if not isCreature(cid) or (type(npc) ~= "string" and not isCreature(npc)) then return -1 end
for i = 91001, (91000+maxTasks) do
    if getPlayerStorageValue(cid, i) ~= -1 and tostring(getPlayerStorageValue(cid, i)) then
       local t = string.explode(getPlayerStorageValue(cid, i), "/")
       if tostring(t[1]) and tostring(t[1]) == (type(npc) == "string" and npc or getCreatureName(npc)) then
          return i
       end
    end
end
return -1
end

function isMyTaskComplete(cid, npc)
if not isCreature(cid) or (type(npc) ~= "string" and not isCreature(npc)) then return false end
local storage = getMyTaskSto(cid, npc)
local count = 0
   if storage ~= -1 then
      local array = getArrayFromStorage(cid, storage)
      for e, f in pairs(array) do
          for i = 1, #f do
              count = count+f[i][2]
          end
      end
   else
      return false
   end
if count == 0 then return true end
end
 
function getFreeTaskStorage(cid)
if not isCreature(cid) then return -1 end
for i = 91001, (91000+maxTasks) do
    if type(getPlayerStorageValue(cid, i)) == "number" and getPlayerStorageValue(cid, i) <= -1 then
       return i
    end
end
return -1
end

function setStorageArray(cid, storage, array)
if not isCreature(cid) or not storage or type(array) ~= "table" then return false end
local str = ""
for e, f in pairs(array) do
    for i = 1, #f do 
        str = i == 1 and str..""..e.." / " or str..""
        str = i == 1 and str..""..f[i][1] or str..";"..f[i][1]
        str = str..", "..f[i][2] 
    end
end
setPlayerStorageValue(cid, storage, str)
return true
end

function getArrayFromStorage(cid, storage)
if not isCreature(cid) or not storage or type(getPlayerStorageValue(cid, storage)) ~= "string" then return {} end
local array = {}
local name = string.explode(getPlayerStorageValue(cid, storage), "/")
if not name or type(name) ~= "table" then return {} end
local t1 = string.explode(name[2], ";")
array[name[1]] = {}
for i = 1, #t1 do
    local t2 = string.explode(t1[i], ",")
    table.insert(array[name[1]], {t2[1], t2[2]})
end
return array
end