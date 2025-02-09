--// Services
local UserInputService = game:GetService("UserInputService")

--// Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/lates-lib/main/Main.lua"))()
local Window = Library:CreateWindow({
    Title = "Slendytubbies VS Redux",
    Theme = "Void",
    Size = UDim2.fromOffset(500, 270),
    Transparency = 0.3,
    Blurring = false,
    MinimizeKeybind = Enum.KeyCode.LeftAlt,
})

local Themes = {
    Light = {
        Primary = Color3.fromRGB(232, 232, 232),
        Secondary = Color3.fromRGB(255, 255, 255),
        Component = Color3.fromRGB(245, 245, 245),
        Interactables = Color3.fromRGB(235, 235, 235),
        Tab = Color3.fromRGB(50, 50, 50),
        Title = Color3.fromRGB(0, 0, 0),
        Description = Color3.fromRGB(100, 100, 100),
        Shadow = Color3.fromRGB(255, 255, 255),
        Outline = Color3.fromRGB(210, 210, 210),
        Icon = Color3.fromRGB(100, 100, 100),
    },
    Dark = {
        Primary = Color3.fromRGB(30, 30, 30),
        Secondary = Color3.fromRGB(35, 35, 35),
        Component = Color3.fromRGB(40, 40, 40),
        Interactables = Color3.fromRGB(45, 45, 45),
        Tab = Color3.fromRGB(200, 200, 200),
        Title = Color3.fromRGB(240,240,240),
        Description = Color3.fromRGB(200,200,200),
        Shadow = Color3.fromRGB(0, 0, 0),
        Outline = Color3.fromRGB(40, 40, 40),
        Icon = Color3.fromRGB(220, 220, 220),
    },
    Void = {
        Primary = Color3.fromRGB(15, 15, 15),
        Secondary = Color3.fromRGB(20, 20, 20),
        Component = Color3.fromRGB(25, 25, 25),
        Interactables = Color3.fromRGB(30, 30, 30),
        Tab = Color3.fromRGB(200, 200, 200),
        Title = Color3.fromRGB(240,240,240),
        Description = Color3.fromRGB(200,200,200),
        Shadow = Color3.fromRGB(0, 0, 0),
        Outline = Color3.fromRGB(40, 40, 40),
        Icon = Color3.fromRGB(220, 220, 220),
    },
}

--// Set the default theme
Window:SetTheme(Themes.Void)

--// Sections
Window:AddTabSection({ Name = "STVSRD", Order = 1 })

game:GetService("StarterGui"):SetCore("SendNotification", {
      Title = "Notification",
      Text = "Script has been loaded successfully!",
      Icon = "rbxassetid://14401779839",
      Duration = 10
})

--// Tab [MAIN]
local Main = Window:AddTab({
    Title = "Main",
    Section = "STVSRD",
    Icon = "rbxassetid://11963373994"
})

local Farm = Window:AddTab({
    Title = "Farm",
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

local args = {
    [1] = "Player",
    [2] = "TrainingMaze"
}

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

Window:AddToggle({
    Title = "NightVision",
    Description = "",
    Tab = Misc,
    Callback = function(Boolean)
        local Lighting = game:GetService("Lighting")
        Lighting.NightVision.Enabled = Boolean
    end,
})

Window:AddToggle({
    Title = "More light",
    Description = "",
    Tab = Misc,
    Callback = function(Boolean)
        local Lighting = game:GetService("Lighting")
        Lighting.LightningEffect.Enabled = Boolean
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
local e = game.Players.LocalPlayer

local function updateHighlights()
    local f = workspace.game.gameCustard:GetDescendants()
    
    for _, g in pairs(f) do
        if g:IsA("Part") then
            if b then
                if not g:FindFirstChild("Highlight") then
                    local h = Instance.new("Highlight")
                    h.Name = "Highlight"
                    h.Parent = g
                    h.FillColor = Color3.fromRGB(235, 52, 219)
                    h.OutlineColor = Color3.fromRGB(255, 255, 255)
                    h.FillTransparency = 0.5
                    h.OutlineTransparency = 0.5

                    local k = Instance.new("PointLight")
                    k.Parent = g
                    k.Color = Color3.fromRGB(232, 85, 242)
                    k.Range = 10
                    k.Brightness = 2
                end

                local i = g:FindFirstChild("BillboardGui")
                local j
                if not i then
                    i = Instance.new("BillboardGui")
                    i.Name = "BillboardGui"
                    i.Adornee = g
                    i.Size = UDim2.new(0, 200, 0, 50)
                    i.StudsOffset = Vector3.new(0, 2, 0)
                    i.AlwaysOnTop = true

                    j = Instance.new("TextLabel") -- Billboard TextLabel 
                    j.Size = UDim2.new(1, 0, 1, 0)
                    j.TextColor3 = Color3.new(1, 1, 1)
                    j.BackgroundTransparency = 1
                    j.TextScaled = false
                    j.TextSize = 10
                    j.TextTransparency = 0.5
                    j.TextStrokeTransparency = 0.5
                    j.TextStrokeColor3 = Color3.new(0, 0, 0)
                    i.Parent = g
                    j.Parent = i
                else
                    j = i:FindFirstChild("TextLabel")
                end

                local distance = (e.Character.PrimaryPart.Position - g.Position).magnitude
                j.Text = "Custard | Distance: " .. math.floor(distance) .. "m"
            else
                local h = g:FindFirstChild("Highlight")
                if h then
                    h:Destroy()
                end

                local k = g:FindFirstChild("PointLight")
                if k then
                    k:Destroy()
                end

                local i = g:FindFirstChild("BillboardGui")
                if i then
                    i:Destroy()
                end
            end
        end
    end
end

spawn(function()
    while true do
        wait(0.01)
        if b then
            updateHighlights()
        else
            for _, part in pairs(workspace.game.gameCustard:GetDescendants()) do
                if part:IsA("Part") then
                    local h = part:FindFirstChild("Highlight")
                    if h then
                        h:Destroy()
                    end

                    local k = part:FindFirstChild("PointLight")
                    if k then
                        k:Destroy()
                    end

                    local i = part:FindFirstChild("BillboardGui")
                    if i then
                        i:Destroy()
                    end
                end
            end
        end
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
