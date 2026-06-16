local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local animator = humanoid:WaitForChild("Animator")

player.CharacterAdded:Connect(function(c)
	character = c
	humanoid = c:WaitForChild("Humanoid")
	animator = humanoid:WaitForChild("Animator")
end)

local function round(n, decimals)
	decimals = decimals or 3
	local mult = 10 ^ decimals
	return math.floor(n * mult + 0.5) / mult
end

local function getPlaceName()
	local success, info = pcall(function()
		return MarketplaceService:GetProductInfo(game.PlaceId)
	end)
	if success and info and info.Name then
		return info.Name:gsub("[^%w%s_-]", ""):gsub("%s+", "_")
	else
		return "Place_" .. tostring(game.PlaceId)
	end
end

local function makeDraggable(frame)
	local dragging, dragInput, dragStart, startPos

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

local old = CoreGui:FindFirstChild("AnimDu")
if old then
	old:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "AnimDu"
gui.ResetOnSpawn = false
pcall(function()
	gui.Parent = CoreGui
end)

-- Main panel (smaller)
local frame = Instance.new("Frame")
frame.Name = "Main"
frame.Size = UDim2.new(0, 220, 0, 150)
frame.Position = UDim2.new(0.5, -110, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
makeDraggable(frame)

-- Log panel (smaller)
local logFrame = Instance.new("Frame")
logFrame.Name = "Log"
logFrame.Size = UDim2.new(0, 260, 0, 200)
logFrame.Position = UDim2.new(0.5, 130, 0.5, -75)
logFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
logFrame.Visible = false
logFrame.Active = true
logFrame.Parent = gui
Instance.new("UICorner", logFrame).CornerRadius = UDim.new(0, 8)
makeDraggable(logFrame)

local logTitle = Instance.new("TextLabel")
logTitle.Text = "LOG"
logTitle.TextSize = 12
logTitle.Size = UDim2.new(1, 0, 0, 22)
logTitle.BackgroundTransparency = 1
logTitle.TextColor3 = Color3.new(1, 1, 1)
logTitle.Font = Enum.Font.GothamBold
logTitle.Parent = logFrame

local logScroll = Instance.new("ScrollingFrame")
logScroll.Size = UDim2.new(0.95, 0, 0.85, 0)
logScroll.Position = UDim2.new(0.025, 0, 0.14, 0)
logScroll.BackgroundTransparency = 1
logScroll.BorderSizePixel = 0
logScroll.ScrollBarThickness = 4
logScroll.Parent = logFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = logScroll
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 0)

local function addLog(text, colorType)
	local label = Instance.new("TextLabel")
	label.Text = text
	label.Size = UDim2.new(1, 0, 0, 13)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Code
	label.TextSize = 11
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = logScroll

	if colorType == "red" then
		label.TextColor3 = Color3.fromRGB(255, 80, 80)
	elseif colorType == "green" then
		label.TextColor3 = Color3.fromRGB(80, 255, 120)
	else
		label.TextColor3 = Color3.fromRGB(200, 200, 200)
	end

	logScroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
	logScroll.CanvasPosition = Vector2.new(0, listLayout.AbsoluteContentSize.Y)
end

-- Title (shortened)
local title = Instance.new("TextLabel")
title.Text = "DUMPER"
title.TextSize = 12
title.Size = UDim2.new(1, 0, 0, 24)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Input box
local input = Instance.new("TextBox")
input.Size = UDim2.new(0.9, 0, 0, 32)
input.Position = UDim2.new(0.05, 0, 0.20, 0)
input.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
input.TextColor3 = Color3.new(1, 1, 1)
input.PlaceholderText = "Anim ID"
input.Font = Enum.Font.Gotham
input.TextSize = 13
input.Parent = frame
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)

-- Dump button
local dumpBtn = Instance.new("TextButton")
dumpBtn.Text = "DUMP"
dumpBtn.Size = UDim2.new(0.9, 0, 0, 32)
dumpBtn.Position = UDim2.new(0.05, 0, 0.42, 0)
dumpBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
dumpBtn.TextColor3 = Color3.new(1, 1, 1)
dumpBtn.Font = Enum.Font.GothamBold
dumpBtn.TextSize = 13
dumpBtn.Parent = frame
Instance.new("UICorner", dumpBtn).CornerRadius = UDim.new(0, 6)

-- Stop button
local stopBtn = Instance.new("TextButton")
stopBtn.Text = "STOP"
stopBtn.Size = UDim2.new(0.9, 0, 0, 22)
stopBtn.Position = UDim2.new(0.05, 0, 0.64, 0)
stopBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
stopBtn.TextColor3 = Color3.new(1, 1, 1)
stopBtn.Font = Enum.Font.GothamBold
stopBtn.TextSize = 12
stopBtn.Parent = frame
Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 6)

-- Copy button (outside frame, left side)
local copyBtn = Instance.new("TextButton")
copyBtn.Text = "📋"
copyBtn.TextSize = 12
copyBtn.Size = UDim2.new(0, 60, 0, 26)
copyBtn.Position = UDim2.new(0, -70, 0.50, 0)
copyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
copyBtn.TextColor3 = Color3.new(1, 1, 1)
copyBtn.Font = Enum.Font.GothamBold
copyBtn.Parent = frame
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 6)

-- Export button (outside frame, left side, below copy)
local fileBtn = Instance.new("TextButton")
fileBtn.Text = "💾"
fileBtn.TextSize = 12
fileBtn.Size = UDim2.new(0, 60, 0, 26)
fileBtn.Position = UDim2.new(0, -70, 0.72, 0)
fileBtn.BackgroundColor3 = Color3.fromRGB(160, 90, 230)
fileBtn.TextColor3 = Color3.new(1, 1, 1)
fileBtn.Font = Enum.Font.GothamBold
fileBtn.Parent = frame
Instance.new("UICorner", fileBtn).CornerRadius = UDim.new(0, 6)

-- Close button (smaller)
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "✕"
closeBtn.TextSize = 11
closeBtn.Size = UDim2.new(0, 16, 0, 16)
closeBtn.Position = UDim2.new(1, -20, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = frame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

-- Eye/log toggle button (smaller)
local eyeBtn = Instance.new("TextButton")
eyeBtn.Text = "👁"
eyeBtn.TextSize = 11
eyeBtn.Size = UDim2.new(0, 16, 0, 16)
eyeBtn.Position = UDim2.new(1, -40, 0, 4)
eyeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
eyeBtn.TextColor3 = Color3.new(1, 1, 1)
eyeBtn.Font = Enum.Font.GothamBold
eyeBtn.Parent = frame
Instance.new("UICorner", eyeBtn).CornerRadius = UDim.new(0, 6)

-- Converter toggle button
local convBtn = Instance.new("TextButton")
convBtn.Text = "🔄"
convBtn.TextSize = 11
convBtn.Size = UDim2.new(0, 16, 0, 16)
convBtn.Position = UDim2.new(1, -60, 0, 4)
convBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
convBtn.TextColor3 = Color3.new(1, 1, 1)
convBtn.Font = Enum.Font.GothamBold
convBtn.Parent = frame
Instance.new("UICorner", convBtn).CornerRadius = UDim.new(0, 6)

----------------------------------------------------------------
-- Export customization popup
----------------------------------------------------------------
local exportFrame = Instance.new("Frame")
exportFrame.Name = "ExportPopup"
exportFrame.Size = UDim2.new(0, 240, 0, 366)
exportFrame.Position = UDim2.new(0.5, -120, 0.5, -183)
exportFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
exportFrame.Visible = false
exportFrame.Active = true
exportFrame.ZIndex = 5
exportFrame.Parent = gui
Instance.new("UICorner", exportFrame).CornerRadius = UDim.new(0, 8)
makeDraggable(exportFrame)

local exportTitle = Instance.new("TextLabel")
exportTitle.Text = "EXPORT OPTIONS"
exportTitle.TextSize = 12
exportTitle.Size = UDim2.new(1, -26, 0, 20)
exportTitle.Position = UDim2.new(0, 0, 0, 4)
exportTitle.BackgroundTransparency = 1
exportTitle.TextColor3 = Color3.new(1, 1, 1)
exportTitle.Font = Enum.Font.GothamBold
exportTitle.ZIndex = 5
exportTitle.Parent = exportFrame

-- Help button
local helpBtn = Instance.new("TextButton")
helpBtn.Text = "?"
helpBtn.TextSize = 12
helpBtn.Size = UDim2.new(0, 18, 0, 18)
helpBtn.Position = UDim2.new(1, -22, 0, 4)
helpBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
helpBtn.TextColor3 = Color3.new(1, 1, 1)
helpBtn.Font = Enum.Font.GothamBold
helpBtn.ZIndex = 5
helpBtn.Parent = exportFrame
Instance.new("UICorner", helpBtn).CornerRadius = UDim.new(0, 6)

-- Help info panel (shown to the right of the export popup)
local helpFrame = Instance.new("Frame")
helpFrame.Name = "HelpPanel"
helpFrame.Size = UDim2.new(0, 220, 0, 366)
helpFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
helpFrame.Visible = false
helpFrame.Active = true
helpFrame.ZIndex = 5
helpFrame.Parent = gui
Instance.new("UICorner", helpFrame).CornerRadius = UDim.new(0, 8)
makeDraggable(helpFrame)

local helpTitle = Instance.new("TextLabel")
helpTitle.Text = "OPTIONS INFO"
helpTitle.TextSize = 12
helpTitle.Size = UDim2.new(1, 0, 0, 20)
helpTitle.Position = UDim2.new(0, 0, 0, 4)
helpTitle.BackgroundTransparency = 1
helpTitle.TextColor3 = Color3.new(1, 1, 1)
helpTitle.Font = Enum.Font.GothamBold
helpTitle.ZIndex = 5
helpTitle.Parent = helpFrame

local helpScroll = Instance.new("ScrollingFrame")
helpScroll.Size = UDim2.new(0.9, 0, 1, -30)
helpScroll.Position = UDim2.new(0.05, 0, 0, 26)
helpScroll.BackgroundTransparency = 1
helpScroll.BorderSizePixel = 0
helpScroll.ScrollBarThickness = 4
helpScroll.ZIndex = 5
helpScroll.Parent = helpFrame

local helpText = Instance.new("TextLabel")
helpText.Text =
	"Filename: name of the exported file (without extension).\n\n" ..
	"Ext: file format. .lua/.txt save Lua code, .json saves structured JSON data.\n\n" ..
	"Decimals: number of decimal places for position/rotation values. Higher = more precise, bigger file.\n\n" ..
	"Sample: export every Nth frame. Higher value = smaller file, less smooth playback.\n\n" ..
	"Header/Footer: adds comment lines marking the start/end of the dump. Type custom text to replace the default header.\n\n" ..
	"Folder: if ON, the exported file is saved inside an \"AnimationD\" folder (created automatically). If OFF, the file is saved directly in the workspace root.\n\n" ..
	"Parts: choose which body parts to include in the export. Unchecked parts are skipped.\n\n" ..
	"Converter (🔄): pick a file from your \"AnimationD\" folder and convert it into a KeyframeSequence.\n\n" ..
	"Convert FPS: resamples the animation to a target frame rate (Original = no change). Lower FPS = fewer keyframes (smaller, less smooth).\n\n" ..
	"Loop: sets the KeyframeSequence.Loop property on the result.\n\n" ..
	"Trim Start/End: removes N frames from the beginning/end (useful for cutting startup poses or fixing loops).\n\n" ..
	"Save to: where the converted KeyframeSequence is placed (Workspace, ReplicatedStorage, or Lighting).\n\n" ..
	"Parts (in Convert options): choose which parts to include for this file.\n\n" ..
	"Convert Selected: converts only the highlighted file using the options above.\n\n" ..
	"Convert ALL: converts every file in \"AnimationD\" with the same FPS/Loop/Trim settings, placed in a \"ConvertedAll\" folder."
helpText.TextSize = 12
helpText.Size = UDim2.new(1, 0, 0, 760)
helpText.BackgroundTransparency = 1
helpText.TextColor3 = Color3.fromRGB(220, 220, 220)
helpText.Font = Enum.Font.Gotham
helpText.TextWrapped = true
helpText.TextXAlignment = Enum.TextXAlignment.Left
helpText.TextYAlignment = Enum.TextYAlignment.Top
helpText.ZIndex = 5
helpText.Parent = helpScroll

helpScroll.CanvasSize = UDim2.new(0, 0, 0, 770)

----------------------------------------------------------------
-- Converter panel (file -> KeyframeSequence)
----------------------------------------------------------------
local convFrame = Instance.new("Frame")
convFrame.Name = "ConverterPanel"
convFrame.Size = UDim2.new(0, 220, 0, 260)
convFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
convFrame.Visible = false
convFrame.Active = true
convFrame.ZIndex = 5
convFrame.Parent = gui
Instance.new("UICorner", convFrame).CornerRadius = UDim.new(0, 8)
makeDraggable(convFrame)

local convTitle = Instance.new("TextLabel")
convTitle.Text = "CONVERT TO KEYFRAMESEQUENCE"
convTitle.TextSize = 11
convTitle.Size = UDim2.new(1, 0, 0, 20)
convTitle.Position = UDim2.new(0, 0, 0, 4)
convTitle.BackgroundTransparency = 1
convTitle.TextColor3 = Color3.new(1, 1, 1)
convTitle.Font = Enum.Font.GothamBold
convTitle.ZIndex = 5
convTitle.Parent = convFrame

-- Back button (navigate to parent folder)
local convBackBtn = Instance.new("TextButton")
convBackBtn.Text = "⬅️"
convBackBtn.TextSize = 11
convBackBtn.Size = UDim2.new(0, 22, 0, 16)
convBackBtn.Position = UDim2.new(0.05, 0, 0, 26)
convBackBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
convBackBtn.TextColor3 = Color3.new(1, 1, 1)
convBackBtn.Font = Enum.Font.GothamBold
convBackBtn.Visible = false
convBackBtn.ZIndex = 5
convBackBtn.Parent = convFrame
Instance.new("UICorner", convBackBtn).CornerRadius = UDim.new(0, 6)

local convSubLabel = Instance.new("TextLabel")
convSubLabel.Text = "AnimationD/"
convSubLabel.TextSize = 11
convSubLabel.Size = UDim2.new(0.9, -26, 0, 14)
convSubLabel.Position = UDim2.new(0.05, 26, 0, 28)
convSubLabel.BackgroundTransparency = 1
convSubLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
convSubLabel.Font = Enum.Font.Gotham
convSubLabel.TextXAlignment = Enum.TextXAlignment.Left
convSubLabel.TextTruncate = Enum.TextTruncate.AtEnd
convSubLabel.ZIndex = 5
convSubLabel.Parent = convFrame

-- File list (scrollable)
local convScroll = Instance.new("ScrollingFrame")
convScroll.Size = UDim2.new(0.9, 0, 0, 160)
convScroll.Position = UDim2.new(0.05, 0, 0, 44)
convScroll.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
convScroll.BorderSizePixel = 0
convScroll.ScrollBarThickness = 4
convScroll.ZIndex = 5
convScroll.Parent = convFrame
Instance.new("UICorner", convScroll).CornerRadius = UDim.new(0, 6)

local convListLayout = Instance.new("UIListLayout")
convListLayout.Parent = convScroll
convListLayout.SortOrder = Enum.SortOrder.Name
convListLayout.Padding = UDim.new(0, 2)

-- Convert button (opens options popup)
local convertBtn = Instance.new("TextButton")
convertBtn.Text = "Convert..."
convertBtn.Size = UDim2.new(0.9, 0, 0, 28)
convertBtn.Position = UDim2.new(0.05, 0, 0, 210)
convertBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
convertBtn.TextColor3 = Color3.new(1, 1, 1)
convertBtn.Font = Enum.Font.GothamBold
convertBtn.TextSize = 12
convertBtn.ZIndex = 5
convertBtn.Parent = convFrame
Instance.new("UICorner", convertBtn).CornerRadius = UDim.new(0, 6)

-- Close converter button
local convCloseBtn = Instance.new("TextButton")
convCloseBtn.Text = "✕"
convCloseBtn.TextSize = 11
convCloseBtn.Size = UDim2.new(0, 16, 0, 16)
convCloseBtn.Position = UDim2.new(1, -20, 0, 4)
convCloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
convCloseBtn.TextColor3 = Color3.new(1, 1, 1)
convCloseBtn.Font = Enum.Font.GothamBold
convCloseBtn.ZIndex = 5
convCloseBtn.Parent = convFrame
Instance.new("UICorner", convCloseBtn).CornerRadius = UDim.new(0, 6)

----------------------------------------------------------------
-- Convert options popup
----------------------------------------------------------------
local convOptFrame = Instance.new("Frame")
convOptFrame.Name = "ConvertOptions"
convOptFrame.Size = UDim2.new(0, 240, 0, 380)
convOptFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
convOptFrame.Visible = false
convOptFrame.Active = true
convOptFrame.ZIndex = 6
convOptFrame.Parent = gui
Instance.new("UICorner", convOptFrame).CornerRadius = UDim.new(0, 8)
makeDraggable(convOptFrame)

local convOptTitle = Instance.new("TextLabel")
convOptTitle.Text = "CONVERT OPTIONS"
convOptTitle.TextSize = 12
convOptTitle.Size = UDim2.new(1, -26, 0, 20)
convOptTitle.Position = UDim2.new(0, 0, 0, 4)
convOptTitle.BackgroundTransparency = 1
convOptTitle.TextColor3 = Color3.new(1, 1, 1)
convOptTitle.Font = Enum.Font.GothamBold
convOptTitle.ZIndex = 6
convOptTitle.Parent = convOptFrame

-- Small "X" close/cancel button (top-right corner)
local convOptXBtn = Instance.new("TextButton")
convOptXBtn.Text = "X"
convOptXBtn.TextSize = 12
convOptXBtn.Size = UDim2.new(0, 18, 0, 18)
convOptXBtn.Position = UDim2.new(1, -22, 0, 4)
convOptXBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
convOptXBtn.TextColor3 = Color3.new(1, 1, 1)
convOptXBtn.Font = Enum.Font.GothamBold
convOptXBtn.ZIndex = 6
convOptXBtn.Parent = convOptFrame
Instance.new("UICorner", convOptXBtn).CornerRadius = UDim.new(0, 6)

local convOptFileLabel = Instance.new("TextLabel")
convOptFileLabel.Text = ""
convOptFileLabel.TextSize = 10
convOptFileLabel.Size = UDim2.new(0.9, 0, 0, 14)
convOptFileLabel.Position = UDim2.new(0.05, 0, 0, 24)
convOptFileLabel.BackgroundTransparency = 1
convOptFileLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
convOptFileLabel.Font = Enum.Font.Gotham
convOptFileLabel.TextXAlignment = Enum.TextXAlignment.Left
convOptFileLabel.TextTruncate = Enum.TextTruncate.AtEnd
convOptFileLabel.ZIndex = 6
convOptFileLabel.Parent = convOptFrame

-- FPS / resample cycle button
local fpsBtn = Instance.new("TextButton")
fpsBtn.TextSize = 12
fpsBtn.Size = UDim2.new(0.9, 0, 0, 22)
fpsBtn.Position = UDim2.new(0.05, 0, 0, 42)
fpsBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
fpsBtn.TextColor3 = Color3.new(1, 1, 1)
fpsBtn.Font = Enum.Font.Gotham
fpsBtn.ZIndex = 6
fpsBtn.Parent = convOptFrame
Instance.new("UICorner", fpsBtn).CornerRadius = UDim.new(0, 6)

-- Loop toggle button
local loopBtn = Instance.new("TextButton")
loopBtn.TextSize = 12
loopBtn.Size = UDim2.new(0.9, 0, 0, 22)
loopBtn.Position = UDim2.new(0.05, 0, 0, 66)
loopBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
loopBtn.TextColor3 = Color3.new(1, 1, 1)
loopBtn.Font = Enum.Font.Gotham
loopBtn.ZIndex = 6
loopBtn.Parent = convOptFrame
Instance.new("UICorner", loopBtn).CornerRadius = UDim.new(0, 6)

-- Trim start cycle button
local trimStartBtn = Instance.new("TextButton")
trimStartBtn.TextSize = 12
trimStartBtn.Size = UDim2.new(0.9, 0, 0, 22)
trimStartBtn.Position = UDim2.new(0.05, 0, 0, 90)
trimStartBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
trimStartBtn.TextColor3 = Color3.new(1, 1, 1)
trimStartBtn.Font = Enum.Font.Gotham
trimStartBtn.ZIndex = 6
trimStartBtn.Parent = convOptFrame
Instance.new("UICorner", trimStartBtn).CornerRadius = UDim.new(0, 6)

-- Trim end cycle button
local trimEndBtn = Instance.new("TextButton")
trimEndBtn.TextSize = 12
trimEndBtn.Size = UDim2.new(0.9, 0, 0, 22)
trimEndBtn.Position = UDim2.new(0.05, 0, 0, 114)
trimEndBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
trimEndBtn.TextColor3 = Color3.new(1, 1, 1)
trimEndBtn.Font = Enum.Font.Gotham
trimEndBtn.ZIndex = 6
trimEndBtn.Parent = convOptFrame
Instance.new("UICorner", trimEndBtn).CornerRadius = UDim.new(0, 6)

-- Destination cycle button
local destBtn = Instance.new("TextButton")
destBtn.TextSize = 12
destBtn.Size = UDim2.new(0.9, 0, 0, 22)
destBtn.Position = UDim2.new(0.05, 0, 0, 138)
destBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
destBtn.TextColor3 = Color3.new(1, 1, 1)
destBtn.Font = Enum.Font.Gotham
destBtn.ZIndex = 6
destBtn.Parent = convOptFrame
Instance.new("UICorner", destBtn).CornerRadius = UDim.new(0, 6)

-- Parts label
local convPartsLabel = Instance.new("TextLabel")
convPartsLabel.Text = "Parts:"
convPartsLabel.TextSize = 11
convPartsLabel.Size = UDim2.new(0.9, 0, 0, 14)
convPartsLabel.Position = UDim2.new(0.05, 0, 0, 164)
convPartsLabel.BackgroundTransparency = 1
convPartsLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
convPartsLabel.Font = Enum.Font.Gotham
convPartsLabel.TextXAlignment = Enum.TextXAlignment.Left
convPartsLabel.ZIndex = 6
convPartsLabel.Parent = convOptFrame

-- Parts scroll list (checkboxes)
local convPartsScroll = Instance.new("ScrollingFrame")
convPartsScroll.Size = UDim2.new(0.9, 0, 0, 80)
convPartsScroll.Position = UDim2.new(0.05, 0, 0, 180)
convPartsScroll.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
convPartsScroll.BorderSizePixel = 0
convPartsScroll.ScrollBarThickness = 4
convPartsScroll.ZIndex = 6
convPartsScroll.Parent = convOptFrame
Instance.new("UICorner", convPartsScroll).CornerRadius = UDim.new(0, 6)

local convPartsListLayout = Instance.new("UIListLayout")
convPartsListLayout.Parent = convPartsScroll
convPartsListLayout.SortOrder = Enum.SortOrder.Name
convPartsListLayout.Padding = UDim.new(0, 2)

-- Convert selected (apply options to the chosen file)
local convOptOkBtn = Instance.new("TextButton")
convOptOkBtn.Text = "Convert Selected"
convOptOkBtn.Size = UDim2.new(0.9, 0, 0, 28)
convOptOkBtn.Position = UDim2.new(0.05, 0, 0, 266)
convOptOkBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
convOptOkBtn.TextColor3 = Color3.new(1, 1, 1)
convOptOkBtn.Font = Enum.Font.GothamBold
convOptOkBtn.TextSize = 12
convOptOkBtn.ZIndex = 6
convOptOkBtn.Parent = convOptFrame
Instance.new("UICorner", convOptOkBtn).CornerRadius = UDim.new(0, 6)

-- Convert ALL (apply options to every file in the list), placed below
local convOptAllBtn = Instance.new("TextButton")
convOptAllBtn.Text = "Convert ALL"
convOptAllBtn.Size = UDim2.new(0.9, 0, 0, 28)
convOptAllBtn.Position = UDim2.new(0.05, 0, 0, 298)
convOptAllBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
convOptAllBtn.TextColor3 = Color3.new(1, 1, 1)
convOptAllBtn.Font = Enum.Font.GothamBold
convOptAllBtn.TextSize = 12
convOptAllBtn.ZIndex = 6
convOptAllBtn.Parent = convOptFrame
Instance.new("UICorner", convOptAllBtn).CornerRadius = UDim.new(0, 6)

-- Cancel
local convOptCancelBtn = Instance.new("TextButton")
convOptCancelBtn.Text = "Cancel"
convOptCancelBtn.Size = UDim2.new(0.9, 0, 0, 26)
convOptCancelBtn.Position = UDim2.new(0.05, 0, 0, 330)
convOptCancelBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
convOptCancelBtn.TextColor3 = Color3.new(1, 1, 1)
convOptCancelBtn.Font = Enum.Font.GothamBold
convOptCancelBtn.TextSize = 12
convOptCancelBtn.ZIndex = 6
convOptCancelBtn.Parent = convOptFrame
Instance.new("UICorner", convOptCancelBtn).CornerRadius = UDim.new(0, 6)

-- Filename
local exportNameBox = Instance.new("TextBox")
exportNameBox.Size = UDim2.new(0.9, 0, 0, 26)
exportNameBox.Position = UDim2.new(0.05, 0, 0, 26)
exportNameBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
exportNameBox.TextColor3 = Color3.new(1, 1, 1)
exportNameBox.Font = Enum.Font.Gotham
exportNameBox.TextSize = 12
exportNameBox.ClearTextOnFocus = false
exportNameBox.ZIndex = 5
exportNameBox.Parent = exportFrame
Instance.new("UICorner", exportNameBox).CornerRadius = UDim.new(0, 6)

-- Extension cycle button
local extBtn = Instance.new("TextButton")
extBtn.TextSize = 12
extBtn.Size = UDim2.new(0.9, 0, 0, 22)
extBtn.Position = UDim2.new(0.05, 0, 0, 56)
extBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
extBtn.TextColor3 = Color3.new(1, 1, 1)
extBtn.Font = Enum.Font.Gotham
extBtn.ZIndex = 5
extBtn.Parent = exportFrame
Instance.new("UICorner", extBtn).CornerRadius = UDim.new(0, 6)

-- Decimal precision cycle button
local precBtn = Instance.new("TextButton")
precBtn.TextSize = 12
precBtn.Size = UDim2.new(0.9, 0, 0, 22)
precBtn.Position = UDim2.new(0.05, 0, 0, 80)
precBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
precBtn.TextColor3 = Color3.new(1, 1, 1)
precBtn.Font = Enum.Font.Gotham
precBtn.ZIndex = 5
precBtn.Parent = exportFrame
Instance.new("UICorner", precBtn).CornerRadius = UDim.new(0, 6)

-- Skip frame cycle button
local skipBtn = Instance.new("TextButton")
skipBtn.TextSize = 12
skipBtn.Size = UDim2.new(0.9, 0, 0, 22)
skipBtn.Position = UDim2.new(0.05, 0, 0, 104)
skipBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
skipBtn.TextColor3 = Color3.new(1, 1, 1)
skipBtn.Font = Enum.Font.Gotham
skipBtn.ZIndex = 5
skipBtn.Parent = exportFrame
Instance.new("UICorner", skipBtn).CornerRadius = UDim.new(0, 6)

-- Header toggle button
local headerBtn = Instance.new("TextButton")
headerBtn.TextSize = 12
headerBtn.Size = UDim2.new(0.9, 0, 0, 22)
headerBtn.Position = UDim2.new(0.05, 0, 0, 128)
headerBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
headerBtn.TextColor3 = Color3.new(1, 1, 1)
headerBtn.Font = Enum.Font.Gotham
headerBtn.ZIndex = 5
headerBtn.Parent = exportFrame
Instance.new("UICorner", headerBtn).CornerRadius = UDim.new(0, 6)

-- Custom header text box
local headerTextBox = Instance.new("TextBox")
headerTextBox.Size = UDim2.new(0.9, 0, 0, 24)
headerTextBox.Position = UDim2.new(0.05, 0, 0, 154)
headerTextBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
headerTextBox.TextColor3 = Color3.new(1, 1, 1)
headerTextBox.PlaceholderText = "Custom header (optional)"
headerTextBox.Font = Enum.Font.Gotham
headerTextBox.TextSize = 11
headerTextBox.ClearTextOnFocus = false
headerTextBox.ZIndex = 5
headerTextBox.Parent = exportFrame
Instance.new("UICorner", headerTextBox).CornerRadius = UDim.new(0, 6)

-- Folder toggle button
local folderBtn = Instance.new("TextButton")
folderBtn.TextSize = 12
folderBtn.Size = UDim2.new(0.9, 0, 0, 22)
folderBtn.Position = UDim2.new(0.05, 0, 0, 182)
folderBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
folderBtn.TextColor3 = Color3.new(1, 1, 1)
folderBtn.Font = Enum.Font.Gotham
folderBtn.ZIndex = 5
folderBtn.Parent = exportFrame
Instance.new("UICorner", folderBtn).CornerRadius = UDim.new(0, 6)

-- Parts label
local partsLabel = Instance.new("TextLabel")
partsLabel.Text = "Parts:"
partsLabel.TextSize = 11
partsLabel.Size = UDim2.new(0.9, 0, 0, 14)
partsLabel.Position = UDim2.new(0.05, 0, 0, 208)
partsLabel.BackgroundTransparency = 1
partsLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
partsLabel.Font = Enum.Font.Gotham
partsLabel.TextXAlignment = Enum.TextXAlignment.Left
partsLabel.ZIndex = 5
partsLabel.Parent = exportFrame

-- Parts scroll list (checkboxes)
local partsScroll = Instance.new("ScrollingFrame")
partsScroll.Size = UDim2.new(0.9, 0, 0, 80)
partsScroll.Position = UDim2.new(0.05, 0, 0, 224)
partsScroll.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
partsScroll.BorderSizePixel = 0
partsScroll.ScrollBarThickness = 4
partsScroll.ZIndex = 5
partsScroll.Parent = exportFrame
Instance.new("UICorner", partsScroll).CornerRadius = UDim.new(0, 6)

local partsListLayout = Instance.new("UIListLayout")
partsListLayout.Parent = partsScroll
partsListLayout.SortOrder = Enum.SortOrder.Name
partsListLayout.Padding = UDim.new(0, 2)

-- OK / Cancel
local exportOkBtn = Instance.new("TextButton")
exportOkBtn.Text = "OK"
exportOkBtn.Size = UDim2.new(0.43, 0, 0, 28)
exportOkBtn.Position = UDim2.new(0.05, 0, 0, 326)
exportOkBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
exportOkBtn.TextColor3 = Color3.new(1, 1, 1)
exportOkBtn.Font = Enum.Font.GothamBold
exportOkBtn.TextSize = 12
exportOkBtn.ZIndex = 5
exportOkBtn.Parent = exportFrame
Instance.new("UICorner", exportOkBtn).CornerRadius = UDim.new(0, 6)

local exportCancelBtn = Instance.new("TextButton")
exportCancelBtn.Text = "Cancel"
exportCancelBtn.Size = UDim2.new(0.43, 0, 0, 28)
exportCancelBtn.Position = UDim2.new(0.52, 0, 0, 326)
exportCancelBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
exportCancelBtn.TextColor3 = Color3.new(1, 1, 1)
exportCancelBtn.Font = Enum.Font.GothamBold
exportCancelBtn.TextSize = 12
exportCancelBtn.ZIndex = 5
exportCancelBtn.Parent = exportFrame
Instance.new("UICorner", exportCancelBtn).CornerRadius = UDim.new(0, 6)

----------------------------------------------------------------
-- State
----------------------------------------------------------------
local dumping = false
local stopped = false
local dumpData = {}
local lastId = ""
local lastHierarchy = {} -- childPartName -> parentPartName (from Motor6D Part1 -> Part0)
local currentTrack = nil
local activeConn = nil
local startTime = 0

-- Export option state
local extOptions = { ".lua", ".txt", ".json" }
local extIndex = 1

local precOptions = { 1, 2, 3, 4 }
local precIndex = 3 -- default 3 decimals

local skipOptions = { 1, 2, 3, 5, 10 }
local skipIndex = 1

local headerOn = true
local folderOn = true
local selectedParts = {} -- partName -> bool

-- Converter state
local selectedConvFile = nil
local pendingFrames = nil
local pendingHierarchy = nil

local convFpsOptions = { 0, 60, 30, 24, 15, 10, 5 } -- 0 = original (no resample)
local convFpsIndex = 1

local convTrimOptions = { 0, 1, 2, 3, 5, 10 }
local convTrimStartIndex = 1
local convTrimEndIndex = 1

local convLoopOn = false

local convDestOptions = { "Workspace", "ReplicatedStorage", "Lighting" }
local convDestIndex = 1

local convSelectedParts = {} -- partName -> bool (for the selected file)

local function refreshExtBtn()
	extBtn.Text = "Ext: " .. extOptions[extIndex]
end

local function refreshPrecBtn()
	precBtn.Text = "Decimals: " .. tostring(precOptions[precIndex])
end

local function refreshSkipBtn()
	local v = skipOptions[skipIndex]
	if v == 1 then
		skipBtn.Text = "Sample: every frame"
	else
		skipBtn.Text = "Sample: every " .. v .. " frames"
	end
end

local function refreshHeaderBtn()
	headerBtn.Text = "Header/Footer: " .. (headerOn and "ON" or "OFF")
end

local function refreshFolderBtn()
	folderBtn.Text = "Folder \"AnimationD\": " .. (folderOn and "ON" or "OFF")
end

local function refreshFpsBtn()
	local v = convFpsOptions[convFpsIndex]
	if v == 0 then
		fpsBtn.Text = "FPS: Original"
	else
		fpsBtn.Text = "FPS: " .. v
	end
end

local function refreshLoopBtn()
	loopBtn.Text = "Loop: " .. (convLoopOn and "ON" or "OFF")
end

local function refreshTrimStartBtn()
	trimStartBtn.Text = "Trim Start: -" .. tostring(convTrimOptions[convTrimStartIndex]) .. " frames"
end

local function refreshTrimEndBtn()
	trimEndBtn.Text = "Trim End: -" .. tostring(convTrimOptions[convTrimEndIndex]) .. " frames"
end

local function refreshDestBtn()
	destBtn.Text = "Save to: " .. convDestOptions[convDestIndex]
end

refreshExtBtn()
refreshPrecBtn()
refreshSkipBtn()
refreshHeaderBtn()
refreshFolderBtn()
refreshFpsBtn()
refreshLoopBtn()
refreshTrimStartBtn()
refreshTrimEndBtn()
refreshDestBtn()

extBtn.MouseButton1Click:Connect(function()
	extIndex = extIndex + 1
	if extIndex > #extOptions then
		extIndex = 1
	end
	refreshExtBtn()
end)

precBtn.MouseButton1Click:Connect(function()
	precIndex = precIndex + 1
	if precIndex > #precOptions then
		precIndex = 1
	end
	refreshPrecBtn()
end)

skipBtn.MouseButton1Click:Connect(function()
	skipIndex = skipIndex + 1
	if skipIndex > #skipOptions then
		skipIndex = 1
	end
	refreshSkipBtn()
end)

headerBtn.MouseButton1Click:Connect(function()
	headerOn = not headerOn
	refreshHeaderBtn()
end)

folderBtn.MouseButton1Click:Connect(function()
	folderOn = not folderOn
	refreshFolderBtn()
end)

fpsBtn.MouseButton1Click:Connect(function()
	convFpsIndex = convFpsIndex + 1
	if convFpsIndex > #convFpsOptions then
		convFpsIndex = 1
	end
	refreshFpsBtn()
end)

loopBtn.MouseButton1Click:Connect(function()
	convLoopOn = not convLoopOn
	refreshLoopBtn()
end)

trimStartBtn.MouseButton1Click:Connect(function()
	convTrimStartIndex = convTrimStartIndex + 1
	if convTrimStartIndex > #convTrimOptions then
		convTrimStartIndex = 1
	end
	refreshTrimStartBtn()
end)

trimEndBtn.MouseButton1Click:Connect(function()
	convTrimEndIndex = convTrimEndIndex + 1
	if convTrimEndIndex > #convTrimOptions then
		convTrimEndIndex = 1
	end
	refreshTrimEndBtn()
end)

destBtn.MouseButton1Click:Connect(function()
	convDestIndex = convDestIndex + 1
	if convDestIndex > #convDestOptions then
		convDestIndex = 1
	end
	refreshDestBtn()
end)

-- Build the parts checkbox list from the latest dump
local function refreshPartsList()
	for _, child in ipairs(partsScroll:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	if #dumpData == 0 then
		partsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
		return
	end

	local names = {}
	for part, _ in pairs(dumpData[1].Poses) do
		names[#names + 1] = part
		if selectedParts[part] == nil then
			selectedParts[part] = true
		end
	end
	table.sort(names)

	for _, name in ipairs(names) do
		local btn = Instance.new("TextButton")
		btn.Name = name
		btn.Text = (selectedParts[name] and "[x] " or "[ ] ") .. name
		btn.Size = UDim2.new(1, 0, 0, 18)
		btn.BackgroundColor3 = selectedParts[name] and Color3.fromRGB(0, 110, 60) or Color3.fromRGB(50, 50, 50)
		btn.TextColor3 = Color3.new(1, 1, 1)
		btn.Font = Enum.Font.Gotham
		btn.TextSize = 11
		btn.TextXAlignment = Enum.TextXAlignment.Left
		btn.ZIndex = 5
		btn.Parent = partsScroll

		btn.MouseButton1Click:Connect(function()
			selectedParts[name] = not selectedParts[name]
			btn.Text = (selectedParts[name] and "[x] " or "[ ] ") .. name
			btn.BackgroundColor3 = selectedParts[name] and Color3.fromRGB(0, 110, 60) or Color3.fromRGB(50, 50, 50)
		end)
	end

	partsScroll.CanvasSize = UDim2.new(0, 0, 0, partsListLayout.AbsoluteContentSize.Y + 4)
end

local function getAllPartsSet()
	local set = {}
	if #dumpData > 0 then
		for part, _ in pairs(dumpData[1].Poses) do
			set[part] = true
		end
	end
	return set
end

----------------------------------------------------------------
-- Converter helpers
----------------------------------------------------------------

-- Navigation state
local convCurrentPath = "AnimationD"
local convPathStack = {} -- stack of previous paths for back navigation

local function convMakeLabel(text, color)
	local lbl = Instance.new("TextLabel")
	lbl.Text = text
	lbl.Size = UDim2.new(1, 0, 0, 18)
	lbl.BackgroundTransparency = 1
	lbl.TextColor3 = color or Color3.fromRGB(200, 200, 200)
	lbl.Font = Enum.Font.Gotham
	lbl.TextSize = 11
	lbl.ZIndex = 5
	lbl.Parent = convScroll
	convScroll.CanvasSize = UDim2.new(0, 0, 0, 20)
end

-- Refreshes the file/folder list for convCurrentPath
local function refreshConvList()
	for _, child in ipairs(convScroll:GetChildren()) do
		if child:IsA("TextButton") or child:IsA("TextLabel") then
			child:Destroy()
		end
	end
	selectedConvFile = nil

	-- Update path label and back button
	convSubLabel.Text = convCurrentPath .. "/"
	convBackBtn.Visible = #convPathStack > 0

	if not (isfolder and listfiles) then
		convMakeLabel("Filesystem not supported", Color3.fromRGB(255, 120, 120))
		return
	end

	if not isfolder(convCurrentPath) then
		convMakeLabel('"' .. convCurrentPath .. '" not found', Color3.fromRGB(255, 120, 120))
		return
	end

	local entries = listfiles(convCurrentPath)
	if #entries == 0 then
		convMakeLabel("(empty folder)", Color3.fromRGB(150, 150, 150))
		return
	end

	-- Separate folders and files, sort each group
	local folders = {}
	local files = {}
	for _, path in ipairs(entries) do
		local name = path:match("([^/\\]+)$") or path
		if isfolder(path) then
			folders[#folders + 1] = { name = name, path = path }
		else
			files[#files + 1] = { name = name, path = path }
		end
	end
	table.sort(folders, function(a, b) return a.name < b.name end)
	table.sort(files,   function(a, b) return a.name < b.name end)

	local function makeRow(name, path, isDir)
		local btn = Instance.new("TextButton")
		btn.Name = name
		btn.Text = (isDir and "📁 " or "   ") .. name
		btn.Size = UDim2.new(1, 0, 0, 18)
		btn.BackgroundColor3 = isDir and Color3.fromRGB(60, 50, 20) or Color3.fromRGB(50, 50, 50)
		btn.TextColor3 = isDir and Color3.fromRGB(255, 210, 100) or Color3.new(1, 1, 1)
		btn.Font = Enum.Font.Gotham
		btn.TextSize = 11
		btn.TextXAlignment = Enum.TextXAlignment.Left
		btn.ZIndex = 5
		btn.Parent = convScroll

		btn.MouseButton1Click:Connect(function()
			if isDir then
				-- Navigate into folder
				convPathStack[#convPathStack + 1] = convCurrentPath
				convCurrentPath = path
				refreshConvList()
			else
				-- Select file
				selectedConvFile = path
				for _, c in ipairs(convScroll:GetChildren()) do
					if c:IsA("TextButton") then
						c.BackgroundColor3 = isfolder(c.Name == name and path or convCurrentPath .. "/" .. c.Name)
							and Color3.fromRGB(60, 50, 20)
							or Color3.fromRGB(50, 50, 50)
					end
				end
				btn.BackgroundColor3 = Color3.fromRGB(0, 110, 60)
			end
		end)
	end

	for _, e in ipairs(folders) do makeRow(e.name, e.path, true) end
	for _, e in ipairs(files)   do makeRow(e.name, e.path, false) end

	convScroll.CanvasSize = UDim2.new(0, 0, 0, convListLayout.AbsoluteContentSize.Y + 4)
end

-- Builds the parts checkbox list inside the convert options popup,
-- based on the parts present in the selected file's first frame.
local function refreshConvPartsList(frames)
	for _, child in ipairs(convPartsScroll:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
	convSelectedParts = {}

	if not frames or #frames == 0 then
		convPartsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
		return
	end

	local names = {}
	for part, _ in pairs(frames[1].poses) do
		names[#names + 1] = part
		convSelectedParts[part] = true
	end
	table.sort(names)

	for _, name in ipairs(names) do
		local btn = Instance.new("TextButton")
		btn.Name = name
		btn.Text = "[x] " .. name
		btn.Size = UDim2.new(1, 0, 0, 18)
		btn.BackgroundColor3 = Color3.fromRGB(0, 110, 60)
		btn.TextColor3 = Color3.new(1, 1, 1)
		btn.Font = Enum.Font.Gotham
		btn.TextSize = 11
		btn.TextXAlignment = Enum.TextXAlignment.Left
		btn.ZIndex = 6
		btn.Parent = convPartsScroll

		btn.MouseButton1Click:Connect(function()
			convSelectedParts[name] = not convSelectedParts[name]
			btn.Text = (convSelectedParts[name] and "[x] " or "[ ] ") .. name
			btn.BackgroundColor3 = convSelectedParts[name] and Color3.fromRGB(0, 110, 60) or Color3.fromRGB(50, 50, 50)
		end)
	end

	convPartsScroll.CanvasSize = UDim2.new(0, 0, 0, convPartsListLayout.AbsoluteContentSize.Y + 4)
end

-- Extracts a CFrame from a string of the form
-- "CFrame.new(x,y,z) * CFrame.Angles(rx,ry,rz)"
local function parsePoseString(str)
	local posStr = str:match("CFrame%.new%(([^%)]*)%)")
	local rotStr = str:match("CFrame%.Angles%(([^%)]*)%)")
	if not posStr or not rotStr then
		return nil
	end

	local nums = {}
	for n in posStr:gmatch("[%-%d%.]+") do
		nums[#nums + 1] = tonumber(n)
	end

	local rnums = {}
	for n in rotStr:gmatch("[%-%d%.]+") do
		rnums[#rnums + 1] = tonumber(n)
	end

	if #nums < 3 or #rnums < 3 then
		return nil
	end

	return CFrame.new(nums[1], nums[2], nums[3]) * CFrame.Angles(rnums[1], rnums[2], rnums[3])
end

-- Reads and parses a dump file (.lua/.txt or .json) into a sorted
-- array of frames: { {time = number, poses = {part = CFrame, ...}}, ... }
-- and a hierarchy table: { childPartName = parentPartName, ... }
local function parseDumpFile(path)
	local okRead, content = pcall(readfile, path)
	if not okRead or not content or content == "" then
		return nil, nil, "Could not read file"
	end

	local isJson = path:lower():match("%.json$") ~= nil

	if isJson then
		local okDecode, data = pcall(function()
			return HttpService:JSONDecode(content)
		end)
		if not okDecode or not data or not data.frames then
			return nil, nil, "Invalid JSON"
		end

		local frames = {}
		for _, f in ipairs(data.frames) do
			local poses = {}
			for part, p in pairs(f.poses or {}) do
				if p.pos and p.rot then
					poses[part] = CFrame.new(p.pos[1], p.pos[2], p.pos[3])
						* CFrame.Angles(p.rot[1], p.rot[2], p.rot[3])
				end
			end
			frames[#frames + 1] = { time = tonumber(f.time) or 0, poses = poses }
		end

		table.sort(frames, function(a, b)
			return a.time < b.time
		end)

		if #frames == 0 then
			return nil, nil, "No frames found"
		end
		return frames, data.hierarchy or {}
	end

	-- .lua / .txt format: "<time>s : <part> = CFrame.new(...) * CFrame.Angles(...)"
	local framesMap = {}
	local order = {}
	local hierarchy = {}

	for line in content:gmatch("[^\r\n]+") do
		-- Hierarchy lines: "-- H:Child=Parent"
		local childName, parentName = line:match("^%-%-%s*H:(%S+)=(%S+)%s*$")
		if childName and parentName then
			hierarchy[childName] = parentName
		elseif not line:match("^%s*%-%-") then
			local timeStr, part, rest = line:match("^%s*([%d%.]+)s%s*:%s*(.-)%s*=%s*(.+)$")
			if timeStr and part and rest then
				local cf = parsePoseString(rest)
				if cf then
					local t = tonumber(timeStr)
					if not framesMap[t] then
						framesMap[t] = { time = t, poses = {} }
						order[#order + 1] = t
					end
					framesMap[t].poses[part] = cf
				end
			end
		end
	end

	if #order == 0 then
		return nil, nil, "No frames found"
	end

	table.sort(order)

	local frames = {}
	for _, t in ipairs(order) do
		frames[#frames + 1] = framesMap[t]
	end

	return frames, hierarchy
end

-- Default rig hierarchies (childPartName -> parentPartName) used as a
-- fallback for older dump files that don't embed hierarchy info.
local DEFAULT_HIERARCHY_R6 = {
	Torso = "HumanoidRootPart",
	Head = "Torso",
	Left_Arm = "Torso",
	Right_Arm = "Torso",
	Left_Leg = "Torso",
	Right_Leg = "Torso",
	["Left Arm"] = "Torso",
	["Right Arm"] = "Torso",
	["Left Leg"] = "Torso",
	["Right Leg"] = "Torso",
}

local DEFAULT_HIERARCHY_R15 = {
	LowerTorso = "HumanoidRootPart",
	UpperTorso = "LowerTorso",
	Head = "UpperTorso",
	LeftUpperArm = "UpperTorso",
	LeftLowerArm = "LeftUpperArm",
	LeftHand = "LeftLowerArm",
	RightUpperArm = "UpperTorso",
	RightLowerArm = "RightUpperArm",
	RightHand = "RightLowerArm",
	LeftUpperLeg = "LowerTorso",
	LeftLowerLeg = "LeftUpperLeg",
	LeftFoot = "LeftLowerLeg",
	RightUpperLeg = "LowerTorso",
	RightLowerLeg = "RightUpperLeg",
	RightFoot = "RightLowerLeg",
}

-- Builds a KeyframeSequence Instance from parsed frame data, rebuilding
-- the Pose hierarchy (HumanoidRootPart -> Torso/limbs, etc.) so the
-- animation plays back correctly on the rig, including arms and legs.
local function buildKeyframeSequence(frames, hierarchy, name)
	-- Merge: defaults (based on detected rig) <- embedded hierarchy (overrides)
	local sample = (frames[1] and frames[1].poses) or {}
	local defaults = sample["LowerTorso"] and DEFAULT_HIERARCHY_R15 or DEFAULT_HIERARCHY_R6

	local merged = {}
	for child, parent in pairs(defaults) do
		merged[child] = parent
	end
	if hierarchy then
		for child, parent in pairs(hierarchy) do
			merged[child] = parent
		end
	end

	-- Build parent -> children map
	local childrenMap = {}
	local isChild = {}
	for child, parent in pairs(merged) do
		childrenMap[parent] = childrenMap[parent] or {}
		table.insert(childrenMap[parent], child)
		isChild[child] = true
	end

	-- Determine root part (referenced as a parent but never as a child)
	local root = "HumanoidRootPart"
	if not childrenMap[root] then
		for parent, _ in pairs(childrenMap) do
			if not isChild[parent] then
				root = parent
				break
			end
		end
	end

	local kfs = Instance.new("KeyframeSequence")
	kfs.Name = name
	kfs.Loop = false

	for _, f in ipairs(frames) do
		local kf = Instance.new("Keyframe")
		kf.Name = "Keyframe"
		kf.Time = f.time

		local created = {}

		local function createPose(partName, parentInstance)
			local pose = Instance.new("Pose")
			pose.Name = partName
			pose.CFrame = f.poses[partName] or CFrame.new()
			pose.Weight = 1
			pose.EasingDirection = Enum.PoseEasingDirection.InOut
			pose.EasingStyle = Enum.PoseEasingStyle.Linear
			pose.Parent = parentInstance
			created[partName] = true

			if childrenMap[partName] then
				for _, childName in ipairs(childrenMap[partName]) do
					createPose(childName, pose)
				end
			end

			return pose
		end

		local rootPose = createPose(root, kf)

		-- Any captured part not covered by the hierarchy is attached
		-- directly under the root pose so nothing gets lost.
		for partName, cf in pairs(f.poses) do
			if not created[partName] then
				local pose = Instance.new("Pose")
				pose.Name = partName
				pose.CFrame = cf
				pose.Weight = 1
				pose.EasingDirection = Enum.PoseEasingDirection.InOut
				pose.EasingStyle = Enum.PoseEasingStyle.Linear
				pose.Parent = rootPose
			end
		end

		kf.Parent = kfs
	end

	return kfs
end

-- Removes N frames from the start and N frames from the end.
-- Mirrors the "cut start/end" logic from the older V8 script.
local function trimFrames(frames, trimStart, trimEnd)
	local total = #frames
	if total <= trimStart + trimEnd then
		return frames
	end

	local result = {}
	for i = trimStart + 1, total - trimEnd do
		result[#result + 1] = frames[i]
	end
	return result
end

-- Resamples frames to a target FPS by picking the nearest captured
-- frame for each target timestamp. Lower FPS = fewer keyframes
-- (a simple form of compression).
local function resampleFrames(frames, fps)
	if fps <= 0 or #frames < 2 then
		return frames
	end

	local dt = 1 / fps
	local firstT = frames[1].time
	local lastT = frames[#frames].time

	local result = {}
	local idx = 1
	local t = firstT

	while t <= lastT + 1e-6 do
		while idx < #frames and math.abs(frames[idx + 1].time - t) <= math.abs(frames[idx].time - t) do
			idx = idx + 1
		end
		result[#result + 1] = { time = round(t, 4), poses = frames[idx].poses }
		t = t + dt
	end

	if result[#result].time < lastT - 1e-6 then
		result[#result + 1] = { time = lastT, poses = frames[#frames].poses }
	end

	return result
end

-- Keeps only the parts present (and true) in partsSet
local function filterFramesByParts(frames, partsSet)
	local result = {}
	for _, f in ipairs(frames) do
		local poses = {}
		for part, cf in pairs(f.poses) do
			if partsSet == nil or partsSet[part] then
				poses[part] = cf
			end
		end
		result[#result + 1] = { time = f.time, poses = poses }
	end
	return result
end

-- Resolves the chosen destination option to an actual Instance
local function getDestParent(idx)
	local name = convDestOptions[idx]
	if name == "ReplicatedStorage" then
		return game:GetService("ReplicatedStorage")
	elseif name == "Lighting" then
		return game:GetService("Lighting")
	end
	return workspace
end

local function sanitizeName(name)
	return tostring(name):gsub("%s+", "_")
end

local function normalizeId(raw)
	raw = tostring(raw)
	raw = raw:gsub("rbxassetid://", "")
	raw = raw:gsub("%D", "")
	return raw
end

local function cfToStr(cf, precision)
	local p = cf.Position
	local rx, ry, rz = cf:ToEulerAnglesXYZ()
	return "CFrame.new(" .. tostring(round(p.X, precision)) .. "," .. tostring(round(p.Y, precision)) .. "," .. tostring(round(p.Z, precision)) .. ") * CFrame.Angles(" .. tostring(round(rx, precision)) .. "," .. tostring(round(ry, precision)) .. "," .. tostring(round(rz, precision)) .. ")"
end

-- Generates export content based on the chosen options
-- ext: ".lua" | ".txt" | ".json"
-- precision: number of decimals
-- skipFrame: take every Nth frame
-- headerEnabled: bool
-- headerText: custom header string (used if not empty)
-- partsSet: table of partName -> bool (only true entries are included)
local function generateFileContent(ext, precision, skipFrame, headerEnabled, headerText, partsSet)
	if ext == ".json" then
		local frames = {}
		for i, f in ipairs(dumpData) do
			if (i - 1) % skipFrame == 0 then
				local poses = {}
				local any = false
				for part, cf in pairs(f.Poses) do
					if partsSet[part] then
						local p = cf.Position
						local rx, ry, rz = cf:ToEulerAnglesXYZ()
						poses[part] = {
							pos = { round(p.X, precision), round(p.Y, precision), round(p.Z, precision) },
							rot = { round(rx, precision), round(ry, precision), round(rz, precision) },
						}
						any = true
					end
				end
				if any then
					frames[#frames + 1] = { time = tonumber(f.Time), poses = poses }
				end
			end
		end

		local data = { id = lastId, hierarchy = lastHierarchy, frames = frames }
		local ok, json = pcall(function()
			return HttpService:JSONEncode(data)
		end)
		if ok then
			return json
		else
			return "{}"
		end
	end

	-- .lua / .txt format
	local lines = {}

	if headerEnabled then
		if headerText ~= "" then
			lines[#lines + 1] = headerText
		else
			lines[#lines + 1] = '-- Start / "' .. lastId .. '" --'
		end
	end

	-- Embed the part hierarchy (Motor6D Part1 -> Part0) so the
	-- converter can rebuild a proper Pose tree later
	for child, parent in pairs(lastHierarchy) do
		lines[#lines + 1] = "-- H:" .. child .. "=" .. parent
	end

	for i, f in ipairs(dumpData) do
		if (i - 1) % skipFrame == 0 then
			for part, cf in pairs(f.Poses) do
				if partsSet[part] then
					lines[#lines + 1] = f.Time .. "s : " .. part .. " = " .. cfToStr(cf, precision)
				end
			end
		end
	end

	if headerEnabled then
		lines[#lines + 1] = "-- END --"
	end

	return table.concat(lines, "\n")
end

----------------------------------------------------------------
-- Button events
----------------------------------------------------------------
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

eyeBtn.MouseButton1Click:Connect(function()
	logFrame.Visible = not logFrame.Visible
	if logFrame.Visible then
		local mainAbsPos = frame.AbsolutePosition
		logFrame.Position = UDim2.new(0, mainAbsPos.X + 230, 0, mainAbsPos.Y)
	end
end)

stopBtn.MouseButton1Click:Connect(function()
	stopped = true
	if currentTrack then
		currentTrack:Stop()
	end
	if activeConn then
		activeConn:Disconnect()
	end

	dumpBtn.Text = "STOP"
	dumpBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

	addLog("> Stopped.", "red")

	task.wait(1)
	dumpBtn.Text = "DUMP"
	dumpBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
	dumping = false
end)

dumpBtn.MouseButton1Click:Connect(function()
	if dumping then
		return
	end

	local raw = input.Text
	local animNum = normalizeId(raw)

	if animNum == "" then
		input.Text = "INVALID"
		addLog("> Invalid ID", "red")
		task.wait(1)
		input.Text = raw
		return
	end

	local animId = "rbxassetid://" .. animNum
	lastId = animNum
	dumping = true
	stopped = false
	dumpData = {}
	selectedParts = {}

	addLog("> Dumping...", "white")

	dumpBtn.Text = "..."
	dumpBtn.BackgroundColor3 = Color3.fromRGB(180, 180, 0)

	local ok, track = pcall(function()
		local a = Instance.new("Animation")
		a.AnimationId = animId
		return animator:LoadAnimation(a)
	end)

	if not ok then
		dumpBtn.Text = "ERR"
		dumpBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
		addLog("> Bad Animation ID", "red")
		task.wait(1)
		dumpBtn.Text = "DUMP"
		dumpBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
		dumping = false
		return
	end

	currentTrack = track
	track.Looped = false
	track.Priority = Enum.AnimationPriority.Action

	dumpBtn.Text = "..."
	dumpBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

	local motors = {}
	lastHierarchy = {}
	for _, v in ipairs(character:GetDescendants()) do
		if v:IsA("Motor6D") and v.Part1 then
			local childName = sanitizeName(v.Part1.Name)
			motors[#motors + 1] = { name = childName, obj = v }
			if v.Part0 then
				lastHierarchy[childName] = sanitizeName(v.Part0.Name)
			end
		end
	end

	addLog("> Rig: " .. tostring(humanoid.RigType), "white")

	startTime = tick()
	track:Play()

	activeConn = RunService.RenderStepped:Connect(function()
		if stopped then
			return
		end
		local rawTime = tick() - startTime
		local t = tostring(round(rawTime))
		local f = { Time = t, Poses = {} }

		for i = 1, #motors do
			local m = motors[i]
			f.Poses[m.name] = m.obj.Transform
		end
		dumpData[#dumpData + 1] = f
	end)

	track.Stopped:Wait()
	if activeConn then
		activeConn:Disconnect()
	end

	if stopped then
		return
	end

	local totalTime = round(tick() - startTime)

	dumpBtn.Text = "OK"
	dumpBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)

	addLog("> Done!", "green")
	addLog("   ID: " .. lastId, "green")
	addLog("   Frames: " .. #dumpData, "green")
	addLog("   Time: " .. totalTime .. "s", "green")

	task.wait(1)
	dumpBtn.Text = "DUMP"
	dumping = false
end)

copyBtn.MouseButton1Click:Connect(function()
	if #dumpData == 0 then
		addLog("> No data", "red")
		return
	end

	local text = generateFileContent(".lua", 3, 1, true, "", getAllPartsSet())

	if setclipboard then
		setclipboard(text)
		addLog("> Copied!", "green")
	else
		addLog("> No clipboard support", "red")
	end
end)

fileBtn.MouseButton1Click:Connect(function()
	if #dumpData == 0 or lastId == "" then
		addLog("> No data", "red")
		return
	end

	local placeName = getPlaceName()
	exportNameBox.Text = lastId .. "_" .. placeName
	headerTextBox.Text = ""

	refreshPartsList()

	local mainAbsPos = frame.AbsolutePosition
	exportFrame.Position = UDim2.new(0, mainAbsPos.X + 10, 0, mainAbsPos.Y - 20)
	exportFrame.Visible = true
end)

exportCancelBtn.MouseButton1Click:Connect(function()
	exportFrame.Visible = false
	helpFrame.Visible = false
end)

helpBtn.MouseButton1Click:Connect(function()
	helpFrame.Visible = not helpFrame.Visible
	if helpFrame.Visible then
		local exAbsPos = exportFrame.AbsolutePosition
		helpFrame.Position = UDim2.new(0, exAbsPos.X + 250, 0, exAbsPos.Y)
	end
end)

exportOkBtn.MouseButton1Click:Connect(function()
	local customName = exportNameBox.Text
	if customName == "" then
		addLog("> Invalid name", "red")
		return
	end

	local ext = extOptions[extIndex]
	local precision = precOptions[precIndex]
	local skipFrame = skipOptions[skipIndex]

	local fileName = customName .. ext
	local folderName = "AnimationD"

	if folderOn then
		if isfolder and not isfolder(folderName) then
			pcall(function()
				makefolder(folderName)
			end)
		end
		fileName = folderName .. "/" .. fileName
	end

	local text = generateFileContent(ext, precision, skipFrame, headerOn, headerTextBox.Text, selectedParts)

	addLog("> Exporting...", "white")

	if writefile then
		local success = pcall(function()
			writefile(fileName, text)
		end)

		if success then
			if folderOn then
				addLog('> Exported! (Your file in "' .. folderName .. '")', "green")
			else
				addLog("> Exported!", "green")
			end
			addLog("   " .. fileName, "green")
		else
			addLog("> Export error", "red")
		end
	else
		addLog("> No writefile support", "red")
	end

	exportFrame.Visible = false
	helpFrame.Visible = false
end)

----------------------------------------------------------------
-- Converter panel events
----------------------------------------------------------------
convBtn.MouseButton1Click:Connect(function()
	convFrame.Visible = not convFrame.Visible
	if convFrame.Visible then
		local mainAbsPos = frame.AbsolutePosition
		convFrame.Position = UDim2.new(0, mainAbsPos.X + 10, 0, mainAbsPos.Y - 20)
		-- Reset to root on open
		convCurrentPath = "AnimationD"
		convPathStack = {}
		selectedConvFile = nil
		refreshConvList()
	end
end)

convCloseBtn.MouseButton1Click:Connect(function()
	convFrame.Visible = false
end)

convBackBtn.MouseButton1Click:Connect(function()
	if #convPathStack > 0 then
		convCurrentPath = convPathStack[#convPathStack]
		convPathStack[#convPathStack] = nil
		refreshConvList()
	end
end)

convertBtn.MouseButton1Click:Connect(function()
	if selectedConvFile then
		-- A specific file is selected: load it for the options popup
		addLog("> Loading file...", "white")

		local frames, hierarchy, err = parseDumpFile(selectedConvFile)
		if not frames then
			addLog("> " .. tostring(err), "red")
			return
		end

		pendingFrames = frames
		pendingHierarchy = hierarchy

		local fileName = selectedConvFile:match("([^/\\]+)$") or selectedConvFile
		convOptFileLabel.Text = "File: " .. fileName

		refreshConvPartsList(frames)
	else
		-- No file selected: will convert current folder when OK is pressed
		pendingFrames = nil
		pendingHierarchy = nil
		convOptFileLabel.Text = "Folder: " .. (convCurrentPath:match("([^/\\]+)$") or convCurrentPath)
		refreshConvPartsList(nil)
	end

	local mainAbsPos = frame.AbsolutePosition
	convOptFrame.Position = UDim2.new(0, mainAbsPos.X + 250, 0, mainAbsPos.Y - 20)
	convOptFrame.Visible = true
end)

convOptCancelBtn.MouseButton1Click:Connect(function()
	convOptFrame.Visible = false
end)

convOptXBtn.MouseButton1Click:Connect(function()
	convOptFrame.Visible = false
end)

convOptOkBtn.MouseButton1Click:Connect(function()
	local trimStart = convTrimOptions[convTrimStartIndex]
	local trimEnd   = convTrimOptions[convTrimEndIndex]
	local fps       = convFpsOptions[convFpsIndex]
	local destParent = getDestParent(convDestIndex)

	-- Helper: convert a single frames+hierarchy pair into a KFS
	local function doConvert(frames, hierarchy, name, parent)
		frames = trimFrames(frames, trimStart, trimEnd)
		frames = resampleFrames(frames, fps)
		frames = filterFramesByParts(frames, pendingFrames and convSelectedParts or nil)
		if #frames == 0 then return false, "no frames left" end
		local ok, kfs = pcall(buildKeyframeSequence, frames, hierarchy, name)
		if not ok or not kfs then return false, "build error" end
		kfs.Loop = convLoopOn
		kfs.Parent = parent
		return true
	end

	if pendingFrames then
		-- Single file conversion
		addLog("> Converting...", "white")
		local baseName = (selectedConvFile and selectedConvFile:match("([^/\\]+)$") or "Anim"):gsub("%.%w+$", "")
		local ok, err2 = doConvert(pendingFrames, pendingHierarchy, baseName, destParent)
		if ok then
			addLog("> Created KeyframeSequence!", "green")
			addLog("   Name: " .. baseName, "green")
			addLog("   Location: " .. convDestOptions[convDestIndex], "green")
		else
			addLog("> Failed: " .. tostring(err2), "red")
		end
	else
		-- No file selected → convert all files in current folder
		if not (isfolder and listfiles) then
			addLog("> Filesystem not supported", "red")
			return
		end

		local folder = destParent:FindFirstChild("ConvertedAll")
		if not folder then
			folder = Instance.new("Folder")
			folder.Name = "ConvertedAll"
			folder.Parent = destParent
		end

		local function collectFiles(path)
			local result = {}
			for _, p in ipairs(listfiles(path)) do
				if isfolder(p) then
					for _, sub in ipairs(collectFiles(p)) do
						result[#result + 1] = sub
					end
				else
					result[#result + 1] = p
				end
			end
			return result
		end

		local allFiles = collectFiles(convCurrentPath)
		addLog("> Converting " .. #allFiles .. " files in " .. (convCurrentPath:match("([^/\\]+)$") or convCurrentPath) .. "...", "white")

		local okCount, failCount = 0, 0
		for i, path in ipairs(allFiles) do
			local fileName = path:match("([^/\\]+)$") or path
			addLog("> [" .. i .. "/" .. #allFiles .. "] " .. fileName .. "...", "white")

			local frames, hierarchy, parseErr = parseDumpFile(path)
			if frames then
				local baseName = fileName:gsub("%.%w+$", "")
				local ok2, err2 = doConvert(frames, hierarchy, baseName, folder)
				if ok2 then
					okCount = okCount + 1
					addLog("   OK", "green")
				else
					failCount = failCount + 1
					addLog("   Failed: " .. tostring(err2), "red")
				end
			else
				failCount = failCount + 1
				addLog("   Failed: " .. tostring(parseErr or "read error"), "red")
			end

			if i % 5 == 0 then task.wait() end
		end

		addLog("> Done! OK: " .. okCount .. " | Failed: " .. failCount, "green")
		addLog("   Location: " .. convDestOptions[convDestIndex] .. "/ConvertedAll", "green")
	end

	convOptFrame.Visible = false
	convFrame.Visible = false
end)

convOptAllBtn.MouseButton1Click:Connect(function()
	if not (isfolder and listfiles) then
		addLog("> Filesystem not supported", "red")
		return
	end

	if not isfolder(convCurrentPath) then
		addLog('> "' .. convCurrentPath .. '" not found', "red")
		return
	end

	local function collectFiles(path)
		local result = {}
		for _, p in ipairs(listfiles(path)) do
			if isfolder(p) then
				for _, sub in ipairs(collectFiles(p)) do
					result[#result + 1] = sub
				end
			else
				result[#result + 1] = p
			end
		end
		return result
	end

	local allFiles = collectFiles(convCurrentPath)
	if #allFiles == 0 then
		addLog("> No files found", "red")
		return
	end

	local trimStart = convTrimOptions[convTrimStartIndex]
	local trimEnd   = convTrimOptions[convTrimEndIndex]
	local fps       = convFpsOptions[convFpsIndex]
	local destParent = getDestParent(convDestIndex)

	local folder = destParent:FindFirstChild("ConvertedAll")
	if not folder then
		folder = Instance.new("Folder")
		folder.Name = "ConvertedAll"
		folder.Parent = destParent
	end

	addLog("> Converting ALL (" .. #allFiles .. " files)...", "white")

	local okCount, failCount = 0, 0

	for i, path in ipairs(allFiles) do
		local fileName = path:match("([^/\\]+)$") or path
		addLog("> [" .. i .. "/" .. #allFiles .. "] " .. fileName .. "...", "white")

		local frames, hierarchy, parseErr = parseDumpFile(path)

		if frames then
			frames = trimFrames(frames, trimStart, trimEnd)
			frames = resampleFrames(frames, fps)
		end

		if frames and #frames > 0 then
			local baseName = fileName:gsub("%%.%w+$", "")
			local okBuild, kfs = pcall(buildKeyframeSequence, frames, hierarchy, baseName)
			if okBuild and kfs then
				kfs.Loop = convLoopOn
				kfs.Parent = folder
				okCount = okCount + 1
				addLog("   OK (" .. #frames .. " frames)", "green")
			else
				failCount = failCount + 1
				addLog("   Failed: " .. fileName .. " (build error)", "red")
			end
		else
			failCount = failCount + 1
			addLog("   Failed: " .. fileName .. " (" .. tostring(parseErr or "no frames") .. ")", "red")
		end

		if i % 5 == 0 then
			task.wait()
		end
	end

	addLog("> Convert ALL done!", "green")
	addLog("   OK: " .. okCount .. " | Failed: " .. failCount, "green")
	addLog("   Location: " .. convDestOptions[convDestIndex] .. "/ConvertedAll", "green")

	convOptFrame.Visible = false
	convFrame.Visible = false
end)
