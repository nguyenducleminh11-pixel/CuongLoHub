local UI = {}

local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local PlayerGui = plr:WaitForChild("PlayerGui")

-- IMPORT MODULE
local Islands = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/nguyenducleminh11-pixel/CuongLoHub/main/AutoFly/Islands.lua"
))()

local Fly = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/nguyenducleminh11-pixel/CuongLoHub/main/AutoFly/FlyCore.lua"
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

-- GUI ROOT
local gui = Instance.new("ScreenGui")
gui.Name = "AutoFlyUI"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

-- LOGO BUTTON
local logo = Instance.new("ImageButton", gui)
logo.Size = UDim2.fromOffset(58, 58)
logo.Position = UDim2.new(0, 15, 0.5, -29)
logo.BackgroundTransparency = 1
logo.Image = "https://cdn.discordapp.com/avatars/1160375285976408185/3c0834c083a843c5fa671b85d6cafebd.png"
logo.ZIndex = 10

-- PANEL
local panel = Instance.new("ScrollingFrame", gui)
panel.Size = UDim2.fromOffset(230, 280)
panel.Position = UDim2.new(0, 85, 0.5, -140)
panel.BackgroundColor3 = Color3.fromRGB(22,22,22)
panel.BorderSizePixel = 0
panel.Visible = false
panel.ScrollBarImageTransparency = 1
panel.CanvasSize = UDim2.new()
panel.ZIndex = 9

local corner = Instance.new("UICorner", panel)
corner.CornerRadius = UDim.new(0, 14)

-- TITLE
local title = Instance.new("TextLabel", panel)
title.Size = UDim2.new(1, -10, 0, 36)
title.Position = UDim2.fromOffset(5, 6)
title.BackgroundTransparency = 1
title.Text = "Auto Fly - "..SEA
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Left

-- LIST
local list = Instance.new("UIListLayout", panel)
list.Padding = UDim.new(0, 6)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center
list.VerticalAlignment = Enum.VerticalAlignment.Top

list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    panel.CanvasSize = UDim2.fromOffset(0, list.AbsoluteContentSize.Y + 50)
end)

-- BUTTON MAKER
local function makeButton(name, pos)
    local b = Instance.new("TextButton", panel)
    b.Size = UDim2.new(1, -20, 0, 34)
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.Text = name
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    b.AutoButtonColor = true

    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0, 10)

    b.MouseButton1Click:Connect(function()
        Fly.Start(pos)
        panel.Visible = false
    end)
end

-- PUSH ISLANDS
for island, pos in pairs(Islands[SEA]) do
    makeButton(island, pos)
end

-- TOGGLE PANEL
logo.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible
end)

return UI
