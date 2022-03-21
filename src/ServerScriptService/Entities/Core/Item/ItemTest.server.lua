local Item = require(game.ServerScriptService.Entities.Core.Item)

local part = Instance.new("Part")

local item = Item.new(part, 10)
part.Name = "Gold"

print(item)
print(item.Name)

