local WrappedClass = require(game.ServerScriptService.Frameworks.WrappedClass)

local ProxBox = {}
setmetatable(ProxBox, WrappedClass)

local boxes = {}

function ProxBox.new(radius: number)
	local inst = WrappedClass.new(newBox(radius)):cast(ProxBox) .. {
		
	}
	
	return inst
end

function newBox(radius: number): Part
	local box = Instance.new("Part")
	box.Name = "ProxBox"
	box.Massless = true
	box.Transparency = 1
	box.Size = Vector3.new(2*radius, 2*radius, 2*radius)
	box.CanCollide = false
	
	return box
end

function ProxBox:weld(part: BasePart)
	self.Parent = part
	local weld = Instance.new("Motor6D")
	weld.Parent = part
	weld.Part0 = part
	weld.Part1 = self()
	part.Destroying:Connect(function()
		self():Destroy()
	end)
end


return ProxBox
