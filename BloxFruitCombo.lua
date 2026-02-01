-- SERVICES
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- UPDATE CHARACTER WHEN RESPAWN
player.CharacterAdded:Connect(function(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
end)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "MeleeComboGui"
gui.Parent = player:WaitForChild("PlayerGui")

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 160, 0, 60)
btn.Position = UDim2.new(0, 20, 0.5, -30)
btn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
btn.Text = "⚔️ COMBO"
btn.TextScaled = true
btn.Font = Enum.Font.GothamBold
btn.Parent = gui
btn.BorderSizePixel = 0
btn.AutoButtonColor = true

-- DEBOUNCE
local busy = false

-- CHECK MELEE
local function getMeleeTool()
    local tool = character:FindFirstChildOfClass("Tool")
    if not tool then return nil end

    -- đa số melee có Activate + không phải fruit
    if tool:FindFirstChild("Handle") then
        return tool
    end
    return nil
end

-- COMBO LOGIC
local function doCombo()
    if busy then return end
    busy = true

    local tool = getMeleeTool()
    if not tool then
        warn("Chưa cầm melee")
        busy = false
        return
    end

    -- spam đấm nhanh
    for i = 1, 8 do
        tool:Activate()
        task.wait(0.08)
    end

    busy = false
end

-- BUTTON CLICK
btn.MouseButton1Click:Connect(doCombo)
