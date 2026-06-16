local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local LP = Players.LocalPlayer or Players:GetPlayers()[1]
if not LP then
	error("No LocalPlayer found.")
end

local PlayerGui = LP:WaitForChild("PlayerGui")

local function safeClipboard(text)
	if typeof(setclipboard) == "function" then
		pcall(setclipboard, text)
		return true
	end
	return false
end

local function getAnimId(anim)
	local id = tostring(anim.AnimationId or "")
	id = id:gsub("%s+", "")
	if id == "" then
		return "N/A"
	end
	return id
end

-- ĐÃ CẬP NHẬT: Quét toàn bộ mọi Service có trong game
local function scanAnimations()
	local results = {}
	local seen = {}

	-- Lấy tất cả các con/service trực thuộc `game`
	for _, service in ipairs(game:GetChildren()) do
		-- Dùng pcall để tránh bị lỗi crash khi đụng trúng các Service bảo mật của Server
		local success, descendants = pcall(function()
			return service:GetDescendants()
		end)

		if success and descendants then
			for _, obj in ipairs(descendants) do
				if obj:IsA("Animation") then
					local id = getAnimId(obj)
					local key = obj:GetFullName() .. "|" .. id
					if not seen[key] then
						seen[key] = true
						table.insert(results, {
							name = obj.Name,
							id = id,
							fullName = obj:GetFullName(),
							parent = obj.Parent and obj.Parent:GetFullName() or "N/A",
						})
					end
				end
			end
		end
	end

	table.sort(results, function(a, b)
		return a.name:lower() < b.name:lower()
	end)

	return results
end

local gui = Instance.new("ScreenGui")
gui.Name = "AnimAuditGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = PlayerGui

local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenButton"
openBtn.Size = UDim2.fromOffset(110, 38)
openBtn.Position = UDim2.new(0, 12, 0.5, -19)
openBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.Text = "Anim Inspector"
openBtn.Font = Enum.Font.GothamSemibold
openBtn.TextSize = 14
openBtn.Visible = false
openBtn.Parent = gui
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 10)

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(600, 400)
main.Position = UDim2.new(0.5, -300, 0.5, -200)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
main.BorderSizePixel = 0
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

local stroke = Instance.new("UIStroke")
stroke.Thickness = 1
stroke.Color = Color3.fromRGB(80, 80, 90)
stroke.Transparency = 0.35
stroke.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 42)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
header.BorderSizePixel = 0
header.Parent = main
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 14)

local headerMask = Instance.new("Frame")
headerMask.Size = UDim2.new(1, 0, 0, 14)
headerMask.Position = UDim2.new(0, 0, 1, -14)
headerMask.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
headerMask.BorderSizePixel = 0
headerMask.Parent = header

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(12, 0)
title.Size = UDim2.new(1, -120, 1, 0)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Text = "Animation Inspector"
title.Parent = header

local cancelBtn = Instance.new("TextButton")
cancelBtn.Size = UDim2.fromOffset(34, 28)
cancelBtn.Position = UDim2.new(1, -42, 0, 7)
cancelBtn.BackgroundColor3 = Color3.fromRGB(170, 60, 60)
cancelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
cancelBtn.Font = Enum.Font.GothamBold
cancelBtn.TextSize = 16
cancelBtn.Text = "×"
cancelBtn.Parent = header
Instance.new("UICorner", cancelBtn).CornerRadius = UDim.new(0, 8)

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.fromOffset(34, 28)
minimizeBtn.Position = UDim2.new(1, -82, 0, 7)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 66)
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 16
minimizeBtn.Text = "–"
minimizeBtn.Parent = header
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 8)

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, -20, 0, 42)
topBar.Position = UDim2.fromOffset(10, 52)
topBar.BackgroundTransparency = 1
topBar.Parent = main

local search = Instance.new("TextBox")
search.Size = UDim2.new(1, -260, 0, 34)
search.Position = UDim2.fromOffset(0, 0)
search.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
search.BorderSizePixel = 0
search.PlaceholderText = "Search..."
search.Text = ""
search.TextColor3 = Color3.fromRGB(255, 255, 255)
search.PlaceholderColor3 = Color3.fromRGB(150, 150, 160)
search.Font = Enum.Font.Gotham
search.TextSize = 14
search.ClearTextOnFocus = false
search.Parent = topBar
Instance.new("UICorner", search).CornerRadius = UDim.new(0, 10)

local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.fromOffset(80, 34)
refreshBtn.Position = UDim2.new(1, -250, 0, 0)
refreshBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 180)
refreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshBtn.Font = Enum.Font.GothamSemibold
refreshBtn.TextSize = 13
refreshBtn.Text = "Refresh"
refreshBtn.Parent = topBar
Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0, 10)

local autoBtn = Instance.new("TextButton")
autoBtn.Size = UDim2.fromOffset(80, 34)
autoBtn.Position = UDim2.new(1, -165, 0, 0)
autoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 66)
autoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoBtn.Font = Enum.Font.GothamSemibold
autoBtn.TextSize = 13
autoBtn.Text = "Auto: ON"
autoBtn.Parent = topBar
Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0, 10)

local copyAllBtn = Instance.new("TextButton")
copyAllBtn.Size = UDim2.fromOffset(80, 34)
copyAllBtn.Position = UDim2.new(1, -80, 0, 0)
copyAllBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 86)
copyAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyAllBtn.Font = Enum.Font.GothamSemibold
copyAllBtn.TextSize = 13
copyAllBtn.Text = "Copy All"
copyAllBtn.Parent = topBar
Instance.new("UICorner", copyAllBtn).CornerRadius = UDim.new(0, 10)

local count = Instance.new("TextLabel")
count.Size = UDim2.new(1, -20, 0, 18)
count.Position = UDim2.fromOffset(10, 86)
count.BackgroundTransparency = 1
count.TextXAlignment = Enum.TextXAlignment.Left
count.Font = Enum.Font.Gotham
count.TextSize = 12
count.TextColor3 = Color3.fromRGB(170, 170, 180)
count.Text = "0 found"
count.Parent = main

local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(0.55, -10, 1, -116)
list.Position = UDim2.fromOffset(10, 108)
list.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
list.BorderSizePixel = 0
list.ScrollBarThickness = 6
list.ScrollBarImageColor3 = Color3.fromRGB(140, 140, 150)
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.Parent = main
Instance.new("UICorner", list).CornerRadius = UDim.new(0, 12)

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.Parent = list

local pad = Instance.new("UIPadding")
pad.PaddingTop = UDim.new(0, 8)
pad.PaddingBottom = UDim.new(0, 8)
pad.PaddingLeft = UDim.new(0, 8)
pad.PaddingRight = UDim.new(0, 8)
pad.Parent = list

local detail = Instance.new("Frame")
detail.Size = UDim2.new(0.45, -10, 1, -116)
detail.Position = UDim2.new(0.55, 0, 0, 108)
detail.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
detail.BorderSizePixel = 0
detail.Parent = main
Instance.new("UICorner", detail).CornerRadius = UDim.new(0, 12)

local detailText = Instance.new("TextLabel")
detailText.Size = UDim2.new(1, -20, 1, -78)
detailText.Position = UDim2.fromOffset(10, 10)
detailText.BackgroundTransparency = 1
detailText.TextXAlignment = Enum.TextXAlignment.Left
detailText.TextYAlignment = Enum.TextYAlignment.Top
detailText.Font = Enum.Font.Code
detailText.TextSize = 12
detailText.TextColor3 = Color3.fromRGB(235, 235, 240)
detailText.TextWrapped = true
detailText.Text = "Select an item."
detailText.Parent = detail

local playBtn = Instance.new("TextButton")
playBtn.Size = UDim2.new(0.5, -15, 0, 34)
playBtn.Position = UDim2.new(0, 10, 1, -44)
playBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 100)
playBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
playBtn.Font = Enum.Font.GothamSemibold
playBtn.TextSize = 13
playBtn.Text = "Play"
playBtn.Parent = detail
Instance.new("UICorner", playBtn).CornerRadius = UDim.new(0, 10)

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0.5, -15, 0, 34)
copyBtn.Position = UDim2.new(0.5, 5, 1, -44)
copyBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 180)
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyBtn.Font = Enum.Font.GothamSemibold
copyBtn.TextSize = 13
copyBtn.Text = "Copy ID"
copyBtn.Parent = detail
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 10)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 18)
status.Position = UDim2.new(0, 10, 1, -68)
status.BackgroundTransparency = 1
status.TextXAlignment = Enum.TextXAlignment.Left
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextColor3 = Color3.fromRGB(170, 170, 180)
status.Text = "Ready."
status.Parent = detail

local dragging = false
local dragStart
local startPos

header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

local autoRefresh = true
local alive = true
local currentResults = {}
local selected = nil
local currentTrack = nil

local function setStatus(text)
	status.Text = tostring(text or "")
end

local function stopCurrentAnim()
	if currentTrack then
		currentTrack:Stop()
		currentTrack = nil
	end
	playBtn.Text = "Play"
	playBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 100)
end

local function clearList()
	for _, child in ipairs(list:GetChildren()) do
		if child:IsA("TextButton") or child:IsA("TextLabel") then
			child:Destroy()
		end
	end
end

local function updateCanvas()
	task.defer(function()
		list.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 12)
	end)
end

local function applySelection(item)
	selected = item
	stopCurrentAnim()

	if not item then
		detailText.Text = "Select an item."
		copyBtn.Text = "Copy ID"
		return
	end

	detailText.Text = table.concat({
		"Name: " .. item.name,
		"ID: " .. item.id,
		"Parent: " .. item.parent,
	}, "\n\n")

	copyBtn.Text = "Copy ID"
end

local function rebuild()
	clearList()

	local q = string.lower(search.Text or "")
	local filtered = {}

	for _, item in ipairs(currentResults) do
		local hay = string.lower(item.name .. " " .. item.id .. " " .. item.fullName .. " " .. item.parent)
		if q == "" or string.find(hay, q, 1, true) then
			table.insert(filtered, item)
		end
	end

	count.Text = tostring(#filtered) .. " found"

	if #filtered == 0 then
		local empty = Instance.new("TextLabel")
		empty.Size = UDim2.new(1, 0, 0, 28)
		empty.BackgroundTransparency = 1
		empty.Font = Enum.Font.Gotham
		empty.TextSize = 13
		empty.TextColor3 = Color3.fromRGB(170, 170, 180)
		empty.Text = "No animations found."
		empty.Parent = list
		updateCanvas()
		return
	end

	for i, item in ipairs(filtered) do
		local row = Instance.new("TextButton")
		row.Size = UDim2.new(1, 0, 0, 56)
		row.BackgroundColor3 = Color3.fromRGB(34, 34, 40)
		row.BorderSizePixel = 0
		row.Text = ""
		row.Parent = list
		Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)

		local n = Instance.new("TextLabel")
		n.Size = UDim2.new(1, -16, 0, 18)
		n.Position = UDim2.fromOffset(8, 6)
		n.BackgroundTransparency = 1
		n.TextXAlignment = Enum.TextXAlignment.Left
		n.Font = Enum.Font.GothamSemibold
		n.TextSize = 13
		n.TextColor3 = Color3.fromRGB(255, 255, 255)
		n.Text = item.name
		n.Parent = row

		local id = Instance.new("TextLabel")
		id.Size = UDim2.new(1, -16, 0, 16)
		id.Position = UDim2.fromOffset(8, 28)
		id.BackgroundTransparency = 1
		id.TextXAlignment = Enum.TextXAlignment.Left
		id.Font = Enum.Font.Code
		id.TextSize = 12
		id.TextColor3 = Color3.fromRGB(190, 190, 200)
		id.Text = item.id
		id.Parent = row

		row.MouseButton1Click:Connect(function()
			applySelection(item)
		end)
	end

	if not selected then
		applySelection(filtered[1])
	end

	updateCanvas()
end

local function refresh()
	currentResults = scanAnimations()
	if #currentResults == 0 then
		applySelection(nil)
		setStatus("No animations found.")
	else
		if selected then
			local keep = nil
			for _, item in ipairs(currentResults) do
				if item.fullName == selected.fullName and item.id == selected.id then
					keep = item
					break
				end
			end
			selected = keep or currentResults[1]
		else
			selected = currentResults[1]
		end
		applySelection(selected)
		setStatus("Updated: " .. tostring(#currentResults) .. " item(s).")
	end
	rebuild()
end

refreshBtn.MouseButton1Click:Connect(refresh)

search:GetPropertyChangedSignal("Text"):Connect(function()
	rebuild()
end)

autoBtn.MouseButton1Click:Connect(function()
	autoRefresh = not autoRefresh
	autoBtn.Text = autoRefresh and "Auto: ON" or "Auto: OFF"
	autoBtn.BackgroundColor3 = autoRefresh and Color3.fromRGB(60, 60, 66) or Color3.fromRGB(100, 70, 70)
	setStatus(autoRefresh and "Auto refresh enabled." or "Auto refresh disabled.")
end)

playBtn.MouseButton1Click:Connect(function()
	if not selected or not selected.id or selected.id == "N/A" then
		setStatus("No valid animation to play.")
		return
	end

	if currentTrack then
		stopCurrentAnim()
		setStatus("Animation stopped.")
	else
		local char = LP.Character
		if not char then setStatus("Character not found.") return end

		local hum = char:FindFirstChildOfClass("Humanoid")
		if not hum then setStatus("Humanoid not found.") return end

		local animator = hum:FindFirstChildOfClass("Animator")
		if not animator then
			animator = Instance.new("Animator")
			animator.Parent = hum
		end

		local animIdNum = string.match(selected.id, "%d+")
		if not animIdNum then setStatus("Invalid ID format.") return end

		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://" .. animIdNum

		local success, err = pcall(function()
			currentTrack = animator:LoadAnimation(anim)
			currentTrack:Play()
		end)

		if success then
			playBtn.Text = "Stop"
			playBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
			setStatus("Playing animation...")
		else
			setStatus("Failed to play: " .. tostring(err))
			stopCurrentAnim()
		end
	end
end)

copyBtn.MouseButton1Click:Connect(function()
	if not selected or not selected.id or selected.id == "N/A" then
		setStatus("Nothing to copy.")
		return
	end

	local full = "rbxassetid://" .. string.match(selected.id, "%d+")
	if safeClipboard(full) then
		setStatus("Copied: " .. full)
	else
		setStatus("Clipboard unavailable. ID: " .. full)
	end
end)

copyAllBtn.MouseButton1Click:Connect(function()
	local lines = {}
	for _, item in ipairs(currentResults) do
		table.insert(lines, item.name .. " | " .. item.id .. " | " .. item.fullName)
	end

	local text = table.concat(lines, "\n")
	if text == "" then
		setStatus("Nothing to copy.")
		return
	end

	if safeClipboard(text) then
		setStatus("Copied all items.")
	else
		setStatus("Clipboard unavailable.")
	end
end)

local function closeGui()
	alive = false
	stopCurrentAnim()
	main.Visible = false
	openBtn.Visible = true
end

cancelBtn.MouseButton1Click:Connect(closeGui)

openBtn.MouseButton1Click:Connect(function()
	if not main.Visible then
		alive = true
		main.Visible = true
		openBtn.Visible = false
		refresh()
	end
end)

minimizeBtn.MouseButton1Click:Connect(function()
	local minimized = not list.Visible
	list.Visible = minimized
	detail.Visible = minimized
	topBar.Visible = minimized
	count.Visible = minimized
	minimizeBtn.Text = minimized and "+" or "–"
	main.Size = minimized and UDim2.fromOffset(600, 42) or UDim2.fromOffset(600, 400)
end)

LP.CharacterAdded:Connect(function()
	task.wait(0.5)
	if main.Visible then
		refresh()
	end
end)

task.spawn(function()
	while gui.Parent do
		task.wait(2)
		if alive and autoRefresh and main.Visible then
			refresh()
		end
	end
end)

refresh()
