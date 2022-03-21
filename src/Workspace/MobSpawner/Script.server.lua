--!strict
local spawner = script.Parent
local mobs = require(script.Parent.Mobs)
local rand = Random.new()

local event, fired = Instance.new("BindableEvent"), false

spawner.CanCollide = false
spawner.Transparency = 1
spawner.Anchored = true


local minCD = 5
local maxCD = 15
event.Event:Connect(function()
	wait(rand:NextInteger(minCD, maxCD))
	local mob: BasePart = mobs[rand:NextInteger(1, #mobs)]:Clone()
	mob.Humanoid.Died:Connect(function()
		event:Fire()
		wait(3)
		mob:Destroy()
	end)
	mob:PivotTo(spawner:GetPivot())
	mob.Parent = game.Workspace
end)



event:Fire()



