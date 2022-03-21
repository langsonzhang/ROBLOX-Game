local DataStoreService = game:GetService("DataStoreService")
local Inventory = require(game.ServerScriptService.Entities.Core.Inventory)

local PlayerInventoryStore = DataStoreService:GetDataStore("PlayerInventory")


local InventorySaver = {}

function InventorySaver.savePlayerInventory(player: Player, inv: Inventory): boolean
	if inv:isEmpty() then
		error("Empty Inventory, aborting save.")
	end
	local serialized = inv:serialize()
	if not serialized then
		error("Serialization failed, aborting save.")
	end
	
	
	local succ, err = pcall(function()
		PlayerInventoryStore:SetAsync(player.UserId, serialized)
	end)
	
	if not succ then
		print(err)
	end
	
	return true
end

function InventorySaver.loadPlayerInventory(player: Player)
	local data
	local succ, err = pcall(function()
		data = PlayerInventoryStore:GetAsync(player.UserId)
	end)
	
	local deserialized = Inventory.deserialize(data)
	if not deserialized then
		error("Deserialization failed, aborting loading data.")
	end
	
	
end


return InventorySaver
