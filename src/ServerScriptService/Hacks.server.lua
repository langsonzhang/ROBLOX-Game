game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		char.Humanoid.WalkSpeed = 100
	end)
end)
