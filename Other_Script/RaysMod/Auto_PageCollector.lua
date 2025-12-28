local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local Settings = {
    ESPEnabled = false,
    UIMinimized = false
}

if CoreGui:FindFirstChild("HydroGeminiRedesignV2") then
    CoreGui.HydroGeminiRedesignV2:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "e"
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
Title.Text = "Page Collector - HYDRO"
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

local function TeleportToPages()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local positions = {
            CFrame.new(362, 24, -31), CFrame.new(124, 24, -10),
            CFrame.new(117, 24, 279), CFrame.new(-161, 24, -272),
            CFrame.new(82, 24, -443), CFrame.new(273, 24, -375),
            CFrame.new(-222, 24, 101), CFrame.new(-113, 24, -606),
        }
        for _, pos in ipairs(positions) do
            if not LocalPlayer.Character then break end
            LocalPlayer.Character.HumanoidRootPart.CFrame = pos
            task.wait(0.5)
        end
    end
end

local function ToggleESP(state)
    local PagesFolder = Workspace:FindFirstChild("map") and Workspace.map:FindFirstChild("Model") and Workspace.map.Model:FindFirstChild("Redwoods Forest by lupalb4") and Workspace.map.Model["Redwoods Forest by lupalb4"]:FindFirstChild("EasterEggs") and Workspace.map.Model["Redwoods Forest by lupalb4"].EasterEggs:FindFirstChild("Pages")
    if not PagesFolder then return end
    
    if state then
        for _, part in pairs(PagesFolder:GetChildren()) do
            if part:IsA("BasePart") and not part:FindFirstChild("HydroHighlight") then
                local hl = Instance.new("Highlight")
                hl.Name = "HydroHighlight"; hl.Adornee = part; hl.FillTransparency = 1
                hl.OutlineColor = Color3.fromRGB(255, 255, 0); hl.OutlineTransparency = 0; hl.Parent = part
                
                local bbg = Instance.new("BillboardGui")
                bbg.Name = "Billboard"
                bbg.Adornee = part
                bbg.Size = UDim2.new(0, 15, 0, 15)
                bbg.StudsOffset = Vector3.new(0, 3, 0)
                bbg.AlwaysOnTop = true
                bbg.Parent = part
                
                local frame = Instance.new("Frame", bbg)
                frame.Size = UDim2.new(1, 0, 1, 0)
                frame.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
                frame.BackgroundTransparency = 0.1
                Instance.new("UICorner", frame).CornerRadius = UDim.new(1, 0)
                
                local stroke = Instance.new("UIStroke", frame)
                stroke.Color = Color3.new(0,0,0)
                stroke.Thickness = 1.5
                stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            end
        end
    else
        for _, part in pairs(PagesFolder:GetChildren()) do
            if part:FindFirstChild("Highlight") then part.HydroHighlight:Destroy() end
            if part:FindFirstChild("Billboard") then part.HydroBillboard:Destroy() end
        end
    end
end

CreateButton("Teleport to Pages", 1, function(btn)
    TeleportToPages()
end)

CreateButton("ESP Pages: OFF", 2, function(btn)
    Settings.ESPEnabled = not Settings.ESPEnabled
    if Settings.ESPEnabled then
        btn.Text = "ESP Pages: ON"
        btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100); btn.BackgroundTransparency = 0; btn.TextColor3 = Color3.new(1,1,1)
        ToggleESP(true)
    else
        btn.Text = "ESP Pages: OFF"
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); btn.BackgroundTransparency = 0.2; btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        ToggleESP(false)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    Settings.ESPEnabled = false; ToggleESP(false); ScreenGui:Destroy()
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
