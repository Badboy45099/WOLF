-- Example.lua (updated to use AWolf and WolfIcons from this repo)
local repo = "https://raw.githubusercontent.com/Badboy45099/WOLF/main/"

-- Load WolfIcons and AWolf UI module from this repo
local WolfIcons = loadstring(game:HttpGet(repo .. "addons/WolfIcons.lua"))()
local AWolf = loadstring(game:HttpGet(repo .. "AWolf.lua"))()

-- Create window using AWolf
local Window = AWolf:CreateWindow({ Title = "WolfTool", Footnote = "By Alpha" })

-- Add a couple of tabs to demonstrate
local PlayerTab = Window:AddTab("Player", "user")
local VisionTab = Window:AddTab("Vision", "eye")

-- Example groupboxes & elements (basic – AWolf exposes AddTab and internal groupbox API)
-- If AWolf returns an object with AddGroupbox/AddToggle/AddSlider as in the pasted UI, you can use them.
-- This example simply demonstrates that the window was created and tabs show up.

print("Example loaded: WolfTool window created")
