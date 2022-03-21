local Calculator = {}
Calculator.__index = Calculator

function Calculator.new(initialValue: any)
	return setmetatable({Value = initialValue}, Calculator)
end

function Calculator:operate(...): any
	error("NotImplementedError")
end

return Calculator
