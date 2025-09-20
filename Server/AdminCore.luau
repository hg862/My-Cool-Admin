local AdminCore = {}
AdminCore.Commands = {}
AdminCore.AdminLevels = {Player=0, Moderator=1, Admin=2, Owner=3}

-- Load all commands from Commands folder
function AdminCore:LoadCommands()
	local folder = script:FindFirstChild("Commands")
	if not folder then
		warn("AdminCore.Commands folder not found!")
		return
	end

	for _, module in pairs(folder:GetChildren()) do
		if module:IsA("ModuleScript") then
			local success, cmd = pcall(require, module)
			if success and cmd.Name then
				self.Commands[cmd.Name:lower()] = cmd
			else
				warn("Failed to load command: " .. module.Name)
			end
		end
	end
end

-- Run a command
function AdminCore:RunCommand(player, commandName, args)
	if typeof(commandName) ~= "string" then return end
	local cmd = self.Commands[commandName:lower()]
	if not cmd then
		warn("Command not found: " .. tostring(commandName))
		return
	end

	local SettingsModule = game.ServerScriptService:FindFirstChild("Settings")
	if not SettingsModule then
		warn("Settings module not found!")
		return
	end
	local Settings = require(SettingsModule)

	if not Settings:CanRun(player, cmd.Name) then
		print(player.Name .. " tried to run " .. cmd.Name .. " but has no permission.")
		return
	end

	local success, err = pcall(function()
		cmd.Execute(player, args)
	end)
	if not success then
		warn("Error executing command '" .. cmd.Name .. "': " .. err)
	end
end

AdminCore:LoadCommands()
return AdminCore
