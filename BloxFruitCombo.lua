-- Script tự động combo Blox Fruit
local player = game.Players.LocalPlayer
local character = player.Character
local humanoid = character:FindFirstChild("Humanoid")

local combo = {
    "Z",
    "X",
    "C",
    "V",
    "Z",
    "X",
    "C",
    "V"
}

local function useSkill(skillName)
    local skill = player:FindFirstChild(skillName)
    if skill then
        skill:Activate()
    end
end

while true do
    for i, skill in pairs(combo) do
        useSkill(skill)
        wait(0.1)
    end
    wait(1)
end
