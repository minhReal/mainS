--[[
   Script by Gemini
   Gui by owner and Gemini
]]

local TweenService = game:GetService("TweenService")
local LogService = game:GetService("LogService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateConsole_V7_Fade"
ScreenGui.ResetOnSpawn = false 
if pcall(function() ScreenGui.Parent = CoreGui end) then else ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui") end

-- // Settings
local settings = {
    Transparency = 0.1,
    TextSize = 12,
    ShowErrors = true,
    ShowWarns = true,
    ShowPrints = true
}

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 320)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = settings.Transparency
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.5
MainStroke.Color = Color3.fromRGB(60, 60, 60)
MainStroke.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TopBar.BackgroundTransparency = settings.Transparency
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local BottomCover = Instance.new("Frame")
BottomCover.Size = UDim2.new(1, 0, 0, 10)
BottomCover.Position = UDim2.new(0, 0, 1, -10)
BottomCover.BorderSizePixel = 0
BottomCover.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BottomCover.BackgroundTransparency = settings.Transparency
BottomCover.Parent = TopBar

local MainTitle = Instance.new("TextLabel")
MainTitle.Text = "CONSOLE"
MainTitle.Size = UDim2.new(0, 100, 1, 0)
MainTitle.Position = UDim2.new(0, 40, 0, 0)
MainTitle.BackgroundTransparency = 1
MainTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 15
MainTitle.TextXAlignment = Enum.TextXAlignment.Left
MainTitle.Parent = TopBar

local SettingsPanel = Instance.new("CanvasGroup")
SettingsPanel.Name = "SettingsPanel"
SettingsPanel.Size = UDim2.new(0, 220, 1, 0)
SettingsPanel.Position = UDim2.new(0, 0, 0, 0)
SettingsPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SettingsPanel.BorderSizePixel = 0
SettingsPanel.ZIndex = -1
SettingsPanel.Visible = false
SettingsPanel.GroupTransparency = 1
SettingsPanel.Parent = MainFrame
Instance.new("UICorner", SettingsPanel).CornerRadius = UDim.new(0, 10)

local SetHead = Instance.new("Frame")
SetHead.Size = UDim2.new(1, 0, 0, 35)
SetHead.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SetHead.BackgroundTransparency = settings.Transparency
SetHead.Parent = SettingsPanel
Instance.new("UICorner", SetHead).CornerRadius = UDim.new(0, 10)
local SetCover = Instance.new("Frame") SetCover.Size = UDim2.new(1,0,0,10) SetCover.Position = UDim2.new(0,0,1,-10) SetCover.BackgroundColor3 = Color3.fromRGB(30,30,30) SetCover.BackgroundTransparency = settings.Transparency SetCover.BorderSizePixel = 0 SetCover.Parent = SetHead
local SetTitle = Instance.new("TextLabel") SetTitle.Text = "SETTINGS" SetTitle.Size = UDim2.new(1,-10,1,0) SetTitle.Position = UDim2.new(0,10,0,0) SetTitle.BackgroundTransparency = 1 SetTitle.TextColor3 = Color3.fromRGB(200,200,200) SetTitle.Font = Enum.Font.GothamBold SetTitle.TextSize = 14 SetTitle.TextXAlignment = Enum.TextXAlignment.Left SetTitle.Parent = SetHead

local SettingsContainer = Instance.new("Frame")
SettingsContainer.Size = UDim2.new(1, 0, 1, -40)
SettingsContainer.Position = UDim2.new(0, 0, 0, 40)
SettingsContainer.BackgroundTransparency = 1
SettingsContainer.Parent = SettingsPanel
local SettingsList = Instance.new("UIListLayout", SettingsContainer)
SettingsList.SortOrder = Enum.SortOrder.LayoutOrder
SettingsList.Padding = UDim.new(0, 8)
SettingsList.HorizontalAlignment = Enum.HorizontalAlignment.Center

local SettingsBtn = Instance.new("TextButton")
SettingsBtn.Size = UDim2.new(0, 24, 0, 24)
SettingsBtn.Text = ""
SettingsBtn.Position = UDim2.new(0, 8, 0.5, -12)
SettingsBtn.BackgroundColor3 = Color3.fromRGB(122, 122, 122)
SettingsBtn.Parent = TopBar
Instance.new("UICorner", SettingsBtn).CornerRadius = UDim.new(0, 6)

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(0, 160, 0, 26)
SearchBox.Position = UDim2.new(1, -250, 0.5, -13)
SearchBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.PlaceholderText = "Search..."
SearchBox.Text = ""
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 12
SearchBox.Parent = TopBar
Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 4)
local SearchStroke = Instance.new("UIStroke", SearchBox) SearchStroke.Thickness = 1 SearchStroke.Color = Color3.fromRGB(60,60,60)

local ExitButton = Instance.new("TextButton")
ExitButton.Size = UDim2.new(0, 26, 0, 26)
ExitButton.Position = UDim2.new(1, -30, 0.5, -13)
ExitButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
ExitButton.Text = ""
ExitButton.Parent = TopBar
Instance.new("UICorner", ExitButton).CornerRadius = UDim.new(0, 6)

local MiniButton = Instance.new("TextButton")
MiniButton.Size = UDim2.new(0, 26, 0, 26)
MiniButton.Position = UDim2.new(1, -60, 0.5, -13)
MiniButton.BackgroundColor3 = Color3.fromRGB(60, 160, 200)
MiniButton.Text = ""
MiniButton.Parent = TopBar
Instance.new("UICorner", MiniButton).CornerRadius = UDim.new(0, 6)

local ScrollContainer = Instance.new("ScrollingFrame")
ScrollContainer.Name = "Logs"
ScrollContainer.Size = UDim2.new(1, -14, 1, -80)
ScrollContainer.Position = UDim2.new(0, 7, 0, 42)
ScrollContainer.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
ScrollContainer.BackgroundTransparency = 0.2
ScrollContainer.BorderSizePixel = 0
ScrollContainer.ScrollBarThickness = 4
ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollContainer.Parent = MainFrame
Instance.new("UICorner", ScrollContainer).CornerRadius = UDim.new(0, 6)
local UIListLayout = Instance.new("UIListLayout", ScrollContainer) UIListLayout.Padding = UDim.new(0, 3)

local ControlBar = Instance.new("Frame")
ControlBar.Size = UDim2.new(1, -14, 0, 28)
ControlBar.Position = UDim2.new(0, 7, 1, -34)
ControlBar.BackgroundTransparency = 1
ControlBar.Parent = MainFrame

local function createBtn(text, color, pos, size)
    local btn = Instance.new("TextButton")
    btn.Text = text
    btn.Size = size
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.Parent = ControlBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    return btn
end
local CopyBtn = createBtn("COPY", Color3.fromRGB(80, 80, 200), UDim2.new(0, 0, 0, 0), UDim2.new(0, 70, 1, 0))
local ClearBtn = createBtn("CLEAR", Color3.fromRGB(200, 140, 40), UDim2.new(0, 75, 0, 0), UDim2.new(0, 70, 1, 0))
local AutoScrollBtn = createBtn("AUTO SCROLL: ON", Color3.fromRGB(46, 204, 113), UDim2.new(1, -110, 0, 0), UDim2.new(0, 110, 1, 0))

local dragging, dragStart, startPos, currentInput
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        currentInput = input
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false currentInput = nil end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input == currentInput then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local function createSlider(text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.9, 0, 0, 50)
    frame.BackgroundTransparency = 1
    frame.Parent = SettingsContainer
    
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, 0, 0, 10)
    sliderBg.Position = UDim2.new(0, 0, 0, 30)
    sliderBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = frame
    Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    fill.BorderSizePixel = 0
    fill.Parent = sliderBg
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
    
    local trigger = Instance.new("TextButton")
    trigger.Size = UDim2.new(1, 20, 3, 0)
    trigger.Position = UDim2.new(0, -10, -1, 0)
    trigger.BackgroundTransparency = 1
    trigger.Text = ""
    trigger.Parent = sliderBg
    
    local draggingSlider, sliderInput
    
    local function update(input)
        local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        TweenService:Create(fill, TweenInfo.new(0.05), {Size = UDim2.new(pos, 0, 1, 0)}):Play()
        local value = min + ((max - min) * pos)
        callback(value)
    end
    
    trigger.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = true
            sliderInput = input
            update(input)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then draggingSlider = false sliderInput = nil end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if draggingSlider and input == sliderInput then update(input) end
    end)
end

local function createToggle(text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.9, 0, 0, 35)
    frame.BackgroundTransparency = 1
    frame.Parent = SettingsContainer
    
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 50, 0, 26)
    btn.Position = UDim2.new(1, -50, 0.5, -13)
    btn.BackgroundColor3 = default and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(60, 60, 60)
    btn.Text = ""
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 22, 0, 22)
    dot.Position = default and UDim2.new(1, -24, 0.5, -11) or UDim2.new(0, 2, 0.5, -11)
    dot.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    dot.Parent = btn
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    
    btn.MouseButton1Click:Connect(function()
        local newState = not ((dot.Position.X.Scale > 0.5))
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = newState and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(60, 60, 60)}):Play()
        TweenService:Create(dot, TweenInfo.new(0.2), {Position = newState and UDim2.new(1, -24, 0.5, -11) or UDim2.new(0, 2, 0.5, -11)}):Play()
        callback(newState)
    end)
end

createSlider("Transparency", 0, 1, settings.Transparency, function(val)
    settings.Transparency = val
    MainFrame.BackgroundTransparency = val
    TopBar.BackgroundTransparency = val
    BottomCover.BackgroundTransparency = val
    SetHead.BackgroundTransparency = val
    SetCover.BackgroundTransparency = val
end)

createSlider("Text Size", 8, 20, settings.TextSize, function(val)
    settings.TextSize = math.floor(val)
    for _, v in pairs(ScrollContainer:GetChildren()) do
        if v:IsA("TextBox") then v.TextSize = settings.TextSize end
    end
end)

createToggle("Show Errors", settings.ShowErrors, function(state) settings.ShowErrors = state end)
createToggle("Show Warnings", settings.ShowWarns, function(state) settings.ShowWarns = state end)
createToggle("Show Prints", settings.ShowPrints, function(state) settings.ShowPrints = state end)

local settingsOpen = false
SettingsBtn.MouseButton1Click:Connect(function()
    settingsOpen = not settingsOpen
    SettingsPanel.Visible = true
    if settingsOpen then
        TweenService:Create(SettingsPanel, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, -230, 0, 0)}):Play()
        TweenService:Create(SettingsPanel, TweenInfo.new(0.05), {GroupTransparency = 0}):Play()
    else
        TweenService:Create(SettingsPanel, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
        TweenService:Create(SettingsPanel, TweenInfo.new(0.05), {GroupTransparency = 1}):Play()
        task.wait(0.07)
        if not settingsOpen then SettingsPanel.Visible = false end
    end
end)

local autoScroll = true
local function addLog(msg, type)
    local color, name, allow = Color3.new(1,1,1), "Print", settings.ShowPrints
    if type == Enum.MessageType.MessageError then color, name, allow = Color3.fromRGB(255,80,80), "Error", settings.ShowErrors
    elseif type == Enum.MessageType.MessageWarning then color, name, allow = Color3.fromRGB(255,200,50), "Warn", settings.ShowWarns end

    local txt = Instance.new("TextBox")
    txt.Name = name
    txt.Text = string.format("[%s] %s", os.date("%X"), tostring(msg))
    txt.TextColor3 = color
    txt.BackgroundTransparency = 1
    txt.Font = Enum.Font.Code
    txt.TextSize = settings.TextSize
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.TextYAlignment = Enum.TextYAlignment.Top
    txt.AutomaticSize = Enum.AutomaticSize.Y
    txt.Size = UDim2.new(1, 0, 0, 0)
    txt.TextWrapped = true
    txt.MultiLine = true
    txt.ClearTextOnFocus = false
    txt.TextEditable = false
    txt.Parent = ScrollContainer
    
    local filter = SearchBox.Text:lower()
    if not allow or (filter ~= "" and not txt.Text:lower():find(filter)) then txt.Visible = false end

    if autoScroll then ScrollContainer.CanvasPosition = Vector2.new(0, ScrollContainer.AbsoluteCanvasSize.Y) end
end
LogService.MessageOut:Connect(addLog)

AutoScrollBtn.MouseButton1Click:Connect(function()
    autoScroll = not autoScroll
    AutoScrollBtn.Text = autoScroll and "AUTO SCROLL: ON" or "AUTO SCROLL: OFF"
    AutoScrollBtn.BackgroundColor3 = autoScroll and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(200, 60, 60)
end)

ClearBtn.MouseButton1Click:Connect(function() for _, v in pairs(ScrollContainer:GetChildren()) do if v:IsA("TextBox") then v:Destroy() end end end)
CopyBtn.MouseButton1Click:Connect(function()
    local s = ""
    for _, v in pairs(ScrollContainer:GetChildren()) do if v:IsA("TextBox") and v.Visible then s = s..v.Text.."\n" end end
    if setclipboard then setclipboard(s) end
    CopyBtn.Text = "COPIED" task.wait(1) CopyBtn.Text = "COPY"
end)

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local filter = SearchBox.Text:lower()
    for _, v in pairs(ScrollContainer:GetChildren()) do
        if v:IsA("TextBox") then
            local allow = (v.Name == "Print" and settings.ShowPrints) or (v.Name == "Warn" and settings.ShowWarns) or (v.Name == "Error" and settings.ShowErrors)
            v.Visible = allow and (filter == "" or v.Text:lower():find(filter))
        end
    end
    ScrollContainer.CanvasPosition = Vector2.new(0, ScrollContainer.AbsoluteCanvasSize.Y)
end)

local minimized, oldSize = false, MainFrame.Size
MiniButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        oldSize = MainFrame.Size
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 500, 0, 35)}):Play()
        ScrollContainer.Visible = false ControlBar.Visible = false if settingsOpen then SettingsPanel.Visible = false end
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = oldSize}):Play()
        task.wait(0.2)
        ScrollContainer.Visible = true ControlBar.Visible = true if settingsOpen then SettingsPanel.Visible = true end
    end
end)
ExitButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Testing
print("✅ Script is working")
warn("⚠️ This is a test warning.")
error("❌ This is a very long test error to check if there is a line break, look at the console!")
