--      _By Hydro_gen_
--   _Bản #2 / Version #2_
--        _4/1/2025_

--// Script Start #1
loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Script/Script_start.lua"))()

--// Toggle 
local gui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))

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

--// Script Loaded Successfully  #2
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

--// Delete something
local Sk = game.Workspace.Spawns:FindFirstChild("Spawn15")
if Sk then
    Sk:Destroy()
end

--// Safebox
local Workspace = game:GetService("Workspace")
local origin = Vector3.new(26.25, 14.25, -154.500031)
local farPosition = origin + Vector3.new(10000, 0, 0)
local SafeBox = Instance.new("Model")
SafeBox.Name = "SafeBox"
SafeBox.Parent = Workspace

local part = Instance.new("Part")
part.Name = "GhK"
part.Size = Vector3.new(10, 10, 10)
part.Position = farPosition
part.Anchored = true
part.CanCollide = true
part.Parent = SafeBox

local light = Instance.new("PointLight")
light.Color = Color3.fromRGB(255, 255, 200)
light.Brightness = 2
light.Range = 20
light.Parent = part

--// DDVC noclip
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

--// Animation Script 
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

--// Các TAB
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

Window:AddParagraph({
	Title = "🫩",
	Description = "The update will take longer because the banwave is very danger",
	Tab = Main
}) 

Window:AddButton({
    Title = "Sub To Hydro_gen!!",
    Description = "Subscribe for more",
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
Window:AddParagraph({ Title = "WARNING", Description = "If you click on a tool, the script will automatically buy that tool!", Tab = toolTab })

Window:AddSection({ Name = "Food", Tab = toolTab }) 

local function autoBuy()
    wait(0.1)
    local player = game:GetService("Players").LocalPlayer
    local popUpUI = player.PlayerGui:WaitForChild("PopUpUI")
    local buyButton = popUpUI.SettingsFrame:WaitForChild("BuyButton"):FindFirstChild("Buy")

    if buyButton and buyButton:IsA("RemoteEvent") then
        buyButton:FireServer()
    end
end

Window:AddButton({
    Title = "Dead burger is 30$",
    Description = "deadville economic inflation",
    Tab = toolTab,
    Callback = function()
        fireclickdetector(workspace.Buyables.Tools.burgre.ClickDetector)
        autoBuy()
    end,
})

Window:AddButton({
    Title = "Coffee is 20$",
    Description = "cup of Joe",
    Tab = toolTab,
    Callback = function()
        fireclickdetector(workspace.Buyables.Tools.coffee.ClickDetector)
        autoBuy()
    end,
})

Window:AddButton({
    Title = "Pizza is 30$",
    Description = "your loss is our sauce!",
    Tab = toolTab,
    Callback = function()
        fireclickdetector(workspace.Buyables.Tools.Pizza.ClickDetector)
        autoBuy()
    end,
})

Window:AddButton({
    Title = "Cola is 15$",
    Description = "with two new flavors just in time for summer, nothing beats bloxy cola!",
    Tab = toolTab,
    Callback = function()
        fireclickdetector(workspace.Buyables.Tools.cola.ClickDetector)
        autoBuy()
    end,
})

Window:AddSection({ Name = "Weapon", Tab = toolTab })

Window:AddButton({
    Title = "PlayerDestroy9000 is FREE",
    Description = "Destroy",
    Tab = toolTab,
    Callback = function()
        local handleDetector = workspace:FindFirstChild("Handle") and workspace.Handle:FindFirstChild("ClickDetector")
        if handleDetector then
            fireclickdetector(handleDetector)
            autoBuy()
        end
    end,
})

Window:AddButton({
    Title = "C4 is FREE",
    Description = "dead co brand explosives!",
    Tab = toolTab,
    Callback = function() 
        fireclickdetector(workspace.Buyables.Tools.c4.ClickDetector)
        autoBuy()
    end,
}) 

Window:AddButton({
    Title = "Knife is FREE",
    Description = "right behind you",
    Tab = toolTab,
    Callback = function()
        fireclickdetector(workspace.Buyables.Tools.Knife.ClickDetector)
        autoBuy()
    end,
})

Window:AddButton({
    Title = "AWP is FREE",
    Description = "boom! headshot!",
    Tab = toolTab,
    Callback = function()
        fireclickdetector(workspace.Buyables.Tools.awp.ClickDetector)
        autoBuy()
    end,
})

Window:AddButton({
    Title = "Shotgun is FREE",
    Description = "produced from dead co. quality assured*!",
    Tab = toolTab,
    Callback = function()
        fireclickdetector(workspace.Buyables.Tools.shotgun.ClickDetector)
        autoBuy()
    end,
})

Window:AddSection({ Name = "Other", Tab = toolTab }) 

Window:AddButton({
    Title = "Medkit is 5$",
    Description = "patch yourself up",
    Tab = toolTab,
    Callback = function()
        fireclickdetector(workspace.Buyables.Tools.medkit.ClickDetector)
        autoBuy()
    end,
})

Window:AddButton({
    Title = "Key card is FREE",
    Description = "Key. card.",
    Tab = toolTab,
    Callback = function()
        fireclickdetector(workspace.Buildings.DeadBurger.Level1Keycard.ClickDetector)
        autoBuy()
    end,
})

Window:AddButton({
    Title = "New paper is FREE",
    Description = "only the latest",
    Tab = toolTab,
    Callback = function()
        fireclickdetector(workspace.Buyables.Tools.NewsPaper.ClickDetector)
        autoBuy()
    end,
})

Window:AddButton({
    Title = "Dread is 40$",
    Description = "one review says a friend tuned into this one and claimed they \"never wanted to be alone again\".",
    Tab = toolTab,
    Callback = function()
        fireclickdetector(workspace.Buyables.Tools.dread.ClickDetector)
        autoBuy()
    end,
})

Window:AddButton({
    Title = "Glee is 40$",
    Description = "recent reviews say the experience left them wanting for more.",
    Tab = toolTab,
    Callback = function()
        fireclickdetector(workspace.Buyables.Tools.glee.ClickDetector)
        autoBuy()
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

Window:AddButton({
    Title = "Animation(human pack)",
    Description = "idk",
    Tab = miscTab,
    Callback = function()
        playAnimation("rbxassetid://8830424363")
    end,
})


Window:AddSection({ Name = "Utilities", Tab = miscTab }) 

local toggled = false
local corpsesFolder = workspace:WaitForChild("StuffOfTheDead"):WaitForChild("Corpses")

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
    Description = "This script is only used when you turn into a zombie cuz when you turn into one your screen willbe blurr",
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
    Tab = miscTab,
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
	loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Other_Script/Spectator_ByHydro_gen.lua"))()
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
	Title = "❗IMPORTANT NOTICE❗",
	Description = "Don't turn it on and off constantly because of bugs",
	Tab = farmTab,
}) 

Window:AddToggle({
    Title = "Autofarm [with Safebox]",
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
    Title = "Autofarm [without Safebox]",
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

local player = game.Players.LocalPlayer
local autoEatEnabled = false

Window:AddToggle({
    Title = "Auto eat [FIX]",
    Description = "If you have less than 50 hunger, the script will run",
    Tab = farmTab,
    Callback = function(Value)
        autoEatEnabled = Value
        if Value then
            eat()
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
--// antimods / admin (maybe)
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

--// Auto eat script
local function checkAndEquipBurger()
    local backpack = player:WaitForChild("Backpack")
    local burger = backpack:FindFirstChild("burger")

    if burger and burger:IsA("Tool") then
        player.Character.Humanoid:EquipTool(burger)
        wait(0.1) -- Đợi 0.1 giây sau khi trang bị
    end
end

local function autoBuyNEat()
    wait(0.1)
    local popUpUI = player.PlayerGui:WaitForChild("PopUpUI")
    
    local settingsFrame = popUpUI:FindFirstChild("SettingsFrame")
    if not settingsFrame then return end
    
    local buyButton = settingsFrame:FindFirstChild("BuyButton")
    if not buyButton then return end
    
    local buyRemote = buyButton:FindFirstChild("Buy")

    if buyRemote and buyRemote:IsA("RemoteEvent") then
        buyRemote:FireServer()
    end
end

local function eat()
    local burgerClickDetector = workspace.Buyables.Tools.burgre.ClickDetector

    while true do
        wait(0.5)
        if autoEatEnabled then
            if player.PlayerGui.Hunger.Hunger.Value < 50 then
                checkAndEquipBurger()

                local burgerInCharacter = player.Character:FindFirstChild("burger")
                if burgerInCharacter then
                    wait(0.1) -- Đợi 0.1 giây trước khi kích hoạt công cụ
                    burgerInCharacter:Activate()
                    wait(1.5) -- Thời gian chờ sau khi kích hoạt
                else
                    if not player.Backpack:FindFirstChild("burger") then
                        if burgerClickDetector then
                            fireclickdetector(burgerClickDetector)
                            autoBuyNEat() -- Gọi hàm mua burger ngay lập tức
                            wait(5) -- Chờ một chút sau khi mua
                        end
                    end
                end
            end
        else
            wait(0.5) -- Đợi một chút trước khi kiểm tra lại trạng thái toggle
        end
    end
end

eat()

-- ESP corpses
local corpsesFolder = workspace:WaitForChild("StuffOfTheDead"):WaitForChild("Corpses")

function updateHighlights()
    for _, corpse in pairs(corpsesFolder:GetChildren()) do
        if corpse:IsA("Model") then
            local highlight = corpse:FindFirstChild("Highlight")
            if toggled then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "Highlight"
                    highlight.Parent = corpse
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.85
                    highlight.OutlineTransparency = 0.35
                end
            elseif highlight then
                highlight:Destroy()
            end
        end
    end
end

-- Highlight khi có corpse mới spawn
corpsesFolder.ChildAdded:Connect(function(child)
    if child:IsA("Model") and toggled then
        updateHighlights()
    end
end)

-- Cập nhật định kỳ (nhẹ)
task.spawn(function()
    while task.wait(0.5) do
        updateHighlights()
    end
end)
