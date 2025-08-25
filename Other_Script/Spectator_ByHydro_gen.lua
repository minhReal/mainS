--// Spectator + Teleport Script
local Players = game:GetService("Players")
local a = Players.LocalPlayer

local b = Instance.new("ScreenGui")
b.Name = "PlayerViewer"
b.ResetOnSpawn = false
b.Parent = a:WaitForChild("PlayerGui")

-- Avatar Image
local c = Instance.new("ImageLabel")
c.Size = UDim2.new(0.08, 0, 0.15, 0)
c.Position = UDim2.new(0.31, 0, -0.1, 0)
c.BackgroundTransparency = 1
c.Parent = b

-- Username
local d = Instance.new("TextBox")
d.Size = UDim2.new(0.3, 0, 0.2, 0)
d.Position = UDim2.new(0.4, 0, -0.1, 0)
d.BackgroundTransparency = 1
d.Text = "Display_name (@username)"
d.TextSize = 20
d.TextXAlignment = Enum.TextXAlignment.Left
d.TextColor3 = Color3.new(1, 1, 1)
d.Font = Enum.Font.Code
d.ClearTextOnFocus = false
d.TextWrapped = true
-- outline
d.TextStrokeTransparency = 0
d.TextStrokeColor3 = Color3.new(0,0,0)
d.Parent = b

-- Next
local e = Instance.new("TextButton")
e.Size = UDim2.new(0.05, 0, 0.1, 0)
e.Position = UDim2.new(0.69, 0, -0.047, 0)
e.BackgroundTransparency = 1
e.Text = ">"
e.TextSize = 20
e.TextColor3 = Color3.new(1, 1, 1)
e.Font = Enum.Font.Code
-- outline
e.TextStrokeTransparency = 0
e.TextStrokeColor3 = Color3.new(0,0,0)
e.Parent = b

-- Previous
local f = Instance.new("TextButton")
f.Size = UDim2.new(0.05, 0, 0.1, 0)
f.Position = UDim2.new(0.26, 0, -0.047, 0)
f.BackgroundTransparency = 1
f.Text = "<"
f.TextSize = 20
f.TextColor3 = Color3.new(1, 1, 1)
f.Font = Enum.Font.Code
-- outline
f.TextStrokeTransparency = 0
f.TextStrokeColor3 = Color3.new(0,0,0)
f.Parent = b

-- Toggle
local k = Instance.new("ImageButton")
k.Size = UDim2.new(0.08, 0, 0.12, 0)
k.Position = UDim2.new(0.92, 0, 0.5, 0)
k.BackgroundTransparency = 0.5
k.Image = "http://www.roblox.com/asset/?id=1137376343"
k.Parent = b

-- Teleport button
local Tele = Instance.new("TextButton")
Tele.Size = UDim2.new(0.1, 0, 0.1, 0)
Tele.Position = UDim2.new(0.9, 0, 0.622, 0)
Tele.BorderColor3 = Color3.new(0, 0, 0)
Tele.BorderSizePixel = 1
Tele.Text = "Teleport"
Tele.TextSize = 24
Tele.BackgroundTransparency = 0.5
Tele.TextColor3 = Color3.new(1, 1, 1)
Tele.Font = Enum.Font.Code
-- outline
Tele.TextStrokeTransparency = 0
Tele.TextStrokeColor3 = Color3.new(0,0,0)
Tele.Parent = b

-- Vars
local g = {}
local h = 1
local viewOn = true
local l = { c.Position, d.Position, e.Position, f.Position }

local function setCameraToLocal()
    local char = a.Character or a.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")
    local cam = workspace.CurrentCamera
    cam.CameraType = Enum.CameraType.Custom
    cam.CameraSubject = hum or char
end

-- Update display
local function i()
    if not viewOn then return end
    local target = g[h]
    if not target then return end

    c.Image = "https://www.roblox.com/avatar-thumbnail/image?userId=" .. target.UserId .. "&width=420&height=420&format=png"
    d.Text = target.DisplayName .. " (@" .. target.Name .. ")"

    local cam = workspace.CurrentCamera
    if target == a then
        setCameraToLocal()
        return
    end

    if target.Character then
        local hum = target.Character:FindFirstChildOfClass("Humanoid")
        local hrp = target.Character:FindFirstChild("HumanoidRootPart")
        if hum then cam.CameraSubject = hum end
        if hrp then
            cam.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 2, -5), hrp.Position)
        end
    end
end

-- Refresh list
local function j()
    g = Players:GetPlayers()
    h = math.clamp(h, 1, #g)
end

-- Buttons
e.MouseButton1Click:Connect(function()
    if #g == 0 then return end
    h = (h % #g) + 1
    i()
end)

f.MouseButton1Click:Connect(function()
    if #g == 0 then return end
    h = (h - 2) % #g + 1
    i()
end)

k.MouseButton1Click:Connect(function()
    viewOn = not viewOn
    if not viewOn then
        c.Position = UDim2.new(-1, 0, -1, 0)
        d.Position = UDim2.new(-1, 0, -1, 0)
        e.Position = UDim2.new(-1, 0, -1, 0)
        f.Position = UDim2.new(-1, 0, -1, 0)
        k.Image = "http://www.roblox.com/asset/?id=14996669677"
        setCameraToLocal()
    else
        c.Position, d.Position, e.Position, f.Position = l[1], l[2], l[3], l[4]
        k.Image = "http://www.roblox.com/asset/?id=1137376343"
        i()
    end
end)

-- Teleport action
Tele.MouseButton1Click:Connect(function()
    local target = g[h]
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local myChar = a.Character or a.CharacterAdded:Wait()
        local myHRP = myChar:FindFirstChild("HumanoidRootPart")
        if myHRP then
            myHRP.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        end
    end
end)

-- Auto refresh
Players.PlayerAdded:Connect(j)
Players.PlayerRemoving:Connect(function(rem)
    local was = g[h]
    j()
    if was == rem then
        setCameraToLocal()
    end
end)

-- Init
j()
setCameraToLocal()
