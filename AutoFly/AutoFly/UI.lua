-- UI.lua (TEXT ONLY)
warn("[AutoFly] UI.lua loaded")

local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local PlayerGui = plr:WaitForChild("PlayerGui")

-- clear UI cũ
pcall(function()
    PlayerGui.AutoFlyUI:Destroy()
end)

-- LOAD MODULE
warn("[AutoFly] Loading modules...")

local Islands = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/nguyenducleminh11-pixel/CuongLoHub/main/AutoFly/AutoFly/Islands.lua"
))()
warn("[AutoFly] Islands loaded")

local Fly = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/nguyenducleminh11-pixel/CuongLoHub/main/AutoFly/AutoFly/FlyCore.lua"
))()
warn("[AutoFly] FlyCore loaded")

-- SEA DETECT
local function GetSea()
    local id = game.PlaceId
    if id == 2753915549 then return "Sea1" end
    if id == 4442272183 then return "Sea2" end
    if id == 7449423635 then return "Sea3" end
end

local SEA = GetSea()
if not SEA then
    warn("[AutoFly] ❌ Not in Blox Fruits")
    return
end
warn("[AutoFly] Detected:", SEA)

-- GUI ROOT
local gui = Instance.new("ScreenGui")
gui.Name = "AutoFlyUI"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui
warn("[AutoFly] UI created")

-- TOGGLE BUTTON (TEXT)
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.fromOffset(110, 36)
toggle.Position = UDim2.new(0, 15, 0.5, -18)
toggle.BackgroundColor3 = Color3.fromRGB(30,30,30)
toggle.Text = "AUTO FLY"
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 13
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 10)

-- PANEL
local panel = Instance.new("Frame", gui)
panel.Size = UDim2.fromOffset(240, 300)
panel.Position = UDim2.new(0, 135, 0.5, -150)
panel.BackgroundColor3 = Color3.fromRGB(22,22,22)
panel.Visible = false
panel.ZIndex = 9
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 14)

-- TITLE
local title = Instance.new("TextLabel", panel)
title.Size = UDim2.new(1, -20, 0, 36)
title.Position = UDim2.fromOffset(10, 8)
title.BackgroundTransparency = 1
title.Text = "Auto Fly - "..SEA
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left

-- SCROLL
local scroll = Instance.new("ScrollingFrame", panel)
scroll.Position = UDim2.fromOffset(10, 50)
scroll.Size = UDim2.new(1, -20, 1, -60)
scroll.CanvasSize = UDim2.new()
scroll.ScrollBarImageTransparency = 1
scroll.BackgroundTransparency = 1

local list = Instance.new("UIListLayout", scroll)
list.Padding = UDim.new(0, 6)

list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scroll.CanvasSize = UDim2.fromOffset(0, list.AbsoluteContentSize.Y + 10)
end)

-- BUTTON
local function makeButton(name, pos)
    local b = Instance.new("TextButton", scroll)
    b.Size = UDim2.new(1, 0, 0, 34)
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.Text = name
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)

    b.MouseButton1Click:Connect(function()
        warn("[AutoFly] Fly to:", name)
        Fly.Start(pos)
        panel.Visible = false
    end)
end

for island, pos in pairs(Islands[SEA]) do
    makeButton(island, pos)
end

-- TOGGLE PANEL
toggle.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible
    warn("[AutoFly] Toggle panel:", panel.Visible)
end)

warn("[AutoFly] ✅ Ready (Text UI)")
