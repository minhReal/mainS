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
	"Parts: choose which body parts to include in the export. Unchecked parts are skipped."
helpText.TextSize = 12
helpText.Size = UDim2.new(1, 0, 0, 360)
helpText.BackgroundTransparency = 1
helpText.TextColor3 = Color3.fromRGB(220, 220, 220)
helpText.Font = Enum.Font.Gotham
helpText.TextWrapped = true
helpText.TextXAlignment = Enum.TextXAlignment.Left
helpText.TextYAlignment = Enum.TextYAlignment.Top
helpText.ZIndex = 5
helpText.Parent = helpScroll

helpScroll.CanvasSize = UDim2.new(0, 0, 0, 370)

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

refreshExtBtn()
refreshPrecBtn()
refreshSkipBtn()
refreshHeaderBtn()
refreshFolderBtn()

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

		local data = { id = lastId, frames = frames }
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
	for _, v in ipairs(character:GetDescendants()) do
		if v:IsA("Motor6D") and v.Part1 then
			motors[#motors + 1] = { name = v.Part1.Name, obj = v }
		end
	end

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
