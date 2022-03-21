
local MobAi = {}
MobAi.__index = MobAi

function MobAi.new(rootPart: BasePart)
	local inst = setmetatable({}, MobAi)
	inst.RootPart = rootPart
	inst.States = {
		idle = inst.idle,
		patrol = inst.patrol,
		attack = inst.attack,
		recover = inst.recover,
		flee = inst.flee
	}
	inst.CurrentState = inst.States.patrol
	inst.Transitons = {
		
	}
	
	return inst
end


function MobAi:update()
	self:CurrentState()
end

--[[
	Use for quick setup.
	Formatting:
		<states> = {
			idle = function() ... end,
			patrol = function() ... end,
			...,
			
			<transitions> = {
				{idle, patrol, GoodSignal.new()},
				{** stateA **, ** stateB **, ** GoodSignal **},
				...
			}
		}
		
		MobAi.new():inject(<states>, <states>.<transitions>)	
]]
function MobAi:inject(states: {}, transitions: {})
	for signature, implementation in pairs(functions) do
		self:setState(signature, implementation)
	end
	
	for _, trans in pairs(transitions) do
		self:setTransition(trans[0], trans[1], trans[2])
	end
end

function MobAi:setState(signature, implementation)
	self.States[signature] = implementation
end

function MobAi:setTransition(a, b, event: GoodSignal)
	local connection = event:Connect(function()
		if self.CurrentState == a then
			self.CurrentState = b
		end
	end)
	table.insert(self.Transitions, connection)
end

function MobAi:setRootPart(rootPart: BasePart)
	self.RootPart = rootPart
end

function MobAi:disconnectAll()
	for _, v in pairs(self.Transitions) do
		v:Disconnect()
	end
end


--------------------------------- Default States ------------------------------

function MobAi:idle()
	
end

function MobAi:patrol()
	print(1)
end

function MobAi:attack()

end

function MobAi:recover()

end


return MobAi
