-- AdminCore.luau
local Sanity = require(script.Parent:WaitForChild("SanityCheck"))
local AdminCore = {}
AdminCore.Commands = {}
AdminCore.AdminLevels = {Player=0, Moderator=1, Admin=2, Owner=3}

-- Safe require Settings
local Settings = Sanity:RequireModule(script.Parent:WaitForChild("Settings"))

-- Load commands from Commands folder
function AdminCore:LoadCommands()
	local folder = script:WaitForChild("Commands")
	for _, module in pairs(folder:GetChildren()) do
		if module:IsA("ModuleScript") then
			local ok, cmd = pcall(require, module)
			if ok and cmd and cmd.Name then
				self.Commands[cmd.Name:lower()] = cmd
			else
				warn("Failed to load command: "..tostring(module))
			end
		end
	end
end

-- Run a command safely
function AdminCore:RunCommand(player, commandName, args)
	local cmd = self.Commands[commandName:lower()]
	if not cmd then return end

	if not Settings:CanRun(player, cmd.Name) then
		player:SendNotification({Title="Error", Text="You do not have permission!"})
		return
	end

	cmd.Execute(player, args)
end

AdminCore:LoadCommands()
return AdminCore

AdminCore:LoadCommands()
return AdminCore
