local WrappedClass = require(game.ServerScriptService.Frameworks.WrappedClass)

local Interactor = {}
Interactor.__index = Interactor
setmetatable(Interactor, WrappedClass)


function Interactor.new()
	local inst = WrappedClass.new(Instance.new("ProximityPrompt")):cast(Interactor)

	return inst
end

-- DO NOT GIVE A MODEL. For some reason ProximityPrompts do not work with Models.
function Interactor:bind(parent: BasePart)
	self.Parent = parent
	return self
end


return Interactor