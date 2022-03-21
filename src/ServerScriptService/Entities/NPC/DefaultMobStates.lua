local CooldownCache = require(game.ServerScriptService.Frameworks.CooldownCache)
local State = require(game.ServerScriptService.Entities.Automata.State)

------------------------------------ Idle --------------------------------------------------

local IdleState = {
	Duration = CooldownCache.new(1)
}
IdleState.__index = IdleState
setmetatable(IdleState, State)

function IdleState.new(character: Model)
	local inst = setmetatable(State.new(), IdleState)
	
	inst.durationHandle = false
	
	inst.onEnter = function()
		character.Humanoid:MoveTo(character.HumanoidRootPart.Position)
		inst.durationHandle = inst.Duration:add()
	end
	
	inst.onExit = function()
		inst.Duration:Clear(inst.durationHandle)
	end
	
	return inst
end

function IdleState:durationOver(): boolean
	return self.Duration:IsReady(self.durationHandle)
end

------------------------------------ Patrol ------------------------------------------------

local PatrolState = {
	Interval = CooldownCache.new(7)	
}
PatrolState.__index = PatrolState
setmetatable(PatrolState, State)

function PatrolState.new(character: Model)
	local inst = setmetatable(State.new(), PatrolState)
	
	local handle = inst.Interval:add()
	inst.update = function()
		if inst.Interval:IsReady(handle) then
			character.Humanoid:MoveTo(character.HumanoidRootPart.Position + Vector3.new(math.random(-20, 20), 0, math.random(-20, 20)))
		end
	end
	
	return inst
end

------------------------------------ Attack ------------------------------------------------

local AttackState = {
	ChaseTime = CooldownCache.new(10),
	AttackCooldown = CooldownCache.new	(2)
}
AttackState.__index = AttackState
setmetatable(AttackState, State)

function AttackState.new(character: Model, getPlayer: ()->(Player))
	local inst = setmetatable(State.new(), AttackState)
	inst.TargetPlayer = false
	inst.AggroTimeHandle = false
	inst.AttackCooldownHandle = false

	
	inst.onEnter = function()
		inst.TargetPlayer = getPlayer()
		inst.AggroTimeHandle = inst.ChaseTime:addReduced(math.random(0, 5))
		inst.AttackCooldownHandle = inst.AttackCooldown:add()
	end
	
	inst.update = function()
		local playerChar = inst.TargetPlayer.Character
		if not playerChar then
			return
		end
		
		local delta = playerChar.Head.Position - character.HumanoidRootPart.Position
		if inst.AttackCooldown:IsReady(inst.AttackCooldownHandle) then
			--require(game.ServerScriptService.Entities.NPC.Behaviours.MeleeAttack).swipe(character)	
		else
			character.Humanoid:MoveTo(inst.TargetPlayer.Character.Head.Position)
		end
	end
	
	inst.onExit = function()
		inst.ChaseTime:Clear(inst.AggroTimeHandle)
		inst.AttackCooldown:Clear(inst.AttackCooldownHandle)
	end

	return inst
end

function AttackState:getAggrodPlayer(): Player
	return self.TargetPlayer
end

function AttackState:lostAggro(): boolean
	return self.ChaseTime:IsReady(self.AggroTimeHandle)
end


------------------------------------ Recover ------------------------------------------------

local RecoverState = setmetatable({}, State)

function RecoverState.new(character: Model)
	local inst = State.new(function() end)

	return inst
end


local DefaultMobStates = {
	IdleState = IdleState,
	PatrolState = PatrolState,
	AttackState = AttackState,
	RecoverState = RecoverState
}

return DefaultMobStates
