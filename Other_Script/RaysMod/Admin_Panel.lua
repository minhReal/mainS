local gui = Instance.new("ScreenGui")
gui.Name = "fuck you"
gui.Parent = game.CoreGui

-- Header chứa AD
local header = Instance.new("Frame")
header.Size = UDim2.new(0.2, 0, 0.07, 0)
header.Position = UDim2.new(0.15, 0, 0.1, 0)
header.BackgroundColor3 = Color3.new(0,0,0)
header.BackgroundTransparency = 1
header.BorderSizePixel = 0
header.Parent = gui

local AD = Instance.new("TextLabel")
AD.Size = UDim2.new(1, 0, 1, 0)
AD.Position = UDim2.new(0, 0, 0, 0)
AD.BackgroundTransparency = 1
AD.Text = "HYDRO - ADMIN PANEL"
AD.TextSize = 20
AD.TextColor3 = Color3.new(1, 1, 1)
AD.Font = Enum.Font.Code
AD.Parent = header

-- Main ScrollingFrame
local main = Instance.new("ScrollingFrame")
main.Size = UDim2.new(0.2, 0, 0.63, 0)
main.Position = UDim2.new(0.15, 0, 0.17, 0) 
main.BackgroundColor3 = Color3.new(0,0,0)
main.BorderSizePixel = 0
main.Active = true
main.BackgroundTransparency = 0.5
main.Draggable = true
main.Parent = gui
main.CanvasSize = UDim2.new(0, 0, 2, 0) 
main.ScrollBarThickness = 10

local UserInputService = game:GetService("UserInputService")

local dragging = false
local dragStart, startPos

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = header.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if dragging then
            local delta = input.Position - dragStart
            header.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
            -- cho main đi theo header
            main.Position = UDim2.new(
                main.Position.X.Scale,
                main.Position.X.Offset + delta.X,
                main.Position.Y.Scale,
                main.Position.Y.Offset + delta.Y
            )
        end
    end
end)

local Ee = Instance.new("UICorner")
Ee.CornerRadius = UDim.new(0, 10)
Ee.Parent = main

-- Layout cho nút
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 7)
layout.FillDirection = Enum.FillDirection.Vertical
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = main

local TweenService = game:GetService("TweenService")

-- Tạo nhanh function để làm button
local function createButton(text)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.8, 0, 0.08, 0) 
    btn.BackgroundColor3 = Color3.new(0, 0, 0)
    btn.BorderColor3 = Color3.new(0, 0, 0)
    btn.Text = text
    btn.TextSize = 24
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Code
    btn.Parent = main

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn

    -- Tween hover
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        }):Play()
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = Color3.new(0, 0, 0)
        }):Play()
    end)

    return btn
end

-- Các nút (chỉ tạo giao diện)
local Votekick = createButton("Vote Kick")
local Vote = createButton("+2 Voter")
local HP = createButton("Golden Gun")
local G = createButton("+100 HP")
local AK = createButton("Golden AK-47")
local Tele = createButton("Telekinesis")
local MNL = createButton("M.N Launcher")
local Nuke = createButton("Nuke")
local Weather = createButton("Weather (All)")

-- Toggle (P)
local To = Instance.new("TextButton")
To.Size = UDim2.new(0.05, 0, 0.11, 0)
To.Position = UDim2.new(0.05, 0, 0.6, 0)
To.BackgroundColor3 = Color3.new(0, 0, 0)
To.BorderColor3 = Color3.new(0, 0, 0)
To.Text = "P"
To.TextSize = 29
To.BackgroundTransparency = 0 
To.TextColor3 = Color3.new(1, 1, 1)
To.Font = Enum.Font.Code
To.Draggable = true
To.Parent = gui

local isVisible = true
To.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    main.Visible = isVisible
    header.Visible = isVisible
end)


-- SCRIPT CHỨC NĂNG (dán hết ở dưới cùng)

-- VoteKick Script
Votekick.MouseButton1Click:Connect(function()
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local LocalPlayer = Players.LocalPlayer

    local inProgress = false
    if inProgress then return end
    inProgress = true

    local voteKick = ReplicatedStorage:WaitForChild("VoteKickInProgress")
    local playersCount = #Players:GetPlayers()

    if voteKick.Value then
        warn("Voting in progress")
        task.wait(3)
        inProgress = false
        return
    end

    if playersCount < 0 then
        warn("something wrong")
        task.wait(3)
        inProgress = false
        return
    end

    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    local oldList = playerGui:FindFirstChild("VoteKickList")
    if oldList then
        oldList:Destroy()
    end

    local cloneList = voteKick:WaitForChild("VoteKickList"):Clone()
    cloneList.Parent = playerGui

    print("Voting initiated")
    task.wait(3)
    inProgress = false
end)

-- Vote Script
Vote.MouseButton1Click:Connect(function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        ReplicatedStorage:WaitForChild("VoteKickInProgress"):WaitForChild("VoteAdded"):FireServer()
    end
    print("Added votes")
end)

-- +100 HP
G.MouseButton1Click:Connect(function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local moreHealthEvent = ReplicatedStorage:WaitForChild("MoreHealth")

    local inProgress = false
    if inProgress then return end
    inProgress = true

    moreHealthEvent:FireServer()
    print("Requested +100 HP")

    for i = 60, 0, -1 do
        print(i)
        task.wait(1)
    end
    inProgress = false
end)

-- Nuke
Nuke.MouseButton1Click:Connect(function()
    game:GetService("ReplicatedStorage").SpawnObject:FireServer("Nuke")
end)

-- Weather (Tornado, Meteors, Flood)
Weather.MouseButton1Click:Connect(function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    ReplicatedStorage.SpawnObject:FireServer("Tornado")
    ReplicatedStorage.SpawnObject:FireServer("Meteors")
    ReplicatedStorage.SpawnObject:FireServer("Flood")
end)

-- Golden Gun
HP.MouseButton1Click:Connect(function()
    game:GetService("ReplicatedStorage").WeaponEvent:FireServer("Golden Gun")
end)

-- Golden AK-47
AK.MouseButton1Click:Connect(function()
    game:GetService("ReplicatedStorage").WeaponEvent:FireServer("Golden AK-47")
end)

-- Telekinesis
Tele.MouseButton1Click:Connect(function()
    game:GetService("ReplicatedStorage").WeaponEvent:FireServer("Telekinesis")
end)

-- Mini Nuke Launcher
MNL.MouseButton1Click:Connect(function()
    game:GetService("ReplicatedStorage").WeaponEvent:FireServer("Mini Nuke Launcher")
end)
