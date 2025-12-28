-- By owner --
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local Settings = {
    IsMoving = false,
    CamToggled = false,
    UIMinimized = false
}

if CoreGui:FindFirstChild("l") then
    CoreGui.l:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "l"
ScreenGui.ResetOnSpawn = false
if pcall(function() ScreenGui.Parent = CoreGui end) then else ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.25
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -70)
MainFrame.Size = UDim2.new(0, 260, 0, 140)
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
Title.Text = "Rock 'n' Roll - HYDRO"
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

local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 0, 0, 40)
ContentContainer.Size = UDim2.new(1, 0, 1, -45)

local function CreateButton(text, order, callback)
    local btn = Instance.new("TextButton", ContentContainer)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.BackgroundTransparency = 0.2
    btn.Position = UDim2.new(0.05, 0, 0, (order - 1) * 45)
    btn.Size = UDim2.new(0.9, 0, 0, 38)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function() callback(btn) end)
    return btn
end

local function ClaimOwnership()
    pcall(function()
        sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
        sethiddenproperty(LocalPlayer, "MaxSimulationRadius", math.huge)
    end)
end

local function MoveObjSafe(obj, targetCFrame)
    if not obj then return end
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = targetCFrame
        task.wait(0.1)
        obj.AssemblyLinearVelocity = Vector3.zero
        obj.AssemblyAngularVelocity = Vector3.zero
        obj.CFrame = targetCFrame
    end
end

local function StartBoulderSequence()
    if Settings.IsMoving then return end
    Settings.IsMoving = true
    task.spawn(function()
        local boulder = Workspace:FindFirstChild("boulder")
        if not boulder then Settings.IsMoving = false; return end
        ClaimOwnership()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = boulder.CFrame
        end
        task.wait(0.5); task.wait(2)
        MoveObjSafe(boulder, CFrame.new(25.192, 22.830, -158.592) * CFrame.Angles(math.rad(1), 0, 0))
        task.wait(3)
        MoveObjSafe(boulder, CFrame.new(10, 2187.687, -12158.5) * CFrame.Angles(math.rad(-1), 0, 0))
        task.wait(0.2)
        MoveObjSafe(boulder, CFrame.new(6.621, 2041.5, -12402.7) * CFrame.Angles(math.rad(1), 0, 0))
        Settings.IsMoving = false
    end)
end

local function ToggleCamera()
    Settings.CamToggled = not Settings.CamToggled
    local cam = Workspace.CurrentCamera
    local boulder = Workspace:FindFirstChild("boulder")
    if Settings.CamToggled and boulder then
        cam.CameraSubject = boulder
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            cam.CameraSubject = LocalPlayer.Character.Humanoid
        end
        Settings.CamToggled = false
    end
end

CreateButton("Get badge", 1, function(btn)
    StartBoulderSequence()
end)

CreateButton("Cam to Rock: OFF", 2, function(btn)
    ToggleCamera()
    if Settings.CamToggled then
        btn.Text = "Cam to Rock: ON"
        btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100); btn.BackgroundTransparency = 0; btn.TextColor3 = Color3.new(1,1,1)
    else
        btn.Text = "Cam to Rock: OFF"
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); btn.BackgroundTransparency = 0.2; btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinBtn.MouseButton1Click:Connect(function()
    Settings.UIMinimized = not Settings.UIMinimized
    if Settings.UIMinimized then
        ContentContainer.Visible = false
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 260, 0, 32)}):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 260, 0, 140)}):Play()
        task.wait(0.2); ContentContainer.Visible = true
    end
end)
