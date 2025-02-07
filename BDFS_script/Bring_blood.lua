local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local targetCFrame = humanoidRootPart.CFrame * CFrame.new(0, -humanoidRootPart.Size.Y / 2, 0) * CFrame.Angles(math.rad(90), 0, 0)

for _, splat in pairs(workspace.Splatters:GetChildren()) do
    if splat:IsA("Part") then
        splat.CFrame = targetCFrame
    end
end
