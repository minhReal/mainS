local TweenService, Random = game:GetService("TweenService"), math.random
local gui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
local Jj = Instance.new("Frame", gui)
Jj.Size, Jj.Position, Jj.BackgroundTransparency, Jj.Active, Jj.BorderColor3 = UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0.25, 0, 0.5, 0), 1, true, Color3.new(0, 0, 0)

local Em = {"📢", "😴", "😜", "😝", "🥰", "🙈", "💀", "🤯", "😳"}
local texts = {Em[Random(1, #Em)], "Scr" .. "ipt by " .. "Hydro(MinhReal)"}
local labels = {}

for i, text in ipairs(texts) do
    local label = Instance.new("TextLabel", Jj)
    label.Size, label.Position, label.BackgroundTransparency, label.TextColor3, label.Font, label.TextSize = UDim2.new(0.3, 0, 0.2, 0), UDim2.new(0.35, 0, 2, 0), 1, Color3.fromRGB(255, 255, 255), Enum.Font.Code, 23
    label.Text = text
    table.insert(labels, label)
end

local tweens = {}
for i, label in ipairs(labels) do
    local targetPos = i == 1 and UDim2.new(0.35, 0, 0.2, 0) or UDim2.new(0.35, 0, 0.35, 0)
    table.insert(tweens, TweenService:Create(label, TweenInfo.new(1), {Position = targetPos}))
end

tweens[1]:Play()
wait(0.15)
tweens[2]:Play()

wait(2.5)
for _, label in ipairs(labels) do
    local returnTween = TweenService:Create(label, TweenInfo.new(1), {Position = UDim2.new(0.35, 0, 2, 0)})
    returnTween:Play()
    returnTween.Completed:Wait()
end

for _, label in ipairs(labels) do label:Destroy() end
