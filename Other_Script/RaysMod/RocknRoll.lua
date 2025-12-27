-- By owner --
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local Settings = {
    IsMoving = false,
    CamToggled = false,
    UIMinimized = false
}

if CoreGui:FindFirstChild("HydroGeminiUI") then
    CoreGui.HydroGeminiUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "y"
ScreenGui.ResetOnSpawn = false
if pcall(function() ScreenGui.Parent = CoreGui end) then else ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.25
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -100)
MainFrame.Size = UDim2.new(0, 250, 0, 110) 
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 8)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(60, 60, 60); Stroke.Thickness = 1; Stroke.Transparency = 0.5

local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TopBar.BackgroundTransparency = 0.1
TopBar.Size = UDim2.new(1, 0, 0, 30)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", TopBar)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0, 150, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Rock 'n' Roll - Hydro"
Title.TextColor3 = Color3.fromRGB(240, 240, 240)
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
CloseBtn.Position = UDim2.new(1, -25, 0.5, -6)
CloseBtn.Size = UDim2.new(0, 12, 0, 12); CloseBtn.Text = ""
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.BackgroundColor3 = Color3.fromRGB(0,160,255)
MinBtn.Position = UDim2.new(0.98, -40, 0.5, -6)
MinBtn.Size = UDim2.new(0, 12, 0, 12); MinBtn.Text = ""
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1, 0)

local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 0, 0, 35)
ContentContainer.Size = UDim2.new(1, 0, 1, -35)

local function CreateButton(text, order, callback)
    local btn = Instance.new("TextButton", ContentContainer)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.BackgroundTransparency = 0.1
    btn.Position = UDim2.new(0.05, 0, 0, (order - 1) * 35)
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function() callback(btn) end)
    return btn
end

local function ClaimOwnership(obj)
    local success, err = pcall(function()
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
        obj.AssemblyLinearVelocity = Vector3.new(0,0,0)
        obj.AssemblyAngularVelocity = Vector3.new(0,0,0)
        obj.CFrame = targetCFrame
    end
end

local function StartBoulderSequence()
    if Settings.IsMoving then return end
    Settings.IsMoving = true
    
    task.spawn(function()
        local boulder = Workspace:FindFirstChild("boulder")
        if not boulder then 
            Settings.IsMoving = false
            return 
        end

        ClaimOwnership()
        
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = boulder.CFrame
        end
        task.wait(0.5)

        task.wait(2)
        local target1 = CFrame.new(25.192, 22.830, -158.592) * CFrame.Angles(math.rad(1), 0, 0)
        MoveObjSafe(boulder, target1)

        task.wait(3)
        local target2 = CFrame.new(10, 2187.687, -12158.5) * CFrame.Angles(math.rad(-1), 0, 0)
        MoveObjSafe(boulder, target2)

        task.wait(0.2)
        local target3 = CFrame.new(6.621, 2041.5, -12402.7) * CFrame.Angles(math.rad(1), 0, 0)
        MoveObjSafe(boulder, target3)

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

CreateButton("Get Badge", 1, function(btn)
    StartBoulderSequence()
end)

CreateButton("Cam to the rock: OFF", 2, function(btn)
    ToggleCamera()
    if Settings.CamToggled then
        btn.Text = "Cam to the rock: ON"
    else
        btn.Text = "Cam to the rock: OFF"
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinBtn.MouseButton1Click:Connect(function()
    Settings.UIMinimized = not Settings.UIMinimized
    if Settings.UIMinimized then
        ContentContainer.Visible = false
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 250, 0, 30)}):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 250, 0, 110)}):Play()
        task.wait(0.2); ContentContainer.Visible = true
    end
end)
