--// AIM ASSIST or AIM BOT idk
-- i made this script with chatgpt as GUI bcuz im lazy 



--[[
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

]]


local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera

local Boxes = {}

-- // GUI
local Gui = Instance.new("ScreenGui", CoreGui)

local Frame = Instance.new("Frame", Gui)
Frame.Size = UDim2.new(0, 220, 0, 220)
Frame.Position = UDim2.new(0, 20, 0, 200)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.Active = true
Frame.Draggable = true

local UIList = Instance.new("UIListLayout", Frame)
UIList.Padding = UDim.new(0, 6)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 25)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "ESP Panel"

local ToggleESP = Instance.new("TextButton", Frame)
ToggleESP.Size = UDim2.new(1, -10, 0, 30)
ToggleESP.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ToggleESP.TextColor3 = Color3.new(1, 1, 1)
ToggleESP.Text = "ESP: OFF"

local SelectPlayer = Instance.new("TextButton", Frame)
SelectPlayer.Size = UDim2.new(1, -10, 0, 30)
SelectPlayer.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
SelectPlayer.TextColor3 = Color3.new(1, 1, 1)
SelectPlayer.Text = "Target: ALL"

-- Aim Assist button
local AimEnabled = false
local FOV = 40

local AimBtn = Instance.new("TextButton", Frame)
AimBtn.Size = UDim2.new(1, -10, 0, 30)
AimBtn.BackgroundColor3 = Color3.fromRGB(200, 20, 20)
AimBtn.TextColor3 = Color3.new(1, 1, 1)
AimBtn.Text = "Aim Assist: OFF"

AimBtn.MouseButton1Click:Connect(function()
    AimEnabled = not AimEnabled
    AimBtn.Text = AimEnabled and "Aim Assist: ON" or "Aim Assist: OFF"
    AimBtn.BackgroundColor3 = AimEnabled and Color3.fromRGB(20, 200, 20) or Color3.fromRGB(200, 20, 20)
end)

-- Fake crosshair
local fakeGui = Instance.new("ScreenGui")
fakeGui.Name = "Crosshair"
fakeGui.ResetOnSpawn = false
fakeGui.Parent = CoreGui

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

-- Real crosshair
local realCrosshair = Instance.new("Frame")
realCrosshair.Size = UDim2.new(0.005, 0, 0.012, 0)
realCrosshair.Position = UDim2.new(0.5, 0, 0.5, 0)
realCrosshair.BackgroundTransparency = 1
realCrosshair.BorderSizePixel = 0
realCrosshair.Parent = CoreGui

-- // DROPDOWN
local Dropdown = Instance.new("Frame")
Dropdown.Size = UDim2.new(0, 200, 0, 220)
Dropdown.Position = UDim2.new(0, 245, 0, 200)
Dropdown.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Dropdown.Visible = false
Dropdown.Parent = Gui

local DropList = Instance.new("ScrollingFrame")
DropList.Size = UDim2.new(1, 0, 1, 0)
DropList.CanvasSize = UDim2.new(0, 0, 0, 0)
DropList.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
DropList.ScrollBarThickness = 6
DropList.Parent = Dropdown

SelectPlayer.MouseButton1Click:Connect(function()
    Dropdown.Visible = not Dropdown.Visible
end)

-- // ESP FUNCTIONS
local ESP_ON = false
local CurrentTarget = "ALL"

local function ClearESP(plr)
    if plr.Character then
        if plr.Character:FindFirstChild("ESP_Highlight") then
            plr.Character.ESP_Highlight:Destroy()
        end
        if plr.Character:FindFirstChild("ESP_Billboard") then
            plr.Character.ESP_Billboard:Destroy()
        end
    end

    if Boxes[plr] then
        Boxes[plr]:Remove()
        Boxes[plr] = nil
    end
end

local function AddESP(plr)
    ClearESP(plr)
    if not plr.Character then return end
    if not plr.Character:FindFirstChild("HumanoidRootPart") then return end

    -- Highlight
    local h = Instance.new("Highlight")
    h.Name = "ESP_Highlight"
    h.Adornee = plr.Character
    h.FillColor = Color3.fromRGB(255, 50, 50)
    h.FillTransparency = 0.6
    h.OutlineColor = Color3.fromRGB(255, 0, 0)
    h.Parent = plr.Character

    -- BillboardGui
    local head = plr.Character:FindFirstChild("Head")
    if head then
        local bill = Instance.new("BillboardGui")
        bill.Name = "ESP_Billboard"
        bill.Size = UDim2.new(0, 120, 0, 22)
        bill.Adornee = head
        bill.AlwaysOnTop = true
        bill.StudsOffset = Vector3.new(0, 3, 0)
        bill.Parent = plr.Character

        local txt = Instance.new("TextLabel", bill)
        txt.Size = UDim2.new(1, 0, 1, 0)
        txt.BackgroundTransparency = 1
        txt.TextColor3 = Color3.new(1, 1, 1)
        txt.TextStrokeTransparency = 0.2
        txt.TextScaled = true
        txt.Text = plr.Name
    end

    -- Box
    local box = Drawing.new("Square")
    box.Thickness = 2
    box.Color = Color3.fromRGB(255, 0, 0)
    box.Filled = false
    box.Visible = true

    Boxes[plr] = box
end

local function UpdateAllESP()
    for _, plr in ipairs(Players:GetPlayers()) do
        ClearESP(plr)
        if ESP_ON then
            if CurrentTarget == "ALL" and plr ~= LocalPlayer then
                AddESP(plr)
            elseif CurrentTarget == plr.Name then
                AddESP(plr)
            end
        end
    end
end

-- // BUTTON EVENTS
ToggleESP.MouseButton1Click:Connect(function()
    ESP_ON = not ESP_ON
    ToggleESP.Text = ESP_ON and "ESP: ON" or "ESP: OFF"
    UpdateAllESP()
end)

-- // UPDATE PLAYER LIST
local function refreshPlayerList()
    DropList:ClearAllChildren()

    local layout = Instance.new("UIListLayout", DropList)
    layout.Padding = UDim.new(0, 4)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    local function createBtn(name)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 28)
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Text = name
        btn.Parent = DropList

        btn.MouseButton1Click:Connect(function()
            CurrentTarget = name
            SelectPlayer.Text = "Target: " .. name
            Dropdown.Visible = false
            UpdateAllESP()
        end)
    end

    createBtn("ALL")

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            createBtn(plr.Name)
        end
    end

    DropList.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end

task.spawn(function()
    while true do
        refreshPlayerList()
        task.wait(2)
    end
end)

Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(refreshPlayerList)

-- // AIM ASSIST LOGIC
local function visible(part)
    local origin = camera.CFrame.Position
    local direction = part.Position - origin

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = {LocalPlayer.Character}

    local result = workspace:Raycast(origin, direction, params)
    if result then
        return result.Instance:IsDescendantOf(part.Parent)
    end
    return false
end

local function getClosestEnemy()
    local closest = nil
    local closestDist = math.huge

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer
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

RunService.RenderStepped:Connect(function()
    if not AimEnabled then return end

    local target = getClosestEnemy()
    if target and target.Character and target.Character:FindFirstChild("Head") then
        local head = target.Character.Head
        camera.CFrame = CFrame.new(camera.CFrame.Position, head.Position)
        local headPos = camera:WorldToViewportPoint(head.Position)
        realCrosshair.Position = UDim2.new(0, headPos.X, 0, headPos.Y)
    end
end)
