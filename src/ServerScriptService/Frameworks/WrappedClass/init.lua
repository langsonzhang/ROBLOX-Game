--[[
	File: WrappedClass.lua

	---------------------------- Brief -------------------------------------
		Wrapping framework which provides cohesion between Instances and "Classes".
	
	---------------------------- API ---------------------------------------
		local superClass = require( *** some superclass ***)
		
		local subClass = {}
		subClass.__index = subClass
		setmetatable(subClass, superClass)
		
		function subClass.new()
			local inst = superClass.new():cast(subClass) .. {
				*** instance variables ***
			}
			*** do stuff ***
			return inst
		end
		
		*** More implementaions ***
		
		
	Author: nosgnal
		
	Date: Created Dec 2021
]]

--TODO: entire implementation potential memory leak

WrappedClass = {}
WrappedClass.__index = WrappedClass

-- Create a new wrapped Instance
function WrappedClass.new(obj: Instance)
	local instance = {}
	
	-- The "Class" of the "instance"
	instance.Class = WrappedClass
	
	instance.Super = WrappedClass
	
	-- Fusing the "Class" and the <model> 
	instance.__index = function(tab, index)
		return tab.Class[index] or obj:GetAttribute(index) or obj[index]
	end
	instance.__newindex = obj
	
	-- Gets the model. Use for method calls like instance():Destroy() etc.
	instance.__call = function()
		return obj
	end
	
	-- Use for instantiation.
	instance.__concat = function(tab, value: {})
		for i, v in pairs(value) do
			rawset(tab, i, v)
		end
		return tab
	end
	
	-- Give it a unique identifier (change this implementation to your liking)
	instance.id = game.HttpService:GenerateGUID(true)
	obj:SetAttribute("Id", instance.id)
	
	instance.ModelId = obj.Name
	
	
	return setmetatable(instance, instance)
end


-- Casting function. This is a hard cast! Your Instance will have a different Class!
function WrappedClass:cast(class: {})
	self.Class = class
	self.Super = getmetatable(class)
	return self
end

function WrappedClass:copy()
	error("copy() function not implemented in the calling object's Class")
end


-- Test
function WrappedClass:bark()
	print(self.Name .. " is barking")
end

function WrappedClass:delete()
	self = nil
end


return WrappedClass