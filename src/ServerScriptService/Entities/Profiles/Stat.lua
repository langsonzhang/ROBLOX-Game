
local Stat = {}
Stat.__index = Stat


------------------------------ Constructor --------------------------------------------

function Stat.new(flat: number, incMulti: number, moreMulti: number)
	local inst = {
		Flat = flat,
		IncreasedMultiplier = incMulti,
		MoreMultiplier = moreMulti,
	}
	setmetatable(inst, Stat)
	
	return inst
end

------------------------------ Functions ----------------------------------------------

function Stat:add(num: number)
	self.Flat = self.Flat + num
end

function Stat:increase(num: number)
	self.IncreasedMultiplier = self.IncreasedMultiplier + num
end

function Stat:multiply(num: number)
	self.MoreMultiplier = self.MoreMultiplier * num
end

function Stat:getTotal(): number
	return self.Flat * self.IncreasedMultiplier * self.MoreMultiplier
end

------------------------------ Serialization ------------------------------------------

function Stat:serialize(): {}
	return {self.Flat, self.IncreasedMultiplier, self.MoreMultiplier}
end

function Stat.deserialize(data: {}): Stat
	return Stat.new(data[0], data[1], data[2])
end


return Stat
