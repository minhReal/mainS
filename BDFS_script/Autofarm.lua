local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = game.Players.LocalPlayer
local moneyHitbox = workspace.Buildings.DeadBurger.DumpsterMoneyMaker.MoneyHitbox

local autofarmActive = false

-- Xử lý Trashcan
local function cleanUpTrashcans()
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name == "Trashcan" and v:IsA("UnionOperation") then
            if #v:GetChildren() ~= 2 then
                v:Destroy()
            elseif v:FindFirstChild("ClickDetector") then
                fireclickdetector(v.ClickDetector)
            end
        end
    end
end

-- Autofarm Computer
local function runComputerAutofarm()
    while autofarmActive do
        task.wait(0.1)
        local buildings = workspace.Buildings

        local function clickIfExists(path)
            local ok, part = pcall(function() return path end)
            if ok and part and part:FindFirstChild("ClickDetector") then
                fireclickdetector(part.ClickDetector)
            end
        end

        clickIfExists(buildings["Green House"].Computer.Monitor.Part)
        clickIfExists(buildings["Red House"].Computer.Monitor.Part)
        clickIfExists(buildings.CleaningServices:GetChildren()[23].Monitor.Part)
    end
end

-- Autofarm chính
local function runAutofarm()
    autofarmActive = true
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    -- ✅ Chờ SafeBox và GhK tồn tại
    local safeBox = workspace:WaitForChild("SafeBox")
    local safePart = safeBox:WaitForChild("GhK")

    -- Teleport nhân vật vào SafeBox 1 lần khi bắt đầu
    if safePart and safePart:IsA("Part") then
        hrp.CFrame = safePart.CFrame * CFrame.new(0, 5, 0)
    end

    task.spawn(runComputerAutofarm)

    local originalCFrame = moneyHitbox.CFrame

    while autofarmActive do
        task.wait(0.1)

        local backpack = player:WaitForChild("Backpack")
        local GTool = backpack:FindFirstChild("Garbage Bag")
        if GTool and GTool:IsA("Tool") then
            player.Character.Humanoid:EquipTool(GTool)
            task.wait(2.5)
        end

        cleanUpTrashcans()

        -- Di chuyển moneyHitbox đến người chơi
        moneyHitbox.CFrame = hrp.CFrame
        task.wait(0.05)

        moneyHitbox.CFrame = originalCFrame
    end

    -- Reset lại moneyHitbox
    moneyHitbox.CFrame = originalCFrame
end

-- Bật / tắt autofarm
function toggleAutofarm(toggle)
    autofarmActive = toggle
    if autofarmActive then
        runAutofarm()
    else
        local spawns = workspace:FindFirstChild("Spawns")
        if spawns and #spawns:GetChildren() > 0 then
            local randomSpawn = spawns:GetChildren()[math.random(1, #spawns:GetChildren())]
            task.wait(0.5)
            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")
            hrp.CFrame = randomSpawn.CFrame
        end
    end
end
