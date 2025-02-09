-- anim zombie for BDFS--
     --// BETA //--
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChild("Humanoid")

-- Dừng các animation không cần thiết
local animations = Humanoid:GetPlayingAnimationTracks()
for _, track in pairs(animations) do
    if track.Name ~= "Run" and track.Name ~= "RunBack" then
        track:Stop()
    end
end

-- Tải các animation với ID đã cung cấp
local runAnim = Instance.new("Animation")
runAnim.AnimationId = "rbxassetid://6280356164"
local runBackAnim = Instance.new("Animation")
runBackAnim.AnimationId = "rbxassetid://7622527104"
local idleAnim = Instance.new("Animation")
idleAnim.AnimationId = "rbxassetid://6450315401"

-- Tải animation vào Humanoid
local loadedRunAnim = Humanoid:LoadAnimation(runAnim)
local loadedRunBackAnim = Humanoid:LoadAnimation(runBackAnim)
local loadedIdleAnim = Humanoid:LoadAnimation(idleAnim)

-- Lấy HumanoidRootPart
local humanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

RunService.RenderStepped:Connect(function()
    local velocity = humanoidRootPart.Velocity
    local speed = velocity.Magnitude

    if speed < 15 then
        -- Dừng tất cả các animation chạy
        loadedRunAnim:Stop()
        loadedRunBackAnim:Stop()
        
        if not loadedIdleAnim.IsPlaying then
            loadedIdleAnim:Play() -- Chạy animation đứng im
        end
    else
        if velocity.Z > 0 then
            if not loadedRunAnim.IsPlaying then
                loadedRunAnim:Play() -- Chạy về phía trước
            end
        elseif velocity.Z < 0 then
            if not loadedRunBackAnim.IsPlaying then
                loadedRunBackAnim:Play() -- Chạy lùi
            end
        end
    end
end)
