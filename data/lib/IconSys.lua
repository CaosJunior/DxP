function doPlayerChangeModeIcon(cid)
if getPlayerStorageValue(cid, 8955) >= 1 then
local x = icons[getItemAttribute(getPlayerSlotItem(cid, 8).uid, "poke")]
local y = icons[getItemAttribute(getPlayerSlotItem(cid, 3).uid, "poke")]
if x and getPlayerSlotItem(cid, 8).itemid == 11826 then     -- Pokeball
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.on)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 11828 then     -- Pokeball Morta
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.off)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 11827 then     -- Pokeball Usada
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.use)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")

elseif x and getPlayerSlotItem(cid, 8).itemid == 11829 then     -- Ultraball
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.on)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 11831 then     -- Ultraball Morta
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.off)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 11830 then     -- Ultraball Usada
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.use)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 11835 then     -- Superball
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.on)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 11837 then     -- Superball Morta
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.off)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 11836 then     -- Superball Usada
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.use)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")

elseif x and getPlayerSlotItem(cid, 8).itemid == 11832 then     -- Greatball
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.on)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 11834 then     -- Greatball Morta
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.off)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 11833 then     -- Greatball Usada
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.use)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")

elseif x and getPlayerSlotItem(cid, 8).itemid == 10975 then     -- Saffariball
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.on)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 10977 then     -- Saffariball Morta
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.off)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 10976 then     -- Saffariball Usada
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.use)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")

elseif x and getPlayerSlotItem(cid, 8).itemid == 12826 then     -- Darkball
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.on)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 12828 then     -- Darkball Morta
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.off)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 12827 then     -- Darkball Usada
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.use)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")

elseif x and getPlayerSlotItem(cid, 8).itemid == 11740 then     -- Shiny Greatball
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.on)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "shiny", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 11742 then     -- Shiny Greatball Morta
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.off)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "shiny", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 11741 then     -- Shiny Greatball Usada
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.use)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "shiny", "yes")
 
 elseif x and getPlayerSlotItem(cid, 8).itemid == 11743 then     -- Shiny Super
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.on)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "shiny", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 11745 then     -- Shiny Super Morta
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.off)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "shiny", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 11744 then     -- Shiny Superball Usada
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.use)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "shiny", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 11746 then     -- Shiny Ultra
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.on)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "shiny", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 11748 then     -- Shiny Ultra Morta
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.off)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "shiny", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 11747 then     -- Shiny Ultraball Usada
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.use)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "shiny", "yes")

elseif x and getPlayerSlotItem(cid, 8).itemid == 11737 then     -- Shiny Poke
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.on)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "shiny", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 11739 then     -- Shiny Poke Morta
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.off)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "shiny", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 11738 then     -- Shiny Pokeball Usada
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.use)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "shiny", "yes")

elseif x and getPlayerSlotItem(cid, 8).itemid == 12621 then     -- Shiny Saffari
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.on)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "shiny", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 12623 then     -- Shiny Saffari Morta
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.off)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "shiny", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 12622 then     -- Shiny Saffariball Usada
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.use)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "shiny", "yes")

elseif x and getPlayerSlotItem(cid, 8).itemid == 12829 then     -- Shiny Dark
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.on)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "shiny", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 12831 then     -- Shiny Dark Morta
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.off)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "shiny", "yes")
 
elseif x and getPlayerSlotItem(cid, 8).itemid == 12830 then     -- Shiny Darkball Usada
 doTransformItem(getPlayerSlotItem(cid, 8).uid, x.use)
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "ball", "Icone")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "morta", "no")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "yes")
 doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "shiny", "yes")
end

local bp = getPlayerSlotItem(cid, CONST_SLOT_BACKPACK)
local balls = getItemsInContainerById(bp.uid, 11826)  ------ Pokeball
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.on)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "no")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end
local balls = getItemsInContainerById(bp.uid, 11828) --- Pokeball morta
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.off)
                 doItemSetAttribute(ball, "ball", "Icone")
                 doItemSetAttribute(ball, "morta", "yes")
                 doItemSetAttribute(ball, "Icone", "yes")
          end 
end
--------------------------------
local balls = getItemsInContainerById(bp.uid, 11829)  ------ Ultraball
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.on)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "no")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end
local balls = getItemsInContainerById(bp.uid, 11831) --- Ultraball morta
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.off)
                 doItemSetAttribute(ball, "ball", "Icone")
                 doItemSetAttribute(ball, "morta", "yes")
                 doItemSetAttribute(ball, "Icone", "yes")
          end 
end

------------------------------
local balls = getItemsInContainerById(bp.uid, 11835)  ------ Superball
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.on)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "no")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end
local balls = getItemsInContainerById(bp.uid, 11837) --- Superball morta
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.off)
                 doItemSetAttribute(ball, "ball", "Icone")
                 doItemSetAttribute(ball, "morta", "yes")
                 doItemSetAttribute(ball, "Icone", "yes")
          end 
end
-----------------------------
local balls = getItemsInContainerById(bp.uid, 11834)  ------ Greatball
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(balll, x.off)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "yes")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end
local balls = getItemsInContainerById(bp.uid, 11832) --- Greatball morta
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.on)
                 doItemSetAttribute(ball, "ball", "Icone")
                 doItemSetAttribute(ball, "morta", "no")
                 doItemSetAttribute(ball, "Icone", "yes")
          end 
end
-----------------------------
local balls = getItemsInContainerById(bp.uid, 10975)  ------ Saffariball
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(balll, x.off)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "yes")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end
local balls = getItemsInContainerById(bp.uid, 10977) --- Saffariball morta
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.on)
                 doItemSetAttribute(ball, "ball", "Icone")
                 doItemSetAttribute(ball, "morta", "no")
                 doItemSetAttribute(ball, "Icone", "yes")
          end 
end

-----------------------------
local balls = getItemsInContainerById(bp.uid, 12826)  ------ Darkball
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(balll, x.off)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "yes")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end
local balls = getItemsInContainerById(bp.uid, 12828) --- Darkball morta
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.on)
                 doItemSetAttribute(ball, "ball", "Icone")
                 doItemSetAttribute(ball, "morta", "no")
                 doItemSetAttribute(ball, "Icone", "yes")
          end 
end

-----------------------------------
local balls = getItemsInContainerById(bp.uid, 11740)  ------ Shiny Great
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.on)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "no")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end

local balls = getItemsInContainerById(bp.uid, 11742)  ------ Shiny Greatball morta
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.off)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "yes")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end

local balls = getItemsInContainerById(bp.uid, 11746)  ------ Shiny Ultraball
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.on)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "no")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end

local balls = getItemsInContainerById(bp.uid, 11748)  ------ Shiny Ultraball morta
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.off)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "yes")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end

---------------------------------------------------
local balls = getItemsInContainerById(bp.uid, 11737) -- Shiny Pokeball
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.on)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "no")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end
local balls = getItemsInContainerById(bp.uid, 11739) -- Shiny Pokeball
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                --doTransformItem(ball, x.off)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "yes")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end
---------------------------------------------------
local balls = getItemsInContainerById(bp.uid, 11740) -- Shiny Greatball
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.on)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "no")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end
local balls = getItemsInContainerById(bp.uid, 11742) -- Shiny Greatball
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.off)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "yes")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end
---------------------------------------------------
local balls = getItemsInContainerById(bp.uid, 11743) -- Shiny Superball
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.on)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "no")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end
local balls = getItemsInContainerById(bp.uid, 11745) -- Shiny Super
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.off)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "yes")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end
---------------------------------------------------
local balls = getItemsInContainerById(bp.uid, 12621) -- Shiny Saffariball
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.on)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "no")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end
local balls = getItemsInContainerById(bp.uid, 12623) -- Shiny Saffari
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.off)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "yes")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end
---------------------------------------------------
local balls = getItemsInContainerById(bp.uid, 12829) -- Shiny Darkball
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.on)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "no")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end
local balls = getItemsInContainerById(bp.uid, 12831) -- Shiny Dark
if #balls >= 1 then 
          for _, ball in pairs (balls) do
          local x = icons[getItemAttribute(ball, "poke")]
                doTransformItem(ball, x.off)
                doItemSetAttribute(ball, "ball", "Icone")
                doItemSetAttribute(ball, "morta", "yes")
                doItemSetAttribute(ball, "Icone", "yes")
          end 
end
else
local pokeball = getItemAttribute(getPlayerSlotItem(cid, 8).uid, "ball")
local mortano = getItemAttribute(getPlayerSlotItem(cid, 8).uid, "morta")
local y = icons[getItemAttribute(getPlayerSlotItem(cid, 8).uid, "poke")]
if pokeball == "normal" and mortano == "no" then     -- Pokeball
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 11826)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "normal" and mortano == "yes" then
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 11828)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "no" then     -- Pokeball
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 11829)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "yes" then
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 11831)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "no" then     -- Pokeball
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 11835)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "yes" then
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 11837)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "no" then     -- Pokeball
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 11832)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "yes" then
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 11834)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "no" then     -- saffariball
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 10975)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "yes" then
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 10977)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "no" then     -- darkball
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 12826)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "yes" then
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 12828)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "no" then     -- saffariball
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 11737)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "yes" then
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 11739)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "no" then     -- Pokeball
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 11746)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "yes" then
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 11748)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "no" then     -- Shiny super
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 11743)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "yes" then
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 11745) --- Shiny superr
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "no" then     -- Shiny great
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 11740)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "yes" then
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 11742)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "no" then     -- Shiny saffari
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 12621)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "yes" then
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 12623)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "no" then     -- Shiny dark
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 12829)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
elseif pokeball == "Icone" and mortano == "yes" then
  doTransformItem(getPlayerSlotItem(cid, 8).uid, 12831)
  doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "Icone", "no")
end
local bp = getPlayerSlotItem(cid, CONST_SLOT_BACKPACK)
x = { }
for a = 1, #x do
local balls = getItemsInContainerById(bp.uid, x[a])  
          for _, ball in pairs (balls) do
          local pokeball = getItemAttribute(ball, "ball")
          local mortano = getItemAttribute(ball, "morta")
              if getItemAttribute(ball, "ball") == "Icone" and getItemAttribute(ball, "morta") == "no" then -- Ultra ball
                doTransformItem(ball, 11829)
                doItemSetAttribute(ball, "Icone", "no")
              elseif getItemAttribute(ball, "ball") == "Icone" and getItemAttribute(ball, "morta") == "yes" then  -- Ultra ball morta
                doTransformItem(ball, 11831)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "no" then
                doTransformItem(ball, 11826)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "yes" then
                doTransformItem(ball, 11828)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "no" then
                doTransformItem(ball, 11835)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "yes" then
                doTransformItem(ball, 11837)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "no" then
                doTransformItem(ball, 11832)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "yes" then
                doTransformItem(ball, 11834)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "no" then
                doTransformItem(ball, 10975)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "yes" then
                doTransformItem(ball, 10977)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "no" then
                doTransformItem(ball, 12826)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "yes" then
                doTransformItem(ball, 12828)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "no" then
                doTransformItem(ball, 11737)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "yes" then
                doTransformItem(ball, 11739)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "no" then
                doTransformItem(ball, 11740)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "yes" then
                doTransformItem(ball, 11742)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "no" then
                doTransformItem(ball, 11743)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "yes" then
                doTransformItem(ball, 11745)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "no" then
                doTransformItem(ball, 11746)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "yes" then
                doTransformItem(ball, 11748)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "no" then
                doTransformItem(ball, 12621)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "yes" then
                doTransformItem(ball, 12623)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "no" then
                doTransformItem(ball, 12829)
                doItemSetAttribute(ball, "Icone", "no")
              elseif pokeball == "Icone" and mortano == "yes" then
                doTransformItem(ball, 12831)
                doItemSetAttribute(ball, "Icone", "no")
              end 
          end 
end
end
end 