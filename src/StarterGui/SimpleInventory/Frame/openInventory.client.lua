local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")

local function handleAction(actionName, inputState, inputObject)
	print(actionName)
	if inputState == Enum.UserInputState.Begin then
		if actionName == "openInventory" then
			script.Parent.Visible = not script.Parent.Visible
		end
	end
	
end

wait(3)
ContextActionService:BindAction("openInventory", handleAction, true, Enum.KeyCode.L)