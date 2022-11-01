# Lua Spinner

This script was created with the intention of learning how to use constructors and metatables. I openly accept any suggestion/opinion.

## Usage

This script will scour a table with elements and their given rarities to display or return a randomly chosen item.

```lua
require 'SpinnerModule'

local Table = { -- Total rarity is 1500 then 1500 = 100%
  {"Hey, i'm quite rare!!!", 100},  -- 100*100/1500 = 6,66%
  {"Hey, i'm uncommon!", 400},      -- 400*100/1500 = 26,66%
  {"I'm super common..", 1000}      -- 1000*100/1500 = 66,66%
}

SpinnerModule.Random(Table) -- Return a random index, based on its rarity.
SpinnerModule.PrintRandom(Table,X) -- Print a random item from Table, X times.

SpinnerModule.AddItem(Table, Name, Rarity) -- Easily insert a new item into the given table, it will format it correctly.
SpinnerModule.RemoveItem(Table, Name) -- Removes a item from a table based on its name/content.

-- Example
SpinnerModule.PrintRandom(Table,10)

```
```
~ lua Spinner.lua

[1] I'm super common.. 67%
[2] I'm super common.. 67%
[3] Hey, i'm uncommon! 27%
[4] I'm super common.. 67%
[5] I'm super common.. 67%
[6] I'm super common.. 67%
[7] I'm super common.. 67%
[8] Hey, i'm uncommon! 27%
[9] I'm super common.. 67%
[10] Hey, i'm quite rare!!! 7%
```
