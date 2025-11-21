local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- List of services to convert to game:GetService
local serviceMap = {
    Players = "Players",
    Workspace = "Workspace",
    ReplicatedStorage = "ReplicatedStorage",
    StarterPlayer = "StarterPlayer",
    Lighting = "Lighting",
    CoreGui = "CoreGui",
    PlayerGui = "Players.LocalPlayer:WaitForChild('PlayerGui')",
}

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 450, 0, 450)
Frame.Position = UDim2.new(0.5, -225, 0.5, -225)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.BorderSizePixel = 0
Frame.ClipsDescendants = true
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner", Frame)
FrameCorner.CornerRadius = UDim.new(0, 12)
local FrameStroke = Instance.new("UIStroke", Frame)
FrameStroke.Thickness = 2
FrameStroke.Color = Color3.fromRGB(90, 90, 90)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Event Finder"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.Parent = Frame

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Parent = Frame
local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Toggle Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 30, 0, 30)
ToggleBtn.Position = UDim2.new(1, -70, 0, 5)
ToggleBtn.Text = "-"
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 18
ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Parent = Frame
local ToggleCorner = Instance.new("UICorner", ToggleBtn)
ToggleCorner.CornerRadius = UDim.new(0, 6)

local isMinimized = false
local originalSize = Frame.Size
local originalPosition = Frame.Position

ToggleBtn.MouseButton1Click:Connect(function()
    if not isMinimized then
        Frame.Size = UDim2.new(0, 200, 0, 40)
        Frame.Position = UDim2.new(0.5, -100, 0.5, -20)
        isMinimized = true
    else
        Frame.Size = originalSize
        Frame.Position = originalPosition
        isMinimized = false
    end
end)

-- Search Box
local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -20, 0, 35)
SearchBox.Position = UDim2.new(0, 10, 0, 50)
SearchBox.PlaceholderText = "Search..."
SearchBox.TextSize = 18
SearchBox.Font = Enum.Font.Gotham
SearchBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.Parent = Frame
local SearchCorner = Instance.new("UICorner", SearchBox)
SearchCorner.CornerRadius = UDim.new(0, 8)

-- Filter Buttons
local FilterFrame = Instance.new("Frame")
FilterFrame.Size = UDim2.new(1, -20, 0, 40)
FilterFrame.Position = UDim2.new(0, 10, 0, 95)
FilterFrame.BackgroundTransparency = 1
FilterFrame.Parent = Frame

local FilterLayout = Instance.new("UIListLayout", FilterFrame)
FilterLayout.FillDirection = Enum.FillDirection.Horizontal
FilterLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
FilterLayout.Padding = UDim.new(0, 10)

local filterMode = "All"
local function createFilterBtn(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.23, 0, 1, 0)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.AutoButtonColor = false
    btn.Parent = FilterFrame
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 8)

    btn.MouseButton1Click:Connect(function()
        filterMode = name
        updateList(SearchBox.Text)
    end)
end

createFilterBtn("All")
createFilterBtn("Events")
createFilterBtn("Functions")
createFilterBtn("Bindables")

-- Scrolling Frame
local Scroller = Instance.new("ScrollingFrame")
Scroller.Size = UDim2.new(1, -20, 1, -150)
Scroller.Position = UDim2.new(0, 10, 0, 145)
Scroller.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Scroller.ScrollBarThickness = 6
Scroller.Parent = Frame

local ListLayout = Instance.new("UIListLayout", Scroller)
ListLayout.Padding = UDim.new(0, 5)

-- Event Logic
local allowed = { RemoteEvent = true, RemoteFunction = true, BindableEvent = true }

local function findAllEvents()
    local list = {}
    for _, obj in ipairs(game:GetDescendants()) do
        if allowed[obj.ClassName] then
            table.insert(list, obj)
        end
    end
    return list
end

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
    -- map service names
    for k, v in pairs(serviceMap) do
        path = path:gsub("^" .. k, "game:GetService(\"" .. v .. "\")")
    end
    -- special case for LocalPlayer
    path = path:gsub("game:GetService%(\"Players\"%)%." .. LocalPlayer.Name, "game:GetService(\"Players\").LocalPlayer")
    return path
end

function updateList(filter)
    for _, child in ipairs(Scroller:GetChildren()) do
        if not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end

    local events = findAllEvents()
    local firstBtn = nil

    for _, v in ipairs(events) do
        if filterMode ~= "All" and v.ClassName ~= filterMode then
            continue
        end
        if filter ~= "" and not string.find(string.lower(v.Name), string.lower(filter)) then
            continue
        end

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -5, 0, 32)
        btn.Text = highlightText(v.Name, filter) .. " [" .. v.ClassName .. "]"
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 15
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextWrapped = true
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Parent = Scroller
        local btnCorner = Instance.new("UICorner", btn)
        btnCorner.CornerRadius = UDim.new(0, 6)

        -- Click = copy path
        btn.MouseButton1Click:Connect(function()
            local code = getFullPath(v)
            if setclipboard then setclipboard(code) end
            print("Copied path:", code)
        end)

        -- Tooltip at click/touch position
        local Tooltip = Instance.new("TextLabel")
        Tooltip.Size = UDim2.new(0, 300, 0, 25)
        Tooltip.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Tooltip.TextColor3 = Color3.fromRGB(255, 255, 0)
        Tooltip.TextSize = 14
        Tooltip.Font = Enum.Font.Gotham
        Tooltip.TextWrapped = true
        Tooltip.Visible = false
        Tooltip.AnchorPoint = Vector2.new(0, 0)
        Tooltip.Parent = Frame
        local TooltipCorner = Instance.new("UICorner", Tooltip)
        TooltipCorner.CornerRadius = UDim.new(0, 6)

        local function showTooltip(pos)
            Tooltip.Text = getFullPath(v)
            Tooltip.Position = UDim2.new(0, pos.X + 10, 0, pos.Y + 10)
            Tooltip.Visible = true
        end

        local function hideTooltip()
            Tooltip.Visible = false
        end

        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                showTooltip(input.Position)
            end
        end)

        btn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                hideTooltip()
            end
        end)

        if not firstBtn then
            firstBtn = btn
        end
    end

    if firstBtn then
        Scroller.CanvasPosition = Vector2.new(0, firstBtn.Position.Y.Offset)
    end
    Scroller.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
end

-- Initial load
updateList("")

-- Update search dynamically
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    updateList(SearchBox.Text)
end)
