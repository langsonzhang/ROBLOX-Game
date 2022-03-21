local itemAddedEvent = game.ReplicatedStorage.Remotes.Inventory.ItemAdded
local itemRemovedEvent = game.ReplicatedStorage.Remotes.Inventory.ItemRemoved

local template = script.Parent.ButtonTemplate

--On ItemAdded we display the item in our inventory GUI
itemAddedEvent.OnClientEvent:Connect(function(itemName, itemId)
	--Make the button
	local template = template:Clone()
	local button = template.Button
	button.Name = itemName
	button.Text =itemName
	
	template.Visible = true
	template.Parent = script.Parent
	template.id.Value = itemId
	
	
	--Tell server when we click/remove the item from our inventory
	button.MouseButton1Click:Connect(function()
		itemRemovedEvent:FireServer(itemId)
		template:Destroy()
		template = nil
		button = nil
	end)
end)