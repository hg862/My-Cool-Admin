local MainModule = {}
local AdminCore = require(script.Parent:WaitForChild("AdminCore"))

MainModule.Core = AdminCore
MainModule.Commands = AdminCore.Commands

function MainModule:Init()
	print("My Cool Admin initializing...")
	print("My Cool Admin ready!")
end

function MainModule:ReloadCommands()
	self.Core:LoadCommands()
	self.Commands = self.Core.Commands
	print("Commands reloaded.")
end

function MainModule:RunCommand(player, commandName, args)
	local success, err = pcall(function()
		self.Core:RunCommand(player, commandName, args)
	end)
	if not success then
		warn("Error in MainModule:RunCommand: " .. err)
	end
end

MainModule:Init()
return MainModule
