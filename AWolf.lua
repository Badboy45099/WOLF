-- AWolf.lua - lightweight WOLF UI implementation (uses Lucide icons via addons/WolfIcons.lua)
-- Designed to be runnable from an executor. Keeps PNG fallbacks for textures.

local repo = "https://raw.githubusercontent.com/Badboy45099/WOLF/main/"
local success, WolfIcons = pcall(function()
    return loadstring(game:HttpGet(repo .. "addons/WolfIcons.lua"))()
end)
if not success or type(WolfIcons) ~= "table" or type(WolfIcons.GetLucideIcon) ~= "function" then
    -- fallback simple function
    WolfIcons = {
        GetLucideIcon = function() return "rbxassetid://10709782497" end
    }
end

local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

local AWolf = {}
AWolf.__index = AWolf

function AWolf:GetLucideIcon(name)
    return WolfIcons.GetLucideIcon(name)
end

function AWolf:CreateWindow(Config)
    Config = Config or {}

    -- Main ScreenGui Container
    local WolfUI = Instance.new("ScreenGui")
    WolfUI.Name = "AWolfUI"
    WolfUI.ResetOnSpawn = false
    WolfUI.Parent = CoreGui

    -- Main UI Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BackgroundTransparency = 0.3
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.fromScale(0.5, 0.5)
    MainFrame.Size = UDim2.fromOffset(680, 420)
    MainFrame.Parent = WolfUI

    -- Top Header Bar
    local HeaderFrame = Instance.new("Frame")
    HeaderFrame.Name = "HeaderFrame"
    HeaderFrame.Size = UDim2.new(1, 0, 0, 48)
    HeaderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    HeaderFrame.BackgroundTransparency = 0.1
    HeaderFrame.BorderSizePixel = 0
    HeaderFrame.Parent = MainFrame

    local HeaderTitle = Instance.new("TextLabel")
    HeaderTitle.Name = "HeaderTitle"
    HeaderTitle.Position = UDim2.fromOffset(180, 0)
    HeaderTitle.Size = UDim2.fromOffset(140, 48)
    HeaderTitle.Font = Enum.Font.SourceSansBold
    HeaderTitle.Text = Config.Title or "WolfTool"
    HeaderTitle.TextColor3 = Color3.fromRGB(170, 10, 10)
    HeaderTitle.TextSize = 24
    HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
    HeaderTitle.BackgroundTransparency = 1
    HeaderTitle.Parent = HeaderFrame

    local SearchBox = Instance.new("TextBox")
    SearchBox.Name = "SearchBox"
    SearchBox.Position = UDim2.fromOffset(325, 8)
    SearchBox.Size = UDim2.fromOffset(200, 32)
    SearchBox.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    SearchBox.Font = Enum.Font.Code
    SearchBox.PlaceholderColor3 = Color3.fromRGB(80, 80, 80)
    SearchBox.PlaceholderText = "🔍 Search..."
    SearchBox.Text = ""
    SearchBox.TextSize = 14
    SearchBox.Parent = HeaderFrame

    local LockButton = Instance.new("TextButton")
    LockButton.Name = "LockButton"
    LockButton.Position = UDim2.fromOffset(540, 8)
    LockButton.Size = UDim2.fromOffset(64, 30)
    LockButton.BackgroundColor3 = Color3.fromRGB(130, 6, 6)
    LockButton.Font = Enum.Font.SourceSansBold
    LockButton.Text = "LOCK"
    LockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    LockButton.TextSize = 14
    LockButton.Parent = HeaderFrame

    local DragIcon = Instance.new("ImageLabel")
    DragIcon.Name = "DragIcon"
    DragIcon.Position = UDim2.fromOffset(615, 2)
    DragIcon.Size = UDim2.fromOffset(40, 40)
    DragIcon.BackgroundTransparency = 1
    DragIcon.Image = AWolf:GetLucideIcon("lucide-move")
    DragIcon.ImageColor3 = Color3.fromRGB(130, 6, 6)
    DragIcon.Parent = HeaderFrame

    -- Left Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Position = UDim2.fromOffset(0, 0)
    Sidebar.Size = UDim2.new(0, 180, 1, -25)
    Sidebar.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
    Sidebar.BackgroundTransparency = 0.2
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = MainFrame

    -- Profile Card
    local ProfileCard = Instance.new("Frame")
    ProfileCard.Name = "ProfileCard"
    ProfileCard.Size = UDim2.new(1, 0, 0, 90)
    ProfileCard.BackgroundColor3 = Color3.fromRGB(25, 25, 27)
    ProfileCard.BackgroundTransparency = 0.05
    ProfileCard.BorderSizePixel = 0
    ProfileCard.Parent = Sidebar

    local Avatar = Instance.new("ImageLabel")
    Avatar.Name = "Avatar"
    Avatar.Position = UDim2.fromOffset(12, 15)
    Avatar.Size = UDim2.fromOffset(48, 48)
    Avatar.BackgroundTransparency = 1
    Avatar.Image = AWolf:GetLucideIcon("user")
    Avatar.Parent = ProfileCard

    local Playername = Instance.new("TextLabel")
    Playername.Name = "Playername"
    Playername.Position = UDim2.fromOffset(70, 10)
    Playername.Size = UDim2.fromOffset(110, 24)
    Playername.Font = Enum.Font.Code
    Playername.Text = LocalPlayer and LocalPlayer.DisplayName or "PlayerName"
    Playername.TextColor3 = Color3.fromRGB(255, 255, 255)
    Playername.TextSize = 16
    Playername.TextXAlignment = Enum.TextXAlignment.Left
    Playername.BackgroundTransparency = 1
    Playername.Parent = ProfileCard

    local Username = Instance.new("TextLabel")
    Username.Name = "Username"
    Username.Position = UDim2.fromOffset(70, 34)
    Username.Size = UDim2.fromOffset(110, 18)
    Username.Font = Enum.Font.Code
    Username.Text = "@" .. (LocalPlayer and LocalPlayer.Name or "username")
    Username.TextColor3 = Color3.fromRGB(170, 170, 170)
    Username.TextSize = 12
    Username.TextXAlignment = Enum.TextXAlignment.Left
    Username.BackgroundTransparency = 1
    Username.Parent = ProfileCard

    -- Tab Buttons Holder
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Position = UDim2.fromOffset(0, 95)
    TabContainer.Size = UDim2.new(1, 0, 1, -95)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Parent = Sidebar

    local TabList = Instance.new("UIListLayout")
    TabList.Padding = UDim.new(0, 8)
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Parent = TabContainer

    -- Content Area Container
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Position = UDim2.fromOffset(180, 48)
    ContentArea.Size = UDim2.new(1, -180, 1, -73)
    ContentArea.BackgroundTransparency = 1
    ContentArea.Parent = MainFrame

    -- Footnote Bar
    local Footnote = Instance.new("TextLabel")
    Footnote.Name = "Footnote"
    Footnote.Position = UDim2.new(0, 0, 1, -25)
    Footnote.Size = UDim2.new(1, 0, 0, 25)
    Footnote.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Footnote.Font = Enum.Font.Code
    Footnote.Text = Config.Footnote or "By Alpha"
    Footnote.TextColor3 = Color3.fromRGB(200, 200, 200)
    Footnote.TextSize = 14
    Footnote.TextTransparency = 0.3
    Footnote.Parent = MainFrame

    local Minimizer = Instance.new("ImageLabel")
    Minimizer.Name = "Minimizer"
    Minimizer.Position = UDim2.new(1, -24, 0, 5)
    Minimizer.Size = UDim2.fromOffset(16, 16)
    Minimizer.BackgroundTransparency = 1
    Minimizer.Image = AWolf:GetLucideIcon("lucide-minimize-2")
    Minimizer.Parent = Footnote

    -- Frame Dragging Mechanism
    local dragging = false
    local dragStart, startPos

    HeaderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)

    HeaderFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- Window API
    local Window = {}
    Window.ScreenGui = WolfUI
    Window.MainFrame = MainFrame
    Window.TabContainer = TabContainer
    Window.ContentArea = ContentArea

    function Window:AddTab(Name, IconName)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, -10, 0, 36)
        TabButton.Position = UDim2.fromOffset(5, 0)
        TabButton.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
        TabButton.BorderSizePixel = 0
        TabButton.Font = Enum.Font.Code
        TabButton.Text = "   " .. Name
        TabButton.TextColor3 = Color3.fromRGB(240, 240, 240)
        TabButton.TextSize = 14
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.Parent = TabContainer

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabButton

        if IconName then
            local IconLabel = Instance.new("ImageLabel")
            IconLabel.Size = UDim2.fromOffset(20, 20)
            IconLabel.Position = UDim2.fromOffset(8, 8)
            IconLabel.BackgroundTransparency = 1
            IconLabel.Image = AWolf:GetLucideIcon(IconName)
            IconLabel.Parent = TabButton
        end

        -- Create a content frame for this tab
        local TabContent = Instance.new("Frame")
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = false
        TabContent.Parent = ContentArea

        -- Make clicking tab show content
        TabButton.MouseButton1Click:Connect(function()
            for _, child in ipairs(ContentArea:GetChildren()) do
                if child:IsA("Frame") then
                    child.Visible = false
                end
            end
            TabContent.Visible = true
        end)

        -- Return a small API to add UI inside the tab
        local TabAPI = {}
        TabAPI.ButtonParent = TabContent

        function TabAPI:AddSection(Title)
            local Section = Instance.new("Frame")
            Section.Size = UDim2.new(1, -20, 0, 100)
            Section.Position = UDim2.fromOffset(10, 10)
            Section.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Section.BorderSizePixel = 0
            Section.Parent = TabContent

            local TitleLabel = Instance.new("TextLabel")
            TitleLabel.Size = UDim2.new(1, 0, 0, 24)
            TitleLabel.Position = UDim2.fromOffset(8, 4)
            TitleLabel.Text = Title
            TitleLabel.Font = Enum.Font.Code
            TitleLabel.TextSize = 16
            TitleLabel.TextColor3 = Color3.fromRGB(240,240,240)
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Parent = Section

            return {
                Frame = Section,
                AddToggle = function(_, id, opts)
                    opts = opts or {}
                    local tb = Instance.new("TextButton")
                    tb.Size = UDim2.new(0, 120, 0, 28)
                    tb.Position = UDim2.fromOffset(8, 36)
                    tb.Text = opts.Text or id or "Toggle"
                    tb.Font = Enum.Font.Code
                    tb.TextSize = 14
                    tb.BackgroundColor3 = Color3.fromRGB(200,200,200)
                    tb.Parent = Section
                    return tb
                end,
            }
        end

        return TabAPI
    end

    -- Return the window API
    return Window
end

return AWolf
