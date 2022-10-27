--[[ Fortis Anima ]] --

-- 'Items' construction

local Items
Items = setmetatable({
  -- Items
  -- Given a subjective total of 90 points:
  { "A cool uncommon power", 25 }, -- 27,77 %
  { "A rare power", 5 }, -- 5,55 %
  { "Yet another rare power", 5 }, -- 5,55 %
  { "A really boring ordinary power", 55 }, -- 61,11 %

  -- Functions inside the constructor

  Sort = function()
    local dmp = 0
    for i = 1, #Items do
      for j = 1, #Items do
        if Items:GetItemRarity(i) < Items:GetItemRarity(j) then
          dmp = Items[i]
          Items[i] = Items[j]
          Items[j] = dmp
        end
      end
    end
  end,
  FixFloatPresence = function()
    for i = 1, #Items do
      while Items:GetItemRarity(i) < 1 do
        Items = Items * 10
      end
    end
  end,
  PrintARandomItem = function(_, Times)
    if Items.Total > 0 then
      if not Times then Times = 1 end
      Items:Sort()
      Items:FixFloatPresence()
      for i = 1, Times do
        local Sum = 0
        local RandNumb = math.random(1, Items.Total)
        for j = 1, #Items do
          Sum = Sum + Items:GetItemRarity(j)

          if RandNumb <= Sum and ((j == 1) or (j > 1 and RandNumb > Items:GetItemRarity(j - 1))) then
            print(string.format("[%i] %s %." .. Items.AfterDecimals .. "f%%", i, Items:GetItemName(j),
              Items:GetItemFrequency(j)))
            break
          end
        end
      end
    end
  end,
  PrintRawRarities = function(_)
    for i = 1, #_ do
      print(string.format("%s - %i", _:GetItemName(i), _:GetItemRarity(i)))
    end
  end,
  AddItem = function(_, Name, Rarity)
    table.insert(Items, { Name, Rarity })
    Items:Sort()
  end,
  GetItemRarity = function(_, Item)
    if _[Item] then return _[Item][2] end
  end,
  GetItemName = function(_, Item)
    if _[Item] then return _[Item][1] end
  end,
  GetItemFrequency = function(_, Item) --Percentage
    return _:GetItemRarity(Item) * 100 / Items.Total
  end,
  ['AfterDecimals'] = 0,
}, {
  __index = function(self, key)
    if key == 'Total' then
      local Sum = 0
      for i = 1, #self do
        Sum = Sum + self[i][2]
      end
      return Sum
    end
  end,
  __mul = function(self, multiplier)
    if multiplier then
      if type(multiplier) == 'number' then
        if multiplier < 0 then error("Negative number.") end
        local newSelf = self
        Items.AfterDecimals = Items.AfterDecimals + 1
        for i = 1, #newSelf do
          newSelf[i][2] = newSelf[i][2] * multiplier
        end
        return newSelf
      else error("Wrong value type.")
      end
    end
  end,
})

-- End of 'Items' construction

Items:PrintARandomItem()

-- Interactive links (Useless if there's no intent of using as interactive mode.)

function PrintARandomItem(Times) Items:PrintARandomItem(Times) end

function PrintRawRarities() Items:PrintRawRarities() end

function AddItem(Name, Rarity) Items:AddItem(Name, Rarity) end

function Help()
  print(string.format("To print a random item: PrintARandomItem(Times)\nTo insert a new item: AddItem(Name,Rarity)\n"))
end
