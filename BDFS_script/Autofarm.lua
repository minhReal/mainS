local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = game.Players.LocalPlayer
local moneyHitbox = workspace.Buildings.DeadBurger.DumpsterMoneyMaker.MoneyHitbox

local autofarmActive = false

function cleanUpTrashcans()
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name == "Trashcan" and v:IsA("UnionOperation") then
            if #v:GetChildren() ~= 2 then
                v:Destroy()
            else
                if v:FindFirstChild("ClickDetector") then
                    fireclickdetector(v.ClickDetector)
                end
            end
        end
    end
end

local function runComputerAutofarm()
    while autofarmActive do
        wait(0.01)
        fireclickdetector(workspace.Buildings["Green House"].Computer.Monitor.Part.ClickDetector)
        wait(0.01)
        fireclickdetector(workspace.Buildings["Red House"].Computer.Monitor.Part.ClickDetector)
        wait(0.01)
        fireclickdetector(workspace.Buildings.CleaningServices:GetChildren()[23].Monitor.Part.ClickDetector)
    end
end

local function runAutofarm()
    autofarmActive = true

    spawn(function()
        while autofarmActive do
            wait(0.01)
          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["SafeBox"].CFrame * CFrame.new(0, 3, 0)
        end
    end)

    spawn(runComputerAutofarm)

    local originalCFrame = moneyHitbox.CFrame

    while autofarmActive do
        wait(0.01)

        local backpack = player:WaitForChild("Backpack")
        local GTool = backpack:FindFirstChild("Garbage Bag")
        if GTool and GTool:IsA("Tool") then
            player.Character.Humanoid:EquipTool(GTool)
            wait(2.5)
        end

        cleanUpTrashcans()

        moneyHitbox.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0)
        wait(0.01)

        moneyHitbox.CFrame = originalCFrame

        wait(0.01)
    end

    moneyHitbox.CFrame = originalCFrame
end

function toggleAutofarm(toggle)
    autofarmActive = toggle
    if autofarmActive then
        runAutofarm()
    else
        local spawns = workspace.Spawns:GetChildren()
        if #spawns > 0 then
            local randomSpawn = spawns[math.random(1, #spawns)]
            wait(0.5)
            player.Character.HumanoidRootPart.CFrame = randomSpawn.CFrame
        end
    end
end
