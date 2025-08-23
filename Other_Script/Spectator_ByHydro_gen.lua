-- a = player
-- b = gui
-- c = avatarImage
-- d = username
-- e = nextButton
-- f = beforeButton
-- g = players
-- h = currentIndex
-- i = updateDisplay
-- j = refreshPlayersList
-- k = toggleButton
-- l = original positions

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
f.Parent = b

-- Toggle
local k = Instance.new("ImageButton")
k.Size = UDim2.new(0.08, 0, 0.12, 0)
k.Position = UDim2.new(0.92, 0, 0.5, 0)
k.BackgroundTransparency = 0.5
k.Image = "http://www.roblox.com/asset/?id=1137376343"
k.Parent = b

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

-- Update display (chỉ đổi camera khi viewOn = true)
local function i()
    if not viewOn then return end
    local target = g[h]
    if not target then return end

    c.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="
        .. target.UserId .. "&width=420&height=420&format=png"
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

-- Refresh list (KHÔNG auto nhảy sang player khác)
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

-- Auto refresh
Players.PlayerAdded:Connect(j)
Players.PlayerRemoving:Connect(function(rem)
    local was = g[h]
    j()
    if was == rem then
        -- Nếu người đang xem rời → trả về local, KHÔNG auto nhảy sang player khác
        setCameraToLocal()
    end
end)

-- Init
j()
setCameraToLocal()
