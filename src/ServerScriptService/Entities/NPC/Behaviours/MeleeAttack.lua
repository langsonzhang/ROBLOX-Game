local HitBox = require(game.ServerScriptService.UseCases.Util.HitBox)

local MeleeAttack = {}


function MeleeAttack.swipe(char: Model)
	local human = char.Humanoid
	local rootPart = char.HumanoidRootPart
	local hitbox = HitBox.new(Vector3.new(5, 1, 3))
	
	hitbox.CFrame = rootPart.CFrame + (rootPart.CFrame.LookVector * 2)
	hitbox.Parent = game.Workspace
	
	--hitbox.Touched:Connect(print)
end



return MeleeAttack
