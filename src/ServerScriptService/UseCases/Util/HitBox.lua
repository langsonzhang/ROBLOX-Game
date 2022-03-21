local CooldownCache = require(game.ServerScriptService.Frameworks.CooldownCache)


local HitBox = {
	Duration = CooldownCache.new(1)
}

local activeHitBoxes = {}

function HitBox.new(dim: Vector3)
	local box = Instance.new("Part")
	box.Transparency = 0.8
	box.Color = Color3.new(1, 0.35378, 0.365423)
	box.Size = dim
	box.Anchored = true
	box.CanCollide = false
	
	activeHitBoxes[HitBox.Duration:add()] = box
	return box
end

game["Run Service"].Heartbeat:Connect(function()
	for handle, box in pairs(activeHitBoxes) do
		if HitBox.Duration:IsReady(handle) then
			box:Destroy()
			HitBox.Duration:Clear(handle)
			activeHitBoxes[handle] = nil
		end
	end
end)


return HitBox