local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local serviceMap = {
    Players = "Players",
    Workspace = "Workspace",
    ReplicatedStorage = "ReplicatedStorage",
    StarterPlayer = "StarterPlayer",
    Lighting = "Lighting",
    CoreGui = "CoreGui",
    ReplicatedFirst = "ReplicatedFirst",
    StarterGui = "StarterGui",
    StarterPack = "StarterPack",
    SoundService = "SoundService",
    PlayerGui = "Players.LocalPlayer:WaitForChild('PlayerGui')",
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Tooltip = Instance.new("TextLabel")
Tooltip.Size = UDim2.new(0, 400, 0, 0)
Tooltip.AutomaticSize = Enum.AutomaticSize.Y
Tooltip.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Tooltip.TextColor3 = Color3.fromRGB(255, 255, 0)
Tooltip.TextSize = 14
Tooltip.Font = Enum.Font.Gotham
Tooltip.TextWrapped = true
Tooltip.TextXAlignment = Enum.TextXAlignment.Left
Tooltip.Visible = false
Tooltip.ZIndex = 100
Tooltip.Parent = ScreenGui

local TooltipPadding = Instance.new("UIPadding", Tooltip)
TooltipPadding.PaddingTop = UDim.new(0, 5)
TooltipPadding.PaddingBottom = UDim.new(0, 5)
TooltipPadding.PaddingLeft = UDim.new(0, 8)
TooltipPadding.PaddingRight = UDim.new(0, 8)

local TooltipCorner = Instance.new("UICorner", Tooltip)
TooltipCorner.CornerRadius = UDim.new(0, 6)

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 600, 0, 450)
Frame.AnchorPoint = Vector2.new(0.5, 0)
Frame.Position = UDim2.new(0.5, 0, 0.5, -225)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.ClipsDescendants = true
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner", Frame)
FrameCorner.CornerRadius = UDim.new(0, 10)
local FrameStroke = Instance.new("UIStroke", Frame)
FrameStroke.Thickness = 2
FrameStroke.Color = Color3.fromRGB(80, 80, 80)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundTransparency = 1
TopBar.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Event Finder"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.Text = ""
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Parent = TopBar
local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 30, 0, 30)
ToggleBtn.Position = UDim2.new(1, -70, 0, 5)
ToggleBtn.Text = ""
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 18
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Parent = TopBar
local ToggleCorner = Instance.new("UICorner", ToggleBtn)
ToggleCorner.CornerRadius = UDim.new(0, 6)

local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, 0, 1, -45)
Container.Position = UDim2.new(0, 0, 0, 45)
Container.BackgroundTransparency = 1
Container.Parent = Frame

local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, 140, 1, -10)
Sidebar.Position = UDim2.new(0, 10, 0, 5)
Sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Sidebar.ScrollBarThickness = 4
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Container
local SidebarCorner = Instance.new("UICorner", Sidebar)
SidebarCorner.CornerRadius = UDim.new(0, 8)

local SidebarLayout = Instance.new("UIListLayout", Sidebar)
SidebarLayout.Padding = UDim.new(0, 5)
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder

local SidebarPadding = Instance.new("UIPadding", Sidebar)
SidebarPadding.PaddingTop = UDim.new(0, 5)
SidebarPadding.PaddingBottom = UDim.new(0, 5)

local MainContent = Instance.new("Frame")
MainContent.Size = UDim2.new(1, -165, 1, -10)
MainContent.Position = UDim2.new(0, 160, 0, 5)
MainContent.BackgroundTransparency = 1
MainContent.Parent = Container

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, 0, 0, 35)
SearchBox.PlaceholderText = "Search..."
SearchBox.Text = ""
SearchBox.TextSize = 14
SearchBox.Font = Enum.Font.Gotham
SearchBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.Parent = MainContent
local SearchCorner = Instance.new("UICorner", SearchBox)
SearchCorner.CornerRadius = UDim.new(0, 8)

local TypeFilters = Instance.new("Frame")
TypeFilters.Size = UDim2.new(1, 0, 0, 30)
TypeFilters.Position = UDim2.new(0, 0, 0, 40)
TypeFilters.BackgroundTransparency = 1
TypeFilters.Parent = MainContent

local TypeLayout = Instance.new("UIListLayout", TypeFilters)
TypeLayout.FillDirection = Enum.FillDirection.Horizontal
TypeLayout.Padding = UDim.new(0, 5)

local ResultsScroller = Instance.new("ScrollingFrame")
ResultsScroller.Size = UDim2.new(1, 0, 1, -80)
ResultsScroller.Position = UDim2.new(0, 0, 0, 80)
ResultsScroller.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ResultsScroller.ScrollBarThickness = 4
ResultsScroller.BorderSizePixel = 0
ResultsScroller.Parent = MainContent
local ResCorner = Instance.new("UICorner", ResultsScroller)
ResCorner.CornerRadius = UDim.new(0, 8)

local ResultLayout = Instance.new("UIListLayout", ResultsScroller)
ResultLayout.Padding = UDim.new(0, 4)

local isMinimized = false
local fullSize = UDim2.new(0, 600, 0, 450)
local miniSize = UDim2.new(0, 600, 0, 40)

local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

ToggleBtn.MouseButton1Click:Connect(function()
    if not isMinimized then
        local tween = TweenService:Create(Frame, tweenInfo, {Size = miniSize})
        tween:Play()
        isMinimized = true
    else
        local tween = TweenService:Create(Frame, tweenInfo, {Size = fullSize})
        tween:Play()
        isMinimized = false
    end
end)

local currentRoot = game
local currentClassFilter = "All"
local currentSearch = ""

local function highlightText(text, search)
    if search == "" then return text end
    local s_lower = string.lower(search)
    local t_lower = string.lower(text)
    local startIdx = string.find(t_lower, s_lower)
    if startIdx then
        local before = string.sub(text, 1, startIdx - 1)
        local match = string.sub(text, startIdx, startIdx + #search - 1)
        local after = string.sub(text, startIdx + #search)
        return before .. "[" .. match .. "]" .. after
    else
        return text
    end
end

function getFullPath(obj)
    local path = obj:GetFullName()
    for k, v in pairs(serviceMap) do
        path = path:gsub("^" .. k, "game:GetService(\"" .. v .. "\")")
    end
    path = path:gsub("game:GetService%(\"Players\"%)%." .. LocalPlayer.Name, "game:GetService(\"Players\").LocalPlayer")
    return path
end

local allowed = { RemoteEvent = true, RemoteFunction = true, BindableEvent = true }

function updateList()
    for _, child in ipairs(ResultsScroller:GetChildren()) do
        if not child:IsA("UIListLayout") then child:Destroy() end
    end

    local objects = {}
    if currentRoot == game then
        for _, obj in ipairs(game:GetDescendants()) do
            if allowed[obj.ClassName] then table.insert(objects, obj) end
        end
    else
        for _, obj in ipairs(currentRoot:GetDescendants()) do
            if allowed[obj.ClassName] then table.insert(objects, obj) end
        end
    end

    local firstBtn = nil
    for _, v in ipairs(objects) do
        if currentClassFilter ~= "All" and v.ClassName ~= currentClassFilter then continue end
        if currentSearch ~= "" and not string.find(string.lower(v.Name), string.lower(currentSearch)) then continue end

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -6, 0, 28)
        btn.Text = "  " .. highlightText(v.Name, currentSearch)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 13
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.AutoButtonColor = true
        btn.Parent = ResultsScroller
        local c = Instance.new("UICorner", btn)
        c.CornerRadius = UDim.new(0, 4)

        local typeTag = Instance.new("TextLabel")
        typeTag.Size = UDim2.new(0, 80, 1, 0)
        typeTag.Position = UDim2.new(1, -85, 0, 0)
        typeTag.BackgroundTransparency = 1
        typeTag.Text = v.ClassName
        typeTag.Font = Enum.Font.Gotham
        typeTag.TextSize = 11
        typeTag.TextColor3 = Color3.fromRGB(150, 150, 150)
        typeTag.TextXAlignment = Enum.TextXAlignment.Right
        typeTag.Parent = btn

        btn.MouseButton1Click:Connect(function()
            local code = getFullPath(v)
            if setclipboard then setclipboard(code) end
            print("Copied:", code)
        end)

        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Tooltip.Text = getFullPath(v)
                Tooltip.Position = UDim2.new(0, input.Position.X + 15, 0, input.Position.Y + 15)
                Tooltip.Visible = true
            end
        end)
        btn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Tooltip.Visible = false
            end
        end)
        
        if not firstBtn then firstBtn = btn end
    end
    
    ResultsScroller.CanvasSize = UDim2.new(0, 0, 0, ResultLayout.AbsoluteContentSize.Y)
end

local services = {
    {Name = "All", Obj = game},
    {Name = "Workspace", Obj = workspace},
    {Name = "Players", Obj = game:GetService("Players")},
    {Name = "StarterGui", Obj = game:GetService("StarterGui")},
    {Name = "StarterPack", Obj = game:GetService("StarterPack")},
    {Name = "ReplicatedFirst", Obj = game:GetService("ReplicatedFirst")},
    {Name = "ReplicatedStorage", Obj = game:GetService("ReplicatedStorage")},
    {Name = "Lighting", Obj = game:GetService("Lighting")},
    {Name = "SoundService", Obj = game:GetService("SoundService")}
}

local sidebarBtns = {}

for i, srv in ipairs(services) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Text = srv.Name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BackgroundColor3 = (i == 1) and Color3.fromRGB(0, 160, 255) or Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = Sidebar
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 6)

    sidebarBtns[srv.Name] = btn

    btn.MouseButton1Click:Connect(function()
        currentRoot = srv.Obj
        for _, b in pairs(sidebarBtns) do
            b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        end
        btn.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
        updateList()
    end)
end

Sidebar.CanvasSize = UDim2.new(0, 0, 0, SidebarLayout.AbsoluteContentSize.Y + 10)

local typeFilters = {
    {Text = "All", Class = "All"},
    {Text = "Events", Class = "RemoteEvent"},
    {Text = "Funcs", Class = "RemoteFunction"},
    {Text = "Bindables", Class = "BindableEvent"}
}

local typeBtns = {}
for i, tf in ipairs(typeFilters) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.25, -5, 1, 0)
    btn.Text = tf.Text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BackgroundColor3 = (i == 1) and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = TypeFilters
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 6)

    typeBtns[tf.Class] = btn

    btn.MouseButton1Click:Connect(function()
        currentClassFilter = tf.Class
        for _, b in pairs(typeBtns) do
            b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
        btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        updateList()
    end)
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    currentSearch = SearchBox.Text
    updateList()
end)

updateList()
