local v0 = game:GetService("TweenService")
local v1 = {"📢", "😴", "😜", "😝", "🥰", "🙈", "💀", "🤯", "😳"}
local v2 = v1[math.random(1, #v1)]

local function newInstance(className, props)
    local inst = Instance.new(className)
    for prop, value in pairs(props) do
        inst[prop] = value
    end
    return inst
end

-- Tạo ScreenGui
local v3 = newInstance("ScreenGui", {Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")})

-- Frame chính
local v5 = newInstance("Frame", {
    Size = UDim2.new(0.5, 0, 0.5, 0),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    BackgroundColor3 = Color3.new(1, 1, 1),
    BorderSizePixel = 0,
    BackgroundTransparency = 0.1,
    Parent = v3
})

-- Label icon random
local v15 = newInstance("TextLabel", {
    Size = UDim2.new(0.3, 0, 0.2, 0),
    Position = UDim2.new(0.35, 0, 0, 0),
    BackgroundColor3 = Color3.new(0, 0, 0),
    BorderSizePixel = 1,
    Text = v2,
    TextSize = 23,
    BackgroundTransparency = 0.3,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.Code,
    Parent = v5
})

-- Label credit
local v28 = newInstance("TextLabel", {
    Size = UDim2.new(0.3, 0, 0.2, 0),
    Position = UDim2.new(0.35, 0, 1, 0),
    BackgroundColor3 = Color3.new(0, 0, 0),
    BorderSizePixel = 1,
    Text = "Script by Hydro(MinhReal)",
    TextSize = 23,
    BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.Code,
    Parent = v5
})

-- Tween 1
local v40 = v0:Create(v15, TweenInfo.new(1), {Position = UDim2.new(0.35, 0, 0.2, 0)})
local v41 = v0:Create(v28, TweenInfo.new(1), {Position = UDim2.new(0.35, 0, 0.35, 0)})

v40:Play()
v40.Completed:Wait()

v41:Play()
v41.Completed:Wait()

-- Tween ra ngoài
local v41Out = v0:Create(v28, TweenInfo.new(1), {Position = UDim2.new(0.35, 0, -1, 0)})
local v40Out = v0:Create(v15, TweenInfo.new(1), {Position = UDim2.new(0.35, 0, 2, 0)})

v41Out:Play()
v40Out:Play()

v40Out.Completed:Wait()
v41Out.Completed:Wait()

-- Xoá toàn bộ GUI
v3:Destroy()
