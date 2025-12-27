-- By owner --
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

local Settings = {
    ESPEnabled = false,
    UIMinimized = false
}

if CoreGui:FindFirstChild("HydroGeminiUI") then
    CoreGui.HydroGeminiUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "💫"
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
Title.Text = "Page Collector - Hydro"
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

-- // LOGIC FUNCTIONS //

local function TeleportToPages()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local positions = {
            CFrame.new(362, 24, -31), CFrame.new(124, 24, -10), 
            CFrame.new(117, 24, 279), CFrame.new(-161, 24, -272), 
            CFrame.new(82, 24, -443), CFrame.new(273, 24, -375), 
            CFrame.new(-222, 24, 101), CFrame.new(-113, 24, -606), 
        }        
        for i, position in ipairs(positions) do
            if not LocalPlayer.Character then break end
            LocalPlayer.Character.HumanoidRootPart.CFrame = position
            task.wait(0.5)
        end
    end
end

local function ToggleESP(state)
    local PagesFolder = Workspace:FindFirstChild("map") 
        and Workspace.map:FindFirstChild("Model") 
        and Workspace.map.Model:FindFirstChild("Redwoods Forest by lupalb4") 
        and Workspace.map.Model["Redwoods Forest by lupalb4"]:FindFirstChild("EasterEggs") 
        and Workspace.map.Model["Redwoods Forest by lupalb4"].EasterEggs:FindFirstChild("Pages")

    if not PagesFolder then return end

    if state then
        for _, part in pairs(PagesFolder:GetChildren()) do
            if part:IsA("BasePart") and not part:FindFirstChild("GeminiHighlight") then
                local hl = Instance.new("Highlight")
                hl.Name = "GeminiHighlight"
                hl.Adornee = part
                hl.FillTransparency = 1
                hl.OutlineColor = Color3.fromRGB(255, 255, 0)
                hl.OutlineTransparency = 0
                hl.Parent = part
            end
        end
    else
        for _, part in pairs(PagesFolder:GetChildren()) do
            if part:FindFirstChild("GeminiHighlight") then part.GeminiHighlight:Destroy() end
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
        ToggleESP(true)
    else
        btn.Text = "ESP Pages: OFF"
        ToggleESP(false)
    end
end)

-- Topbar
CloseBtn.MouseButton1Click:Connect(function()
    Settings.ESPEnabled = false; ToggleESP(false); ScreenGui:Destroy()
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
