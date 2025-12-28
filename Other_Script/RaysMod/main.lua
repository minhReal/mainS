-- By owner
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("HydroCustomUI") then
    CoreGui.HydroCustomUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "h"
ScreenGui.ResetOnSpawn = false
if pcall(function() ScreenGui.Parent = CoreGui end) then else ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.25
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -90)
MainFrame.Size = UDim2.new(0, 250, 0, 180)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(50, 50, 50)
Stroke.Thickness = 1
Stroke.Transparency = 0.5

local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TopBar.BackgroundTransparency = 0.1
TopBar.Size = UDim2.new(1, 0, 0, 32)

local TopBarCorner = Instance.new("UICorner", TopBar)
TopBarCorner.CornerRadius = UDim.new(0, 10)

local Filler = Instance.new("Frame", TopBar) 
Filler.BackgroundColor3 = TopBar.BackgroundColor3
Filler.BackgroundTransparency = TopBar.BackgroundTransparency
Filler.BorderSizePixel = 0
Filler.Position = UDim2.new(0, 0, 1, -5)
Filler.Size = UDim2.new(1, 0, 0, 5)

local Title = Instance.new("TextLabel", TopBar)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Size = UDim2.new(0, 150, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Ray's Mod - HYDRO"
Title.TextColor3 = Color3.fromRGB(240, 240, 240)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
CloseBtn.Position = UDim2.new(1, -25, 0.5, -6)
CloseBtn.Size = UDim2.new(0, 12, 0, 12)
CloseBtn.Text = ""
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
MinBtn.Position = UDim2.new(1, -45, 0.5, -6)
MinBtn.Size = UDim2.new(0, 12, 0, 12)
MinBtn.Text = ""
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1, 0)

local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 0, 0, 35)
ContentContainer.Size = UDim2.new(1, 0, 1, -35)

local BaseUrl = "https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Other_Script/RaysMod/"

local function CreateButton(text, order, scriptName)
    local btn = Instance.new("TextButton", ContentContainer)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.BackgroundTransparency = 0.2
    btn.Position = UDim2.new(0.05, 0, 0, (order - 1) * 45)
    btn.Size = UDim2.new(0.9, 0, 0, 38)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.TextSize = 14
    
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        loadstring(game:HttpGet(BaseUrl .. scriptName))()
    end)
    
    return btn
end

CreateButton("Page Collector", 1, "Auto_PageCollector.lua")
CreateButton("Rock 'n' Roll", 2, "RocknRoll.lua")
CreateButton("Power Surge", 3, "PowerSurge.lua")

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        ContentContainer.Visible = false
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 250, 0, 32)}):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 250, 0, 180)}):Play()
        task.wait(0.2)
        ContentContainer.Visible = true
    end
end)
