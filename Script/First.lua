-- anim idk for BDFS --
-- // FIXED FULL VERSION // --

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "patrickGui"
gui.Parent = game.CoreGui

local ru = Instance.new("ImageButton")
ru.Size = UDim2.new(0.08, 0, 0.15, 0)
ru.Position = UDim2.new(0.8, 0, 0.5, 0)
ru.BackgroundTransparency = 1
ru.ImageColor3 = Color3.new(1, 1, 1)
ru.Image = "rbxassetid://17580004188"
ru.Parent = gui

local images = {run="rbxassetid://17580004188", walk="rbxassetid://17579998673"}

-- Hover effect
ru.MouseEnter:Connect(function() ru.ImageColor3 = Color3.fromRGB(200,200,255) end)
ru.MouseLeave:Connect(function() ru.ImageColor3 = Color3.new(1,1,1) end)

-- === CHARACTER AND ANIMATION ===
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

local Animator = Humanoid:FindFirstChildOfClass("Animator")
if not Animator then
    Animator = Instance.new("Animator")
    Animator.Parent = Humanoid
end

for _, track in pairs(Humanoid:GetPlayingAnimationTracks()) do
    track:Stop()
end

local function newAnim(id) local a = Instance.new("Animation") a.AnimationId = id return a end

-- Packs
local pack1 = {
    idle = Animator:LoadAnimation(newAnim("rbxassetid://6450315401")),
    runF = Animator:LoadAnimation(newAnim("rbxassetid://6280356164")),
    runB = Animator:LoadAnimation(newAnim("rbxassetid://7622527104")),
    runR = Animator:LoadAnimation(newAnim("rbxassetid://7622638623")),
    runL = Animator:LoadAnimation(newAnim("rbxassetid://7622624472")),
}

local pack2 = {
    runF = Animator:LoadAnimation(newAnim("rbxassetid://79821909217725")),
    runB = Animator:LoadAnimation(newAnim("rbxassetid://7417236954")),
    runR = Animator:LoadAnimation(newAnim("rbxassetid://742107911")),
    runL = Animator:LoadAnimation(newAnim("rbxassetid://7421211445")),
}

local jumpAnim = Animator:LoadAnimation(newAnim("rbxassetid://6266580007"))
local fallAnim = Animator:LoadAnimation(newAnim("rbxassetid://6266583739"))
local climbAnim = Animator:LoadAnimation(newAnim("http://www.roblox.com/asset/?id=180436334"))

-- SMOOTH BLENDING FUNCTION
local function playBlend(targetTracks)
    for _, track in pairs({pack1.runF, pack1.runB, pack1.runR, pack1.runL,
                           pack2.runF, pack2.runB, pack2.runR, pack2.runL,
                           pack1.idle}) do
        local weight = targetTracks[track] or 0
        if weight > 0 and not track.IsPlaying then
            track:Play(0.05) -- fade 
        end
        track:AdjustWeight(weight, 0.05) -- fade 
    end
end

-- Humanoid state handler
Humanoid.StateChanged:Connect(function(_, newState)
    if newState == Enum.HumanoidStateType.Jumping then
        jumpAnim:AdjustSpeed(1.1)
        playBlend({[jumpAnim]=1})
    elseif newState == Enum.HumanoidStateType.Freefall then
        fallAnim:AdjustSpeed(1)
        playBlend({[fallAnim]=1})
    elseif newState == Enum.HumanoidStateType.Climbing then
        climbAnim:AdjustSpeed(1)
        playBlend({[climbAnim]=1})
    elseif newState == Enum.HumanoidStateType.Landed
        or newState == Enum.HumanoidStateType.Running
        or newState == Enum.HumanoidStateType.None then
        jumpAnim:AdjustWeight(0,0.05)
        fallAnim:AdjustWeight(0,0.05)
        climbAnim:AdjustWeight(0,0.05)
    end
end)

-- RUN/WALK TOGGLE
local isRun = true
local function updateSpeed()
    Humanoid.WalkSpeed = isRun and 16 or 23
end

ru.MouseButton1Click:Connect(function()
    isRun = not isRun
    ru.Image = isRun and images.run or images.walk
    updateSpeed()
end)

-- ANIMATION UPDATE LOOP
RunService.RenderStepped:Connect(function()
    local state = Humanoid:GetState()
    if state == Enum.HumanoidStateType.Jumping
    or state == Enum.HumanoidStateType.Freefall
    or state == Enum.HumanoidStateType.Climbing then return end

    local velocity = HRP.Velocity * Vector3.new(1,0,1)
    local speed = velocity.Magnitude
    local targetTracks = {}

    local pack = (Humanoid.WalkSpeed == 16) and pack1 or pack2

    if speed < 2 then
        targetTracks[pack1.idle] = 1
    else
        local moveDir = HRP.CFrame:VectorToObjectSpace(velocity.Unit)
        local absX = math.abs(moveDir.X)
        local absZ = math.abs(moveDir.Z)
        local total = absX + absZ
        if total == 0 then total = 1 end

        targetTracks[pack.runF] = math.max(0, -moveDir.Z/total)
        targetTracks[pack.runB] = math.max(0, moveDir.Z/total)
        targetTracks[pack.runR] = math.max(0, moveDir.X/total)
        targetTracks[pack.runL] = math.max(0, -moveDir.X/total)
    end

    playBlend(targetTracks)
end)

updateSpeed()
