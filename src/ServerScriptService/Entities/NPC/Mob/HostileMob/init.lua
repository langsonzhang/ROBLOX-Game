local StateMachine = require(game.ServerScriptService.Entities.Automata.StateMachine)
local State = require(game.ServerScriptService.Entities.Automata.State)
local Mob = require(script.Parent)
local GoodSignal = require(game.ServerScriptService.Frameworks.GoodSignal)

local DefaultMobStates = require(script.Parent.Parent.DefaultMobStates)

local HostileMob = {}
HostileMob.__index = HostileMob
setmetatable(HostileMob, Mob)

--------------------- Constructors ---------------------------------------------

function HostileMob.new(model: BasePart, mobStats: StatsProfile)
	local inst = Mob.new(model, mobStats):cast(HostileMob) .. {
		TargetPlayer = Instance.new("ObjectValue"),
		Spawner = false,
		AggroMultiplier = 1,
		AggroTime = 5,
	}
	inst:setupAi()
	
	return inst
end

--------------------- Functions ---------------------------------------------

function HostileMob:update()
	self.StateMachine:update()
end


-- Overrides Default Mob AI
function HostileMob:setupAi()
	if self.StateMachine then
		self.StateMachine:DisconnecAll()
	end
	
	if not self.States then
		self.States = {}
	end
	
	-- Add default hostile States
	local q = self.States
	
	q.idle = DefaultMobStates.IdleState.new(self())
	q.patrol = DefaultMobStates.PatrolState.new(self())
	q.attack = DefaultMobStates.AttackState.new(self(), function()
		return self:getClosestPlayer()
	end)
	
	
	-- Set the defaut transitions
	self.StateMachine = StateMachine.new(q.patrol) -- Starting state
	
	self.StateMachine:setTransition(q.patrol, q.attack, function() -- Patrol to Attack
		return self:getClosestPlayer() -- return if nil
	end)
	self.StateMachine:setTransition(q.attack, q.idle, function() -- Attack to Idle 
		return q.attack:lostAggro() and not self:getClosestPlayer()
	end)
	self.StateMachine:setTransition(q.attack, q.attack, function() -- Attack to Attack
		return q.attack:lostAggro() and self:getClosestPlayer() == q.attack:getAggrodPlayer() -- return if still aggrod to same player
	end)
	self.StateMachine:setTransition(q.idle, q.patrol, function() -- Idle to Patrol
		return q.idle:durationOver()
	end)
end



return HostileMob
