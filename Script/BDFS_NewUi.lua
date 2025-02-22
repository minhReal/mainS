--// Script Start #1
loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Other_Script/Script_start.lua"))()

--// Toggle 
local gui = Instance.new("ScreenGui")
gui.Name = "12345678910111213141516171819202122"
gui.Parent = game.CoreGui

local Line = Instance.new("ImageButton")
Line.Size = UDim2.new(0.075, 0, 0.2, 0)
Line.Position = UDim2.new(0.05, 0, 0.5, 0)
Line.BackgroundColor3 = Color3.new(0, 0, 0)
Line.BorderColor3 = Color3.new(1, 1, 1)
Line.BorderSizePixel = 1
Line.Image = "rbxassetid://14029997290"
Line.Transparency = 1
Line.Draggable = true
Line.Parent = gui

local uicornerGuiS = Instance.new("UICorner")
uicornerGuiS.CornerRadius = UDim.new(0.5, 0)
uicornerGuiS.Parent = Line

local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent then
        if input.KeyCode == Enum.KeyCode.LeftAlt then
        end
    end
end)



--// Services
local UserInputService = game:GetService("UserInputService");

--// Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/lates-lib/main/Main.lua"))()
local Window = Library:CreateWindow({
    Title = "HYDRA | Be Dead Forever Simulator",
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
        
local player = game.Players.LocalPlayer
local VirtualInputManager = game:GetService("VirtualInputManager")

Line.MouseButton1Click:Connect(function()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftAlt, false, player.Character and player.Character:FindFirstChild("Humanoid"))
end)

local S = game.Workspace.Spawns:FindFirstChild("Spawn15")
if S then
    S:Destroy()
end

local targetCFrame = CFrame.new(216.000015, 72.5999985, 830.499939, 1, 0, 0, 0, 1, 0, 0, 0, 1)
local targetSize = Vector3.new(14.40000057220459, 10.199999809265137, 12.40000057220459)

local foundPart = nil

for _, part in pairs(workspace:GetChildren()) do
    if part:IsA("Part") and part.CFrame == targetCFrame and part.Size == targetSize then
        foundPart = part
        break
    end
end

if foundPart then
    foundPart.CanCollide = false
end

local player = game.Players.LocalPlayer
local moneyHitbox = workspace.Buildings.DeadBurger.DumpsterMoneyMaker.MoneyHitbox

local currentAnimation
local isAnimating = false

local function playAnimation(animationId)
    local character = player.Character or player.CharacterAdded:Wait()
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            local animation = Instance.new("Animation")
            animation.AnimationId = animationId
            if currentAnimation then
                currentAnimation:Stop()
            end
            currentAnimation = humanoid:LoadAnimation(animation)
            currentAnimation:Play()
            isAnimating = true
        end
    end
end


--// Các phần/Thư mục
Window:AddTabSection({ Name = "HYDRA | BDFS", Order = 1 })

--// Các Tab
local Main = Window:AddTab({
    Title = "Main",
    Section = "BDFS",
    Icon = "rbxassetid://11963373994"
})

local toolTab = Window:AddTab({
    Title = "Tools",
    Section = "BDFS",
    Icon = "rbxassetid://11963373994"
})

local miscTab = Window:AddTab({
    Title = "Misc",
    Section = "BDFS",
    Icon = "rbxassetid://11963373994"
})

local farmTab = Window:AddTab({
    Title = "Autofarm",
    Section = "BDFS",
    Icon = "rbxassetid://11963373994"
})

local teleportTab = Window:AddTab({
    Title = "Teleport",
    Section = "BDFS",
    Icon = "rbxassetid://11963373994"
})

local Settings = Window:AddTab({
	Title = "Settings",
	Section = "BDFS",
	Icon = "rbxassetid://11293977610",
})

--// settings [TAB]
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
	Callback = function(Amount) 
		Window:SetSetting("Transparency", Amount)
	end,
}) 

Window:AddButton({
    Title = "Rejoin",
    Description = "",
    Tab = Settings,
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
    TeleportService:Teleport(game.PlaceId, player)
    end,
})

--// Main [TAB]
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
	Title = "Update date: Friday, January 31, 2025",
	Description = "-a stressful time-",
	Tab = Main
}) 

Window:AddSection({ Name = "Player", Tab = Main }) 

Window:AddButton({
	Title = "Player status (JOY)",
	Description = "shows player status (JOY) and whether autofarm should be used ",
	Tab = Main,
	Callback = function() 
		local player = game.Players.LocalPlayer
local joyValue = player.Character and player.Character.Values and player.Character.Values.Joy and player.Character.Values.Joy.Value or 0

local formattedJoyValue = string.format("%.2f", joyValue)
local statusMessage = joyValue < 50 and " | Not good" or " | Good"

Window:Notify({
    Title = "Notification",
    Description = "Current Joy Value: " .. formattedJoyValue .. statusMessage, 
    Duration = 10
})


	end,
}) 
Window:AddButton({
    Title = "Reset",
    Description = "isekai-",
    Tab = Main,
    Callback = function()
        player.Character.Humanoid.Health = 0
    end,
})

Window:AddSlider({
    Title = "WalkSpeed",
    Description = "Normal speed is 16",
    Tab = Main,
    MaxValue = 1000,
    DefaultValue = 16,
    Callback = function(Amount) 
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Amount
    end,
})

Window:AddSlider({
    Title = "JumpPower",
    Description = "Normal jump power is 50",
    Tab = Main,
    MaxValue = 1000,
    DefaultValue = 50,
    Callback = function(Amount) 
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Amount
    end,
})


Window:AddSlider({
    Title = "Gravity",
    Description = "Normal gravity is 196.2",
    Tab = Main,
    MaxValue = 1000,
    DefaultValue = 196.2,
    Callback = function(Amount) 
        workspace.Gravity = Amount
    end,
})

--// Tools [TAB]
Window:AddSection({ Name = "Tools", Tab = toolTab }) 

Window:AddButton({
    Title = "Get Medik",
    Description = "2 lives",
    Tab = toolTab,
    Callback = function()
        fireclickdetector(workspace["Meshes/Medkit"].ClickDetector)
    end,
})

Window:AddButton({
    Title = "Get a dead burger",
    Description = "Buy a dead burger for $30",
    Tab = toolTab,
    Callback = function()
        local burgerDetector = workspace.Buildings:FindFirstChild("DeadBurger") and workspace.Buildings.DeadBurger.burgre:FindFirstChild("ClickDetector")
        if burgerDetector then
            fireclickdetector(burgerDetector)
        end
    end,
})

Window:AddButton({
    Title = "Get Key card",
    Description = "Key card.",
    Tab = toolTab,
    Callback = function()
        fireclickdetector(workspace.Buildings.DeadBurger.Level1Keycard.ClickDetector)
    end,
})

Window:AddButton({
    Title = "Get New paper",
    Description = "What's new",
    Tab = toolTab,
    Callback = function()
        local targetCFrame = CFrame.new(-16.954525, 17.9250011, 160.480621, 0.953241706, -0.3022089, 6.66081905e-06, -6.66081905e-06, -4.30345535e-05, -1, 0.3022089, 0.953241706, -4.30345535e-05)
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Part") and item.Name == "Handle" and item.CFrame == targetCFrame then
                local clickDetector = item:FindFirstChildOfClass("ClickDetector")
                if clickDetector then
                    fireclickdetector(clickDetector)
                end
                return
            end
        end
    end,
})

Window:AddButton({
    Title = "Get PlayerDestroy9000",
    Description = "Destroy",
    Tab = toolTab,
    Callback = function()
        local handleDetector = workspace:FindFirstChild("Handle") and workspace.Handle:FindFirstChild("ClickDetector")
        if handleDetector then
            fireclickdetector(handleDetector)
        end
    end,
})

Window:AddButton({
    Title = "Get Knife",
    Description = "Knife.",
    Tab = toolTab,
    Callback = function()
        local knifeClickDetector = workspace:FindFirstChild("Knife") and workspace.Knife:FindFirstChild("ClickDetector")
        if knifeClickDetector then
            fireclickdetector(knifeClickDetector)
        end
    end,
})

Window:AddButton({
    Title = "Get AWP",
    Description = "Sniper ",
    Tab = toolTab,
    Callback = function()
        local targetCFrame = CFrame.new(127.603859, 99.1851883, -63.2750053, 0.921245217, 4.82797623e-06, 0.388982356, 0.388982356, -2.38418579e-05, -0.921245158, 4.82797623e-06, 0.99999994, -2.38418579e-05)
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("MeshPart") and item.Name == "Handle" and item.CFrame == targetCFrame then
                local clickDetector = item:FindFirstChildOfClass("ClickDetector")
                if clickDetector then
                    fireclickdetector(clickDetector)
                end
                return
            end
        end
    end,
})

Window:AddButton({
    Title = "Get Shotgun",
    Description = "Buckshot",
    Tab = toolTab,
    Callback = function()
        fireclickdetector(workspace.shotgun.ClickDetector)
    end,
})


--// Misc [TAB]
Window:AddSection({ Name = "Animation", Tab = miscTab }) 

Window:AddButton({
    Title = "Animation(Bat)",
    Description = "",
    Tab = miscTab,
    Callback = function()
        playAnimation("rbxassetid://8830424363")
    end,
})

Window:AddButton({
    Title = "Animation(Reviving)",
    Description = "",
    Tab = miscTab,
    Callback = function()
        playAnimation("rbxassetid://7284407444")
    end,
})


Window:AddSection({ Name = "Utilities", Tab = miscTab }) 


local toggled = false
Window:AddToggle({
    Title = "Esp the dead",
    Description = "Highlights dead bodies but some will be inactive",
    Tab = miscTab,
    Callback = function(Boolean)
        toggled = Boolean
        updateHighlights()
    end,
})

Window:AddToggle({
    Title = "Antimods / Admin",
    Description = "/console to see which mods or admins have been blocked",
    Tab = miscTab,
    Callback = function(Boolean)
        if Boolean then
            _G.toggleState = true
            setToggleState(true)
        else
            setToggleState(false)
            _G.toggleState = false
        end
    end,
})


Window:AddToggle({
    Title = "No Car",
    Description = "[Not working]",
    Tab = miscTab,
    Callback = function(Boolean) 
        if Boolean then
            removalRunning = true
            loadstring(game:HttpGet("https://pastefy.app/kCnixnXg/raw"))()
        else
            removalRunning = false
        end
    end,
})

Window:AddButton({
	Title = "No vent",
	Description = "No die in the vent",
	Tab = miscTab,
	Callback = function()
	local targetCFrame = CFrame.new(29.75, -6.3500042, 215, 1, 0, 0, 0, 1, 0, 0, 0, 1)

for _, part in pairs(workspace:GetDescendants()) do
    if part:IsA("Part") and part.Name == "Button" and part.CFrame == targetCFrame then
        part:Destroy()
        break
    end
end

	end,
}) 

Window:AddButton({
    Title = "Turn into a zombie",
    Description = "🧟",
    Tab = miscTab,
    Callback = function()
        local infectionLiquid = workspace:FindFirstChild("Infection Liquid")
        if infectionLiquid then
            firetouchinterest(player.Character.HumanoidRootPart, infectionLiquid, 0)
        end
    end,
})

Window:AddButton({
    Title = "No blur",
    Description = "",
    Tab = miscTab,
    Callback = function()
        local lighting = game:GetService("Lighting")
        local blurEffect = lighting:FindFirstChild("Blur")

        if blurEffect then
            if blurEffect.Enabled then
                blurEffect.Enabled = false
                Window:Notify({
                    Title = "Notification",
                    Description = "Blur is off",
                    Duration = 10
                })
            else
                Window:Notify({
                    Title = "Notification",
                    Description = "Blur was turned off before",
                    Duration = 10
                })
            end
        end
    end,
})


Window:AddButton({
    Title = "Antiafk",
    Description = "",
    Tab = miscTab,
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-AntiAFK-script-18076"))()
    end,
})

Window:AddToggle({
    Title = "Fullbright",
    Description = "",
    Tab = Main,
    Callback = function(Boolean)
        getgenv().loopbright = Boolean
        local lighting = game:GetService("Lighting")
        
        if Boolean then
            while getgenv().loopbright do
                lighting.Brightness = 2
                lighting.ClockTime = 12
                lighting.FogEnd = 1e5
                lighting.GlobalShadows = false
                lighting.Ambient = Color3.new(1, 1, 1)
                task.wait()
            end
        else
            lighting.Brightness = 1
            lighting.ClockTime = 14
            lighting.FogEnd = 1000
            lighting.GlobalShadows = true
            lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        end
    end,
})

Window:AddButton({
    Title = "Teleport tool",
    Description = "",
    Tab = miscTab,
    Callback = function()
	mouse = game.Players.LocalPlayer:GetMouse()
tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Teleport Tool"
tool.Activated:connect(function()
local pos = mouse.Hit+Vector3.new(0,2.5,0)
pos = CFrame.new(pos.X,pos.Y,pos.Z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end)
tool.Parent = game.Players.LocalPlayer.Backpack

    end,
})

Window:AddButton({
    Title = "Spectator",
    Description = "",
    Tab = miscTab,
    Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Other_Script/Spectator.lua"))()
    end,
})


Window:AddButton({
    Title = "Shiftlock",
    Description = "",
    Tab = miscTab,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Other_Script/Shiftlock.lua"))()
    end,
})

Window:AddButton({
    Title = "Telekinesis",
    Description = "",
    Tab = miscTab,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Other_Script/Telekinesis.lua"))()
    end,
})

Window:AddButton({
    Title = "Be dead forever script [OLD]",
    Description = "this is my old script",
    Tab = miscTab,
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Bdfs.lua"))()
end,
})

--// farm [TAB]
Window:AddSection({ Name = "Dead burger", Tab = farmTab }) 

Window:AddParagraph({
	Title = "IMPORTANT NOTICE",
	Description = "Don't turn it on and off constantly because of bugs",
	Tab = farmTab,
}) 

Window:AddToggle({
    Title = "Autofarm",
    Description = "Auto farm + monitor",
    Tab = farmTab,
    Callback = function(Boolean)
        if Boolean then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/BDFS_script/Autofarm.lua"))()
            toggleAutofarm(true)
        else
            toggleAutofarm(false)
        end
    end,
})

Window:AddToggle({
    Title = "Autofarm (movable)",
    Description = "Auto farm + monitor",
    Tab = farmTab,
    Callback = function(isEnabled)
        if isEnabled then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/BDFS_script/Autofarm_Movable.lua"))()
            toggleAutofarm(true)
        else
            toggleAutofarm(false)
        end
    end,
})

Window:AddToggle({
    Title = "Auto eat",
    Description = "If you have less than 50 hunger, the script will run.",
    Tab = farmTab,
    Callback = function(isEnabled)
        autoEatActive = isEnabled
        if isEnabled then
            while autoEatActive do
                wait(0.5)
                local hungerGui = player.PlayerGui:WaitForChild("Hunger")
                if hungerGui and hungerGui.Hunger.Value < 50 and not autoEating then
                    autoEating = true
                    eat()
                    autoEating = false
                end 
            end
        end
    end,
})

Window:AddSection({ Name = "DVSC", Tab = farmTab }) 

Window:AddButton({
	Title = "clean up a dead body",
	Description = "",
	Tab = farmTab,
	Callback = function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/BDFS_script/clean_up_deadBody.lua'),true))()
	end,
}) 

Window:AddButton({
	Title = "Bring blood",
	Description = "",
	Tab = farmTab,
	Callback = function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/BDFS_script/Bring_blood.lua'),true))()
	end,
}) 

Window:AddButton({
	Title = "Get job",
	Description = "",
	Tab = farmTab,
	Callback = function() 
loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/BDFS_script/Get_job.lua"))()
	end,
}) 

--// teleport [TAB]
Window:AddDropdown({
    Title = "Safe zone",
    Description = "",
    Tab = teleportTab,
    Options = {
        ["SafeBox"] = "S",
        ["SafeSpot"] = "F",
    },
    Callback = function(selectedOption)
        if selectedOption == "S" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["SafeBox"].CFrame * CFrame.new(0, 2.5, 0)
        elseif selectedOption == "F" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Safespot"].CFrame * CFrame.new(0, 10, 0)
        end
    end,
})

Window:AddButton({
    Title = "Tp to DVSC",
    Description = "",
    Tab = teleportTab,
    Callback = function()
    local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
character:SetPrimaryPartCFrame(CFrame.new(233.55099487304688, 70.5, 857.654052734375))
    end,
}) 

Window:AddButton({
    Title = "Tp to Dead buger",
    Description = "",
    Tab = teleportTab,
    Callback = function()
    local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
character:SetPrimaryPartCFrame(CFrame.new(-25.858579635620117, 16.999996185302734, 144.6079864501953))
    end,
})







--// Scripts
--// antimods / admin
local playersToBlock = {
    "mad_hhhh", "Maxim_L1111", "mmmax1", "Electr0nic_Person", "ElectroMotiveDev",
    "TheRealJ4YD3N", "Sk3tchYT", "Jayingee", "KenvinEdwardsJr", "forstaken",
    "princessunicakeyum", "honeyblack265", "Demonic_AngelPB", "Roduxman999",
    "BananaDatBo", "CruntchiiBoi", "meteorcrasher118", "Stronglion12344",
    "Fezezen", "pulsekinesis", "1936indiana"
}

local _toggleActive = false

print("Players to block:")
for _, name in ipairs(playersToBlock) do
    print(" • " .. name)
end

local function checkPlayers()
    local localPlayer = game.Players.LocalPlayer
    if localPlayer then
        for _, player in ipairs(game.Players:GetPlayers()) do
            for _, blockedName in ipairs(playersToBlock) do
                if player.Name == blockedName then

                    localPlayer:Kick("Blocked player detected: " .. player.Name)
                    return
                end
            end
        end
    end
end


spawn(function()
    while true do
        wait(0.01)
        if _toggleActive then
            checkPlayers()
        end
    end
end)

function setToggleState(state)
    _toggleActive = state
end


--// auto eat script
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local PlayerService = game:GetService("Players")
local player = PlayerService.LocalPlayer


local function eat()
    local burgerClickDetector = workspace.Buildings.DeadBurger.burgre.ClickDetector
    if not player.Backpack:FindFirstChild("Burger") then
        fireclickdetector(burgerClickDetector)
        wait(5)
    end

    local _burger = player.Backpack:FindFirstChild("Burger")
    if _burger then
        _burger.Parent = player.Character
        _burger:Activate()
        wait(1.5)
    end
end

local autofarmActive = false
local autoEating = false
local autoEatActive = false

function cleanUpTrashcans()
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name == "Trashcan" and v:IsA("UnionOperation") then
            if #v:GetChildren() ~= 2 then
                v:Destroy()
            else
                if v:FindFirstChild("ClickDetector") then
                    fireclickdetector(v.ClickDetector)
                end
            end
        end
    end
end

local function runComputerAutofarm()
    while autofarmActive do
        wait(0.01)
        fireclickdetector(workspace.Buildings["Green House"].Computer.Monitor.Part.ClickDetector)
    end
end

local function runAutofarm()
    autofarmActive = true

    spawn(function()
        while autofarmActive do
            wait(0.01)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["SafeBox"].CFrame * CFrame.new(0, 2.5, 0)
        end
    end)


    spawn(runComputerAutofarm)

    while autofarmActive do
        wait(0.01)

        local backpack = player:WaitForChild("Backpack")
        local GTool = backpack:FindFirstChild("Garbage Bag")
        if GTool and GTool:IsA("Tool") then
            player.Character.Humanoid:EquipTool(GTool)
            wait(2.5)
        end

        cleanUpTrashcans()

        local hungerGui = player.PlayerGui:WaitForChild("Hunger")
        if hungerGui and hungerGui.Hunger.Value < 50 and not autoEating then
            autoEating = true
            eat()
            autoEating = false
        end
    end
end

--// SafeBox
if workspace:FindFirstChild("SafeBox") == nil then
local S = Instance.new("Part")
S.Name = "SafeBox"
S.Anchored = true
S.CanCollide = true
S.Transparency = 0.5
S.Position = Vector3.new(-682.13562, 106.659348, -23153.1016, 1, 0, 0, 0, 1, 0, 0, 0, 1)
S.Size = Vector3.new(13, 1, 13)
S.Parent = workspace

local S1 = Instance.new("Part")
S1.Name = "S1"
S1.Anchored = true
S1.CanCollide = true
S1.Transparency = 0.5
S1.Position = Vector3.new(-689.13562, 111.626587, -23153.1465, 1, 0, 0, 0, 1, 0, 0, 0, 1)
S1.Size = Vector3.new(1, 11, 15)
S1.Parent = workspace:FindFirstChild("SafeBox")

local S2 = Instance.new("Part")
S2.Name = "Safe2"
S2.Anchored = true
S2.CanCollide = true
S2.Transparency = 0.5
S2.Position = Vector3.new(-682.139771, 111.727631, -23146.1016, 1, 0, 0, 0, 1, 0, 0, 0, 1)
S2.Size = Vector3.new(13, 11, 1)
S2.Parent = workspace:FindFirstChild("SafeBox")

local S3 = Instance.new("Part")
S3.Name = "Safe3"
S3.Anchored = true
S3.CanCollide = true
S3.Transparency = 0.5
S3.Position = Vector3.new(-675.13562, 111.738739, -23153.1191, 1, 0, 0, 0, 1, 0, 0, 0, 1)
S3.Size = Vector3.new(1, 11, 15)
S3.Parent = workspace:FindFirstChild("SafeBox")

local S4 = Instance.new("Part")
S4.Name = "Safe4"
S4.Anchored = true
S4.CanCollide = true
S4.Transparency = 0.5
S4.Position = Vector3.new(-682.210083, 117.659355, -23153.0859, 1, 0, 0, 0, 1, 0, 0, 0, 1)
S4.Size = Vector3.new(15, 1, 15)
S4.Parent = workspace:FindFirstChild("SafeBox")

local S5 = Instance.new("Part")
S5.Name = "Safe5"
S5.Anchored = true
S5.CanCollide = true
S5.Transparency = .5
S5.Position = Vector3.new(-682.139771, 111.727631, -23160.1016, 1, 0, 0, 0, 1, 0, 0, 0, 1)
S5.Size = Vector3.new(13, 11, 1)
S5.Parent = workspace:FindFirstChild("SafeBox")

local light = Instance.new("PointLight")
light.Color = Color3.fromRGB(255, 255, 255)
light.Range = 20
light.Brightness = 2
light.Parent = workspace:FindFirstChild("SafeBox")
end

--// SafeSpot
if workspace:FindFirstChild("Safespot") == nil then
local Safespot = Instance.new("Part",workspace)
Safespot.Name = "Safespot"
Safespot.Position = Vector3.new(10000,-50,10000)
Safespot.Size = Vector3.new(500,10,500)
Safespot.Anchored = true
Safespot.CanCollide = true
Safespot.Transparency = .5

local Safespot1 = Instance.new("Part",workspace)
Safespot1.Name = "DefendPart"
Safespot1.Position = Vector3.new(10000.2, 13, 9752.45)
Safespot1.Size = Vector3.new(500, 117, 5)
Safespot1.Anchored = true
Safespot1.CanCollide = true
Safespot1.Transparency = .5
Safespot1.Parent = game.workspace.Safespot

local Safespot2 = Instance.new("Part",workspace)
Safespot2.Name = "DefendPart1"
Safespot2.Position = Vector3.new(10248.2, 13, 10002.4)
Safespot2.Size = Vector3.new(5, 117, 496)
Safespot2.Anchored = true
Safespot2.CanCollide = true
Safespot2.Transparency = .5
Safespot2.Parent = game.workspace.Safespot

local Safespot3 = Instance.new("Part",workspace)
Safespot3.Name = "DefendPart2"
Safespot3.Position = Vector3.new(9998.13, 13, 10247.2)
Safespot3.Size = Vector3.new(497, 117, 6)
Safespot3.Anchored = true
Safespot3.CanCollide = true
Safespot3.Transparency = .5
Safespot3.Parent = game.workspace.Safespot

local Safespot4 = Instance.new("Part",workspace)
Safespot4.Name = "DefendPart3"
Safespot4.Position = Vector3.new(9752.71, 13, 9999.28)
Safespot4.Size = Vector3.new(7, 117, 490)
Safespot4.Anchored = true
Safespot4.CanCollide = true
Safespot4.Transparency = .5
Safespot4.Parent = game.workspace.Safespot

local Safespot5 = Instance.new("Part",workspace)
Safespot5.Name = "DefendPart4"
Safespot5.Position = Vector3.new(10001.1, 76, 9999.66)
Safespot5.Size = Vector3.new(491, 10, 491)
Safespot5.Anchored = true
Safespot5.CanCollide = true
Safespot5.Transparency = .5
Safespot5.Parent = game.workspace.Safespot

local light = Instance.new("PointLight")
light.Color = Color3.fromRGB(255, 255, 255)
light.Range = 50
light.Brightness = 2
light.Parent = game.workspace.Safespot
end

--// esp script 
local function updateHighlights()
    local corpses = workspace.StuffOfTheDead.Corpses:GetChildren()
    
    for _, corpse in pairs(corpses) do
        if corpse:IsA("Model") then
            if toggled then
                if not corpse:FindFirstChild("Highlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "Highlight"
                    highlight.Parent = corpse
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.85
                    highlight.OutlineTransparency = 0.35
                end
            else
                local highlight = corpse:FindFirstChild("Highlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end

while true do
    wait(0.01)
    if toggled then
        updateHighlights()
    else
        local corpses = workspace.StuffOfTheDead.Corpses:GetChildren()
        for _, corpse in pairs(corpses) do
            if corpse:IsA("Model") then
                local highlight = corpse:FindFirstChild("Highlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end
