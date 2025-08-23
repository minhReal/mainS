-- anim zombie for BDFS --
-- // FIXED FULL VERSION // --

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

-- Animator
local Animator = Humanoid:FindFirstChildOfClass("Animator")
if not Animator then
    Animator = Instance.new("Animator")
    Animator.Parent = Humanoid
end

-- Xoá anim mặc định
for _, track in pairs(Humanoid:GetPlayingAnimationTracks()) do
    track:Stop()
end

-- Animation assets
local runAnim = Instance.new("Animation")
runAnim.AnimationId = "rbxassetid://6280356164" -- Run Forward

local runBackAnim = Instance.new("Animation")
runBackAnim.AnimationId = "rbxassetid://7622527104" -- Run Back

local runRightAnim = Instance.new("Animation")
runRightAnim.AnimationId = "rbxassetid://7622638623" -- Run Right

local runLeftAnim = Instance.new("Animation")
runLeftAnim.AnimationId = "rbxassetid://7622624472" -- Run Left

local idleAnim = Instance.new("Animation")
idleAnim.AnimationId = "rbxassetid://6450315401" -- Idle

-- Load Animations
local loadedRunAnim = Animator:LoadAnimation(runAnim)
local loadedRunBackAnim = Animator:LoadAnimation(runBackAnim)
local loadedRunRightAnim = Animator:LoadAnimation(runRightAnim)
local loadedRunLeftAnim = Animator:LoadAnimation(runLeftAnim)
local loadedIdleAnim = Animator:LoadAnimation(idleAnim)

-- Hàm đổi anim
local function playAnim(anim)
    for _, track in pairs(Animator:GetPlayingAnimationTracks()) do
        if track ~= anim then
            track:Stop()
        end
    end
    if not anim.IsPlaying then
        anim:Play()
    end
end

-- Update animation theo velocity
RunService.RenderStepped:Connect(function()
    local velocity = HRP.Velocity * Vector3.new(1,0,1) -- bỏ Y
    local speed = velocity.Magnitude

    if speed < 2 then
        playAnim(loadedIdleAnim)
    else
        -- Tính hướng chuyển động so với nhân vật
        local moveDir = HRP.CFrame:VectorToObjectSpace(velocity.Unit)

        -- Chia hướng dựa theo Z (trước/sau) và X (trái/phải)
        if math.abs(moveDir.Z) > math.abs(moveDir.X) then
            if moveDir.Z < 0 then
                playAnim(loadedRunAnim) -- đi tới
            else
                playAnim(loadedRunBackAnim) -- đi lùi
            end
        else
            if moveDir.X > 0 then
                playAnim(loadedRunRightAnim) -- đi phải
            else
                playAnim(loadedRunLeftAnim) -- đi trái
            end
        end
    end
end)
