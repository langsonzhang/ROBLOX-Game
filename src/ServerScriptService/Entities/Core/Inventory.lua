local Item = require(game.ServerScriptService.Entities.Core.Item)

local Inventory = {}
Inventory.__index = Inventory

--------------------- Constructors ---------------------------------------------

function Inventory.new()
	local instance = {
		Storage = {}
	}
	return setmetatable(instance, Inventory)
end

--------------------- Functions ---------------------------------------------

-- Remove the item corresponding to <id>
function Inventory:removeItem(id: string): Item
	local prev = self.Storage[id]
	if prev == nil then
		error("Item " .. id .. " is not in " .. tostring(self))
	end
	self.Storage[id] = nil
	
	return prev
end

-- Add <item>
function Inventory:addItem(item: Item)
	self.Storage[item.id] = item
end


function Inventory:getItem(id: string): Item
	return self.Storage[id]
end

function Inventory:isEmpty(): boolean
	return #self.Storage == 0
end

function Inventory:getAll(): {Item}
	return self.Storage
end


------------------------------ Serialization ------------------------------

function Inventory:serialize(): {}
	local data = {}
	for id, item in pairs(self.Storage) do
		data[id] = item:serialize()
	end
	return data
end

function Inventory.deserialize(data: {}): Inventory
	local inv = Inventory.new()
	for id, itemData in pairs(data or {}) do
		inv:addItem(Item.deserialize(itemData))
	end
	return inv
end




return Inventory
