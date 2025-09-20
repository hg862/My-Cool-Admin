local MainModule = require(script.Parent:WaitForChild("MainModule"))
game.Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(msg)
		if msg:sub(1,1)=="/" then
			local parts = msg:sub(2):split(" ")
			local cmdName = parts[1]
			table.remove(parts,1)
			MainModule:RunCommand(player, cmdName, parts)
		end
	end)
end)

