--[[ Fortis Anima ]] --

-- local var = setmetatable({table},{metatable})
--
SpinnerModule = {}

local GetItemRarity = function(_, Item) -- Return the raw rarity
  if _[Item] then return _[Item][2] end
end

local GetItemName = function(_, Item) -- Return item name
  if _[Item] then return _[Item][1] end
end

local GetItemFrequency = function(_, Item) -- Percentage
  return GetItemRarity(_,Item) * 100 / _.Total
end

local GetItemPos = function (_,Item)
  for i = 1, #_ do
    if GetItemName(_,i) == Item then return i end
  end
end

local Sort = function (_) -- Functions that sorts array
  local dmp = 0
  for i = 1, #_ do
    for j = 1, #_ do
      if GetItemRarity(_,i) < GetItemRarity(_,j) then
        dmp = _[i]
        _[i] = _[j]
        _[j] = dmp
      end
    end
  end
end

local FixFloatPresence = function (_) -- In case there are float numbers
  for i = 1, #_ do
    while GetItemRarity(_,i) < 1 do
      _ = _ * 10
    end
  end
end

local meta = {
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
        self.AfterDecimals = self.AfterDecimals + 1
        for i = 1, #newSelf do
          newSelf[i][2] = newSelf[i][2] * multiplier
        end
        return newSelf
      else error("Wrong value type.")
      end
    end
  end,
}

function SpinnerModule.Random(Origin) -- Returns a random index (item)
  local Items = setmetatable(Origin,meta)
  if Items.Total > 0 then
    Sort(Items)
    FixFloatPresence(Items)
    local Sum = 0
    local RandNumb = math.random(1, Items.Total)
    for j = 1, #Items do
      Sum = Sum + GetItemRarity(Items,j)
      if RandNumb <= Sum and ((j == 1) or (j > 1 and RandNumb > GetItemRarity(Items,j - 1))) then
        return j
      end
    end
  end
end

function SpinnerModule.PrintRandom(Origin,Times)
  if not Origin then error("No origin given") return end
  local Items = setmetatable(Origin,meta)
  Items['AfterDecimals'] = 0
  if not Times then Times = 1 end
  for i = 1, Times do
    local j = SpinnerModule.Random(Items)
    print(string.format("[%i] %s %." .. Items.AfterDecimals .. "f%%", i, GetItemName(Items,j),
          GetItemFrequency(Items,j)))
  end
  Items = nil
end

function SpinnerModule.AddItem (Origin, Name, Rarity)
  if not Origin or not Name or not Rarity then error("No origin or name or rarity given") return end
  table.insert(Origin, { Name, Rarity })
  Sort(Origin)
end

function SpinnerModule.RemoveItem (Origin, Name)
  if not Origin or not Name then error("No origin or name given") return end
  table.remove(Origin, GetItemPos(Origin,Name))
  Sort(Origin)
end

return SpinnerModule
