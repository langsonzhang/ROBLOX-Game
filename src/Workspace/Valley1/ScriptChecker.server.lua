for _, v in pairs(script.Parent:GetDescendants()) do
	local success, isScript = pcall(function()
		return v:IsA("BaseScript")
	end)
	
	if success and isScript then
		--warn("Found ".. tostring(v) .. " in " .. tostring(script.Parent) .. "/../" .. tostring(v.Parent) .. v)
		warn("Found script " .. v:GetFullName())
	end
end