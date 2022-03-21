require(game.ServerScriptService.Frameworks.GoodSignal)
local mc = require(script.Parent)


task.spawn(function()
	for i = 0, 10 do
		for j = 0, 10  do
			mc.spawnMob()
		end
		wait(0.5)
	end
end)

--mc.spawnMob()

--task.spawn(function()
--	local zombie = game.ReplicatedStorage.DroolingZombie1
--	for i = 0, 10 do
--		for j = 0, 10  do
--			local temp = zombie:Clone()
--			temp:PivotTo(game.Workspace.ItemSpawner.CFrame)
--			temp.Parent = game.Workspace
--		end
--		wait(0.5)
--	end
--end)

local timer = require(game.ServerScriptService.Frameworks.CooldownCache).new(0.1)
local a = timer:add()
game["Run Service"].Heartbeat:Connect(function()
	if timer:IsReady(a) then
		mc.updateMobs()
	end
end)


