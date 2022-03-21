local GoodSignal = require(game.ServerScriptService.Frameworks.GoodSignal)
local Item = require(game.ServerScriptService.Entities.Core.Item)
local Inventory = require(game.ServerScriptService.Entities.Core.Item)
require(game.ServerScriptService.Controllers.InventoryController)
local MobManager = require(game.ServerScriptService.UseCases.MobManager)


for i = 0, 10 do
	local gold = Instance.new("Part")
	gold.Name = "Gold"
	local item = Item.new(gold, 10)
	gold.Position = game.Workspace.ItemSpawner.Position
	gold.Parent = game.Workspace
end

function setupPlayer(player: Player)
	
end

game.Players.PlayerAdded:Connect(function(player)
	setupPlayer(player)
	player.CharacterAdded:Connect(function(char)
		player.Character.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
		local box = require(game.ServerScriptService.Entities.Util.ProxBox).new(20)
		box:weld(char.HumanoidRootPart)
		game.PhysicsService:SetPartCollisionGroup(box(), "PlayerAggroBox")
		box.Transparency = 0.8
		
		box.Touched:Connect(function(part)
			local id = part:GetAttribute("id")
			MobManager.setClosestPlayer(id, player)
		end)
		
		box.TouchEnded:Connect(function(part)
			local id = part:GetAttribute("id")
			if MobManager.getMob(id) then
				MobManager.setClosestPlayer(id, nil)
			end
		end)
	end)
end)

game:BindToClose(function()
	wait(3)
end)


--local HttpService = game:GetService("HttpService")

--local tab = {
--	-- Remember: these lines are equivalent
--	["message"] = "success";
--	message = "success";

--	info = {
--		points = 120,
--		isLeader = true,
--		user = {
--			id = 12345,
--			name = "JohnDoe"
--		},
--		past_scores = {50, 42, 95},
--		best_friend = nil
--	}
--}

--local json = HttpService:JSONEncode(tab)
--print(json)