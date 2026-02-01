-- FlyCore.lua
local Fly = {}
local RunService = game:GetService("RunService")
local plr = game.Players.LocalPlayer

function Fly.Start(targetPos)
    -- cleanup cũ
    if Fly._conn then
        Fly._conn:Disconnect()
        Fly._conn = nil
    end

    local char = plr.Character or plr.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.Parent = hrp

    local bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bg.P = 9e4
    bg.Parent = hrp

    local speed = 120

    -- raycast params (ignore chính mình)
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {char}
    params.FilterType = Enum.RaycastFilterType.Blacklist

    Fly._conn = RunService.Heartbeat:Connect(function()
        if not hrp or not hrp.Parent then return end

        local dir = targetPos - hrp.Position
        if dir.Magnitude < 40 then
            bv:Destroy()
            bg:Destroy()
            Fly._conn:Disconnect()
            Fly._conn = nil
            return
        end

        -- gặp tường thì bay lên
        local ray = workspace:Raycast(hrp.Position, dir.Unit * 8, params)
        if ray then
            dir = dir + Vector3.new(0, 80, 0)
        end

        bv.Velocity = dir.Unit * speed
        bg.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + dir)
    end)
end

return Fly
