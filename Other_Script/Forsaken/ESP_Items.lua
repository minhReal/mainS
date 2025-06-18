-- highlight items
local gui = Instance.new("ScreenGui")
gui.Name = "Gui"
gui.Parent = game.CoreGui

local m = Instance.new("TextButton")
m.Size = UDim2.new(0.05, 0, 0.1, 0)
m.Position = UDim2.new(0.1, 0, 0.5, 0)
m.BackgroundColor3 = Color3.new(0, 0, 0)
m.BorderColor3 = Color3.new(0, 0, 0)
m.BorderSizePixel = 1
m.Text = "§"
m.TextSize = 20
m.BackgroundTransparency = 0
m.TextColor3 = Color3.new(1, 1, 1)
m.Font = Enum.Font.Code
m.Draggable = true
m.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 5)
corner.Parent = m

local espEnabled = true -- Trạng thái của ESP

-- Hàm tạo Billboard cho tool
local function createBillboard(tool)
    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = tool
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true

    local textLabel = Instance.new("TextLabel", billboard)
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = tool.Name
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextStrokeTransparency = 0.5

    billboard.Parent = tool
end

-- Hàm tạo Highlight cho tool
local function createHighlight(tool)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = tool
    highlight.FillColor = Color3.new(1, 1, 1) -- Màu sắc highlight (trắng)
    highlight.OutlineColor = Color3.new(1, 1, 1) -- Màu viền (trắng)
    highlight.FillTransparency = 0.7 -- Độ trong suốt của fill
    highlight.OutlineTransparency = 0.5 -- Độ trong suốt của outline
    highlight.Parent = tool
end

-- Hàm cập nhật Billboard và Highlight cho tất cả tool trong Ingame
local function updateBillboardsAndHighlights()
    for _, obj in pairs(workspace.Map.Ingame:GetChildren()) do
        if obj:IsA("Tool") then
            if espEnabled then
                -- Tạo Billboard nếu chưa có
                if not obj:FindFirstChildOfClass("BillboardGui") then
                    createBillboard(obj)
                end
                
                -- Tạo Highlight nếu chưa có
                if not obj:FindFirstChildOfClass("Highlight") then
                    createHighlight(obj)
                end
            else
                -- Xóa Billboard nếu ESP bị tắt
                local billboard = obj:FindFirstChildOfClass("BillboardGui")
                if billboard then
                    billboard:Destroy()
                end

                -- Xóa Highlight nếu highlight bị tắt
                local highlight = obj:FindFirstChildOfClass("Highlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end

-- Kết nối sự kiện nhấn nút để bật/tắt ESP
m.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled -- Đảo ngược trạng thái ESP
    updateBillboardsAndHighlights() -- Cập nhật Billboard và Highlight theo trạng thái mới
end)

-- Chạy liên tục để cập nhật Billboard và Highlight
while true do
    updateBillboardsAndHighlights()
    wait(1) -- Cập nhật mỗi 0.1 giây
end
