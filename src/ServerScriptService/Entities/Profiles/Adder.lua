local Calculator = require(script.Parent)

local Adder = {}
Adder.__index = Adder
setmetatable(Adder, Calculator)


function Adder.new(initialValue: number)
	local inst = setmetatable(Calculator.new(initialValue), Adder)

	return inst
end

function Adder:operate(num: number)
	self.Value = self.Value + num
end


return Adder
