local DataStoreService = game:GetService("DataStoreService")
local InventoryManager = require(game.ServerScriptService.UseCases.InventoryManager)
local Item = require(game.ServerScriptService.Entities.Core.Item)
local Inventory = require(game.ServerScriptService.Entities.Core.Inventory)


local PlayerInventoryStore = DataStoreService:GetDataStore("PlayerInventory")


local InventoryController = {}

function InventoryController.saveInventory(player: Player)
	local userId = player.UserId
	local serialized = InventoryManager.getSerializedInventoryFor(player)
	if not serialized  then
		error("Empty Inventory, aborting save.")
	end
	
	local succ, err = pcall(function()
		PlayerInventoryStore:SetAsync(userId, serialized)
	end)
	print(serialized)
	print(PlayerInventoryStore:GetAsync(userId))
	
	if not succ then
		error(err)
	end
end

function InventoryController.loadInventory(player: Player)
	local data = {}
	local succ, err = pcall(function()
		data = PlayerInventoryStore:GetAsync(player.UserId)
	end)
	if not succ then
		error(err)
	end
	print(data)
	InventoryManager.loadInventoryFromSerializedFor(player, data)
end


-- Save and Load inventories
game.Players.PlayerAdded:Connect(InventoryController.loadInventory)
game.Players.PlayerRemoving:Connect(InventoryController.saveInventory)

-- Add items
Item.Picked:Connect(InventoryManager.addItem)

-- Drop items
game.ReplicatedStorage.Remotes.Inventory.ItemRemoved.OnServerEvent:Connect(function(player, itemId)
	InventoryManager.dropItem(player, itemId)
end)

--PlayerInventoryStore:RemoveAsync(417127540)

return InventoryController
