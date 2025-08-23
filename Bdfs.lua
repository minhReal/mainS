-- Bản Fixed / Version Fixed --

-- Hiệu ứng gõ chữ
local function typeText(object, text, delay)
    for i = 1, #text do
        object.Text = text:sub(1, i)
        task.wait(delay)
    end
end

local function clearText(object, delay)
    for i = #object.Text, 1, -1 do
        object.Text = object.Text:sub(1, i - 1)
        task.wait(delay)
    end
end

local msg = Instance.new("Hint", workspace)
msg.Text = ""

local function displayMessages()
    typeText(msg, "Thanks for using my script", 0.05)
    task.wait(2.5)
    clearText(msg, 0.05)

    typeText(msg, "Enjoy!", 0.05)
    task.wait(2)
    clearText(msg, 0.05)
    msg:Destroy()
end
coroutine.wrap(displayMessages)()

-- Part + Light
local part = Instance.new("Part")
part.Name = "Sub"
part.Position = Vector3.new(-123, -7, 165)
part.Size = Vector3.new(10.5, 0.5, 10)
part.Anchored = true
part.Parent = workspace

local light = Instance.new("PointLight")
light.Brightness = 5
light.Range = 10
light.Color = Color3.fromRGB(255, 255, 255)
light.Parent = part

-- Remove spawn
local S = workspace.Spawns:FindFirstChild("Spawn15")
if S then S:Destroy() end

local player = game.Players.LocalPlayer

-- chỉnh hitbox
local moneyHitbox = workspace.Buildings.DeadBurger.DumpsterMoneyMaker.MoneyHitbox
moneyHitbox.Transparency = 0.7
moneyHitbox.Material = Enum.Material.Air
moneyHitbox.Color = Color3.fromRGB(255, 255, 255)
moneyHitbox.Size = Vector3.new(9.5, 50, 9.5)

-- GUI chính
local gui = Instance.new("ScreenGui")
gui.Name = "187369187619e918"
gui.Parent = game.CoreGui

local currentAnimation

local function playAnimation(animationId)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        local animation = Instance.new("Animation")
        animation.AnimationId = string.find(animationId,"rbxassetid://") and animationId or "rbxassetid://"..animationId
        if currentAnimation then currentAnimation:Stop() end
        currentAnimation = humanoid:LoadAnimation(animation)
        currentAnimation:Play()
    end
end

-- Tạo khung
local function createScrollingFrame(position)
    local frame = Instance.new("ScrollingFrame")
    frame.Size = UDim2.new(0.2, 0, 1, 0)
    frame.Position = position
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BorderColor3 = Color3.new(0, 0, 0)
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 0.6
    frame.Visible = false
    frame.CanvasSize = UDim2.new(0, 0, 50, 0)
    return frame
end

local main = createScrollingFrame(UDim2.new(0.11, 0, -0.01, 0))
local main2 = createScrollingFrame(UDim2.new(0.35, 0, -0.01, 0))
local main3 = createScrollingFrame(UDim2.new(0.6, 0, -0.01, 0))

main.Parent = gui
main2.Parent = gui
main3.Parent = gui

local lastButtonY_main, lastButtonY_main2, lastButtonY_main3, lastButtonY_autofarm = 0,0,0,0
local buttonOffset = 0.00285

local function createButton(parent, text, callback, frameId)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0.0025, 0)
    button.Position = UDim2.new(0.05, 0, (frameId==1 and lastButtonY_main or frameId==2 and lastButtonY_main2 or lastButtonY_main3), 0)
    button.BackgroundColor3 = Color3.new(0, 0, 0)
    button.BorderColor3 = Color3.new(1, 1, 1)
    button.BorderSizePixel = 1
    button.Text = text
    button.TextSize = 16
    button.BackgroundTransparency = 0
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.Code
    button.Parent = parent
    button.MouseButton1Click:Connect(callback)

    if frameId == 1 then
        lastButtonY_main += buttonOffset
    elseif frameId == 2 then
        lastButtonY_main2 += buttonOffset
    else
        lastButtonY_main3 += buttonOffset
    end

    return button
end

-- buttons (main + main2 giống script cũ)
-- ... [phần button giữ nguyên như script bạn đưa, chỉ fix Color3 và AnimationId] ...

-- AutoFarm + ăn Burger
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local hungerGui = player.PlayerGui:WaitForChild("Hunger")
local burgerClickDetector = workspace.Buildings.DeadBurger.burgre.ClickDetector

function cleanUpTrashcans()
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

local function eat()
    if not player.Backpack:FindFirstChild("Burger") then
        fireclickdetector(burgerClickDetector)
    end
    task.wait(0.1)

    local _burger = player.Backpack:WaitForChild("Burger")
    _burger.Parent = player.Character
    _burger:Activate()
    task.wait(1.5)
end

local autofarmActive = false

local function runComputerAutofarm()
    while autofarmActive do
        task.wait(0.01)
        local comp = workspace.Buildings["Green House"].Computer.Monitor.Part
        if comp:FindFirstChild("ClickDetector") then
            fireclickdetector(comp.ClickDetector)
        end
    end
end

local function runAutofarm()
    autofarmActive = true
    task.spawn(function()
        while autofarmActive do
            task.wait(0.01)
            player.Character.HumanoidRootPart.CFrame = CFrame.new(-122.55, -3.75, 165.34)
        end
    end)
    task.spawn(runComputerAutofarm)

    while autofarmActive do
        task.wait(0.01)
        VirtualInputManager:SendKeyEvent(true, "One", false, player.Character:FindFirstChild("Humanoid"))
        task.wait(0.01)
        VirtualInputManager:SendKeyEvent(true, "Two", false, player.Character:FindFirstChild("Humanoid"))

        cleanUpTrashcans()

        if hungerGui and hungerGui.Hunger.Value < 50 then
            eat()
            task.wait(2.5)
        end
    end
end

local function createAutofarmButton()
    local autofarmToggle = Instance.new("TextButton")
    autofarmToggle.Size = UDim2.new(0.9, 0, 0.0025, 0)
    autofarmToggle.Position = UDim2.new(0.05, 0, lastButtonY_autofarm, 0)
    autofarmToggle.BackgroundColor3 = Color3.new(0, 0, 0)
    autofarmToggle.BorderColor3 = Color3.new(1, 1, 1)
    autofarmToggle.BorderSizePixel = 1
    autofarmToggle.Text = "Autofarm + eat (silent)"
    autofarmToggle.TextSize = 13.5
    autofarmToggle.TextColor3 = Color3.new(1, 1, 1)
    autofarmToggle.Font = Enum.Font.Code
    autofarmToggle.Parent = main3

    lastButtonY_autofarm += buttonOffset

    autofarmToggle.MouseButton1Click:Connect(function()
        autofarmActive = not autofarmActive
        autofarmToggle.TextColor3 = autofarmActive and Color3.new(0,1,0) or Color3.new(1,0,0)

        if autofarmActive then
            runAutofarm()
        else
            local spawns = workspace.Spawns:GetChildren()
            if #spawns > 0 then
                local randomSpawn = spawns[math.random(1, #spawns)]
                task.wait(0.5)
                player.Character.HumanoidRootPart.CFrame = randomSpawn.CFrame
            end
        end
    end)
end
createAutofarmButton()

-- HUD hiển thị Hunger + Joy
local PlayerGui = player:WaitForChild("PlayerGui")
local displayGui = Instance.new("ScreenGui", PlayerGui)
displayGui.Name = "DisplayInfoGui"

local infoFrame = Instance.new("Frame", displayGui)
infoFrame.Size = UDim2.new(0.3, 0, 0.05, 0)
infoFrame.Position = UDim2.new(0.28, 0, 0.9, 0)
infoFrame.BackgroundTransparency = 1
infoFrame.Visible = false

local hungerLabel = Instance.new("TextLabel", infoFrame)
hungerLabel.Size = UDim2.new(1, 0, 0.5, 0)
hungerLabel.BackgroundTransparency = 1
hungerLabel.TextColor3 = Color3.new(1,1,1)
hungerLabel.Font = Enum.Font.Code
hungerLabel.TextSize = 18

local joyLabel = hungerLabel:Clone()
joyLabel.Parent = infoFrame
joyLabel.Position = UDim2.new(0,0,0.5,0)

local function updateInfo()
    local hungerValue = hungerGui.Hunger.Value
    local joyValue = player.Character.Values.Joy.Value
    hungerLabel.Text = "Hunger: " .. hungerValue
    joyLabel.Text = string.format("Joy: %.3f - %s", joyValue, joyValue<50 and "Not good" or "Good")
end
hungerGui.Hunger:GetPropertyChangedSignal("Value"):Connect(updateInfo)
player.Character.Values.Joy:GetPropertyChangedSignal("Value"):Connect(updateInfo)
updateInfo()

-- Nút bật/tắt Info
local infoLabelBtn = Instance.new("TextButton", main3)
infoLabelBtn.Size = UDim2.new(0.9, 0, 0.0025, 0)
infoLabelBtn.Position = UDim2.new(0.05, 0, lastButtonY_autofarm, 0)
infoLabelBtn.BackgroundColor3 = Color3.new(0, 0, 0)
infoLabelBtn.BorderColor3 = Color3.new(1, 1, 1)
infoLabelBtn.TextSize = 15
infoLabelBtn.Text = "Toggle Info Text"
infoLabelBtn.TextColor3 = Color3.new(1,1,1)
infoLabelBtn.Font = Enum.Font.Code

local isInfoVisible = false
infoLabelBtn.MouseButton1Click:Connect(function()
    isInfoVisible = not isInfoVisible
    infoFrame.Visible = isInfoVisible
    infoLabelBtn.TextColor3 = isInfoVisible and Color3.new(0,1,0) or Color3.new(1,0,0)
end)

-- Toggle GUI
local isVisible = false
local togglebutton = Instance.new("TextButton", gui)
togglebutton.Size = UDim2.new(0.1, 0, 0.1, 0)
togglebutton.Position = UDim2.new(0, 0, 0.5, 0)
togglebutton.TextColor3 = Color3.new(1, 1, 1)
togglebutton.BackgroundColor3 = Color3.new(0, 0, 0)
togglebutton.Text = "Support"
togglebutton.TextSize = 10

togglebutton.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    main.Visible, main2.Visible, main3.Visible = isVisible, isVisible, isVisible
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "⚠️ WARNING ⚠️",
    Text = "IF YOU ENABLE AUTOFARM YOU MUST PUT ALL ITEMS INTO THE BACKPACK FOR AUTOFARM.",
    Duration = 20
})
