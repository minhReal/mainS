local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local a = Players.LocalPlayer

local b = Instance.new("ScreenGui")
b.Name = "PVS"
b.ResetOnSpawn = false
b.Parent = a:WaitForChild("PlayerGui")

local c = Instance.new("ImageLabel")
c.Size = UDim2.new(0.08, 0, 0.14, 0)
c.Position = UDim2.new(0.31, 0, -0.07, 0)
c.BackgroundTransparency = 1
c.Parent = b

local d = Instance.new("TextBox")
d.Size = UDim2.new(0.3, 0, 0.2, 0)
d.Position = UDim2.new(0.4, 0, -0.1, 0)
d.BackgroundTransparency = 1
d.TextSize = 20
d.TextXAlignment = Enum.TextXAlignment.Left
d.TextColor3 = Color3.new(1, 1, 1)
d.Font = Enum.Font.Code
d.ClearTextOnFocus = false
d.TextWrapped = true
d.TextStrokeTransparency = 0
d.TextStrokeColor3 = Color3.new(0,0,0)
d.Parent = b

local e = Instance.new("TextButton")
e.Size = UDim2.new(0.05, 0, 0.1, 0)
e.Position = UDim2.new(0.69, 0, -0.047, 0)
e.BackgroundTransparency = 1
e.Text = ">"
e.TextSize = 20
e.TextColor3 = Color3.new(1, 1, 1)
e.Font = Enum.Font.Code
e.TextStrokeTransparency = 0
e.TextStrokeColor3 = Color3.new(0,0,0)
e.Parent = b

local f = Instance.new("TextButton")
f.Size = UDim2.new(0.05, 0, 0.1, 0)
f.Position = UDim2.new(0.26, 0, -0.047, 0)
f.BackgroundTransparency = 1
f.Text = "<"
f.TextSize = 20
f.TextColor3 = Color3.new(1, 1, 1)
f.Font = Enum.Font.Code
f.TextStrokeTransparency = 0
f.TextStrokeColor3 = Color3.new(0,0,0)
f.Parent = b

local k = Instance.new("ImageButton")
k.Size = UDim2.new(0.08, 0, 0.12, 0)
k.Position = UDim2.new(0.92, 0, 0.5, 0)
k.BackgroundTransparency = 0.5
k.Image = "http://www.roblox.com/asset/?id=1137376343"
k.Parent = b

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
Tele.TextStrokeTransparency = 0
Tele.TextStrokeColor3 = Color3.new(0,0,0)
Tele.Parent = b

local g = {}
local h = 1
local viewOn = true
local l = { c.Position, d.Position, e.Position, f.Position }
local cam = workspace.CurrentCamera

local function setCameraToLocal()
    local char = a.Character
    if char then
        cam.CameraSubject = char:FindFirstChildOfClass("Humanoid") or char
        cam.CameraType = Enum.CameraType.Custom
    end
end

local function i()
    if not viewOn then return end
    local target = g[h]
    if not target then return end

    c.Image = "https://www.roblox.com/avatar-thumbnail/image?userId=" .. target.UserId .. "&width=420&height=420&format=png"
    d.Text = target.DisplayName .. " (@" .. target.Name .. ")"

    if target == a then
        setCameraToLocal()
    elseif target.Character then
        local hum = target.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            cam.CameraSubject = hum
        end
    end
end

local function j()
    local currentTarget = g[h]
    g = Players:GetPlayers()
    h = 1
    for index, p in ipairs(g) do
        if p == currentTarget then
            h = index
            break
        end
    end
    i()
end

RunService.RenderStepped:Connect(function()
    if viewOn and g[h] and g[h] ~= a then
        local target = g[h]
        if target.Character and target.Character:FindFirstChildOfClass("Humanoid") then
            if cam.CameraSubject ~= target.Character:FindFirstChildOfClass("Humanoid") then
                cam.CameraSubject = target.Character:FindFirstChildOfClass("Humanoid")
            end
        end
    end
end)

e.MouseButton1Click:Connect(function()
    if #g == 0 then return end
    h = (h % #g) + 1
    i()
end)

f.MouseButton1Click:Connect(function()
    if #g == 0 then return end
    h = (h - 2 + #g) % #g + 1
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

Tele.MouseButton1Click:Connect(function()
    local target = g[h]
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local myChar = a.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            myChar:PivotTo(target.Character:GetPivot() * CFrame.new(0, 3, 0))
        end
    end
end)

Players.PlayerAdded:Connect(j)
Players.PlayerRemoving:Connect(j)

j()
