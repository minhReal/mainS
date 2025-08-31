
loadstring(game:HttpGet("https://rawscripts.net/raw/Demonology-GHOST-ESP-FINGERPRINT-ESP-CURSED-ITEM-ESP-28153"))()
local gui = Instance.new("ScreenGui")
gui.Name = "DBvKC"
gui.Parent = game.CoreGui

-- Ghost Stats
local H = Instance.new("Frame")
H.Name = "stats"
H.Size = UDim2.new(0.25, 0, 0.8, 0)
H.Position = UDim2.new(0.1, 0, 0.1, 0)
H.BackgroundColor3 = Color3.new(0,0,0)
H.BackgroundTransparency = 0.3
H.BorderSizePixel = 1
H.Active = true
H.Draggable = true
H.Parent = gui
local hj = Instance.new("UICorner")
hj.CornerRadius = UDim.new(0, 15)
hj.Parent = H
local ouj = Instance.new("UIStroke")
ouj.Color = Color3.new(1,1,1)
ouj.Thickness = 1
ouj.Parent = H


-- Misc
-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- Main Frame
local kk = Instance.new("Frame")
kk.Size = UDim2.new(0.2, 0, 0.5, 0)
kk.Position = UDim2.new(0.7, 0, 0.1, 0)
kk.BackgroundColor3 = Color3.new(0,0,0)
kk.BorderColor3 = Color3.new(1,1,1)
kk.BorderSizePixel = 1
kk.Active = true
kk.BackgroundTransparency = 0.3
kk.Draggable = true
kk.Parent = gui

-- Styling
local kj = Instance.new("UICorner")
kj.CornerRadius = UDim.new(0, 15)
kj.Parent = kk
local ou = Instance.new("UIStroke")
ou.Color = Color3.new(1,1,1)
ou.Thickness = 1
ou.Parent = kk

-- Title
local kl = Instance.new("TextLabel")
kl.Size = UDim2.new(1, 0, 0.1, 0)
kl.Position = UDim2.new(0, 0, 0.03, 0)
kl.BackgroundColor3 = Color3.new(0, 0, 0)
kl.BorderSizePixel = 0
kl.Text = "Misc"
kl.TextSize = 20
kl.BackgroundTransparency = 1
kl.TextColor3 = Color3.new(1, 1, 1)
kl.Font = Enum.Font.Code
kl.Parent = kk

-- Buttons
local function createButton(name, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.8, 0, 0.2, 0)
    btn.Position = UDim2.new(0.1, 0, posY, 0)
    btn.BackgroundColor3 = Color3.new(0, 0, 0)
    btn.Text = name
    btn.TextSize = 22
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Code
    btn.Parent = kk
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn
    return btn
end

local button1 = createButton("TP To Ghost", 0.18)
local button2 = createButton("Auto Hide: OFF", 0.41)
local button3 = createButton("TP To Spawn", 0.64)

-- Page Controls
local nextBtn = Instance.new("TextButton")
nextBtn.Size = UDim2.new(0.1, 0, 0.1, 0)
nextBtn.Position = UDim2.new(0.8, 0, 0.88, 0)
nextBtn.BackgroundTransparency = 1
nextBtn.Text = ">"
nextBtn.TextSize = 20
nextBtn.TextColor3 = Color3.new(1,1,1)
nextBtn.Font = Enum.Font.Code
nextBtn.Parent = kk

local prevBtn = Instance.new("TextButton")
prevBtn.Size = UDim2.new(0.1, 0, 0.1, 0)
prevBtn.Position = UDim2.new(0.1, 0, 0.88, 0)
prevBtn.BackgroundTransparency = 1
prevBtn.Text = "<"
prevBtn.TextSize = 20
prevBtn.TextColor3 = Color3.new(1,1,1)
prevBtn.Font = Enum.Font.Code
prevBtn.Parent = kk

local pageLabel = Instance.new("TextLabel")
pageLabel.Size = UDim2.new(0.1,0,0.1,0)
pageLabel.Position = UDim2.new(0.46,0,0.88,0)
pageLabel.BackgroundTransparency = 1
pageLabel.TextColor3 = Color3.new(1,1,1)
pageLabel.Font = Enum.Font.Code
pageLabel.TextSize = 20
pageLabel.Text = "Page 1"
pageLabel.Parent = kk

-- Toggle (P)
local CoreGui = game:GetService("CoreGui")
local DBvKC = CoreGui:WaitForChild("DBvKC")

local ToP = Instance.new("TextButton")
ToP.Size = UDim2.new(0.05, 0, 0.11, 0)
ToP.Position = UDim2.new(0.05, 0, 0.6, 0)
ToP.BackgroundColor3 = Color3.new(0, 0, 0)
ToP.BorderColor3 = Color3.new(0, 0, 0)
ToP.Text = "P"
ToP.TextSize = 29
ToP.BackgroundTransparency = 0
ToP.TextColor3 = Color3.new(1, 1, 1)
ToP.Font = Enum.Font.Code
ToP.Draggable = true
ToP.Parent = DBvKC

local visibleAll = true
ToP.MouseButton1Click:Connect(function()
    visibleAll = not visibleAll
    
    local stats = DBvKC:FindFirstChild("stats")
    if stats then
        for _, obj in ipairs(stats:GetDescendants()) do
            if obj:IsA("GuiObject") then
                obj.Visible = visibleAll
            end
        end
        stats.Visible = visibleAll
    end
end)


-- Notes
local function createFrame(size, pos, bgColor, borderSize)
    local f = Instance.new("Frame")
    f.Size = size
    f.Position = pos
    f.BackgroundColor3 = bgColor or Color3.new(0,0,0)
    f.BorderSizePixel = borderSize or 1
    f.BackgroundTransparency = 0.3
    f.Active = true
    f.Draggable = true
    f.Parent = gui
    f.Visible = false
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 15)
    c.Parent = f
    local s = Instance.new("UIStroke")
    s.Color = Color3.new(1,1,1)
    s.Thickness = 2
    s.Parent = f
    return f
end
local oj = createFrame(UDim2.new(0.65,0,0.7,0), UDim2.new(0.16,0,0.1,0))

local Xc = Instance.new("TextButton")
Xc.Size = UDim2.new(0.05, 0, 0.1, 0)
Xc.Position = UDim2.new(0.94, 0, 0.03, 0)
Xc.BackgroundColor3 = Color3.new(1, 0, 0)
Xc.BorderColor3 = Color3.new(1, 0, 0)
Xc.BorderSizePixel = 1
Xc.Text = "X"
Xc.TextSize = 25
Xc.BackgroundTransparency = 0 
Xc.TextColor3 = Color3.new(255, 255, 255)
Xc.Font = Enum.Font.Code
Xc.Parent = oj
local Xj = Instance.new("UICorner")
Xj.CornerRadius = UDim.new(0, 50)
Xj.Parent = Xc
Xc.MouseButton1Click:Connect(function()
    oj:Destroy()
end)

local NOTE = Instance.new("TextLabel")
NOTE.Size = UDim2.new(1,0,0.2,0)
NOTE.Position = UDim2.new(0,0,0,0)
NOTE.BackgroundTransparency = 1
NOTE.Text = "NOTE"
NOTE.TextSize = 45
NOTE.TextColor3 = Color3.new(1,1,1)
NOTE.Font = Enum.Font.Code
NOTE.Parent = oj
local nt = Instance.new("UIStroke")
nt.Color = Color3.new(1,1,1)
nt.Thickness = 1
nt.Parent = NOTE

local function createTextLabel(parent, size, pos, text, textSize)
    local t = Instance.new("TextLabel")
    t.Size = size
    t.Position = pos
    t.BackgroundTransparency = 1
    t.Text = text
    t.TextSize = textSize or 20
    t.TextColor3 = Color3.new(1,1,1)
    t.Font = Enum.Font.Code
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.TextWrapped = true
    t.Parent = parent
    return t
end

local line0 = createTextLabel(oj, UDim2.new(0.9,0,0.05,0), UDim2.new(0.02,0,0.2,0), "• Demon type may or may not be correct", 20)

local line1 = createTextLabel(oj, UDim2.new(0.96,0,0.05,0), UDim2.new(0.02,0,0.26,0), "• Remember Skinwalker can fake \"Ghost Orb\"", 20)

local line2 = createTextLabel(oj, UDim2.new(0.96,0,0.05,0), UDim2.new(0.02,0,0.32,0), "• Please feedback on discord if you find bugs", 20)



-- Title
local stats = Instance.new("TextLabel")
stats.Size = UDim2.new(1, 0, 0.14, 0)
stats.Position = UDim2.new(0, 0, 0, 0)
stats.BackgroundTransparency = 1
stats.Text = "Ghost Stats"
stats.TextSize = 28
stats.TextColor3 = Color3.new(1, 1, 1)
stats.Font = Enum.Font.GothamBold
stats.Parent = H

-- Template label
local Laser_Proj = Instance.new("TextLabel")
Laser_Proj.Size = UDim2.new(1, 0, 0.05, 0)
Laser_Proj.BackgroundTransparency = 1
Laser_Proj.Text = ""
Laser_Proj.TextSize = 20
Laser_Proj.TextColor3 = Color3.new(1, 1, 1)
Laser_Proj.Font = Enum.Font.Code
Laser_Proj.Parent = H

local Wither = Laser_Proj:Clone()
Wither.Position = UDim2.new(0, 0, 0.12, 0)
Wither.Text = "Wither: ..."
Wither.Parent = H

local Ghost_Orbs = Laser_Proj:Clone()
Ghost_Orbs.Position = UDim2.new(0, 0, 0.18, 0)
Ghost_Orbs.Text = "Ghost Orbs: ..."
Ghost_Orbs.Parent = H

local Spirit_Box = Laser_Proj:Clone()
Spirit_Box.Position = UDim2.new(0, 0, 0.24, 0)
Spirit_Box.Text = "Spirit Box: ..."
Spirit_Box.Parent = H

local Handprints = Laser_Proj:Clone()
Handprints.Position = UDim2.new(0, 0, 0.30, 0)
Handprints.Text = "Handprints: ..."
Handprints.Parent = H

local Ghost_Writing = Laser_Proj:Clone()
Ghost_Writing.Position = UDim2.new(0, 0, 0.36, 0)
Ghost_Writing.Text = "Ghost Writing: ..."
Ghost_Writing.Parent = H

local EMF5 = Laser_Proj:Clone()
EMF5.Position = UDim2.new(0, 0, 0.42, 0)
EMF5.Text = "EMF Level 5: ..."
EMF5.Parent = H

local LaserLabel = Laser_Proj:Clone()
LaserLabel.Position = UDim2.new(0, 0, 0.48, 0)
LaserLabel.Text = "Laser Projector: ..."
LaserLabel.Parent = H

local Freezing_Temp = Laser_Proj:Clone()
Freezing_Temp.Position = UDim2.new(0, 0, 0.54, 0)
Freezing_Temp.Text = "Freezing Temp: ..."
Freezing_Temp.Parent = H

local CurrentRoom = Laser_Proj:Clone()
CurrentRoom.Position = UDim2.new(0, 0, 0.60, 0)
CurrentRoom.Text = "Current Room: ..."
CurrentRoom.Parent = H

local CurrentTemp = Laser_Proj:Clone()
CurrentTemp.Position = UDim2.new(0, 0, 0.66, 0)
CurrentTemp.Text = "Current Temp: ..."
CurrentTemp.Parent = H

local FavoriteRoom = Laser_Proj:Clone()
FavoriteRoom.Position = UDim2.new(0, 0, 0.72, 0)
FavoriteRoom.Text = "Favorite Room: ..."
FavoriteRoom.Parent = H

local FavoriteTemp = Laser_Proj:Clone()
FavoriteTemp.Position = UDim2.new(0, 0, 0.78, 0)
FavoriteTemp.Text = "Favorite Temp: ..."
FavoriteTemp.Parent = H

local DemonResult = Laser_Proj:Clone()
DemonResult.Position = UDim2.new(0, 0, 0.84, 0)
DemonResult.Text = "Demon Type: ..."
DemonResult.TextColor3 = Color3.fromRGB(255,255,255)
DemonResult.Parent = H

local ReadMeButton = Instance.new("TextButton")
ReadMeButton.Size = UDim2.new(1, 0, 0.08, 0)
ReadMeButton.Position = UDim2.new(0, 0, 0.90, 0)
ReadMeButton.BackgroundTransparency = 0.5
ReadMeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ReadMeButton.Text = "Click to README!"
ReadMeButton.TextSize = 20
ReadMeButton.TextColor3 = Color3.new(1, 1, 1)
ReadMeButton.BackgroundTransparency = 1
ReadMeButton.TextTransparency = 0.8
ReadMeButton.Font = Enum.Font.Code
ReadMeButton.Parent = H
local ojVisible = false
ReadMeButton.MouseButton1Click:Connect(function()
    ojVisible = not ojVisible
    oj.Visible = ojVisible
end)



------------------------------------------------------
-- Ghost Stats Functions
------------------------------------------------------


local TweenService = game:GetService("TweenService")
local gui = game.CoreGui:FindFirstChild("DBvKC")


local activeNotifications = {}
local notificationHeight = 20
local notificationSpacing = 10
local startY = 0.7

local function updatePositions()
    for i, notif in ipairs(activeNotifications) do
        local newY = startY - (i-1) * (notificationHeight + notificationSpacing) / gui.AbsoluteSize.Y
        TweenService:Create(notif, TweenInfo.new(0.3), {Position = UDim2.new(0,0,newY,0)}):Play()
    end
end

local function customNotify(message)
    local O = Instance.new("TextLabel")
    O.Size = UDim2.new(1, 0, 0, notificationHeight)
    O.Position = UDim2.new(0, 0, startY, 0)
    O.BackgroundTransparency = 1
    O.BorderSizePixel = 0
    O.Text = message
    O.TextSize = 25
    O.TextColor3 = Color3.fromRGB(150,255,150)
    O.TextTransparency = 1
    O.Font = Enum.Font.Code
    O.Parent = gui

    local OS = Instance.new("UIStroke")
    OS.Color = Color3.new(0,0,0)
    OS.Thickness = 1.5
    OS.Transparency = 1
    OS.Parent = O

    table.insert(activeNotifications, O)
    updatePositions()

    TweenService:Create(O, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    TweenService:Create(OS, TweenInfo.new(0.5), {Transparency = 0}):Play()

    task.spawn(function()
        task.wait(10)
        local tweenText = TweenService:Create(O, TweenInfo.new(1), {TextTransparency = 1})
        local tweenOutline = TweenService:Create(OS, TweenInfo.new(1), {Transparency = 1})
        tweenText:Play()
        tweenOutline:Play()
        tweenText.Completed:Wait()

        for i, notif in ipairs(activeNotifications) do
            if notif == O then
                table.remove(activeNotifications, i)
                break
            end
        end
        O:Destroy()
        updatePositions()
    end)
end

local notified = {}
local function notifyOnce(evidence, message)
    if not notified[evidence] then
        notified[evidence] = true
        customNotify(message)
    end
end

-- EMF Level 5
task.spawn(function()
    while task.wait(1) do
        local emf = workspace:FindFirstChild("Items") and workspace.Items:FindFirstChild("6")
        local ind = emf and emf:FindFirstChild("Indicators")
        local five = ind and ind:FindFirstChild("5")

        if five and five:IsA("BasePart") and five.Material == Enum.Material.Neon then  
            if EMF5.Text ~= "EMF Level 5: Yes" then
                EMF5.Text = "EMF Level 5: Yes"
                notifyOnce("EMF5", "EMF Level 5 detected!")
            end
        end
    end
end)

-- Freezing Temperatures
task.spawn(function()
    while task.wait(2) do
        local function extractTemp(text)
            local num = string.match(text, "[-%d]+%.?%d*")
            return tonumber(num)
        end
        local curTemp = extractTemp(CurrentTemp.Text) or 99
        local favTemp = extractTemp(FavoriteTemp.Text) or 99

        if curTemp <= 0 or favTemp <= 0 then
            if Freezing_Temp.Text ~= "Freezing Temp: Yes" then
                Freezing_Temp.Text = "Freezing Temp: Yes"
                notifyOnce("Freezing", "Freezing Temperature detected!")
            end
        end
    end
end)

-- Spirit Box
task.spawn(function()
    local player = game.Players.LocalPlayer
    while task.wait(1) do
        local gui = player:FindFirstChild("PlayerGui")
        local label = gui and gui:FindFirstChild("Subtitles") 
            and gui.Subtitles:FindFirstChild("Holder") 
            and gui.Subtitles.Holder:FindFirstChild("TextLabel")

        if label and label:IsA("TextLabel") and label.Text ~= "" then
            if Spirit_Box.Text ~= "Spirit Box: Yes" then
                Spirit_Box.Text = "Spirit Box: Yes"
                notifyOnce("SpiritBox", "Spirit Box detected!")
            end
        end
    end
end)

-- Ghost Writing
task.spawn(function()
    while task.wait(2) do
        local folder3 = workspace:FindFirstChild("Items") and workspace.Items:FindFirstChild("3")
        local leftPage = folder3 and folder3:FindFirstChild("LeftPage")
        local decal = leftPage and leftPage:FindFirstChildOfClass("Decal")

        if decal and decal.Texture and decal.Texture ~= "" then
            if Ghost_Writing.Text ~= "Ghost Writing: Yes" then
                Ghost_Writing.Text = "Ghost Writing: Yes"
                notifyOnce("GhostWriting", "Ghost Writing detected!")
            end
        end
    end
end)

-- Wither
task.spawn(function()
    while task.wait(2) do
        local folder9 = workspace:FindFirstChild("Items") and workspace.Items:FindFirstChild("9")
        local found = false
        if folder9 then
            for _, obj in ipairs(folder9:GetChildren()) do
                if obj.Name == "New Flower Rig" then
                    local petals = obj:FindFirstChild("Petals")
                    if petals and petals:IsA("BasePart") and petals.Color == Color3.fromRGB(0,0,0) then
                        found = true
                        break
                    end
                end
            end
        end
        if found then
            if Wither.Text ~= "Wither: Yes" then
                Wither.Text = "Wither: Yes"
                notifyOnce("Wither", "Wither evidence detected!")
            end
        end
    end
end)

-- Ghost Orbs
task.spawn(function()
    while task.wait(3) do
        local found = false
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name == "GhostOrb" then
                found = true
                break
            end
        end
        if found then
            if Ghost_Orbs.Text ~= "Ghost Orbs: Yes" then
                Ghost_Orbs.Text = "Ghost Orbs: Yes"
                notifyOnce("GhostOrbs", "Ghost Orbs detected!")
            end
        else
            Ghost_Orbs.Text = "Ghost Orbs: No"
        end
    end
end)

-- Handprints
task.spawn(function()
    while task.wait(2) do
        local found = false
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (
                obj.Name == "Handprint1" or obj.Name == "Handprint2"
                or obj.Name == "Fingerprint" or obj.Name == "Fingerprint2"
            ) then
                found = true
                break
            end
        end
        if found then
            if Handprints.Text ~= "Handprints: Yes" then
                Handprints.Text = "Handprints: Yes"
                notifyOnce("Handprints", "Handprints detected!")
            end
        end
    end
end)

-- Laser Projector
task.spawn(function()
    local function setLaserText(txt)
        LaserLabel.Text = "Laser Projector: " .. txt
        if txt == "Yes" then
            notifyOnce("Laser", "Laser Projector detected!")
        end
    end
    local function hookGhost(ghost)
        setLaserText(ghost and (ghost:GetAttribute("InLaser") ~= nil and "Yes" or "...") or "...")
        if ghost then
            ghost:GetAttributeChangedSignal("InLaser"):Connect(function()
                setLaserText(ghost:GetAttribute("InLaser") ~= nil and "Yes" or "...")
            end)
            ghost.AncestryChanged:Connect(function(_, parent)
                if not parent then setLaserText("...") end
            end)
        end
    end
    hookGhost(workspace:FindFirstChild("Ghost"))
    workspace.ChildAdded:Connect(function(child)
        if child.Name == "Ghost" then
            hookGhost(child)
        end
    end)
end)

-- Room Tracking + Temps
task.spawn(function()
    local ghostModel = workspace:WaitForChild("Ghost", 10)
    if not ghostModel then return end
    local ghostPart = ghostModel:FindFirstChildWhichIsA("BasePart")
    local roomsFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Rooms")
    if not ghostPart or not roomsFolder then return end

    local stableRoom, roomStreak = nil, 0

    local function isPointInRegion(part, pos)
        local rel = part.CFrame:pointToObjectSpace(pos)
        return math.abs(rel.X) <= part.Size.X / 2 
            and math.abs(rel.Y) <= part.Size.Y / 2 
            and math.abs(rel.Z) <= part.Size.Z / 2
    end

    local function getRoomName(pos)
        for _, room in ipairs(roomsFolder:GetChildren()) do
            for _, part in ipairs(room:GetDescendants()) do
                if part:IsA("BasePart") and isPointInRegion(part, pos) then
                    return room.Name, room
                end
            end
        end
        return nil
    end

    while task.wait(1.5) do
        local currentRoomName, roomInstance = getRoomName(ghostPart.Position)
        if currentRoomName == stableRoom then
            roomStreak += 1
        else
            stableRoom = currentRoomName
            roomStreak = 1
        end

        if roomStreak >= 2 and currentRoomName then
            CurrentRoom.Text = "Current Room: " .. currentRoomName
            if roomInstance and roomInstance:GetAttribute("Temperature") then
                CurrentTemp.Text = string.format("Current Temp: %.1f°C", roomInstance:GetAttribute("Temperature"))
            end
        end

        local favName = ghostModel:GetAttribute("FavoriteRoom")
        if favName and favName ~= "" then
            FavoriteRoom.Text = "Favorite Room: " .. favName
            local favRoom = roomsFolder:FindFirstChild(favName)
            if favRoom and favRoom:GetAttribute("Temperature") then
                FavoriteTemp.Text = string.format("Favorite Temp: %.1f°C", favRoom:GetAttribute("Temperature"))
            end
        end
    end
end)

-- Misc 
-- Variables
local currentPage = 1
local autoHideEnabled = false
local loopbright = false
local oldCFrame = nil

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Ghost = workspace:WaitForChild("Ghost")
local Spawns = workspace:WaitForChild("Map"):WaitForChild("Spawns")

-- Functions
local function getRandomSpawn()
    local spawnPoints = Spawns:GetChildren()
    if #spawnPoints > 0 then
        local spawnPoint = spawnPoints[math.random(1,#spawnPoints)]
        if spawnPoint:IsA("BasePart") then
            return spawnPoint
        end
    end
    return nil
end

local function updatePage()
    if currentPage == 1 then
        button1.Text = "TP To Ghost"
        button2.Text = "Auto Hide: " .. (autoHideEnabled and "ON" or "OFF")
        button3.Visible = true
        pageLabel.Text = "Page 1"
    elseif currentPage == 2 then
        button1.Text = "Fullbright"
        button2.Text = "ESP"
        button3.Visible = false
        pageLabel.Text = "Page 2"
    end
end

-- Page Buttons
nextBtn.MouseButton1Click:Connect(function()
    if currentPage < 2 then
        currentPage += 1
        updatePage()
    end
end)

prevBtn.MouseButton1Click:Connect(function()
    if currentPage > 1 then
        currentPage -= 1
        updatePage()
    end
end)

-- Button Actions
button1.MouseButton1Click:Connect(function()
    if currentPage == 1 then
        -- TP To Ghost
        if Ghost and Ghost:IsA("Model") then
            local ghostPart = Ghost:FindFirstChildWhichIsA("BasePart")
            if ghostPart and HumanoidRootPart then
                HumanoidRootPart.CFrame = ghostPart.CFrame + Vector3.new(0,3,0)
            end
        end
    elseif currentPage == 2 then
        -- Fullbright
        loopbright = not loopbright
        if loopbright then
            task.spawn(function()
                local lighting = game:GetService("Lighting")
                while loopbright do
                    lighting.Brightness = 2
                    lighting.ClockTime = 12
                    lighting.FogEnd = 1e5
                    lighting.GlobalShadows = false
                    lighting.Ambient = Color3.new(1,1,1)
                    task.wait()
                end
            end)
        end
    end
end)

button2.MouseButton1Click:Connect(function()
    if currentPage == 1 then
        -- Auto Hide Toggle
        autoHideEnabled = not autoHideEnabled
        button2.Text = "Auto Hide: " .. (autoHideEnabled and "ON" or "OFF")
    elseif currentPage == 2 then
        -- ESP
        loadstring(game:HttpGet("https://rawscripts.net/raw/Demonology-GHOST-ESP-FINGERPRINT-ESP-CURSED-ITEM-ESP-28153"))()
    end
end)

button3.MouseButton1Click:Connect(function()
    -- TP To Random Spawn
    local spawnPoint = getRandomSpawn()
    if spawnPoint and HumanoidRootPart then
        HumanoidRootPart.CFrame = spawnPoint.CFrame + Vector3.new(0,3,0)
    end
end)

-- Auto Hide Logic
task.spawn(function()
    while task.wait(0.5) do
        if autoHideEnabled then
            local hunting = Ghost:GetAttribute("Hunting")
            if hunting == true then
                if oldCFrame == nil and HumanoidRootPart then
                    oldCFrame = HumanoidRootPart.CFrame
                    local spawnPoint = getRandomSpawn()
                    if spawnPoint then
                        HumanoidRootPart.CFrame = spawnPoint.CFrame + Vector3.new(0,3,0)
                    end
                end
            elseif hunting == false then
                if oldCFrame ~= nil and HumanoidRootPart then
                    HumanoidRootPart.CFrame = oldCFrame
                    oldCFrame = nil
                end
            end
        end
    end
end)

--- Demon Types
local demons = {  
    Aswang = {"Wither", "EMF Level 5", "Ghost Writing"},  
    Banshee = {"Ghost Orb", "Handprint", "Freezing Temp"},  
    Demon = {"EMF Level 5", "Handprint", "Freezing Temp"},  
    Dullahan = {"Wither", "Laser Projector", "Freezing Temp"},  
    Dybbuk = {"Wither", "Handprint", "Freezing Temp"},  
    Entity = {"Spirit Box", "Handprint", "Laser Projector"},  
    Ghoul = {"Spirit Box", "Freezing Temp", "Ghost Orb"},  
    Keres = {"Wither", "Handprint", "Spirit Box"},  
    Leviathan = {"Ghost Orb", "Handprint", "Ghost Writing"},  
    Nightmare = {"EMF Level 5", "Spirit Box", "Ghost Orb"},  
    Oni = {"Laser Projector", "Spirit Box", "Freezing Temp"},  
    Phantom = {"EMF Level 5", "Handprint", "Ghost Orb"},  
    Revenant = {"Ghost Writing", "EMF Level 5", "Freezing Temp"},  
    Shadow = {"EMF Level 5", "Ghost Writing", "Laser Projector"},  
    Siren = {"Wither", "Spirit Box", "EMF Level 5"},  
    Skinwalker = {"Freezing Temp", "Ghost Writing", "Spirit Box"},  
    Specter = {"EMF Level 5", "Freezing Temp", "Laser Projector"},  
    Spirit = {"Handprint", "Ghost Writing", "Spirit Box"},  
    Umbra = {"Ghost Orb", "Laser Projector", "Handprint"},  
    Vex = {"Wither", "Ghost Orb", "Freezing Temp"},  
    Wendigo = {"Ghost Orb", "Ghost Writing", "Laser Projector"},  
    ["The Wisp"] = {"Ghost Orb", "Laser Projector", "Wither"},  
    Wraith = {"EMF Level 5", "Spirit Box", "Laser Projector"}  
}  

local labelMap = {  
    ["Wither"] = Wither,  
    ["Handprint"] = Handprints,  
    ["Ghost Writing"] = Ghost_Writing,  
    ["Spirit Box"] = Spirit_Box,  
    ["EMF Level 5"] = EMF5,  
    ["Laser Projector"] = LaserLabel,  
    ["Freezing Temp"] = Freezing_Temp,  
    ["Ghost Orb"] = Ghost_Orbs  
}  

local function getEvidenceStatus(name)  
    local lbl = labelMap[name]  
    if not lbl then return false end  
    return lbl.Text:find("Yes") ~= nil  
end  

local displayList = {}
local currentIndex = 1

local function updateDemonType()
    displayList = {}

    local exactMatches = {}
    local partialMatches = {}

    local skinwalkerEvidences = demons["Skinwalker"]
    local skinwalkerMatch = true
    for _, e in ipairs(skinwalkerEvidences) do
        if not getEvidenceStatus(e) then
            skinwalkerMatch = false
            break
        end
    end

    if skinwalkerMatch then
        displayList = {"Skinwalker"}
        DemonResult.TextColor3 = Color3.fromRGB(0,255,0)
        return
    end

    for demon, evidences in pairs(demons) do
        local matchCount = 0
        for _, e in ipairs(evidences) do
            if getEvidenceStatus(e) then
                matchCount = matchCount + 1
            end
        end

        if matchCount == #evidences then
            table.insert(exactMatches, demon)
        elseif matchCount >= 2 then
            table.insert(partialMatches, demon)
        end
    end

    if #exactMatches >= 1 then
        displayList = exactMatches
        DemonResult.TextColor3 = Color3.fromRGB(0,255,0)
    elseif #partialMatches > 0 then
        displayList = partialMatches
        DemonResult.TextColor3 = Color3.fromRGB(255,255,0)
    else
        displayList = {"Unknown"}
        DemonResult.TextColor3 = Color3.fromRGB(255,100,100)
    end
end

task.spawn(function()  
    while task.wait(1) do  
        updateDemonType()  
    end  
end)  

task.spawn(function()
    while task.wait(1) do
        if #displayList > 0 then
            DemonResult.Text = "Demon Type: " .. displayList[currentIndex]
            currentIndex = currentIndex + 1
            if currentIndex > #displayList then
                currentIndex = 1
            end
        end
    end
end)

local StarterGui = game:GetService("StarterGui")  
local ghost = workspace:WaitForChild("Ghost")  
local previousHunting = ghost:GetAttribute("Hunting") or false  

local function sendNotification(title, text, duration)  
    StarterGui:SetCore("SendNotification", {  
        Title = title,  
        Text = text,  
        Duration = duration or 5  
    })  
end  

task.spawn(function()
    while true do  
        local currentHunting = ghost:GetAttribute("Hunting") or false  
        if currentHunting ~= previousHunting then  
            if currentHunting then  
                sendNotification("❗WARNING❗", "GHOST EVENT STARTED", 10)  
            else  
                sendNotification("❗WARNING❗", "GHOST EVENT ENDED", 10)  
            end  
            previousHunting = currentHunting  
        end  
        task.wait(0.5)  
    end
end)
