local targetCFrame = CFrame.new(216.000015, 72.5999985, 830.499939, 1, 0, 0, 0, 1, 0, 0, 0, 1)
local targetSize = Vector3.new(14.40000057220459, 10.199999809265137, 12.40000057220459)

local foundPart = nil

for _, part in pairs(workspace:GetChildren()) do
    if part:IsA("Part") and part.CFrame == targetCFrame and part.Size == targetSize then
        foundPart = part
        break
    end
end

if foundPart then
    foundPart.CanCollide = false
end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local initialPosition = humanoidRootPart.CFrame
local targetPosition = Vector3.new(216.10861206054688, 70.49999237060547, 826.9887084960938)
local targetCFrame = CFrame.new(216.25, 73.0999985, 822.850037, 0, 0, 1, 0, 1, 0, -1, 0, 0)

local function teleportAndFindClickDetector()
    humanoidRootPart.CFrame = CFrame.new(targetPosition)
    wait(1.5)
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.CFrame == targetCFrame then
            local clickDetector = part:FindFirstChildOfClass("ClickDetector")
            if clickDetector then
                fireclickdetector(clickDetector)
                return
            end
        end
    end
end

teleportAndFindClickDetector()

wait(2)

local playerGui = player.PlayerGui
local popUpUI = playerGui:WaitForChild("PopUpUI", 5)
if popUpUI then
    local hireButton = popUpUI.Frame:WaitForChild("HireButton", 5)
    if hireButton then
        hireButton.Hire:FireServer()
    end
end

humanoidRootPart.CFrame = initialPosition
