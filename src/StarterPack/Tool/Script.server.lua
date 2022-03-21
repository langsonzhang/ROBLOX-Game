local MobManager = require(game.ServerScriptService.UseCases.MobManager)

function killall()
	local objects = game.Workspace:GetChildren()	
	for i, v in pairs(objects) do
		if v.Name == "Zombie" then
			v.Humanoid.Health  = 0
		end
	end
	MobManager.killAll()
end

script.Parent.Activated:Connect(killall)