-- SUPPORTING SCRIPTS --

-- // BYPASSERS


                      -- // nothing here // --


-- // TOGGLE GUI


                      -- // nothing here // --


-- // MAIN SCRIPT 
local Fluent = loadstring(game:HttpGet(
    "https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"
))()

local Window = Fluent:CreateWindow({
    Title = "Supporting Scripts",
    SubTitle = "by minhh",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- // TABS
local Tabs = {
    Dex = Window:AddTab({ Title = "Dex", Icon = "code" }),
    Spy = Window:AddTab({ Title = "Spy", Icon = "search" }),
    An = Window:AddTab({ Title = "Other things ", Icon = "box" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}

local Options = Fluent.Options


-- // DEX EXPLORER
Tabs.Dex:AddParagraph({
    Title = "DEX SCRIPTs",
    Content = "Dùng để xem cấu trúc game như Explorer / Properties | Used to view game structure like Explorer / Properties"
})

Tabs.Dex:AddButton({
    Title = "Dex",
    Description = "Phiên bản bình thường | Normal ver",
    Callback = function()
        loadstring(game:HttpGet(
            "https://rawscripts.net/raw/Universal-Script-Keyless-mobile-dex-17888"
        ))()
    end
})

Tabs.Dex:AddButton({
    Title = "Dex PlusPlus",
    Description = "Dex nhưng đẹp và nhiều tính năng hơn | Dex but more beautiful and with more features",
    Callback = function()
        loadstring(game:HttpGet(
            "https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"
        ))()
    end
})

Tabs.Dex:AddButton({
    Title = "Dex API-less",
    Description = "Tính năng này chỉ dành cho những người dùng gặp sự cố khi vượt qua ''Fetching API'' trong Dex hoặc không thể chờ đợi lâu | This feature is only for users who have problems getting through the ''Fetching API'' in Dex or can't wait that long",
    Callback = function()
        loadstring(game:HttpGet(
            "https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"
        ))()
    end
})
-- // REMOTE SPY 
Tabs.Spy:AddSection("Remote Spy")
Tabs.Spy:AddParagraph({
    Title = "REMOTE SPY SCRIPTs",
    Content = "Theo dõi RemoteEvent / RemoteFunction | Monitor RemoteEvent / RemoteFunction"
})

Tabs.Spy:AddButton({
    Title = "Remote Spy",
    Description = "Phiên bản bình thường / Normal ver. By REDz",
    Callback = function()
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Other_Script/RemoteSpy.lua"
        ))()
    end
})

Tabs.Spy:AddButton({
    Title = "OctoSpy",
    Description = "RemoteSpy nhưng đẹp | RemoteSpy but beautiful",
    Callback = function()
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/InfernusScripts/Octo-Spy/refs/heads/main/Main.lua"
        ))()
    end
})

Tabs.Spy:AddButton({
    Title = "Simple Spy",
    Description = "RemoteSpy + HttpSpy + Upvalues",
    Callback = function()
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/InfernusScripts/Ketamine/refs/heads/main/Ketamine.lua"
        ))()
    end
})

Tabs.Spy:AddButton({
    Title = "Hydroxide",
    Description = "Debugger + Upvalue + Constant + Remote Spy",
    Callback = function()
        local owner, branch = "Upbolt", "revision"
        local function import(file)
            return loadstring(game:HttpGet(
                ("https://raw.githubusercontent.com/%s/Hydroxide/%s/%s.lua")
                :format(owner, branch, file)
            ))()
        end
        import("init")
        import("ui/main")
    end
})


-- // HTTP SPY
Tabs.Spy:AddSection("Http Spy")
Tabs.Spy:AddParagraph({
    Title = "HTTPSPY SCRIPTs",
    Content = "Theo dõi các yêu cầu HTTP | Monitor HTTP requests"
})

Tabs.Spy:AddButton({
    Title = "HTTP Spy",
    Description = "Theo dõi HTTP Requests | Monitor HTTP Requests",
    Callback = function()
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/Bebo-Mods/Scripts/refs/heads/master/HttpsSpy.lua"
        ))()
    end
})

Tabs.Spy:AddButton({
    Title = "Simple Spy",
    Description = "RemoteSpy + HttpSpy + Upvalues",
    Callback = function()
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/InfernusScripts/Ketamine/refs/heads/main/Ketamine.lua"
        ))()
    end
})

-- OTHER THINGS
Tabs.An:AddButton({
    Title = "Debuggers",
    Description = "Idk how to explain it;-;",
    Callback = function()
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/yofriendfromschool1/debugnation/main/decompilers%20and%20debugging/Debuggers.txt"
        ))()
    end
})

Tabs.An:AddButton({
    Title = "Gui maker",
    Description = "Dùng để tạo giao diện GUI | Used to create GUI interfaces",
    Callback = function()
        loadstring(game:HttpGet(
            "https://pastefy.app/EOgPqinS/raw"
        ))()
    end
})

Tabs.An:AddButton({
    Title = "Universal Viewer",
    Description = "Xem danh sách các place liên kết với place hiện tại | View a list of places linked to the current place",
    Callback = function()
    
local TeleportService = game:GetService("TeleportService")
local pages = game:GetService("AssetService"):GetGamePlacesAsync()
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Parent = game:GetService("CoreGui")
gui.ResetOnSpawn = false

local outerFrame = Instance.new("Frame")
outerFrame.Size = UDim2.new(0.45,0,0.6,0)
outerFrame.Position = UDim2.new(0.275,0,0.2,0)
outerFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
outerFrame.BorderSizePixel = 0
outerFrame.Active = true
outerFrame.Draggable = true
outerFrame.Parent = gui

local outerCorner = Instance.new("UICorner")
outerCorner.CornerRadius = UDim.new(0,12)
outerCorner.Parent = outerFrame

local outerStroke = Instance.new("UIStroke")
outerStroke.Color = Color3.fromRGB(255,165,0)
outerStroke.Thickness = 2
outerStroke.Parent = outerFrame

-- Shadow effect
local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1,12,1,12)
shadow.Position = UDim2.new(0,-6,0,-6)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://7032322446" -- subtle shadow
shadow.ImageColor3 = Color3.fromRGB(0,0,0)
shadow.ImageTransparency = 0.7
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10,10,118,118)
shadow.Parent = outerFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.BackgroundColor3 = Color3.fromRGB(50,50,50)
title.Text = "Universal Viewer"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = outerFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0,10)
titleCorner.Parent = title

local closeButton = Instance.new("TextButton")
closeButton.Text = "×"
closeButton.Size = UDim2.new(0,35,0,35)
closeButton.Position = UDim2.new(1,-40,0,2)
closeButton.TextSize = 20
closeButton.BackgroundTransparency = 1
closeButton.TextColor3 = Color3.fromRGB(255,100,100)
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = title
closeButton.MouseEnter:Connect(function()
    closeButton.TextColor3 = Color3.fromRGB(255,50,50)
end)
closeButton.MouseLeave:Connect(function()
    closeButton.TextColor3 = Color3.fromRGB(255,100,100)
end)
closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Container frame
local container = Instance.new("Frame")
container.Size = UDim2.new(1,-10,1,-50)
container.Position = UDim2.new(0,5,0,45)
container.BackgroundColor3 = Color3.fromRGB(40,40,40)
container.BorderSizePixel = 0
container.Parent = outerFrame

local containerCorner = Instance.new("UICorner")
containerCorner.CornerRadius = UDim.new(0,10)
containerCorner.Parent = container

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1,0,1,0)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 8
scrollFrame.Parent = container

local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0,8)
listLayout.Parent = scrollFrame

-- Create Place Item
local function createPlaceItem(place)
    local item = Instance.new("Frame")
    item.Size = UDim2.new(1,-10,0,50)
    item.BackgroundColor3 = Color3.fromRGB(60,60,60)
    item.BorderSizePixel = 0
    item.Parent = scrollFrame

    local itemCorner = Instance.new("UICorner")
    itemCorner.CornerRadius = UDim.new(0,8)
    itemCorner.Parent = item

    -- Gradient for item
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(70,70,70)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(60,60,60))
    }
    gradient.Parent = item

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Text = place.Name
    nameLabel.Size = UDim2.new(0.7,0,1,0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(255,255,255)
    nameLabel.TextSize = 16
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = item

    -- Teleport button
    local tpButton = Instance.new("TextButton")
    tpButton.Text = "Teleport"
    tpButton.Size = UDim2.new(0.28,0,0.8,0)
    tpButton.Position = UDim2.new(0.72,0,0.1,0)
    tpButton.BackgroundColor3 = Color3.fromRGB(120,120,120)
    tpButton.TextColor3 = Color3.fromRGB(255,255,255)
    tpButton.Font = Enum.Font.GothamBold
    tpButton.TextSize = 14
    tpButton.AutoButtonColor = false
    tpButton.Parent = item

    local tpCorner = Instance.new("UICorner")
    tpCorner.CornerRadius = UDim.new(0,6)
    tpCorner.Parent = tpButton

    -- Hover effect
    tpButton.MouseEnter:Connect(function()
        tpButton.BackgroundColor3 = Color3.fromRGB(150,150,150)
    end)
    tpButton.MouseLeave:Connect(function()
        tpButton.BackgroundColor3 = Color3.fromRGB(120,120,120)
    end)

    tpButton.MouseButton1Click:Connect(function()
        TeleportService:Teleport(place.PlaceId, player)
    end)

    -- Hover effect for item
    item.MouseEnter:Connect(function()
        local tween = game:GetService("TweenService"):Create(item,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(75,75,75)})
        tween:Play()
    end)
    item.MouseLeave:Connect(function()
        local tween = game:GetService("TweenService"):Create(item,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(60,60,60)})
        tween:Play()
    end)
end

-- Populate items
local function updateGUI()
    for _, place in pairs(pages:GetCurrentPage()) do
        createPlaceItem(place)
    end
    scrollFrame.CanvasSize = UDim2.new(0,0,0,listLayout.AbsoluteContentSize.Y)
    if not pages.IsFinished then
        pages:AdvanceToNextPageAsync()
    end
end

updateGUI()
    end
})


Tabs.An:AddButton({
    Title = "Animation logger",
    Description = "Một animation được phát, nó sẽ ghi lại animation đó | An animation is played, it will record that animation",
    Callback = function()
local gui = Instance.new("ScreenGui")
gui.Parent = game:GetService("CoreGui")

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Main frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.35, 0, 0.5, 0)
frame.Position = UDim2.new(0.325, 0, 0.25, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = gui
frame.Draggable = true
frame.Active = true
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0,12)
frameCorner.Parent = frame

local frameStroke = Instance.new("UIStroke")
frameStroke.Thickness = 2
frameStroke.Color = Color3.fromRGB(80,80,80)
frameStroke.Parent = frame

-- Top bar
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1,0,0,36)
topBar.BackgroundColor3 = Color3.fromRGB(50,50,50)
topBar.BorderSizePixel = 0
topBar.Parent = frame
local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0,12)
topCorner.Parent = topBar

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -140, 1, 0)
titleLabel.Position = UDim2.new(0,10,0,0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Animation Logger"
titleLabel.Font = Enum.Font.GothamSemibold
titleLabel.TextColor3 = Color3.fromRGB(245,245,245)
titleLabel.TextSize = 20
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

-- Top buttons
local clearButton = Instance.new("TextButton")
clearButton.Size = UDim2.new(0,88,0,28)
clearButton.Position = UDim2.new(0.8,-100,0,4)
clearButton.BackgroundColor3 = Color3.fromRGB(200,60,60)
clearButton.Text = "Clear All"
clearButton.TextColor3 = Color3.fromRGB(255,255,255)
clearButton.TextSize = 16
clearButton.Font = Enum.Font.Gotham
clearButton.Parent = topBar
local clearCorner = Instance.new("UICorner")
clearCorner.CornerRadius = UDim.new(0,6)
clearCorner.Parent = clearButton

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0,28,0,28)
minimizeButton.Position = UDim2.new(1,-70,0,4)
minimizeButton.BackgroundColor3 = Color3.fromRGB(80,160,220)
minimizeButton.Text = "–"
minimizeButton.TextColor3 = Color3.fromRGB(255,255,255)
minimizeButton.TextSize = 18
minimizeButton.Font = Enum.Font.Gotham
minimizeButton.Parent = topBar
local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0,6)
minCorner.Parent = minimizeButton

local xButton = Instance.new("TextButton")
xButton.Size = UDim2.new(0,28,0,28)
xButton.Position = UDim2.new(1,-36,0,4)
xButton.BackgroundColor3 = Color3.fromRGB(220,80,80)
xButton.Text = "X"
xButton.TextColor3 = Color3.fromRGB(255,255,255)
xButton.TextSize = 18
xButton.Font = Enum.Font.Gotham
xButton.Parent = topBar
local xCorner = Instance.new("UICorner")
xCorner.CornerRadius = UDim.new(0,6)
xCorner.Parent = xButton

-- Scroll frame
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1,0,1,-36)
scrollFrame.Position = UDim2.new(0,0,0,36)
scrollFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 8
scrollFrame.Parent = frame
local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0,12)
scrollCorner.Parent = scrollFrame

local logLayout = Instance.new("UIListLayout")
logLayout.Parent = scrollFrame
logLayout.SortOrder = Enum.SortOrder.LayoutOrder
logLayout.Padding = UDim.new(0,8)

-- Table lưu animation: {count, frame, animation}
local loggedAnimations = {}

-- Hàm log animation với số lần lặp hiển thị bên tên
local function logAnimation(name, anim)
	local id = anim.AnimationId
	if loggedAnimations[id] then
		local entry = loggedAnimations[id]
		entry.count += 1
		entry.textLabel.Text = string.format("%s x%d\nAnimation ID: %s", name, entry.count, id)
		entry.frame.BackgroundColor3 = Color3.fromRGB(255,255,255)
		local tween = TweenService:Create(entry.frame, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(40,40,40)})
		tween:Play()
		return
	end

	-- Frame chứa text + nút
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1,-16,0,60)
	container.BackgroundColor3 = Color3.fromRGB(40,40,40)
	container.Parent = scrollFrame

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,8)
	corner.Parent = container

	-- TextLabel
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1,-100,1,0)
	textLabel.Position = UDim2.new(0,8,0,0)
	textLabel.BackgroundTransparency = 1
	textLabel.Text = string.format("%s x1\nAnimation ID: %s", name, id)
	textLabel.TextWrapped = true
	textLabel.Font = Enum.Font.Gotham
	textLabel.TextSize = 16
	textLabel.TextColor3 = Color3.fromRGB(255,255,255)
	textLabel.TextXAlignment = Enum.TextXAlignment.Left
	textLabel.Parent = container

	-- Nút màu xám
	local function createButton(posX, label)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0,28,0,28)
		btn.Position = UDim2.new(1,posX,0,16)
		btn.BackgroundColor3 = Color3.fromRGB(120,120,120)
		btn.Text = label
		btn.Font = Enum.Font.Gotham
		btn.TextSize = 14
		btn.TextColor3 = Color3.fromRGB(255,255,255)
		btn.Parent = container
		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0,6)
		btnCorner.Parent = btn
		return btn
	end

	local playBtn = createButton(-90, "▶")
	local stopBtn = createButton(-60, "| |")
	local copyBtn = createButton(-30, "📋")

	playBtn.MouseButton1Click:Connect(function()
		local char = player.Character
		if char then
			local humanoid = char:FindFirstChild("Humanoid")
			if humanoid then
				humanoid:LoadAnimation(anim):Play()
			end
		end
	end)

	stopBtn.MouseButton1Click:Connect(function()
		local char = player.Character
		if char then
			local humanoid = char:FindFirstChild("Humanoid")
			if humanoid then
				for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
					if track.Animation.AnimationId == anim.AnimationId then
						track:Stop()
					end
				end
			end
		end
	end)

	copyBtn.MouseButton1Click:Connect(function()
		setclipboard(anim.AnimationId)
	end)

	-- Hover effect container
	container.MouseEnter:Connect(function()
		container.BackgroundColor3 = Color3.fromRGB(60,60,60)
	end)
	container.MouseLeave:Connect(function()
		container.BackgroundColor3 = Color3.fromRGB(40,40,40)
	end)

	-- Lưu vào table
	loggedAnimations[id] = {count=1, frame=container, anim=anim, textLabel=textLabel}

	-- Update CanvasSize & auto-scroll
	scrollFrame.CanvasSize = UDim2.new(0,0,0,logLayout.AbsoluteContentSize.Y)
	scrollFrame.CanvasPosition = Vector2.new(0, scrollFrame.CanvasSize.Y.Offset)
end

-- Auto update canvas
logLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scrollFrame.CanvasSize = UDim2.new(0,0,0,logLayout.AbsoluteContentSize.Y)
	scrollFrame.CanvasPosition = Vector2.new(0, scrollFrame.CanvasSize.Y.Offset)
end)

-- Track player animations
local function onAnimationPlayed(track)
	if track.Animation then
		logAnimation(track.Animation.Name or "Unknown Animation", track.Animation)
	end
end

local function trackPlayerAnimations()
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")
	humanoid.AnimationPlayed:Connect(onAnimationPlayed)
end

trackPlayerAnimations()

-- Clear
clearButton.MouseButton1Click:Connect(function()
	for _, child in ipairs(scrollFrame:GetChildren()) do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end
	loggedAnimations = {}
	scrollFrame.CanvasSize = UDim2.new(0,0,0,0)
end)

-- Close
xButton.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Minimize
local isMinimized = false
local originalSize = frame.Size
minimizeButton.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	if isMinimized then
		minimizeButton.Text = "+"
		frame.Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset,0,36)
		scrollFrame.Visible = false
	else
		minimizeButton.Text = "–"
		frame.Size = originalSize
		scrollFrame.Visible = true
	end
      end)
    end
})

Tabs.An:AddButton({
    Title = "Audio logger",
    Description = "Một GUI khi sound được phát, nó sẽ ghi lại | A GUI when sound is played it will record",
    Callback = function()
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/infyiff/backup/main/audiologger.lua"
        ))()
    end
})

Tabs.An:AddButton({
    Title = "Event finder",
    Description = "Một GUI khi sound được phát, nó sẽ ghi lại | A GUI when sound is played it will record",
    Callback = function()
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Other_Script/Event_Finder.lua"
        ))()
    end
})


-- // SETTINGS
Tabs.Settings:AddParagraph({

    Title = "Settings",
    Content = "Không có gì ở đây đâu <3 / Nothing here :>"
})
