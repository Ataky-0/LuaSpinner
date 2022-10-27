SL = require "SpinnerModule"

function PrintTable(Table)
  if not Table then error("Not enough arguments") end
  for i =1 , #Table do
    print(string.format("%i\t%s\t%i",i,Table[i][1],Table[i][2]))
  end
end

Items = {
  { "A cool uncommon power", 25 },
  { "A rare power", 5 },
  { "Yet another rare power", 5 },
  { "A really boring ordinary power", 55 },
}

-- SL.AddItem(Items,"Test",100)
-- SL.PrintRandom(Items) -- Raw way of doing the same: print(Items[SL.Random(Items)][1])
