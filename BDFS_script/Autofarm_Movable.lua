local PlayerService = game:GetService("Players")
local WorkspaceService = game:GetService("Workspace")
local player = PlayerService.LocalPlayer
local moneyBox = WorkspaceService.Buildings.DeadBurger.DumpsterMoneyMaker.MoneyHitbox

local isAutofarming = false

function cleanTrashCans()
    for _, item in pairs(WorkspaceService:GetChildren()) do
        if item.Name == "Trashcan" and item:IsA("UnionOperation") then
            if #item:GetChildren() ~= 2 then
                item:Destroy()
            else
                if item:FindFirstChild("ClickDetector") then
                    fireclickdetector(item.ClickDetector)
                end
            end
        end
    end
end

local function startComputerAutofarm()
    while isAutofarming do
        wait(0.01)
        fireclickdetector(WorkspaceService.Buildings["Green House"].Computer.Monitor.Part.ClickDetector)
        wait(0.01)
        fireclickdetector(workspace.Buildings["Red House"].Computer.Monitor.Part.ClickDetector)
        wait(0.01)
        fireclickdetector(workspace.Buildings.CleaningServices:GetChildren()[23].Monitor.Part.ClickDetector)
    end
end

local function executeAutofarm()
    isAutofarming = true

    spawn(startComputerAutofarm)

    local previousCFrame = moneyBox.CFrame

    while isAutofarming do
        wait(0.01)

        local backpack = player:WaitForChild("Backpack")
        local garbageTool = backpack:FindFirstChild("Garbage Bag")
        if garbageTool and garbageTool:IsA("Tool") then
            player.Character.Humanoid:EquipTool(garbageTool)
            wait(0.5)
        end

        cleanTrashCans()
        
        moneyBox.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0)
        wait(0.05)

        moneyBox.CFrame = previousCFrame
        wait(0.05)
    end
    moneyBox.CFrame = previousCFrame
end

function toggleAutofarm(toggle)
    isAutofarming = toggle
    if isAutofarming then
        executeAutofarm()
    end
end
