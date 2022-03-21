-------------------------- Transition Class ----------------------------------------

--local Transition = {}
--Transition.__index = Transition
--Transition.__newindex = error

--function Transition.new(from: State, to: State, event: GoodSignal)
--	local inst = {
--		from = from,
--		to = to,
--		event = event,
--		connection = nil
--	}
--	setmetatable(inst, Transition)
	
--	return inst
--end

--function Transition:Disconnect()
--	self.connection:Disconnect()
--end

--function Transition:Connect(func)
--	self.connection = self.event:Connect(func)
--end

------------------------ StateMachine Class ----------------------------------------

local StateMachine = {}
StateMachine.__index = StateMachine
StateMachine.__newindex = error

function StateMachine.new(start: State)
	local inst = setmetatable({
		currentState = start,
		transitions = {}
	}, StateMachine)
	
	return inst
end

function StateMachine:update()
	local trans = self.transitions[self.currentState] or {}
	for _, v in pairs(trans) do
		if v[2]() then
			self.currentState.onExit()
			self.currentState = v[1]
			self.currentState.onEnter()
		end
	end
	
	self.currentState.update()
end

function StateMachine:setTransition(from: State, to: State, predicate: ()->(boolean))
	--local connection = event:Connect(function(...)
	--	--print(self.currentTransition)
	--	if self.currentState == from then
	--		self.currentState.onExit(...)
	--		self.currentState = to
	--		self.currentState.onEnter(...)
	--	end
	--end)
	--table.insert(self.connections, connection)
	if not self.transitions[from] then
		self.transitions[from] = {}
	end
	table.insert(self.transitions[from], {to, predicate})
end

function StateMachine:DisconnectAll()
	for _, v in pairs(self.connections) do
		v:Disconnect()
	end
end






return StateMachine