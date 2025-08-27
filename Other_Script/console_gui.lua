-- script by ChatGPT
-- Gui by owner🕴️
local TweenService = game:GetService("TweenService")
local LogService = game:GetService("LogService")

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "sigma boi"
gui.Parent = game.CoreGui

-- Frame chính
local hh = Instance.new("Frame")
hh.Size = UDim2.new(0.5, 0, 0.6, 0)
hh.Position = UDim2.new(0.3, 0, 0.2, 0)
hh.BorderColor3 = Color3.new(0, 0, 0)
hh.BorderSizePixel = 1
hh.Active = true
hh.BackgroundTransparency = 0.5
hh.Draggable = true
hh.Parent = gui

-- ScrollingFrame (console hiển thị log)
local ma = Instance.new("ScrollingFrame")
ma.Size = UDim2.new(0.9, 0, 0.6, 0)
ma.Position = UDim2.new(0.05, 0, 0.13, 0)
ma.BackgroundColor3 = Color3.new(0,0,0)
ma.BorderColor3 = Color3.new(0, 0, 0)
ma.BorderSizePixel = 1
ma.CanvasSize = UDim2.new(0,0,0,0)
ma.AutomaticCanvasSize = Enum.AutomaticSize.Y
ma.ScrollBarThickness = 6
ma.Parent = hh

-- UIListLayout để sắp xếp log
local layout = Instance.new("UIListLayout")
layout.Parent = ma
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Nút Copy
local copy = Instance.new("TextButton")
copy.Size = UDim2.new(0.3, 0, 0.2, 0)
copy.Position = UDim2.new(0.05, 0, 0.775, 0)
copy.BackgroundColor3 = Color3.new(0,0,0)
copy.Text = "Copy"
copy.TextColor3 = Color3.new(1, 0, 1)
copy.Font = Enum.Font.Code
copy.TextSize = 15
copy.Parent = hh

-- Nút Clear
local del = Instance.new("TextButton")
del.Size = UDim2.new(0.3, 0, 0.2, 0)
del.Position = UDim2.new(0.38, 0, 0.775, 0)
del.BackgroundColor3 = Color3.new(0, 0, 0)
del.Text = "Clear"
del.TextColor3 = Color3.new(1, 1, 1)
del.Font = Enum.Font.Code
del.TextSize = 15
del.Parent = hh

-- Nút X (xóa GUI)
local x = Instance.new("TextButton")
x.Size = UDim2.new(0.05, 0, 0.08, 0)
x.Position = UDim2.new(0.01, 0, 0.01, 0)
x.BackgroundColor3 = Color3.new(1,0,0)
x.BorderColor3 = Color3.new(0, 0, 0)
x.BorderSizePixel = 1
x.Text = "X"
x.TextSize = 18
x.BackgroundTransparency = 0 
x.TextColor3 = Color3.new(1, 1, 1)
x.Font = Enum.Font.Code
x.Parent = hh

-- Nút I (ẩn/hiện GUI)
local i = Instance.new("TextButton")
i.Size = UDim2.new(0.09, 0, 0.08, 0)
i.Position = UDim2.new(0.075, 0, 0.01, 0)
i.BackgroundColor3 = Color3.new(0,0,1)
i.BorderColor3 = Color3.new(0, 0, 0)
i.BorderSizePixel = 1
i.Text = "-"
i.TextSize = 18
i.BackgroundTransparency = 0 
i.TextColor3 = Color3.new(1, 1, 1)
i.Font = Enum.Font.Code
i.Parent = hh

-- Save size gốc để toggle
local originalSize = hh.Size
local minimizedSize = UDim2.new(0.1, 0, 0.2, 0)
local minimized = false

i.MouseButton1Click:Connect(function()
    minimized = not minimized
    local goalSize = minimized and minimizedSize or originalSize

    local tween = TweenService:Create(hh, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = goalSize})
    tween:Play()

    for _, btn in ipairs({copy, del, ma}) do
        btn.Visible = not minimized
    end
end)

-- Hàm thêm log vào console (TextBox editable + auto xuống dòng)
local function addLog(msg, color)
    local log = Instance.new("TextBox")
    log.Size = UDim2.new(1, -5, 0, 0)
    log.BackgroundTransparency = 1
    log.TextXAlignment = Enum.TextXAlignment.Left
    log.TextYAlignment = Enum.TextYAlignment.Top
    log.Font = Enum.Font.Code
    log.TextSize = 14
    log.TextWrapped = true
    log.AutomaticSize = Enum.AutomaticSize.Y
    log.ClearTextOnFocus = false
    log.MultiLine = true
    log.TextEditable = true
    log.Text = msg
    log.TextColor3 = color or Color3.new(1,1,1)

    local textConstraint = Instance.new("UITextSizeConstraint")
    textConstraint.MaxTextSize = 18
    textConstraint.MinTextSize = 10
    textConstraint.Parent = log

    log.Parent = ma
    task.wait()
    ma.CanvasPosition = Vector2.new(0, ma.AbsoluteCanvasSize.Y)
end

-- Clear button
del.MouseButton1Click:Connect(function()
    for _, child in pairs(ma:GetChildren()) do
        if child:IsA("TextBox") then
            child:Destroy()
        end
    end
end)

-- Copy button
copy.MouseButton1Click:Connect(function()
    local text = ""
    for _, child in pairs(ma:GetChildren()) do
        if child:IsA("TextBox") then
            text = text .. child.Text .. "\n"
        end
    end
    if setclipboard then
        setclipboard(text)
    end
end)

-- X button
x.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Bắt log Roblox
LogService.MessageOut:Connect(function(msg, msgType)
    local color = Color3.new(1,1,1)
    if msgType == Enum.MessageType.MessageError then
        color = Color3.new(1,0,0) -- đỏ: error
    elseif msgType == Enum.MessageType.MessageWarning then
        color = Color3.new(1,1,0) -- vàng: warn
    end
    addLog(msg, color)
end)

-- Test
print("✅ Console GUI enabled!")
warn("⚠ This is a test warning.")
error("❌ This is a very long test error to check if there is a line break, look at the console!")
