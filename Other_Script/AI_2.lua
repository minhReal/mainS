--[[ 
free edit please dont remove the script creator 

script with pathfindingService

by owner with chatgpt;)
]]

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local PathfindingService = game:GetService("PathfindingService")

local lp = Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Clone NPC
local npc = char:Clone()
npc.Name = lp.Name.."_Enemy"
npc.Parent = workspace

local npcHum = npc:FindFirstChildWhichIsA("Humanoid")
local npcRoot = npc:FindFirstChild("HumanoidRootPart")
local npcHead = npc:FindFirstChild("Head")
npc.PrimaryPart = npcRoot

-- Disable clip
for _, part in ipairs(npc:GetDescendants()) do
	if part:IsA("BasePart") and part ~= npcRoot then
		part.CanCollide = false
	end
end

-- Head / Neck
local npcTorso = npc:FindFirstChild("Torso") or npcRoot
local Neck = npcHead:FindFirstChild("Neck")
if not Neck then
	Neck = Instance.new("Motor6D")
	Neck.Name = "Neck"
	Neck.Part0 = npcTorso
	Neck.Part1 = npcHead
	Neck.C0 = CFrame.new(0,1,0)
	Neck.C1 = CFrame.new()
	Neck.Parent = npcHead
end
local baseC0 = Neck.C0 * CFrame.new(0,0.5,0)

RunService.RenderStepped:Connect(function()
	if npcHead and Neck and lp.Character and lp.Character.PrimaryPart then
		local targetPos = lp.Character.PrimaryPart.Position
		local dir = (targetPos - npcHead.Position).Unit
		local torsoLook = npcTorso.CFrame.LookVector
		local angleY = math.clamp(math.asin(torsoLook:Cross(dir).Y), -math.rad(80), math.rad(80))
		local angleX = math.clamp(math.asin(dir.Y), -math.rad(40), math.rad(40))
		Neck.C0 = baseC0 * CFrame.Angles(angleX, angleY, 0)
	end
end)

-- Thêm SpotLight cho NPC clone
local function addSpotLight(npcRootPart)
    if not npcRootPart then return end
    local spot = Instance.new("SpotLight")
    spot.Parent = npcRootPart
    spot.Face = Enum.NormalId.Front
    spot.Brightness = 5
    spot.Range = 15
    spot.Angle = 60
    spot.Shadows = true
end
addSpotLight(npcRoot)

-- Xoá script & sound "what"
for _, v in ipairs(npc:GetDescendants()) do
	if v:IsA("Script") or v:IsA("LocalScript") then v:Destroy() end
	if v:IsA("Sound") and v.Name == "what" then v:Destroy() end
end

-- Animation
local Animator = npcHum:FindFirstChildOfClass("Animator") or Instance.new("Animator", npcHum)
local function newAnim(id) local a=Instance.new("Animation") a.AnimationId=id return a end

local pack1 = { runF = Animator:LoadAnimation(newAnim("rbxassetid://6608487832")) }
local pack2 = { runF = Animator:LoadAnimation(newAnim("rbxassetid://79821909217725")) }
local jumpAnim = Animator:LoadAnimation(newAnim("rbxassetid://6266580007"))
local fallAnim = Animator:LoadAnimation(newAnim("rbxassetid://6266583739"))

local function playBlend(targetTracks)
	for _, track in pairs({pack1.runF, pack2.runF, jumpAnim, fallAnim}) do
		local weight = targetTracks[track] or 0
		if weight>0 and not track.IsPlaying then track:Play(0.1) end
		track:AdjustWeight(weight,0.1)
	end
end

-- Spawn xa player
local function randomSpawn()
	local angle = math.random()*2*math.pi
	local dist = math.random(30,50)
	return hrp.Position + Vector3.new(math.cos(angle)*dist,0,math.sin(angle)*dist)
end
npcRoot.CFrame = CFrame.new(randomSpawn())

-- Chạm player kill
npcRoot.Touched:Connect(function(hit)
	if hit:IsDescendantOf(lp.Character) then
		if lp.Character and lp.Character:FindFirstChild("Humanoid") then
			lp.Character.Humanoid.Health = 0
		end
	end
end)

-- Folder chứa waypoint
local WaypointFolder = workspace:FindFirstChild("Waypoints") or Instance.new("Folder", workspace)
WaypointFolder.Name = "Waypointss"
local waypoints = {}
local currentWaypointIndex = 1

local function clearWaypoints()
	for _, wp in ipairs(WaypointFolder:GetChildren()) do wp:Destroy() end
	waypoints = {}
	currentWaypointIndex = 1
end

-- Biến để dự đoán vị trí player
local lastPlayerPos = lp.Character.PrimaryPart.Position

-- Pathfinding update với dự đoán vị trí
local function updatePathPredictive()
	if not lp.Character or not lp.Character.PrimaryPart then return end
	local currentPlayerPos = lp.Character.PrimaryPart.Position
	local playerVel = currentPlayerPos - lastPlayerPos
	lastPlayerPos = currentPlayerPos

	-- Dự đoán vị trí 1.5s sau
	local predictedPos = currentPlayerPos + playerVel * 1.5

	local path = PathfindingService:CreatePath({
		AgentRadius = 2,
		AgentHeight = 5,
		AgentCanJump = true,
		AgentJumpHeight = 6,
		AgentMaxSlope = 45
	})
	path:ComputeAsync(npcRoot.Position, predictedPos)

	if path.Status == Enum.PathStatus.Success then
		clearWaypoints()
		local lastPos = npcRoot.Position
		for i, waypoint in ipairs(path:GetWaypoints()) do
			local dist = (waypoint.Position - lastPos).Magnitude
			if dist > 2 and (waypoint.Position - npcRoot.Position).Magnitude > 5 then
				local wp = Instance.new("Part")
				wp.Shape = Enum.PartType.Ball
				wp.Size = Vector3.new(1,1,1)
				wp.Anchored = true
				wp.CanCollide = false
				wp.Transparency = 1
				wp.Material = Enum.Material.Neon
				wp.BrickColor = BrickColor.new("Lime green")
				wp.Position = waypoint.Position
				wp.Name = "Waypoint"..i
				wp.Parent = WaypointFolder
				table.insert(waypoints, wp)
				lastPos = waypoint.Position
			end
			if waypoint.Action == Enum.PathWaypointAction.Jump then
				npcHum.Jump = true
			end
		end
		currentWaypointIndex = 1
	end
end

-- AI State Hunt/Chill
local currentState = "hunt"
task.spawn(function()
	while true do
		if math.random()<0.7 then currentState="hunt" else currentState="chill" end
		wait(math.random(5,10))
	end
end)

-- Di chuyển theo waypoint
local function moveTowards()
	if #waypoints == 0 then return end
	local targetWP = waypoints[currentWaypointIndex]
	if not targetWP then return end

	local targetPos = targetWP.Position
	local dir = targetPos - npcRoot.Position
	local horizontalDir = Vector3.new(dir.X,0,dir.Z)
	local distance = horizontalDir.Magnitude

	if distance < 2 then
		if currentWaypointIndex < #waypoints then
			currentWaypointIndex = currentWaypointIndex + 1
		end
		return
	end

	local moveDir = horizontalDir.Unit
	npcHum:Move(moveDir)

	local targetTracks = {}
	if currentState=="chill" then
		npcHum.WalkSpeed = 15.5
		targetTracks[pack1.runF]=1
	else
		npcHum.WalkSpeed = 23.8
		targetTracks[pack2.runF]=1
	end
	playBlend(targetTracks)

	local state = npcHum:GetState()
	if state==Enum.HumanoidStateType.Jumping then
		playBlend({[jumpAnim]=1})
	elseif state==Enum.HumanoidStateType.Freefall then
		playBlend({[fallAnim]=1})
	end
end

-- Update path liên tục
task.spawn(function()
	while task.wait(0.1) do -- check 10 lần / giây
		updatePathPredictive()
	end
end)

-- Main loop
RunService.RenderStepped:Connect(function()
	moveTowards()
end)

-- Gắn DAO vào tay
local knifePart = Workspace:WaitForChild("Buyables"):WaitForChild("Tools"):WaitForChild("Knife")
if knifePart then
	local knifeClone = knifePart:Clone()
	knifeClone.Parent = npc
	local rightHand = npc:FindFirstChild("RightHand") or npc:FindFirstChild("Right Arm")
	if rightHand then
		knifeClone.Anchored = false
		knifeClone.CanCollide = false
		local weld = Instance.new("Weld")
		weld.Part0 = rightHand
		weld.Part1 = knifeClone
		weld.C0 = CFrame.new(0,-1,-1.1) * CFrame.Angles(-165,math.rad(-5),0)
		weld.Parent = knifeClone
	end
end

-- Khi player chết
local function onPlayerDied()
	npcHum.WalkSpeed = 0.01
	task.spawn(function()
		while true do
			local emoteAnim = Instance.new("Animation")
			emoteAnim.AnimationId = "rbxassetid://6323596869"
			local emoteTrack = npcHum:LoadAnimation(emoteAnim)
			emoteTrack:Play()
			local sound = Instance.new("Sound")
			sound.SoundId = "rbxassetid://617500399"
			sound.Volume = 1
			sound.Parent = npcRoot
			sound:Play()
			task.wait(5.5)
			emoteTrack:Stop()
			sound:Stop()
			sound:Destroy()
		end
	end)
end

if lp.Character and lp.Character:FindFirstChild("Humanoid") then
	lp.Character.Humanoid.Died:Connect(onPlayerDied)
end
