local gui = Instance.new("ScreenGui")
gui.Name = "fuck you"
gui.Parent = game.CoreGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0.2, 0, 0.7, 0)
main.Position = UDim2.new(0.1, 0, 0.17, 0)
main.BackgroundColor3 = Color3.new(0,0,0)
main.BorderColor3 = Color3.new(0, 0, 0)
main.BorderSizePixel = 1
main.Active = true
main.BackgroundTransparency = 0.5
main.Draggable = true
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0.1, 0)
corner.Parent = main

local AD = Instance.new("TextLabel")
AD.Size = UDim2.new(0.8, 0, 0.2, 0)
AD.Position = UDim2.new(0.11, 0, -0.05, 0)
AD.BackgroundColor3 = Color3.new(0, 0, 0)
AD.BorderColor3 = Color3.new(0, 0, 0)
AD.BorderSizePixel = 1
AD.Text = "HYDRO - ADMIN PANEL"
AD.TextSize = 20
AD.BackgroundTransparency = 1
AD.TextColor3 = Color3.new(1, 1, 1)
AD.Font = Enum.Font.Code
AD.Parent = main

-- Button VoteKick
local Votekick = Instance.new("TextButton")
Votekick.Size = UDim2.new(0.8, 0, 0.2, 0)
Votekick.Position = UDim2.new(0.1, 0, 0.1, 0)
Votekick.BackgroundColor3 = Color3.new(0, 0, 0)
Votekick.BorderColor3 = Color3.new(0, 0, 0)
Votekick.Text = "Vote Kick"
Votekick.TextSize = 24
Votekick.TextColor3 = Color3.new(1, 1, 1)
Votekick.Font = Enum.Font.Code
Votekick.Parent = main

-- Button Vote
local Vote = Instance.new("TextButton")
Vote.Size = UDim2.new(0.8, 0, 0.2, 0)
Vote.Position = UDim2.new(0.1, 0, 0.33, 0)
Vote.BackgroundColor3 = Color3.new(0, 0, 0)
Vote.BorderColor3 = Color3.new(0, 0, 0)
Vote.Text = "+2 Voter"
Vote.TextSize = 24
Vote.TextColor3 = Color3.new(1, 1, 1)
Vote.Font = Enum.Font.Code
Vote.Parent = main

-- Button Inf HP
local HP = Instance.new("TextButton")
HP.Size = UDim2.new(0.8, 0, 0.2, 0)
HP.Position = UDim2.new(0.1, 0, 0.56, 0)
HP.BackgroundColor3 = Color3.new(0, 0, 0)
HP.BorderColor3 = Color3.new(0, 0, 0)
HP.Text = " Inf HP (ig)"
HP.TextSize = 24
HP.TextColor3 = Color3.new(1, 1, 1)
HP.Font = Enum.Font.Code
HP.Parent = main

-- Button +100 HP
local G = Instance.new("TextButton")
G.Size = UDim2.new(0.8, 0, 0.18, 0)
G.Position = UDim2.new(0.1, 0, 0.79, 0)
G.BackgroundColor3 = Color3.new(0, 0, 0)
G.BorderColor3 = Color3.new(0, 0, 0)
G.Text = "+100 HP"
G.TextSize = 24
G.TextColor3 = Color3.new(1, 1, 1)
G.Font = Enum.Font.Code
G.Parent = main


--// FUNCTION BINDINGS //--

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

-- Infinite HP
HP.MouseButton1Click:Connect(function()
    local Event = game:GetService("Players").LocalPlayer.Character.FallDamage.RemoteEvent
    Event:FireServer(-math.huge)
    print("Infinite HP activated")
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

-- Toggle (P)
local To = Instance.new("TextButton")
To.Size = UDim2.new(0.05, 0, 0.11, 0)
To.Position = UDim2.new(0.15, 0, 0.5, 0)
To.BackgroundColor3 = Color3.new(0, 0, 0)
To.BorderColor3 = Color3.new(0, 0, 0)
To.BorderSizePixel = 1
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
end)
