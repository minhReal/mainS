-- Bản #2 / Version #2 --
-- Bản cũ \ old version --

--[[ the defective part is removed / phần được lỗi bỏ
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
    local firstMessage = "Thanks for using my script"
    typeText(msg, firstMessage, 0.05)
    task.wait(2.5)

    clearText(msg, 0.05)

    
    local secondMessage = "Enjoy!"
    typeText(msg, secondMessage, 0.05)
    task.wait(2)

    clearText(msg, 0.05)
    msg:Destroy()
end


coroutine.wrap(displayMessages)()
]]

local part = Instance.new("Part")
part.Name = "Sub"
part.Position = Vector3.new(-123, -7, 165)
part.Size = Vector3.new(10.5, 0.5, 10)
part.Anchored = true
part.Parent = game.Workspace

local light = Instance.new("PointLight")
light.Brightness = 5
light.Range = 10
light.Color = Color3.new(255, 255, 255)
light.Parent = part

local S = game.Workspace.Spawns:FindFirstChild("Spawn15")
if S then
    S:Destroy()
end


local player = game.Players.LocalPlayer
local moneyHitbox = workspace.Buildings.DeadBurger.DumpsterMoneyMaker.MoneyHitbox
moneyHitbox.Transparency = 0.7
moneyHitbox.Material = Enum.Material.Air
moneyHitbox.Color = Color3.new(1, 1, 1)
moneyHitbox.Size = Vector3.new(9.5, 50, 9.5)

local gui = Instance.new("ScreenGui")
gui.Name = "187369187619e918"
gui.Parent = game.CoreGui

local currentAnimation
local isAnimating = false

local function playAnimation(animationId)
    local character = player.Character or player.CharacterAdded:Wait()
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            local animation = Instance.new("Animation")
            animation.AnimationId = animationId
            if currentAnimation then
                currentAnimation:Stop()
            end
            currentAnimation = humanoid:LoadAnimation(animation)
            currentAnimation:Play()
            isAnimating = true
        end
    end
end

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

local lastButtonY_main = 0
local lastButtonY_main2 = 0
local lastButtonY_main3 = 0
local lastButtonY_autofarm = 0
local buttonOffset = 0.00285


local function createButton(parent, text, callback, frameId)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0.0025, 0)
    button.Position = UDim2.new(0.05, 0, (frameId == 1 and lastButtonY_main or frameId == 2 and lastButtonY_main2 or lastButtonY_main3), 0)
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
        lastButtonY_main = lastButtonY_main + buttonOffset
    elseif frameId == 2 then
        lastButtonY_main2 = lastButtonY_main2 + buttonOffset
    else
        lastButtonY_main3 = lastButtonY_main3 + buttonOffset
    end

    return button
end

createButton(main, "Meshes/Medkit", function()
    fireclickdetector(workspace["Meshes/Medkit"].ClickDetector)
end, 1)

createButton(main, "Hamburger $30", function()
    local burgerDetector = workspace.Buildings:FindFirstChild("DeadBurger") and workspace.Buildings.DeadBurger:FindFirstChild("burgre"):FindFirstChild("ClickDetector")
    if burgerDetector then
        fireclickdetector(burgerDetector)
    end
end, 1)

createButton(main, "Key card", function()
    fireclickdetector(workspace.Buildings.DeadBurger.Level1Keycard.ClickDetector)
end, 1)

createButton(main, "coming soon..", function()
    fireclickdetector(workspace:GetChildren()[4652].ClickDetector)
end, 1)

createButton(main, "PlayerDestroy9000", function()
    local handleDetector = workspace:FindFirstChild("Handle") and workspace.Handle:FindFirstChild("ClickDetector")
    if handleDetector then
        fireclickdetector(handleDetector)
    end
end, 1)

createButton(main, "Knife", function()
    local knifeClickDetector = workspace:FindFirstChild("Knife") and workspace.Knife:FindFirstChild("ClickDetector")
    if knifeClickDetector then
        fireclickdetector(knifeClickDetector)
    end
end, 1)

createButton(main2, "Anim(Bat)", function()
    playAnimation("rbxassetid://8830424363")
end, 2)

createButton(main2, "Anim(Reviving)", function()
    playAnimation("rbxassetid://7284407444")
end, 2)

createButton(main2, "Turn into a zombie", function()
    local infectionLiquid = workspace:FindFirstChild("Infection Liquid")
    if infectionLiquid then
        firetouchinterest(player.Character.HumanoidRootPart, infectionLiquid, 0)
    end
end, 2)

createButton(main2, "Reset", function()
    player.Character.Humanoid.Health = 0
end, 2)

createButton(main2, "Esp the dead", function()
    local corpses = workspace.StuffOfTheDead.Corpses:GetChildren()
    for _, corpse in pairs(corpses) do
        if corpse:IsA("Model") then
            local highlight = Instance.new("Highlight")
            highlight.Parent = corpse
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.8
            highlight.OutlineTransparency = 0.2
        end
    end
end, 2)

createButton(main2, "Antiafk", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-AntiAFK-script-18076"))()
end, 2)

createButton(main2, "FullBright", function()
    loadstring(game:HttpGet("https://pastefy.app/bUT6Ec1s/raw"))()
end, 2)

createButton(main2, "TP tool", function()
    loadstring(game:HttpGet("https://pastefy.app/Urr0ZArX/raw"))()
end, 2)

createButton(main2, "Shiftlock", function()
    loadstring(game:HttpGet("https://pastefy.app/GCnYtXlr/raw"))()
end, 2)

createButton(main2, "Telekinesis", function()  
    loadstring(game:HttpGet("https://pastefy.app/7nvhyNkx/raw"))()
end, 2)

createButton(main2, "Rejoin", function()
    local TeleportService = game:GetService("TeleportService")
    TeleportService:Teleport(game.PlaceId, player)
end, 2)

local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = game.Players.LocalPlayer
local hungerGui = player.PlayerGui:WaitForChild("Hunger")
local burgerClickDetector = workspace.Buildings.DeadBurger.burgre.ClickDetector

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

local function eat()
    if not player.Backpack:FindFirstChild("Burger") then
        fireclickdetector(burgerClickDetector)
    end
    wait(0.1)

    local _burger = player.Backpack:WaitForChild("Burger")
    _burger.Parent = player.Character
    _burger:Activate()
    wait(1.5)
end

local autofarmActive = false

local function runComputerAutofarm()
    while autofarmActive do
        wait(0.01)
        fireclickdetector(workspace.Buildings["Green House"].Computer.Monitor.Part.ClickDetector)
    end
end

local function runAutofarm()
    autofarmActive = true
    spawn(function()
        while autofarmActive do
            wait(0.01)
            player.Character.HumanoidRootPart.CFrame = CFrame.new(-122.55330657958984, -3.750000476837158, 165.34146118164062)
        end
    end)

    spawn(runComputerAutofarm)

    while autofarmActive do
        wait(0.01)
        VirtualInputManager:SendKeyEvent(true, "One", false, player.Character:FindFirstChild("Humanoid"))
        wait(0.01)
        VirtualInputManager:SendKeyEvent(true, "Two", false, player.Character:FindFirstChild("Humanoid"))

        cleanUpTrashcans()

        if hungerGui and hungerGui.Hunger.Value < 50 then
            eat()
            wait(2.5)
        end

        wait(0.01)
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
    autofarmToggle.BackgroundTransparency = 0
    autofarmToggle.TextColor3 = Color3.new(1, 1, 1)
    autofarmToggle.Font = Enum.Font.Code
    autofarmToggle.Parent = main3

    lastButtonY_autofarm = lastButtonY_autofarm + buttonOffset

    autofarmToggle.MouseButton1Click:Connect(function()
        autofarmActive = not autofarmActive
        autofarmToggle.TextColor3 = autofarmActive and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)

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
    end)
end

createAutofarmButton()


local PlayerGui = player:WaitForChild("PlayerGui")

local hungerGui = PlayerGui:FindFirstChild("Hunger")
if not hungerGui then
    return
end

local displayGui = Instance.new("ScreenGui")
displayGui.Name = "DisplayInfoGui"
displayGui.Parent = PlayerGui

local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(0.3, 0, 0.05, 0)
infoFrame.Position = UDim2.new(0.28, 0, 0.958, 0)
infoFrame.BackgroundColor3 = Color3.new(0, 0, 0)
infoFrame.BackgroundTransparency = 1
infoFrame.Parent = displayGui
infoFrame.Visible = false

local hungerLabel = Instance.new("TextLabel")
hungerLabel.Size = UDim2.new(1, 0, 0)
hungerLabel.Position = UDim2.new(-0.2, -0.55, 0)
hungerLabel.BackgroundTransparency = 1
hungerLabel.TextColor3 = Color3.new(1, 1, 1)
hungerLabel.Font = Enum.Font.Code
hungerLabel.TextSize = 18
hungerLabel.TextXAlignment = Enum.TextXAlignment.Left
hungerLabel.TextStrokeTransparency = 0
hungerLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
hungerLabel.Parent = infoFrame

local joyLabel = Instance.new("TextLabel")
joyLabel.Size = UDim2.new(1, 0, 0)
joyLabel.Position = UDim2.new(1.2, -0.55, 0)
joyLabel.BackgroundTransparency = 1
joyLabel.TextColor3 = Color3.new(1, 1, 1)
joyLabel.Font = Enum.Font.Code
joyLabel.TextSize = 18
joyLabel.TextXAlignment = Enum.TextXAlignment.Left
joyLabel.TextStrokeTransparency = 0
joyLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
joyLabel.Parent = infoFrame


local function updateInfo()
    local hungerValue = hungerGui.Hunger.Value
    
    local joyValue = player.Character:WaitForChild("Values"):WaitForChild("Joy").Value 
    hungerLabel.Text = "Hunger: " .. hungerValue 

    local joyText = string.format("Joy: %.3f - ", joyValue)


    if joyValue < 50 then
        joyText = joyText .. "Not good"
    else
        joyText = joyText .. "Good"
    end

    joyLabel.Text = joyText
end


hungerGui.Hunger:GetPropertyChangedSignal("Value"):Connect(updateInfo)
player.Character.Values.Joy:GetPropertyChangedSignal("Value"):Connect(updateInfo)


updateInfo()

local infoLabelBtn = Instance.new("TextButton")
infoLabelBtn.Size = UDim2.new(0.9, 0, 0.0025, 0)
infoLabelBtn.Position = UDim2.new(0.05, 0, lastButtonY_autofarm, 0)
infoLabelBtn.BackgroundColor3 = Color3.new(0, 0, 0)
infoLabelBtn.BorderColor3 = Color3.new(1, 1, 1)
infoLabelBtn.TextSize = 15
infoLabelBtn.BorderSizePixel = 1
infoLabelBtn.Text = "Toggle Info Text"
infoLabelBtn.BackgroundTransparency = 0
infoLabelBtn.TextColor3 = Color3.new(1, 1, 1)
infoLabelBtn.Font = Enum.Font.Code
infoLabelBtn.Parent = main3

local isInfoVisible = false

infoLabelBtn.MouseButton1Click:Connect(function()
    isInfoVisible = not isInfoVisible
    infoFrame.Visible = isInfoVisible

    infoLabelBtn.TextColor3 = isInfoVisible and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
end)

local isVisible = false
local togglebutton = Instance.new("TextButton")
togglebutton.Size = UDim2.new(0.1, 0, 0.1, 0)
togglebutton.Position = UDim2.new(0, 0, 0.5, 0)
togglebutton.TextColor3 = Color3.new(1, 1, 1)
togglebutton.BorderColor3 = Color3.new(0, 0, 0)
togglebutton.BorderSizePixel = 0
togglebutton.BackgroundColor3 = Color3.new(0, 0, 0)
togglebutton.Parent = gui
togglebutton.Text = "Support"
togglebutton.TextSize = 10

togglebutton.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    main.Visible = isVisible
    main2.Visible = isVisible
    main3.Visible = isVisible
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "⚠️ WARNING ⚠️",
    Text = "IF YOU ENABLE AUTOFARM YOU MUST PUT ALL ITEMS INTO THE BACKPACK FOR AUTOFARM.",
    Duration = 20
})
