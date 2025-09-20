-- SanityCheck.luau
-- Put this in Server folder
-- This module checks for critical components, license validity, and reports issues

local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local SanityCheck = {}
SanityCheck.Reported = false

-- Discord webhook reporting function
function SanityCheck:Report(reason)
	if self.Reported then return end
	self.Reported = true

	-- Console warning
	warn(":: CRITICAL FAILURE DETECTED :: " .. tostring(reason))
	print(":: Game is not authorized to have this admin system, has been reported to developers ::")
	
	-- Send webhook if secret is set
	local webhook
	local success = pcall(function()
		webhook = HttpService:GetSecret("ADMIN_LICENSE_WEBHOOK")
	end)

	if success and webhook then
		local payload = {
			username = "Admin System Alert",
			embeds = {{
				title = "🚨 Critical Admin Failure",
				color = 16711680,
				fields = {
					{ name = "PlaceId", value = tostring(game.PlaceId), inline = true },
					{ name = "Reason", value = reason, inline = false }
				},
				timestamp = DateTime.now():ToIsoDate()
			}}
		}
		pcall(function()
			HttpService:PostAsync(webhook, HttpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
		end)
	end
end

-- Safe require function for critical modules
function SanityCheck:RequireModule(module)
	local ok, result = pcall(require, module)
	if not ok or not result then
		self:Report("Critical module missing or failed: " .. tostring(module))
		error("Admin system disabled due to missing critical module.")
	end
	return result
end

-- Optional: Validate License StringValue exists
function SanityCheck:ValidateLicenseFolder(folder)
	local licenseValue = folder:FindFirstChild("License")
	if not licenseValue or not licenseValue:IsA("StringValue") then
		self:Report("Missing License StringValue in folder: " .. folder.Name)
		error("Admin system disabled due to missing license.")
	end
end

return SanityCheck
