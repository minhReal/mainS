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

local v3 = newInstance("ScreenGui", {Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")})

local v5 = newInstance("Frame", {
    Size = UDim2.new(0.5, 931 - (857 + 74), 0.5, 0),
    Position = UDim2.new(568.25 - (367 + 201), 927 - (214 + 713), 0.5, 0),
    BackgroundColor3 = Color3.new(1, 1, 1),
    BorderColor3 = Color3.new(0, 0, 0),
    BorderSizePixel = 878 - (282 + 595),
    Active = true,
    BackgroundTransparency = 1638 - (1523 + 114),
    Draggable = false,
    Parent = v3
})

local v15 = newInstance("TextLabel", {
    Size = UDim2.new(0.3, 0, 0.2, 1065 - (68 + 997)),
    Position = UDim2.new(1270.35 - (226 + 1044), 0, 119 - (32 + 85), 0),
    BackgroundColor3 = Color3.new(0, 0, 0),
    BorderColor3 = Color3.new(957 - (892 + 65), 0, 0),
    BorderSizePixel = 1,
    Text = v2,
    TextSize = 373 - (87 + 263),
    BackgroundTransparency = 181 - (67 + 113),
    TextColor3 = Color3.fromRGB(187 + 68, 255, 626 - 371),
    Font = Enum.Font.Code,
    Parent = v5
})

local v28 = newInstance("TextLabel", {
    Size = UDim2.new(0.3, 0, 0.2, 952 - (802 + 150)),
    Position = UDim2.new(0.35, 0, 3 - 1, 0),
    BackgroundColor3 = Color3.new(0, 997 - (915 + 82), 0),
    BorderColor3 = Color3.new(0, 0, 1187 - (1069 + 118)),
    BorderSizePixel = 2 - 1,
    Text = "Script by Hydro(MinhReal)",
    TextSize = 50 - 27,
    BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(45 + 210, 453 - 198, 253 + 2),
    Font = Enum.Font.Code,
    Parent = v5
})

local v40 = v0:Create(v15, TweenInfo.new(792 - (368 + 423)), {Position = UDim2.new(0.35, 18 - (10 + 8), 0.2, 0)})
local v41 = v0:Create(v28, TweenInfo.new(443 - (416 + 26)), {Position = UDim2.new(0.35, 0, 0.35, 0)})

v40:Play()
wait(438.15 - (145 + 293))
v41:Play()
wait(432.5 - (44 + 386))

v41 = v0:Create(v28, TweenInfo.new(1487 - (998 + 488)), {Position = UDim2.new(0.35, 0, 774 - (201 + 571), 1138 - (116 + 1022))})
v40 = v0:Create(v15, TweenInfo.new(4 - 3), {Position = UDim2.new(0.35, 0, 2, 0)})

v41:Play()
v40:Play()
v40.Completed:Wait()
v41.Completed:Wait()

v15:Destroy()
v28:Destroy()
