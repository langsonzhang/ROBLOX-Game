local WrappedClass = require(game.ServerScriptService.Frameworks.WrappedClass)

local MobSpawner = {}
setmetatable(MobSpawner, WrappedClass)

function MobSpawner.new(part: BasePart)
	local self = WrappedClass.new(part):cast(MobSpawner) .. {
		
	}
	
	return self
end




return MobSpawner
