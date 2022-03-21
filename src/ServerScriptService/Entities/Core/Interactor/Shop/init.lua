local Interactive = require(script.Parent)
local InventoryClass = require(game.ServerScriptService.Entities.Core.Inventory)
local InventoryManager = require(game.ServerScriptService.UseCases.InventoryManager)
local Item = require(game.ServerScriptService.Entities.Core.Item)

local Shop = {}
Shop.__index = Shop
setmetatable(Shop, Interactive)


function Shop.new(inventory: Inventory)
	local inst = Interactive.new():cast(Shop) .. {
		Inventory = inventory
	}
	local item = Item.new(game.ServerStorage.Items.Gold:Clone(), 500)
	inst.Inventory:addItem(item)
	inst.ActionText = "Shop"
	
	inst.Triggered:Connect(function(player)
		InventoryManager.addItem(player, inst.Inventory:getItem(item.id):copy())
	end)
	
	return inst
end





return Shop
