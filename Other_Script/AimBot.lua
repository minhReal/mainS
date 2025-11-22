--// AIM ASSIST or AIM BOT
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local rs = game:GetService("RunService")

local FOV = 40
local AimEnabled = true

-- // CROSSHAIR
-- Real crosshair
local realCrosshair = Instance.new("Frame")
realCrosshair.Size = UDim2.new(0.005, 0, 0.012, 0)
realCrosshair.Position = UDim2.new(0.5, 0, 0.5, 0)
realCrosshair.BackgroundTransparency = 1
realCrosshair.BorderSizePixel = 0
realCrosshair.Parent = game.CoreGui

-- Fake crosshair
local fakeGui = Instance.new("ScreenGui")
fakeGui.Name = "Crosshair"
fakeGui.ResetOnSpawn = false
fakeGui.Parent = game.CoreGui

local fakeCrosshair = Instance.new("Frame")
fakeCrosshair.Size = UDim2.new(0.005, 0, 0.012, 0)
fakeCrosshair.Position = UDim2.new(0.4972, 0, 0.428, 0)
fakeCrosshair.BackgroundColor3 = Color3.new(1,0,0)
fakeCrosshair.BorderColor3 = Color3.new(0,0,0)
fakeCrosshair.BorderSizePixel = 0
fakeCrosshair.Parent = fakeGui

local uic = Instance.new("UICorner")
uic.CornerRadius = UDim.new(15, 10)
uic.Parent = fakeCrosshair

-- // GUI and BUTTON
local mainGui = Instance.new("ScreenGui")
mainGui.ResetOnSpawn = false
mainGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 150, 0, 60)
mainFrame.Position = UDim2.new(0.72, 0, 0.05, 0) -- đưa lên cao hơn
mainFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = mainGui

-- Aim Assist button
local aimBtn = Instance.new("TextButton")
aimBtn.Size = UDim2.new(0, 130, 0, 40)
aimBtn.Position = UDim2.new(0, 10, 0, 10)
aimBtn.BackgroundColor3 = Color3.fromRGB(20,200,20)
aimBtn.TextColor3 = Color3.new(1,1,1)
aimBtn.Text = "Aim Assist"
aimBtn.BorderSizePixel = 0
aimBtn.Parent = mainFrame

aimBtn.MouseButton1Click:Connect(function()
    AimEnabled = not AimEnabled
    aimBtn.BackgroundColor3 = AimEnabled and Color3.fromRGB(20,200,20) or Color3.fromRGB(200,20,20)
end)

-- // CHECK WALL (NO AIM THROUGH WALLS)
local function visible(part)
    local origin = camera.CFrame.Position
    local direction = part.Position - origin

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = {player.Character}

    local result = workspace:Raycast(origin, direction, params)
    if result then
        return result.Instance:IsDescendantOf(part.Parent)
    end
    return false
end

-- // GET CLOSEST PLAYER (HEAD)
local function getClosestEnemy()
    local closest = nil
    local closestDist = math.huge

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player
        and plr.Character
        and plr.Character:FindFirstChild("Head")
        and plr.Character:FindFirstChild("Humanoid")
        and plr.Character.Humanoid.Health > 0 then
            
            local head = plr.Character.Head
            local pos, onScreen = camera:WorldToViewportPoint(head.Position)

            if onScreen and visible(head) then
                local dist = (Vector2.new(pos.X, pos.Y) - camera.ViewportSize/2).Magnitude
                if dist < closestDist and dist < FOV * 10 then
                    closestDist = dist
                    closest = plr
                end
            end
        end
    end

    return closest
end

-- // AIM LOOP 
rs.RenderStepped:Connect(function()
    if not AimEnabled then return end

    local target = getClosestEnemy()
    if target and target.Character and target.Character:FindFirstChild("Head") then
        local head = target.Character.Head
        camera.CFrame = CFrame.new(camera.CFrame.Position, head.Position)
        local headPos = camera:WorldToViewportPoint(head.Position)
        realCrosshair.Position = UDim2.new(0, headPos.X, 0, headPos.Y)
    end
end)
