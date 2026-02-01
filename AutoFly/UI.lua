local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local PlayerGui = plr:WaitForChild("PlayerGui")

-- IMPORT
local Islands = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/USERNAME/REPO/main/AutoFly/Islands.lua"
))()

local Fly = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/USERNAME/REPO/main/AutoFly/FlyCore.lua"
))()

-- SEA DETECT
local function GetSea()
    local id = game.PlaceId
    if id == 2753915549 then return "Sea1" end
    if id == 4442272183 then return "Sea2" end
    if id == 7449423635 then return "Sea3" end
end

local SEA = GetSea()
if not SEA then return end

-- GUI
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "AutoFlyUI"
gui.ResetOnSpawn = false

-- LOGO
local logo = Instance.new("ImageButton", gui)
logo.Size = UDim2.fromOffset(60, 60)
logo.Position = UDim2.new(0, 15, 0.5, -30)
logo.Image = "rbxassetid://1160375285976408185"
logo.BackgroundTransparency = 1
logo.ZIndex = 10

-- PANEL
local panel = Instance.new("Frame", gui)
panel.Size = UDim2.fromOffset(220, 260)
panel.Position = UDim2.new(0, 90, 0.5, -130)
panel.BackgroundColor3 = Color3.fromRGB(25,25,25)
panel.Visible = false
panel.BorderSizePixel = 0
panel.ZIndex = 9

local corner = Instance.new("UICorner", panel)
corner.CornerRadius = UDim.new(0,12)

-- TITLE
local title = Instance.new("TextLabel", panel)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "Select Island - "..SEA
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 14

-- LIST
local list = Instance.new("UIListLayout", panel)
list.Padding = UDim.new(0,6)
list.HorizontalAlignment = Center
list.VerticalAlignment = Top
list.Parent = panel
list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    panel.CanvasSize = UDim2.fromOffset(0, list.AbsoluteContentSize.Y + 10)
end)

list.Parent = panel

-- BUTTON MAKER
local function makeButton(name)
    local b = Instance.new("TextButton", panel)
    b.Size = UDim2.new(1,-20,0,32)
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.Text = name
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    b.AutoButtonColor = true

    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0,8)

    b.MouseButton1Click:Connect(function()
        Fly.Start(Islands[SEA][name])
        panel.Visible = false
    end)
end

-- FILL ISLANDS
for island,_ in pairs(Islands[SEA]) do
    makeButton(island)
end

-- TOGGLE
logo.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible
end)
