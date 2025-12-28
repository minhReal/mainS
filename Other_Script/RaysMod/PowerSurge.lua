-- By owner --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Connections = {}
local Settings = {
    Noclip = false,
    BringDistance = 15,
    LoopBringModels = false,
    LoopBringPlayers = false,
    AimbotEnabled = false,
    AimbotTargetType = "Players",
    AimbotFOV = 300, 
    UIMinimized = false,
    CurrentTab = "Farm"
}

if CoreGui:FindFirstChild("u") then
    CoreGui.u:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "u "
ScreenGui.ResetOnSpawn = false
if pcall(function() ScreenGui.Parent = CoreGui end) then else ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.25
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -170)
MainFrame.Size = UDim2.new(0, 280, 0, 350)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(50, 50, 50); Stroke.Thickness = 1; Stroke.Transparency = 0.5

local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TopBar.BackgroundTransparency = 0.1
TopBar.Size = UDim2.new(1, 0, 0, 32)

local TopBarCorner = Instance.new("UICorner", TopBar)
TopBarCorner.CornerRadius = UDim.new(0, 10)
local Filler = Instance.new("Frame", TopBar) 
Filler.BackgroundColor3 = TopBar.BackgroundColor3; Filler.BackgroundTransparency = TopBar.BackgroundTransparency
Filler.BorderSizePixel = 0; Filler.Position = UDim2.new(0, 0, 1, -5); Filler.Size = UDim2.new(1, 0, 0, 5)

local Title = Instance.new("TextLabel", TopBar)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Size = UDim2.new(0, 150, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Power Surge - HYDRO"
Title.TextColor3 = Color3.fromRGB(240, 240, 240)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
CloseBtn.Position = UDim2.new(1, -25, 0.5, -6)
CloseBtn.Size = UDim2.new(0, 12, 0, 12); CloseBtn.Text = ""
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.BackgroundColor3 = Color3.fromRGB(0,160,255)
MinBtn.Position = UDim2.new(1, -45, 0.5, -6)
MinBtn.Size = UDim2.new(0, 12, 0, 12); MinBtn.Text = ""
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1, 0)

local TabContainer = Instance.new("Frame", MainFrame)
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 0, 0, 35)
TabContainer.Size = UDim2.new(1, 0, 0, 30)

local TabFarmBtn = Instance.new("TextButton", TabContainer)
TabFarmBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TabFarmBtn.Position = UDim2.new(0.05, 0, 0, 0)
TabFarmBtn.Size = UDim2.new(0.425, 0, 1, 0)
TabFarmBtn.Font = Enum.Font.GothamBold
TabFarmBtn.Text = "FARM KILL"
TabFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TabFarmBtn.TextSize = 11
Instance.new("UICorner", TabFarmBtn).CornerRadius = UDim.new(0, 6)

local TabAimbotBtn = Instance.new("TextButton", TabContainer)
TabAimbotBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TabAimbotBtn.Position = UDim2.new(0.525, 0, 0, 0)
TabAimbotBtn.Size = UDim2.new(0.425, 0, 1, 0)
TabAimbotBtn.Font = Enum.Font.GothamBold
TabAimbotBtn.Text = "AIMBOT"
TabAimbotBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
TabAimbotBtn.TextSize = 11
Instance.new("UICorner", TabAimbotBtn).CornerRadius = UDim.new(0, 6)

local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 0, 0, 75)
ContentContainer.Size = UDim2.new(1, 0, 1, -85)

local function isVisible(part)
    local origin = Camera.CFrame.Position
    local direction = part.Position - origin
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = {LocalPlayer.Character}
    local result = Workspace:Raycast(origin, direction, params)
    if result then return result.Instance:IsDescendantOf(part.Parent) end
    return false
end

local function getClosestTarget()
    local closest = nil
    local closestDist = math.huge
    local potentialTargets = {}
    
    if Settings.AimbotTargetType == "Players" then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character then table.insert(potentialTargets, v.Character) end
        end
    elseif Settings.AimbotTargetType == "NPCs" then
        for _, v in pairs(Workspace:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Head") then
                if not Players:GetPlayerFromCharacter(v) and v ~= LocalPlayer.Character then
                    table.insert(potentialTargets, v)
                end
            end
        end
    end

    for _, char in pairs(potentialTargets) do
        local head = char:FindFirstChild("Head")
        local hum = char:FindFirstChild("Humanoid")
        if head and hum and hum.Health > 0 then
            local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
            if onScreen and isVisible(head) then
                local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if dist < closestDist and dist < Settings.AimbotFOV then
                    closestDist = dist
                    closest = head
                end
            end
        end
    end
    return closest
end

local function ClearContent()
    for _, child in pairs(ContentContainer:GetChildren()) do child:Destroy() end
end

local function CreateButton(text, order, color, transparency, callback)
    local btn = Instance.new("TextButton", ContentContainer)
    btn.BackgroundColor3 = color or Color3.fromRGB(45, 45, 45)
    btn.BackgroundTransparency = transparency or 0.2
    btn.Position = UDim2.new(0.05, 0, 0, (order - 1) * 48)
    btn.Size = UDim2.new(0.9, 0, 0, 38)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.TextSize = 16
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function() callback(btn) end)
    return btn
end

local function LoadFarmTab()
    ClearContent()
    
    local noclipBtn = CreateButton(Settings.Noclip and "Noclip: ON" or "Noclip: OFF", 1, Settings.Noclip and Color3.fromRGB(0, 180, 110), Settings.Noclip and 0, function(btn)
        Settings.Noclip = not Settings.Noclip
        btn.Text = Settings.Noclip and "Noclip: ON" or "Noclip: OFF"
        btn.BackgroundColor3 = Settings.Noclip and Color3.fromRGB(0, 180, 110) or Color3.fromRGB(45, 45, 45)
        btn.BackgroundTransparency = Settings.Noclip and 0 or 0.2
    end)

    local SliderFrame = Instance.new("Frame", ContentContainer)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35); SliderFrame.BackgroundTransparency = 0.4
    SliderFrame.Position = UDim2.new(0.05, 0, 0, 48); SliderFrame.Size = UDim2.new(0.9, 0, 0, 45)
    Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 6)
    
    local sLabel = Instance.new("TextLabel", SliderFrame)
    sLabel.BackgroundTransparency = 1; sLabel.Position = UDim2.new(0,10,0,2); sLabel.Size = UDim2.new(1,-20,0,20)
    sLabel.Font = Enum.Font.GothamMedium; 
    sLabel.Text = "Radius: " .. Settings.BringDistance .. " studs" 
    sLabel.TextColor3 = Color3.fromRGB(180,180,180); sLabel.TextSize = 11; sLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local sBg = Instance.new("Frame", SliderFrame)
    sBg.BackgroundColor3 = Color3.fromRGB(60,60,60); sBg.Position = UDim2.new(0,10,0,28); sBg.Size = UDim2.new(1,-20,0,4)
    Instance.new("UICorner", sBg).CornerRadius = UDim.new(1,0)
    
    local sKnob = Instance.new("TextButton", sBg)
    sKnob.BackgroundColor3 = Color3.fromRGB(0,160,255); sKnob.Size = UDim2.new(0,14,0,14); sKnob.AnchorPoint = Vector2.new(0.5,0.5); sKnob.Text = ""
    Instance.new("UICorner", sKnob).CornerRadius = UDim.new(1,0)
    
    local min, max = 15, 35
    local currentPercent = (Settings.BringDistance - min) / (max - min)
    sKnob.Position = UDim2.new(currentPercent, 0, 0.5, 0)

    local dragging = false
    sKnob.InputBegan:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then dragging = true end end)
    UserInputService.InputEnded:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
    UserInputService.InputChanged:Connect(function(inp) 
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local percent = math.clamp((inp.Position.X - sBg.AbsolutePosition.X)/sBg.AbsoluteSize.X, 0, 1)
            sKnob.Position = UDim2.new(percent, 0, 0.5, 0)
            
            local value = min + math.floor(percent * (max - min))
            Settings.BringDistance = value
            sLabel.Text = "Radius: " .. value .. " studs"
        end 
    end)

    CreateButton(Settings.LoopBringModels and "Bring: ON" or "Bring: OFF", 3.1, Settings.LoopBringModels and Color3.fromRGB(0, 180, 110), Settings.LoopBringModels and 0, function(btn)
        Settings.LoopBringModels = not Settings.LoopBringModels
        if Settings.LoopBringModels then Settings.LoopBringPlayers = false end
        LoadFarmTab()
    end)

    CreateButton(Settings.LoopBringPlayers and "Type: PLAYER" or "Bring: NPC", 4.1, Settings.LoopBringPlayers and Color3.fromRGB(0, 180, 110), Settings.LoopBringPlayers and 0, function(btn)
        Settings.LoopBringPlayers = not Settings.LoopBringPlayers
        if Settings.LoopBringPlayers then Settings.LoopBringModels = false end
        LoadFarmTab()
    end)
    
    local NoteLabel = Instance.new("TextLabel", ContentContainer)
    NoteLabel.Position = UDim2.new(0.05, 0, 0, 195)
    NoteLabel.Size = UDim2.new(0.9, 0, 0, 59)
    NoteLabel.BackgroundTransparency = 1
    NoteLabel.Font = Enum.Font.GothamBold
    NoteLabel.Text = "NOTE: GUNS SUCH AS ROCKET LAUNCHER WILL NOT WORK"
    NoteLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    NoteLabel.TextSize = 15
    NoteLabel.TextWrapped = true
end

local function LoadAimbotTab()
    ClearContent()
    
    local aimBtn = CreateButton(Settings.AimbotEnabled and "Aimbot: ON" or "Aimbot: OFF", 1, Settings.AimbotEnabled and Color3.fromRGB(0, 200, 100), Settings.AimbotEnabled and 0, function(btn)
        Settings.AimbotEnabled = not Settings.AimbotEnabled
        if Settings.AimbotEnabled then
            btn.Text = "Aimbot: ON"
            btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            btn.BackgroundTransparency = 0
        else
            btn.Text = "Aimbot: OFF"
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            btn.BackgroundTransparency = 0.2
        end
    end)

    CreateButton("Target: " .. string.upper(Settings.AimbotTargetType), 2, nil, nil, function(btn)
        if Settings.AimbotTargetType == "Players" then
            Settings.AimbotTargetType = "NPCs"
        else
            Settings.AimbotTargetType = "Players"
        end
        btn.Text = "Target: " .. string.upper(Settings.AimbotTargetType)
    end)
end

TabFarmBtn.MouseButton1Click:Connect(function()
    Settings.CurrentTab = "Farm"
    TabFarmBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); TabFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabAimbotBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); TabAimbotBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    LoadFarmTab()
end)

TabAimbotBtn.MouseButton1Click:Connect(function()
    Settings.CurrentTab = "Aimbot"
    TabAimbotBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); TabAimbotBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabFarmBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); TabFarmBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    LoadAimbotTab()
end)

LoadFarmTab()

CloseBtn.MouseButton1Click:Connect(function()
    Settings.Noclip = false; Settings.LoopBringModels = false; Settings.LoopBringPlayers = false; Settings.AimbotEnabled = false
    for _, conn in pairs(Connections) do if conn then conn:Disconnect() end end
    ScreenGui:Destroy()
end)

MinBtn.MouseButton1Click:Connect(function()
    Settings.UIMinimized = not Settings.UIMinimized
    if Settings.UIMinimized then
        ContentContainer.Visible = false; TabContainer.Visible = false
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 280, 0, 32)}):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 280, 0, 350)}):Play()
        task.wait(0.2); ContentContainer.Visible = true; TabContainer.Visible = true
    end
end)

Connections.NoclipLoop = RunService.Stepped:Connect(function()
    if Settings.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
        end
    end
end)

Connections.BringLoop = RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local targetCF = CFrame.new(hrp.Position + (hrp.CFrame.LookVector * Settings.BringDistance))

    if Settings.LoopBringModels then
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Model") and obj ~= char and not Players:GetPlayerFromCharacter(obj) and obj.PrimaryPart then
                obj:SetPrimaryPartCFrame(targetCF)
                for _, p in pairs(obj:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
            end
        end
    end
    if Settings.LoopBringPlayers then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.CFrame = targetCF
            end
        end
    end
end)

Connections.AimbotLoop = RunService.RenderStepped:Connect(function()
    if Settings.AimbotEnabled then
        local targetHead = getClosestTarget()
        if targetHead then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetHead.Position)
        end
    end
end)
