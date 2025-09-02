local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

local desc = hum:GetAppliedDescription()
local npc = Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType.R6)
npc.Name = lp.Name
npc.Parent = workspace

local npcHum = npc:WaitForChild("Humanoid")
local npcRoot = npc:WaitForChild("HumanoidRootPart")
npc.PrimaryPart = npcRoot
npcRoot.CFrame = hrp.CFrame * CFrame.new(5, 0, 0)

for _, inst in ipairs(npc:GetDescendants()) do
    if inst:IsA("BasePart") then
        inst.CanCollide = true
        inst.Massless = false
    end
end

-- Animation IDs R6
local animIds = {
    idle   = "http://www.roblox.com/asset/?id=180435571",
    walk   = "http://www.roblox.com/asset/?id=180426354",
    run    = "http://www.roblox.com/asset/?id=180426354",
    jump   = "http://www.roblox.com/asset/?id=125750702",
    fall   = "http://www.roblox.com/asset/?id=180436148",
}

-- Animator
local animator = Instance.new("Animator")
animator.Parent = npcHum

local animTracks = {}
for state, id in pairs(animIds) do
    local anim = Instance.new("Animation")
    anim.AnimationId = id
    animTracks[state] = animator:LoadAnimation(anim)
end

local currentAnim = nil
local function stopAll()
    for _, track in pairs(animTracks) do
        if track.IsPlaying then track:Stop() end
    end
end
local function playAnim(name)
    if currentAnim == name then return end
    stopAll()
    local track = animTracks[name]
    if track then
        track:Play()
        currentAnim = name
    end
end

playAnim("idle")

npcHum.StateChanged:Connect(function(_, new)
    if new == Enum.HumanoidStateType.Jumping then
        playAnim("jump")
    elseif new == Enum.HumanoidStateType.Freefall then
        playAnim("fall")
    elseif new == Enum.HumanoidStateType.Landed then
        if npcHum.MoveDirection.Magnitude > 0 then
            playAnim("walk")
        else
            playAnim("idle")
        end
    end
end)

task.spawn(function()
    while task.wait(0.25) do
        if not npc.Parent then break end
        if not char.Parent then continue end

        local dist = (npcRoot.Position - hrp.Position).Magnitude
        if dist > 6 then
            local offset = Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))
            local target = hrp.Position + offset
            playAnim("walk")
            npcHum:MoveTo(target)
            else
            local chance = math.random(1, 10)
            if chance == 1 then
                npcHum.Jump = true
            else
                playAnim("idle")
            end
        end
    end
end)
