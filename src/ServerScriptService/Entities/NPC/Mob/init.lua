local GoodSignal = require(game.ServerScriptService.Frameworks.GoodSignal)
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local wrap = require(game.ServerScriptService.Frameworks.WrappedClass)
local ProxBox = require(game.ServerScriptService.Entities.Util.ProxBox)


local StatsProfile = require(game.ServerScriptService.Entities.Profiles.StatsProfile)
local MobAi = require(script.Parent.MobAi)



local Mob = {
	Died = GoodSignal.new()
}
Mob.__index = Mob
setmetatable(Mob, wrap)

-------------------- Constructor -------------------------------------------

function Mob.new(model: BasePart, mobStats: StatsProfile)
	local instance = wrap.new(model):cast(Mob) .. {
		ClosestPlayer = Instance.new("ObjectValue"),
		MobStats = mobStats,
		AggroMultiplier = 1,
		StateMachine = false, 	-- StateMachine for Ai
		States = false,			-- Dictionary of States
		SpawnerPart = false,
	}
	game.PhysicsService:SetPartCollisionGroup(instance.Head, "MobAggroBox")
	instance.Head:SetAttribute("id", instance.id)
	instance.HumanoidRootPart:SetAttribute("id", instance.id)
	
		
	local humanoid = instance().Humanoid
	--humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
	humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	--humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
	humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
	--humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
	--humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
	--humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
	--humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
	--humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
	--humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
	--humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
	
	humanoid.MaxHealth = instance.MobStats.MaxHealth:getTotal()
	humanoid.Health = humanoid.MaxHealth
	return instance
end

--------------------- Functions ---------------------------------------------

function Mob:getCFrame(): CFrame
	return self().HumanoidRootPart.CFrame
end

function Mob:damage(num: number)
	self.Humanoid.Health = self.Humanoid.Health - num
	if not self:isAlive() then
		self.Died:Fire(self)
	end
end

function Mob:isAlive(): boolean
	return self.Humanoid.Health > 0
end

function Mob:update()
	--self.Humanoid:MoveTo(game.Workspace.RampTop.Position)
	error("NotImplementedError")
end

function Mob:setupAi()
	error("NotImplementedError")
end



function Mob:setClosestPlayer(player: Player)
	self.ClosestPlayer.Value = player
end

function Mob:getClosestPlayer(player: Player)
	return self.ClosestPlayer.Value
end

function Mob:setSpawnerPart(part: BasePart)
	self.SpawnerPart = part
end


return Mob