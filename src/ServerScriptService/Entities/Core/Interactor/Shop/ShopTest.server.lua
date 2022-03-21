local Shop = require(script.Parent)
local Inventory = require(game.ServerScriptService.Entities.Core.Inventory)
local Item = require(game.ServerScriptService.Entities.Core.Item)



local inventory = Inventory.new()
inventory:addItem(Item.new(Instance.new("Part")))

local actualShop = Instance.new("MeshPart", game.Workspace)
actualShop.Position = game.Workspace.SpawnLocation.Position + Vector3.new(0,0, -15)

local newShop = Shop.new(inventory):bind(actualShop)
print(newShop)

