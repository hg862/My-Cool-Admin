-- MainModule.luau
local Sanity = require(script:WaitForChild("SanityCheck"))

-- Safe require AdminCore
local AdminCore = Sanity:RequireModule(script:WaitForChild("AdminCore"))

local MainModule = {}
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
	self.Core:RunCommand(player, commandName, args)
end

MainModule:Init()
return MainModule
