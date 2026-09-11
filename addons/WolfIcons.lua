-- WolfIcons addon: lucide icon registry for WOLF
local WolfIcons = {}

local icons = {
	["lucide-minimize-2"] = "rbxassetid://10734895530",
	["lucide-move"] = "rbxassetid://10734900011",
	["user"] = "rbxassetid://10709782497",
	["chevron-down"] = "rbxassetid://10734895530",
	["search"] = "rbxassetid://10734900011",
	["lock"] = "rbxassetid://10734900011",
	["bell"] = "rbxassetid://10709782497",
	["map-pin"] = "rbxassetid://10709782497",
	["gamepad"] = "rbxassetid://10709782497",
	["settings"] = "rbxassetid://10709782497",
	["clock"] = "rbxassetid://10709782497",
	["check"] = "rbxassetid://10709782497",
	["loader"] = "rbxassetid://10709782497",
}

-- Returns rbxassetid string for a given lucide icon name. Falls back to 'user' icon if unknown.
function WolfIcons.GetLucideIcon(name)
	if not name then return icons["user"] end
	local key = tostring(name):lower()
	return icons[key] or icons["user"]
end

-- Expose icons table for manual tweaks
WolfIcons.Icons = icons

return WolfIcons
