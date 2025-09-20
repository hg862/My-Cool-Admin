return {
	Name = "Cmds",
	Description = "Print all loaded commands",
	AdminLevel = 1,
	Execute = function(player, args)
		local mainModule = require(game.ServerScriptService:WaitForChild("My Cool Admin"):WaitForChild("Server"):WaitForChild("MainModule"))
		local AdminCore = mainModule.Core

		print("===== AdminCore Commands =====")
		local count = 0
		for name, cmd in pairs(AdminCore.Commands) do
			print("Command: " .. name .. " | Description: " .. (cmd.Description or "No description"))
			count = count + 1
		end
		if count == 0 then warn("No commands loaded!") end
		print("================================")
	end
}
