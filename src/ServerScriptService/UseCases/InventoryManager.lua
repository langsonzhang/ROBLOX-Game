local GoodSignal = require(game.ServerScriptService.Frameworks.GoodSignal)
local Inventory = require(game.ServerScriptService.Entities.Core.Inventory)
local Item = require(game.ServerScriptService.Entities.Core.Item)


local InventoryManager = {
	ItemRemoved = GoodSignal.new(), 	-- (Player, Item)
	ItemAdded = GoodSignal.new()	 	-- (Player, Item)	
}

--************************** Variables ********************************************************************************


local InventoryList = {}


--************************** Functions ********************************************************************************


-- Initialize the Inventory for <player>
function InventoryManager.setInventory(player: Player, inv: Inventory)
	InventoryList[player] = inv
end

-- Add <item> to <player>'s Inventory
function InventoryManager.addItem(player: Player, item: Item)
	InventoryList[player]:addItem(item)
	item.Parent = nil
	
	InventoryManager.ItemAdded:Fire(player, item)
	game.ReplicatedStorage.Remotes.Inventory.ItemAdded:FireClient(player, item.Name, item.id)
end

-- Drop the item associated with <id> from <player>'s Inventory at <player>'s position
function InventoryManager.dropItem(player: Player, id: string)
	local character = player.Character or player.CharacterAdded:Wait()
	local itemToDrop = InventoryList[player]:removeItem(id)
	itemToDrop():PivotTo(character.Head.CFrame * CFrame.new(0,0,-10))
	itemToDrop.Parent = game.Workspace
	
	InventoryManager.ItemRemoved:Fire(player, itemToDrop)
	game.ReplicatedStorage.Remotes.Inventory.ItemRemoved:FireClient(player, itemToDrop.Name, id)	
end

function InventoryManager.getSerializedInventoryFor(player: Player)
	return InventoryList[player]:serialize()
end

function InventoryManager.loadInventoryFromSerializedFor(player: Player, data: {})
	local remote = game.ReplicatedStorage.Remotes.Inventory.ItemAdded
	InventoryList[player] = Inventory.deserialize(data)
	for id, item in pairs(InventoryList[player].Storage) do
		remote:FireClient(player, item.Name, item.id)
	end
end


return InventoryManager
