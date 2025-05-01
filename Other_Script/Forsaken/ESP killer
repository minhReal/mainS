-- highlight killer
local Players = game:GetService("Players")
local workspace = game:GetService("Workspace")

local gui = Instance.new("ScreenGui")
gui.Name = "Gui"
gui.Parent = game.CoreGui

local m = Instance.new("TextButton")
m.Size = UDim2.new(0.05, 0, 0.1, 0)
m.Position = UDim2.new(0.1, 0, 0.3, 0)
m.BackgroundColor3 = Color3.new(0, 0, 0)
m.BorderColor3 = Color3.new(0, 0, 0)
m.BorderSizePixel = 1
m.Text = "π"
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
local highlights = {} -- Lưu trữ các highlight

-- Hàm tạo Highlight cho Torso
local function createHighlight(part)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = part
    highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Màu đỏ
    highlight.OutlineColor = Color3.fromRGB(255, 0, 0) -- Màu đỏ viền
    highlight.FillTransparency = 0.3 -- Độ trong suốt của màu fill
    highlight.OutlineTransparency = 0
    highlight.Parent = part
    return highlight
end

-- Hàm cập nhật Highlight cho tất cả model trong Killers
local function updateHighlights()
    for _, killerModel in pairs(workspace.Players.Killers:GetChildren()) do
        if killerModel:IsA("Model") then
            local torso = killerModel:FindFirstChild("Torso") -- Thay HumanoidRootPart bằng Torso
            if torso then
                if espEnabled then
                    if not highlights[torso] then
                        highlights[torso] = createHighlight(torso)
                    end
                else
                    if highlights[torso] then
                        highlights[torso]:Destroy()
                        highlights[torso] = nil
                    end
                end
            end
        end
    end
end

-- Kết nối sự kiện nhấn nút để bật/tắt ESP
m.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled -- Đảo ngược trạng thái ESP
    updateHighlights() -- Cập nhật Highlight theo trạng thái mới
end)

-- Chạy liên tục để cập nhật Highlight
while true do
    updateHighlights()
    wait(1) -- Cập nhật mỗi giây
end
