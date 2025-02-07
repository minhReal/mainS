local corpsesFolder = game.Workspace:WaitForChild("StuffOfTheDead"):WaitForChild("Corpses")
local desiredCFrame = CFrame.new(229.125015, 69.8499985, 847.725037)

local function teleportAndActivateClickDetector()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")

    if #corpsesFolder:GetChildren() == 0 then
        warn("No corpses found in StuffOfTheDead.")
        return
    end

    local corpse = corpsesFolder:GetChildren()[1]

    if corpse:IsA("Model") and corpse.PrimaryPart then
        rootPart.CFrame = corpse.PrimaryPart.CFrame
        wait(0.2)

        local corpseName = corpse.Name
        print("Teleported to:", corpseName)

        local clickDetectorPath = workspace.StuffOfTheDead.Corpses[corpseName].Torso.BodyClickDetector
        if clickDetectorPath then
            fireclickdetector(clickDetectorPath)
        end
    else
        print(corpse.Name, "is not a Model or does not have a PrimaryPart.")
    end
end

teleportAndActivateClickDetector()

wait(2)
local targetCFrame = CFrame.new(229.125015, 69.8499985, 847.725037, 1, 0, 0, 0, 1, 0, 0, 0, 1)

local function findPartWithCFrame()
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("Part") and part.CFrame == targetCFrame then
            print("Found part:", part.Name)

            local clickDetector = part:FindFirstChildOfClass("ClickDetector")
            if clickDetector then
                fireclickdetector(clickDetector)
            end
            
            return
        end
    end

    print("No part found with the specified CFrame.")
end

findPartWithCFrame()

wait(2)

local desiredCFrame = CFrame.new(229.125015, 69.8499985, 847.725037)

local function findPartWithCFrame()
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("Part") and part.CFrame.Position == desiredCFrame.Position then
            print("Found part:", part.Name)

            local clickDetector = part:FindFirstChildOfClass("ClickDetector")
            if clickDetector then
                fireclickdetector(clickDetector)
            end
            
            return
        end
    end

    print("No part found with the specified CFrame.")
end
