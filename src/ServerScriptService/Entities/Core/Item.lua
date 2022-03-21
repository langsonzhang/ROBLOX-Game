local GoodSignal = require(game.ServerScriptService.Frameworks.GoodSignal)
local WrappedClass = require(game.ServerScriptService.Frameworks.WrappedClass)
local Interactor = require(game.ServerScriptService.Entities.Core.Interactor)


local Item = {
	Picked = GoodSignal.new()
}
Item.__index = Item
setmetatable(Item, WrappedClass)


function Item.new(model: BasePart, price: number)
	local instance = WrappedClass.new(model):cast(Item) .. {
		VendorPrice = price
	}
	
	instance:setInteractor()
	
	-- Reduce physics costs
	model.Anchored = true
	model.CanCollide = false
	
	return instance
end

-- Setup the "pickup" prompt
function Item:setInteractor()
	local interact = Interactor.new()
	interact.ActionText = "Pickup"
	interact.ObjectText = self.Name
	interact:bind(self())
	interact.RequiresLineOfSight = false
	interact.Triggered:Connect(function(player)
		Item.Picked:Fire(player, self)
	end)
end


-- Creates the exact same instance of the Item
function Item:copy(): Item
	local model = self():clone()
	model:ClearAllChildren()
	return Item.new(model, self.VendorPrice)
end


------------------------------ Serialization ------------------------------

function Item:serialize(): {}
	local data = {}
	data.VendorPrice = self.VendorPrice
	data.ModelId = self.ModelId
	return data
end

function Item.deserialize(data: {}): Item
	local model = game.ServerStorage.Items:WaitForChild(data.ModelId)
	local newItem = Item.new(model:Clone(), data.VendorPrice)
	return newItem
end


return Item
