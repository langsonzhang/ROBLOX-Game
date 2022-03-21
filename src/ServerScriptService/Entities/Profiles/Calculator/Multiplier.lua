local Calculator = require(script.Parent)

local Multiplier = {}
Multiplier.__index = Multiplier
setmetatable(Multiplier, Calculator)


function Multiplier.new(initialValue: number)
	local inst = setmetatable(Calculator.new(initialValue), Multiplier)
	
	return inst
end

function Multiplier:operate(num: number)
	self.Value = self.Value * num
end


return Multiplier
