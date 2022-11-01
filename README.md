# Lua Spinner

This script was created with the intention of learning how to use constructors and metatables. I openly accept any suggestion/opinion.

## Usage

This script will scour a table with elements and their given rarities to display or return a randomly chosen item.

```lua
SpinnerModule.Random(Table) -- Return a random index, based on its rarity.
SpinnerModule.PrintRandom(Table,X) -- Print a random item from Table, X times.

SpinnerModule.AddItem(Table, Name, Rarity) -- Easily insert a new item into the given table, it will format it correctly.
SpinnerModule.RemoveItem(Table, Name) -- Removes a item from a table based on its name/content.
```
