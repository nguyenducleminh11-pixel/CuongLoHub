local Fly = {}
local RunService = game:GetService("RunService")
local plr = game.Players.LocalPlayer

function Fly.Start(targetPos)
    local char = plr.Character or plr.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    local bv = Instance.new("BodyVelocity", hrp)
    bv.MaxForce = Vector3.new(1e9,1e9,1e9)

    local bg = Instance.new("BodyGyro", hrp)
    bg.MaxTorque = Vector3.new(1e9,1e9,1e9)

    local speed = 120

    Fly._conn = RunService.Heartbeat:Connect(function()
        if not hrp or not hrp.Parent then return end

        local dir = (targetPos - hrp.Position)
        if dir.Magnitude < 50 then
            bv:Destroy()
            bg:Destroy()
            Fly._conn:Disconnect()
            return
        end

        -- gặp tường thì bay lên
        local ray = workspace:Raycast(
            hrp.Position,
            dir.Unit * 8,
            RaycastParams.new()
        )

        if ray then
            dir = dir + Vector3.new(0, 80, 0)
        end

        bv.Velocity = dir.Unit * speed
        bg.CFrame = CFrame.lookAt(hrp.Position, targetPos)
    end)
end

return Fly
