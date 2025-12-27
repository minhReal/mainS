--[[
              _By Hydro_gen_
          _Bản #2.8 / Version #2.8_
               _25/12/2025_
]]

--// Script Start #1
loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Script/Script_start.lua"))()

--// Services
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = game.Players.LocalPlayer
local Workspace = game:GetService("Workspace")

--// Toggle
local gui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "HydroToggleGUI"

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

local isGuiVisible = true
Line.MouseButton1Click:Connect(function()
    isGuiVisible = not isGuiVisible
    local coreGui = game:GetService("CoreGui")
    for _, child in pairs(coreGui:GetChildren()) do
        if child:FindFirstChild("Main") and child:FindFirstChild("Shadow") then
            child.Enabled = isGuiVisible
        end
    end
end)

local Themes = { 
    Light = { Primary = Color3.fromRGB(232, 232, 232), Secondary = Color3.fromRGB(255, 255, 255), Component = Color3.fromRGB(245, 245, 245), Interactables = Color3.fromRGB(235, 235, 235), Tab = Color3.fromRGB(50, 50, 50), Title = Color3.fromRGB(0, 0, 0), Description = Color3.fromRGB(100, 100, 100), Shadow = Color3.fromRGB(255, 255, 255), Outline = Color3.fromRGB(210, 210, 210), Icon = Color3.fromRGB(100, 100, 100), },
    Dark = { Primary = Color3.fromRGB(30, 30, 30), Secondary = Color3.fromRGB(35, 35, 35), Component = Color3.fromRGB(40, 40, 40), Interactables = Color3.fromRGB(45, 45, 45), Tab = Color3.fromRGB(200, 200, 200), Title = Color3.fromRGB(240,240,240), Description = Color3.fromRGB(200,200,200), Shadow = Color3.fromRGB(0, 0, 0), Outline = Color3.fromRGB(40, 40, 40), Icon = Color3.fromRGB(220, 220, 220), }, 
    Void = { Primary = Color3.fromRGB(15, 15, 15), Secondary = Color3.fromRGB(20, 20, 20), Component = Color3.fromRGB(25, 25, 25), Interactables = Color3.fromRGB(30, 30, 30), Tab = Color3.fromRGB(200, 200, 200), Title = Color3.fromRGB(240,240,240), Description = Color3.fromRGB(200,200,200), Shadow = Color3.fromRGB(0, 0, 0), Outline = Color3.fromRGB(40, 40, 40), Icon = Color3.fromRGB(220, 220, 220), }, 
}

Window:SetTheme(Themes.Void)

--// Script Loaded Successfully
game:GetService("StarterGui"):SetCore("SendNotification", {
      Title = "Notification",
      Text = "Script has been loaded successfully!",
      Icon = "rbxassetid://14401779839",
      Duration = 10
})
        
--// Delete something
local Sk = game.Workspace.Spawns:FindFirstChild("Spawn15")
if Sk then
    Sk:Destroy()
end

--// Safebox
local origin = Vector3.new(26.25, 14.25, -154.500031)
local farPosition = origin + Vector3.new(10000, 0, 0)
local SafeBox = Instance.new("Model")
SafeBox.Name = "SafeBox"
SafeBox.Parent = Workspace

local part = Instance.new("Part")
part.Name = "GhK"
part.Size = Vector3.new(1000, 10, 1000)
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

--// Settings [TAB]
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
    Description = "Subscribe for more",
    Tab = Main,
    Callback = function() 
        setclipboard("https://youtube.com/@hydro_genn?si=mnpY7VvpSeO_8_KM")
    end,
})

Window:AddParagraph({
	Title = "December 25, 2025",
	Description = "-☃️ Merry Christmas ❄️-",
	Tab = Main
}) 

Window:AddSection({ Name = "Player", Tab = Main }) 

Window:AddButton({
	Title = "Player status (JOY)",
	Description = "shows player status (JOY) and whether autofarm should be used ",
	Tab = Main,
	Callback = function() 
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
        local h = workspace:FindFirstChild("Handle") and workspace.Handle:FindFirstChild("ClickDetector")
        if h then
            fireclickdetector(h)
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
    Title = "Animation( pack)",
    Description = "idk",
    Tab = miscTab,
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Script/First.lua'))()
    end,
})

Window:AddSection({ Name = "Utilities", Tab = miscTab }) 

local toggled = false
local corpsesFolder = workspace:WaitForChild("StuffOfTheDead"):WaitForChild("Corpses")

local function addHighlight(model)
    local torso = model:FindFirstChild("Torso")
    if not torso then return end

    if not model:FindFirstChild("Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "Highlight"
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.85
        highlight.OutlineTransparency = 0.35
        highlight.Parent = model
    end

    if not torso:FindFirstChild("ESP_Tag") then
        local bb = Instance.new("BillboardGui")
        bb.Name = "ESP_Tag"
        bb.Adornee = torso
        bb.Parent = torso
        bb.AlwaysOnTop = true
        
        bb.Size = UDim2.new(2, 0, 2, 0) 
        
        local dot = Instance.new("Frame")
        dot.Name = "RedDot"
        dot.Size = UDim2.new(0.4, 0, 0.4, 0)
        dot.Position = UDim2.new(0.3, 0, 0.3, 0)
        dot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        dot.BorderSizePixel = 0
        dot.Parent = bb
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = dot
    end
end

local function removeHighlight(model)
    local highlight = model:FindFirstChild("Highlight")
    if highlight then
        highlight:Destroy()
    end
    
    local torso = model:FindFirstChild("Torso")
    if torso then
        local espTag = torso:FindFirstChild("HydroESP_Tag")
        if espTag then
            espTag:Destroy()
        end
    end
end

local function updateHighlights()
    for _, corpse in pairs(corpsesFolder:GetChildren()) do
        if corpse:IsA("Model") then
            if toggled then
                addHighlight(corpse)
            else
                removeHighlight(corpse)
            end
        end
    end
end

corpsesFolder.ChildAdded:Connect(function(child)
    if toggled and child:IsA("Model") then
        addHighlight(child)
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if toggled then
            updateHighlights()
        end
    end
end)
--// ----------------------

Window:AddToggle({
    Title = "Esp the dead [FIXED]",
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

Window:AddToggle({
    Title = "No Car",
    Description = "not working",
    Tab = miscTab,
    Callback = function(Boolean) 
        if Boolean then
            removalRunning = true
            loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/BDFS_script/no_cars.lua"))()
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
        local l = workspace:FindFirstChild("Infection Liquid")
        if l then
            firetouchinterest(player.Character.HumanoidRootPart, l, 0)
        end
    end,
})

Window:AddButton({
    Title = "No blur",
    Description = "Remove zombie blur",
    Tab = miscTab,
    Callback = function()
        local lighting = game:GetService("Lighting")
        local blurEffect = lighting:FindFirstChild("Blur")
        if blurEffect then
            if blurEffect.Enabled then
                blurEffect.Enabled = false
                Window:Notify({ Title = "Notification", Description = "Blur is off", Duration = 10 })
            else
                Window:Notify({ Title = "Notification", Description = "Blur was turned off before", Duration = 10 })
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

Window:AddButton({
    Title = "Freecam",
    Description = "",
    Tab = miscTab,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Other_Script/freecam.lua"))()
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
    Title = "Spawn a enemy ",
    Description = "Spawns clone enemy",
    Tab = miscTab,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Other_Script/AI_2.lua"))()
    end,
})

--// farm [TAB]
Window:AddSection({ Name = "Dead burger", Tab = farmTab }) 

Window:AddParagraph({
    Title = "❗IMPORTANT NOTICE❗",
    Description = "Don't turn it on and off constantly because of bugs",
    Tab = farmTab,
}) 

Window:AddButton({
	Title = "Player status (JOY)",
	Description = "shows player status (JOY) and whether autofarm should be used ",
	Tab = Main,
	Callback = function() 
		local joyValue = player.Character and player.Character.Values and player.Character.Values.Joy and player.Character.Values.Joy.Value or 0
        local formattedJoyValue = string.format("%.2f", joyValue)
        local statusMessage = joyValue < 35 and " | Not good" or " | Good"
        Window:Notify({
            Title = "Notification",
            Description = "Current Joy Value: " .. formattedJoyValue .. statusMessage, 
            Duration = 10
        })
	end,
})

Window:AddToggle({
    Title = "Autofarm ",
    Description = "With Safebox",
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
    Title = "Autofarm",
    Description = "Without Safebox",
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

local running = false
Window:AddToggle({
    Title = "Monitor",
    Description = "test",
    Tab = farmTab,
    Callback = function(Boolean)
        running = Boolean
        if running then
            task.spawn(function()
                while running do
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("Model") and obj.Name == "Monitor" then
                            local part = obj:FindFirstChild("Part")
                            if part then
                                local cd = part:FindFirstChildOfClass("ClickDetector")
                                if cd then
                                    fireclickdetector(cd)
                                    task.wait(0.1)
                                end
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end,
})

local autoEatEnabled = false
Window:AddToggle({
    Title = "Auto eat",
    Description = "If you have less than 50 hunger, the script will run",
    Tab = farmTab,
    Callback = function(Value)
        autoEatEnabled = Value
        if Value then
            eat()
        end
    end,
})

-- Script Logic for Auto Happy
local RNing = false
local triggered = false
local model = workspace:WaitForChild(player.Name)
local joyValue = model:WaitForChild("Values"):WaitForChild("Joy")

local function equipAndUseGlee()
    local glee = player:WaitForChild("Backpack"):FindFirstChild("glee")
    if glee and glee:IsA("Tool") then
        player.Character.Humanoid:EquipTool(glee)
        task.wait(0.2)
        if glee.Activate then
            glee:Activate()
        end
    end
end

local function autoBuyNEat()
    wait(0.1)
    local popUpUI = player.PlayerGui:WaitForChild("PopUpUI")
    local b = popUpUI:FindFirstChild("SettingsFrame") and popUpUI.SettingsFrame:FindFirstChild("BuyButton") and popUpUI.SettingsFrame.BuyButton:FindFirstChild("Buy")
    if b and b:IsA("RemoteEvent") then
        b:FireServer()
    end
end

Window:AddToggle({
    Title = "Auto happy",
    Description = "If your Joy is under 30 it will make you happy.",
    Tab = farmTab,
    Callback = function(Boolean) 
        RNing = Boolean
        if RNing then
            task.spawn(function()
                while RNing do
                    if joyValue.Value < 30 and not triggered then
                        triggered = true
                        local gleeTool = workspace:WaitForChild("Buyables"):WaitForChild("Tools"):WaitForChild("glee")
                        local detector = gleeTool:FindFirstChildOfClass("ClickDetector")
                        if detector then
                            fireclickdetector(detector)
                        end
                        task.wait(0.5)
                        autoBuy()
                        task.wait(1)
                        equipAndUseGlee()
                    elseif joyValue.Value >= 30 then
                        triggered = false 
                    end
                    task.wait(0.5)
                end
            end)
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
    Title = "Tp to SafePlace",
    Description = "",
    Tab = teleportTab,
    Callback = function()
        local h = player.Character.HumanoidRootPart
        local s = workspace:FindFirstChild("SafeBox")
        if s and s:FindFirstChild("GhK") then
            h.CFrame = s.GhK.CFrame + Vector3.new(0, 5, 0)
        end
    end,
})

Window:AddButton({
    Title = "Tp to DVSC",
    Description = "",
    Tab = teleportTab,
    Callback = function()
        player.Character:SetPrimaryPartCFrame(CFrame.new(233.55099487304688, 70.5, 857.654052734375))
    end,
}) 

Window:AddButton({
    Title = "Tp to Dead buger",
    Description = "",
    Tab = teleportTab,
    Callback = function()
        player.Character:SetPrimaryPartCFrame(CFrame.new(-25.858579635620117, 16.999996185302734, 144.6079864501953))
    end,
})

--// Scripts Logic Area
local playersToBlock = {
    "mad_hhhh", "Maxim_L1111", "mmmax1", "Electr0nic_Person", "ElectroMotiveDev",
    "TheRealJ4YD3N", "Sk3tchYT", "Jayingee", "KenvinEdwardsJr", "forstaken",
    "princessunicakeyum", "honeyblack265", "Demonic_AngelPB", "Roduxman999",
    "BananaDatBo", "CruntchiiBoi", "meteorcrasher118", "Stronglion12344",
    "Fezezen", "pulsekinesis", "1936indiana"
}

local _toggleActive = false
local function checkPlayers()
    for _, p in ipairs(game.Players:GetPlayers()) do
        for _, b in ipairs(playersToBlock) do
            if p.Name == b then
                player:Kick("Blocked player detected: " .. p.Name)
                return
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

--// Auto eat logic
local function checkAndEquipBurger()
    local b = player:WaitForChild("Backpack"):FindFirstChild("burger")
    if b and b:IsA("Tool") then
        player.Character.Humanoid:EquipTool(b)
        wait(0.1)
    end
end

local function eat()
    local burgerCD = workspace.Buyables.Tools.burgre.ClickDetector
    while true do
        wait(0.5)
        if autoEatEnabled then
            if player.PlayerGui.Hunger.Hunger.Value < 50 then
                checkAndEquipBurger()
                local bc = player.Character:FindFirstChild("burger")
                if bc then
                    wait(0.1)
                    bc:Activate()
                    wait(1.5)
                else
                    if not player.Backpack:FindFirstChild("burger") and burgerCD then
                        fireclickdetector(burgerCD)
                        autoBuyNEat()
                        wait(5)
                    end
                end
            end
        else
            wait(0.5)
        end
    end
end
spawn(eat)

--// Hydro Alert
local targetName = "glitchglitchg48"
local alerted = false
local function alertOnce()
    if not alerted then
        alerted = true
        Window:Notify({
            Title = "Hydro Alert",
            Description = "hydro(owner) in this server",
            Duration = 5
        })
        task.delay(2, function()
            Window:Notify({
                Title = "Hydro Alert",
                Description = "don't kill him.",
                Duration = 5
            })
        end)
    end
end

for _, p in pairs(game.Players:GetPlayers()) do
    if p.Name == targetName then
        alertOnce()
        break
    end
end

game.Players.PlayerAdded:Connect(function(p)
    if p.Name == targetName then
        alertOnce()
    end
end)
