local Stat = require(script.Parent.Stat)

local StatsProfile = {
	
}
StatsProfile.__index = StatsProfile
StatsProfile.__newindex = function(tab, index, value)
	error("Cannot find stat " .. index)
end
--StatsProfile.__newindex = nil


------------------------ Constructors ------------------------------------------

function StatsProfile.new()
	local inst = {
		-- Syntax: Stat.new(** flat value **, ** increased multiplier ** , ** more multiplier **)
		
		MaxHealth = Stat.new(100, 1, 1),
		HealthRegen = Stat.new(1, 1, 1),
		
		MaxMana = Stat.new(100, 1, 1),
		ManaRegen = Stat.new(5, 1, 1),
		
		DamageTaken = Stat.new(0, 1, 1),
		
		MoveSpeed = Stat.new(15, 1, 1),
		
		AttackDamage = Stat.new(10, 1, 1),
		SpellDamage = Stat.new(10, 1, 1),
		
		APS = Stat.new(1, 1, 1),
		
		AttackRange = Stat.new(15, 1, 1)
	}
	setmetatable(inst, StatsProfile)
	
	return inst
end

------------------------------ Serialization ------------------------------------

function StatsProfile:serialize(): {}
	local data = {}
	for name, stat in pairs(self) do
		data[name] = stat:serialize() 
	end
	
	return data
end

function StatsProfile.deserialize(data: {}): StatsProfile
	local inst = StatsProfile.new()
	for name, statData in pairs(data) do
		inst[name] = Stat.deserialize(statData)
	end
	return inst
end


return StatsProfile
