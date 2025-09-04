-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

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

-- Disable clip tay/chÃ¢n
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

    -- Tạo SpotLight
    local spot = Instance.new("SpotLight")
    spot.Parent = npcRootPart
    spot.Face = Enum.NormalId.Front   -- hướng ánh sáng ra phía trước
    spot.Brightness = 5               -- độ sáng
    spot.Range = 15                   -- khoảng cách chiếu
    spot.Angle = 60                   -- góc chiếu
    spot.Shadows = true               -- tạo bóng
end

addSpotLight(npcRoot)

-- script & sound "what"
for _, v in ipairs(npc:GetDescendants()) do
	if v:IsA("Script") or v:IsA("LocalScript") then v:Destroy() end
	if v:IsA("Sound") and v.Name == "what" then v:Destroy() end
end

-- Animation (chá»‰ runF, jump, fall)
local Animator = npcHum:FindFirstChildOfClass("Animator") or Instance.new("Animator", npcHum)
local function newAnim(id) local a=Instance.new("Animation") a.AnimationId=id return a end

local pack1 = { runF = Animator:LoadAnimation(newAnim("rbxassetid://6608487832")) }
local pack2 = { runF = Animator:LoadAnimation(newAnim("rbxassetid://79821909217725")) }
local jumpAnim = Animator:LoadAnimation(newAnim("rbxassetid://6266580007"))
local fallAnim = Animator:LoadAnimation(newAnim("rbxassetid://6266583739"))

local function playBlend(targetTracks)
	for _, track in pairs({pack1.runF, pack2.runF, jumpAnim, fallAnim}) do
		local weight = targetTracks[track] or 0
		if weight>0 and not track.IsPlaying then track:Play(0.05) end
		track:AdjustWeight(weight,0.05)
	end
end

-- ðŸ”¹ Spawn xa player
local function randomSpawn()
	local angle = math.random()*2*math.pi
	local dist = math.random(30,50)
	return hrp.Position + Vector3.new(math.cos(angle)*dist,0,math.sin(angle)*dist)
end
npcRoot.CFrame = CFrame.new(randomSpawn())

-- ðŸ”¹ Cháº¡m player kill
npcRoot.Touched:Connect(function(hit)
	if hit:IsDescendantOf(lp.Character) then
		if lp.Character and lp.Character:FindFirstChild("Humanoid") then
			lp.Character.Humanoid.Health = 0
		end
	end
end)

-- ðŸ”¹ Waypoints
local WaypointFolder = workspace:FindFirstChild("Waypoints") or Instance.new("Folder", workspace)
WaypointFolder.Name = "Waypoints"
local waypoints = {}
local currentWaypointIndex = 1

local function clearWaypoints()
	for _, wp in ipairs(WaypointFolder:GetChildren()) do wp:Destroy() end
	waypoints = {}
	currentWaypointIndex = 1
end

local function getGroundPosition(pos)
	local rayOrigin = pos + Vector3.new(0,50,0)
	local rayDir = Vector3.new(0,-100,0)
	local rayParams = RaycastParams.new()
	rayParams.FilterDescendantsInstances = {npc}
	rayParams.FilterType = Enum.RaycastFilterType.Blacklist
	local result = workspace:Raycast(rayOrigin, rayDir, rayParams)
	if result then
		return Vector3.new(pos.X, result.Position.Y + npcRoot.Size.Y/2, pos.Z)
	else
		return pos
	end
end

local lastPlayerPos = lp.Character.PrimaryPart.Position
local MAX_JUMP_HEIGHT = 5

local function updateWaypointsSmart()
	if not lp.Character or not lp.Character.PrimaryPart then return end
	local playerPos = lp.Character.PrimaryPart.Position
	local playerVel = playerPos - lastPlayerPos
	lastPlayerPos = playerPos

	local distToLastWP = waypoints[#waypoints] and (waypoints[#waypoints].Position - playerPos).Magnitude or math.huge

	if distToLastWP > 5 or playerVel.Magnitude > 1 then
		clearWaypoints()
		local startPos = npcRoot.Position
		local endPos = playerPos + playerVel*0.5
		local stepDist = 5
		local maxSteps = 50
		local currentPos = startPos

		for i=1,maxSteps do
			local bestDir
			local bestScore = -math.huge
			local directions = {
				Vector3.new(1,0,0),Vector3.new(-1,0,0),
				Vector3.new(0,0,1),Vector3.new(0,0,-1),
				Vector3.new(1,0,1).Unit,Vector3.new(-1,0,1).Unit,
				Vector3.new(1,0,-1).Unit,Vector3.new(-1,0,-1).Unit
			}
			local dirToPlayer = (endPos - currentPos).Unit

			for _, d in ipairs(directions) do
				local newPos = currentPos + d*stepDist
				local rayParams = RaycastParams.new()
				rayParams.FilterDescendantsInstances = {npc}
				rayParams.FilterType = Enum.RaycastFilterType.Blacklist
				local result = workspace:Raycast(currentPos + Vector3.new(0,2,0), d*stepDist, rayParams)
				if not (result and result.Instance.CanCollide and not result.Instance:IsDescendantOf(WaypointFolder)) then
					local score = d:Dot(dirToPlayer)
					if score>bestScore then
						bestScore=score
						bestDir=d
					end
				end
			end

			if bestDir then
				local heightDiff = endPos.Y - currentPos.Y
				local stepY = 0
				if heightDiff > 1 and heightDiff <= MAX_JUMP_HEIGHT then
					stepY = math.min(heightDiff, MAX_JUMP_HEIGHT)
				end
				currentPos = currentPos + Vector3.new(bestDir.X*stepDist, stepY, bestDir.Z*stepDist)
				currentPos = getGroundPosition(currentPos)

				local wp = Instance.new("Part")
				wp.Size = Vector3.new(2,1,2)
				wp.Anchored = true
				wp.CanCollide = false
				wp.Transparency = 1
				wp.Position = currentPos
				wp.Name = "Waypoint"..i
				wp.Parent = WaypointFolder
				table.insert(waypoints, wp)
			else break end
			if (currentPos - endPos).Magnitude < 3 then break end
		end
	end
end

-- ðŸ”¹ Sensor
local FRONT_CHECK_DIST = 3
local SENSOR_HEIGHTS = {1,2,3}

local function checkObstacleAhead(pos, dir)
	for _, h in ipairs(SENSOR_HEIGHTS) do
		local origin = pos + Vector3.new(0,h,0)
		local rayParams = RaycastParams.new()
		rayParams.FilterDescendantsInstances = {npc}
		rayParams.FilterType = Enum.RaycastFilterType.Blacklist
		local result = workspace:Raycast(origin, dir*FRONT_CHECK_DIST, rayParams)
		if result and result.Instance.CanCollide and not result.Instance:IsDescendantOf(WaypointFolder) then
			local obstacleHeight = result.Position.Y - npcRoot.Position.Y
			if obstacleHeight <= MAX_JUMP_HEIGHT then
				return "jump"
			else
				return "blocked"
			end
		end
	end
	return "clear"
end

local lastPos = npcRoot.Position
local stuckTimer = 0
local STUCK_THRESHOLD = 0.5

-- ðŸ”¹ AI State Hunt/Chill
local states = {"hunt","chill"}
local currentState = "hunt"
local function changeStateRandom()
	while true do
		if math.random()<0.7 then currentState="hunt" else currentState="chill" end
		wait(math.random(5,10))
	end
end
task.spawn(changeStateRandom)

local function moveTowards(dt)
	if #waypoints==0 then return end
	local targetPos = waypoints[currentWaypointIndex] and waypoints[currentWaypointIndex].Position or lp.Character.PrimaryPart.Position
	local dir = targetPos - npcRoot.Position
	local horizontalDir = Vector3.new(dir.X,0,dir.Z)
	local distance = horizontalDir.Magnitude
	if distance < 1 then
		if currentWaypointIndex<#waypoints then currentWaypointIndex=currentWaypointIndex+1 end
		return
	end
	local moveDir = horizontalDir.Unit

	-- ðŸ”¹ Kiá»ƒm tra káº¹t dá»±a trÃªn khoáº£ng cÃ¡ch di chuyá»ƒn
	local movedDistance = (npcRoot.Position - lastPos).Magnitude
	if movedDistance < STUCK_THRESHOLD then
		stuckTimer = stuckTimer + dt
		if stuckTimer > 0.5 then
			local angle = math.rad(math.random(45,180))
			local cf = CFrame.Angles(0,angle,0)
			moveDir = Vector3.new(cf.LookVector.X,0,cf.LookVector.Z).Unit
			stuckTimer = 0
		end
	else
		stuckTimer = 0
	end
	lastPos = npcRoot.Position

	-- ðŸ”¹ Sensor & jump
	local status = checkObstacleAhead(npcRoot.Position, moveDir)
	if status=="jump" then
		npcHum.Jump=true
		playBlend({[jumpAnim]=1})
	elseif status=="blocked" then
		currentWaypointIndex = math.max(1,currentWaypointIndex-1)
	end

	-- ðŸ”¹ Move
	npcHum:Move(Vector3.new(moveDir.X,0,moveDir.Z))

	-- ðŸ”¹ Pack & speed dá»±a state
	local targetTracks = {}
	if currentState=="chill" then
		npcHum.WalkSpeed = 15.5
		targetTracks[pack1.runF]=1
	else
		npcHum.WalkSpeed = 23.5
		targetTracks[pack2.runF]=1
	end
	playBlend(targetTracks)

	-- ðŸ”¹ Jump/fall anim
	local state = npcHum:GetState()
	if state==Enum.HumanoidStateType.Jumping then
		playBlend({[jumpAnim]=1})
	elseif state==Enum.HumanoidStateType.Freefall then
		playBlend({[fallAnim]=1})
	end
end

-- ðŸ”¹ Main loop
RunService.RenderStepped:Connect(function(dt)
	updateWaypointsSmart()
	moveTowards(dt)
end)

-- ðŸ”¹ Gáº¯n DAO vÃ o tay pháº£i
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

--  Khi player cht, NPC clone i rt chm và spam emote + sound
local function onPlayerDied()
	-- Speed cc thp
	npcHum.WalkSpeed = 0.01

	task.spawn(function()
		while true do
			-- Chi emote
			local emoteAnim = Instance.new("Animation")
			emoteAnim.AnimationId = "rbxassetid://6323596869"
			local emoteTrack = npcHum:LoadAnimation(emoteAnim)
			emoteTrack:Play()

			-- Chi sound
			local sound = Instance.new("Sound")
			sound.SoundId = "rbxassetid://617500399"
			sound.Volume = 1
			sound.Parent = npcRoot
			sound:Play()

			task.wait(5.5) -- spam mi 0.5 giây

			-- Dng track và sound  lp li
			emoteTrack:Stop()
			sound:Stop()
			sound:Destroy()
		end
	end)
end

-- Kt ni vi player humanoid cht
if lp.Character and lp.Character:FindFirstChild("Humanoid") then
	lp.Character.Humanoid.Died:Connect(onPlayerDied)
end
