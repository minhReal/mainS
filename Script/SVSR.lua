--// Script Start #1
loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Script/Script_start.lua"))()

--// Services
local UserInputService = game:GetService("UserInputService")

--// Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/lates-lib/main/Main.lua"))()
local Window = Library:CreateWindow({
    Title = "HYDRA | Slendytubbies VS Redux",
    Theme = "Void",
    Size = UDim2.fromOffset(500, 270),
    Transparency = 0.3,
    Blurring = false,
    MinimizeKeybind = Enum.KeyCode.LeftAlt,
})

local Themes = { 
    Light = { Primary = Color3.fromRGB(232, 232, 232), Secondary = Color3.fromRGB(255, 255, 255), Component = Color3.fromRGB(245, 245, 245), Interactables = Color3.fromRGB(235, 235, 235), Tab = Color3.fromRGB(50, 50, 50), Title = Color3.fromRGB(0, 0, 0), Description = Color3.fromRGB(100, 100, 100), Shadow = Color3.fromRGB(255, 255, 255), Outline = Color3.fromRGB(210, 210, 210), Icon = Color3.fromRGB(100, 100, 100), },
    Dark = { Primary = Color3.fromRGB(30, 30, 30), Secondary = Color3.fromRGB(35, 35, 35), Component = Color3.fromRGB(40, 40, 40), Interactables = Color3.fromRGB(45, 45, 45), Tab = Color3.fromRGB(200, 200, 200), Title = Color3.fromRGB(240,240,240), Description = Color3.fromRGB(200,200,200), Shadow = Color3.fromRGB(0, 0, 0), Outline = Color3.fromRGB(40, 40, 40), Icon = Color3.fromRGB(220, 220, 220), }, 
    Void = { Primary = Color3.fromRGB(15, 15, 15), Secondary = Color3.fromRGB(20, 20, 20), Component = Color3.fromRGB(25, 25, 25), Interactables = Color3.fromRGB(30, 30, 30), Tab = Color3.fromRGB(200, 200, 200), Title = Color3.fromRGB(240,240,240), Description = Color3.fromRGB(200,200,200), Shadow = Color3.fromRGB(0, 0, 0), Outline = Color3.fromRGB(40, 40, 40), Icon = Color3.fromRGB(220, 220, 220), }, 
}

--// Set the default theme
Window:SetTheme(Themes.Void)

--// Script Start #2
game:GetService("StarterGui"):SetCore("SendNotification", {
      Title = "Notification",
      Text = "Script has been loaded successfully!",
      Icon = "rbxassetid://14401779839",
      Duration = 10
})

--// Các phần/Thư mục
Window:AddTabSection({ Name = "HYDRA | SVSR", Order = 1 })

--// Các Tab
local Main = Window:AddTab({
    Title = "Main",
    Section = "STVSRD",
    Icon = "rbxassetid://11963373994"
})

local Farm = Window:AddTab({
    Title = "AutoFarm",
    Section = "STVSRD",
    Icon = "rbxassetid://11963373994"
})

local Misc = Window:AddTab({
    Title = "Misc",
    Section = "STVSRD",
    Icon = "rbxassetid://11963373994"
})

Window:AddSection({ Name = "Notification", Tab = Main }) 

Window:AddButton({
    Title = "Sub To Hydro_gen!!",
    Description = "Subscribe for more",
    Tab = Main,
    Callback = function() 
        setclipboard("https://youtube.com/@hydro_genn?si=mnpY7VvpSeO_8_KM")
    end,
})

Window:AddParagraph({
	Title = "Update date: Sunday February 9",
	Description = "-a stressful time-",
	Tab = Main
})

-- Tab [FARM]
local args = { [1] = "Player", [2] = "TrainingMaze" }
local a = false
local b = false
Window:AddToggle({
    Title = "Autofarm",
    Description = "[Beta]",
    Tab = Farm,
    Callback = function(c)
        a = c
    end,
})

Window:AddToggle({
    Title = "ESP Custards",
    Description = "",
    Tab = Farm,
    Callback = function(c)
        b = c
        updateHighlights()
    end,
})

--// Tab [MISC]
local player = game.Players.LocalPlayer
local model = player.Character or player.CharacterAdded:Wait()
Window:AddSlider({
    Title = "Flashlight",
    Description = "adjust flashlight brightness",
    Tab = Misc,
    MaxValue = 1000,
    Callback = function(Amount)
        if model and model:FindFirstChild("lightScript") then
            local lightScript = model.lightScript
            if lightScript:FindFirstChild("lAngle") then
                lightScript.lAngle.Value = Amount
            end
        end
    end,
})

local playerModel = game.Players.LocalPlayer.Character
local lightScript = playerModel:FindFirstChild("lightScript")

Window:AddSlider({
    Title = "Flashlight range ",
    Description = "Adjust the range that the flashlight can illuminate",
    Tab = Misc,
    MaxValue = 1000,
    Callback = function(Amount) 
        if lightScript then
            lightScript.lRange.Value = Amount
        end
    end,
})

local AntiModsEnabled = false
Window:AddToggle({
    Title = "Antimod / Admin",
    Description = "Anti high ranked players in the group. [BETA]",
    Tab = Misc,
    Callback = function(Value)
        AntiModsEnabled = Value
        if AntiModsEnabled then
            while AntiModsEnabled do
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player:GetRankInGroup(4630728) > 0 then
                        game.Players.LocalPlayer:Kick("High Rank Player Detected. [ " .. player.Name .. " ]")
                        break
                    end
                end
                task.wait(0.5)
            end
        end
    end,
})

game.Players.PlayerRemoving:Connect(function(player)
if player == game.Players.LocalPlayer then
AntiModsEnabled = false
end
end)

Window:AddToggle({
    Title = "NightVision",
    Description = "",
    Tab = Misc,
    Callback = function(Boolean)
        game:GetService("Lighting").NightVision.Enabled = Boolean
    end,
})

Window:AddToggle({
    Title = "More light",
    Description = "",
    Tab = Misc,
    Callback = function(Boolean)
        game:GetService("Lighting").LightningEffect.Enabled = Boolean
    end,
})



--// Tab [SETTINGS]
local Settings = Window:AddTab({
    Title = "Settings",
    Section = "STVSRD",
    Icon = "rbxassetid://11293977610",
})

Window:AddDropdown({
    Title = "Set Theme",
    Description = "Set the theme of the library!",
    Tab = Settings,
    Options = {
        ["Light Mode"] = "Light",
        ["Dark Mode"] = "Dark",
        ["Extra Dark"] = "Void",
    },
    Callback = function(Theme) 
        Window:SetTheme(Themes[Theme])
    end,
}) 

Window:AddSlider({
    Title = "UI Transparency",
    Description = "Set the transparency of the UI",
    Tab = Settings,
    AllowDecimals = true,
    MaxValue = 1,
    Callback = function(d) 
        Window:SetSetting("Transparency", d)
    end,
})

--// Highlight
local Player = game.Players.LocalPlayer
local b = false -- biến toggle ESP

-- Đảm bảo các folder tồn tại trước khi dùng
local gameFolder = workspace:WaitForChild("game")
local custardFolder = gameFolder:WaitForChild("gameCustard")

local function updateHighlights()
    local addedParts = {}

    for _, part in pairs(custardFolder:GetDescendants()) do
        if part:IsA("Part") then
            table.insert(addedParts, part)

            if b then
                -- Highlight
                if not part:FindFirstChild("Highlight") then
                    local h = Instance.new("Highlight")
                    h.Name = "Highlight"
                    h.Parent = part
                    h.FillColor = Color3.fromRGB(235, 52, 219)
                    h.OutlineColor = Color3.fromRGB(255, 255, 255)
                    h.FillTransparency = 0.5
                    h.OutlineTransparency = 0.5
                end

                -- BillboardGui
                local gui = part:FindFirstChild("BillboardGui")
                local label
                if not gui then
                    gui = Instance.new("BillboardGui")
                    gui.Name = "BillboardGui"
                    gui.Adornee = part
                    gui.Size = UDim2.new(0, 200, 0, 50)
                    gui.StudsOffset = Vector3.new(0, 2, 0)
                    gui.AlwaysOnTop = true

                    label = Instance.new("TextLabel")
                    label.Size = UDim2.new(1,0,1,0)
                    label.BackgroundTransparency = 1
                    label.TextColor3 = Color3.new(1,1,1)
                    label.TextSize = 10
                    label.TextTransparency = 0.5
                    label.TextStrokeTransparency = 0.5
                    label.TextStrokeColor3 = Color3.new(0,0,0)
                    label.Parent = gui

                    gui.Parent = part
                else
                    label = gui:FindFirstChild("TextLabel")
                end

                -- Khoảng cách
                if Player.Character and Player.Character.PrimaryPart then
                    local distance = (Player.Character.PrimaryPart.Position - part.Position).Magnitude
                    label.Text = "Custard | Distance: " .. math.floor(distance) .. "m"
                else
                    label.Text = "Custard | Distance: N/A"
                end

                -- PointLight
                if not part:FindFirstChild("PointLight") then
                    local light = Instance.new("PointLight")
                    light.Color = Color3.fromRGB(232,85,242)
                    light.Range = 10
                    light.Brightness = 2
                    light.Parent = part
                end
            else
                -- Xóa highlight khi tắt ESP
                local h = part:FindFirstChild("Highlight")
                if h then h:Destroy() end

                local light = part:FindFirstChild("PointLight")
                if light then light:Destroy() end

                local gui = part:FindFirstChild("BillboardGui")
                if gui then gui:Destroy() end
            end
        end
    end

    return addedParts
end

-- Loop ESP tối ưu
spawn(function()
    while true do
        task.wait(0.1) -- giảm lag
        updateHighlights()
    end
end)



--// Autofarm
local function teleportParts()
    local k = e.Character or e.CharacterAdded:Wait()
    local l = game.Workspace:WaitForChild("game"):WaitForChild("gameCustard"):GetChildren()

    for _, m in ipairs(l) do
        if e.PlayerGui:FindFirstChild("Title") and e.PlayerGui.Title:FindFirstChild("mainframe") and e.PlayerGui.Title.mainframe.Visible then
            return true
        end

        if m:IsA("Part") then
            m.Position = k.PrimaryPart.Position + Vector3.new(0, 0, 0)
            wait(0.75) -- time to get the custard, you can adjust it🔍
        end
    end

    return false
end

spawn(function()
    while true do
        wait(1)

        if a then
            game:GetService("ReplicatedStorage").sendCharacterSpawnRequest:FireServer(unpack(args))
            wait(1.5)

            local n = e.PlayerGui
            if n:FindFirstChild("PlayerDefaultGui") and n.PlayerDefaultGui:FindFirstChild("Mobile") then
                teleportParts()
            end

            e.CharacterAdded:Wait()
        end
        
        wait(1)
    end
end)
