local State = {}
State.__index = State

function State.new(update, enter, exit)
	local inst = {
		update = update or function() end,
		onEnter = enter or function() end,
		onExit = exit or function() end
	}
	setmetatable(inst, State)
	
	return inst
end

return State
