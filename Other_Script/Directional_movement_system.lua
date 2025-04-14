local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Torso = Character:WaitForChild("Torso")

local Joints = {
	RootJoint = HumanoidRootPart:WaitForChild("RootJoint"),
	Neck = Torso:WaitForChild("Neck"),
	RightShoulder = Torso:WaitForChild("Right Shoulder"),
	LeftShoulder = Torso:WaitForChild("Left Shoulder"),
	RightHip = Torso:WaitForChild("Right Hip"),
	LeftHip = Torso:WaitForChild("Left Hip")
}

local JointsC0 = {
	RootJointC0 = Joints.RootJoint.C0,
	NeckC0 = Joints.Neck.C0,
	RightShoulderC0 = Joints.RightShoulder.C0,
	LeftShoulderC0 = Joints.LeftShoulder.C0,
	RightHipC0 = Joints.RightHip.C0,
	LeftHipC0 = Joints.LeftHip.C0
}

local JointTilts = {
	RootJointTilt = CFrame.new(),
	NeckTilt = CFrame.new(),
	RightShoulderTilt = CFrame.new(),
	LeftShoulderTilt = CFrame.new(),
	RightHipTilt = CFrame.new(),
	LeftHipTilt = CFrame.new()
}

local DefaultLerpAlpha = 0.145
local dotThreshold = 0.9
local lastTime = 0
local tickRate = 1 / 60

local function LerpJoints(moveDirection, angles)
	JointTilts.RootJointTilt = JointTilts.RootJointTilt:Lerp(CFrame.Angles(unpack(angles.RootJoint)), DefaultLerpAlpha)
	Joints.RootJoint.C0 = JointsC0.RootJointC0 * JointTilts.RootJointTilt

	JointTilts.NeckTilt = JointTilts.NeckTilt:Lerp(CFrame.Angles(unpack(angles.Neck)), DefaultLerpAlpha)
	Joints.Neck.C0 = JointsC0.NeckC0 * JointTilts.NeckTilt

	JointTilts.RightShoulderTilt = JointTilts.RightShoulderTilt:Lerp(CFrame.Angles(unpack(angles.RightShoulder)), DefaultLerpAlpha)
	Joints.RightShoulder.C0 = JointsC0.RightShoulderC0 * JointTilts.RightShoulderTilt

	JointTilts.LeftShoulderTilt = JointTilts.LeftShoulderTilt:Lerp(CFrame.Angles(unpack(angles.LeftShoulder)), DefaultLerpAlpha)
	Joints.LeftShoulder.C0 = JointsC0.LeftShoulderC0 * JointTilts.LeftShoulderTilt

	JointTilts.RightHipTilt = JointTilts.RightHipTilt:Lerp(CFrame.Angles(unpack(angles.RightHip)), DefaultLerpAlpha)
	Joints.RightHip.C0 = JointsC0.RightHipC0 * JointTilts.RightHipTilt

	JointTilts.LeftHipTilt = JointTilts.LeftHipTilt:Lerp(CFrame.Angles(unpack(angles.LeftHip)), DefaultLerpAlpha)
	Joints.LeftHip.C0 = JointsC0.LeftHipC0 * JointTilts.LeftHipTilt
end

local function UpdateDirectionalMovement(deltaTime)
	local now = workspace:GetServerTimeNow()
	if now - lastTime >= tickRate then
		lastTime = now

		local moveDirection = HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection)

		if moveDirection:Dot(Vector3.new(1,0,-1).Unit) > dotThreshold then
			LerpJoints(moveDirection, {
				RootJoint = {math.rad(-moveDirection.Z) * 5, 0, math.rad(-moveDirection.X) * 25},
				Neck = {math.rad(moveDirection.Z) * 5, 0, math.rad(moveDirection.X) * 15},
				RightShoulder = {0, math.rad(-moveDirection.X) * 10, 0},
				LeftShoulder = {0, math.rad(-moveDirection.X) * 10, 0},
				RightHip = {0, math.rad(-moveDirection.X) * 10, 0},
				LeftHip = {0, math.rad(-moveDirection.X) * 10, 0}
			})
		elseif moveDirection:Dot(Vector3.new(1,0,1).Unit) > dotThreshold then
			LerpJoints(moveDirection, {
				RootJoint = {math.rad(-moveDirection.Z) * 5, 0, math.rad(moveDirection.X) * 25},
				Neck = {math.rad(moveDirection.Z) * 5, 0, math.rad(-moveDirection.X) * 25},
				RightShoulder = {0, math.rad(moveDirection.X) * 10, 0},
				LeftShoulder = {0, math.rad(moveDirection.X) * 10, 0},
				RightHip = {0, math.rad(moveDirection.X) * 10, 0},
				LeftHip = {0, math.rad(moveDirection.X) * 10, 0}
			})
		elseif moveDirection:Dot(Vector3.new(-1,0,1).Unit) > dotThreshold then
			LerpJoints(moveDirection, {
				RootJoint = {math.rad(-moveDirection.Z) * 5, 0, math.rad(moveDirection.X) * 25},
				Neck = {math.rad(moveDirection.Z) * 5, 0, math.rad(-moveDirection.X) * 25},
				RightShoulder = {0, math.rad(moveDirection.X) * 10, 0},
				LeftShoulder = {0, math.rad(moveDirection.X) * 10, 0},
				RightHip = {0, math.rad(moveDirection.X) * 10, 0},
				LeftHip = {0, math.rad(moveDirection.X) * 10, 0}
			})
		elseif moveDirection:Dot(Vector3.new(-1,0,-1).Unit) > dotThreshold then
			LerpJoints(moveDirection, {
				RootJoint = {math.rad(-moveDirection.Z) * 5, 0, math.rad(-moveDirection.X) * 25},
				Neck = {math.rad(moveDirection.Z) * 5, 0, math.rad(moveDirection.X) * 15},
				RightShoulder = {0, math.rad(-moveDirection.X) * 10, 0},
				LeftShoulder = {0, math.rad(-moveDirection.X) * 10, 0},
				RightHip = {0, math.rad(-moveDirection.X) * 10, 0},
				LeftHip = {0, math.rad(-moveDirection.X) * 10, 0}
			})
		elseif moveDirection:Dot(Vector3.new(0,0,-1).Unit) > dotThreshold then
			LerpJoints(moveDirection, {
				RootJoint = {math.rad(-moveDirection.Z) * 10, 0, 0},
				Neck = {math.rad(moveDirection.Z) * 10, 0, 0},
				RightShoulder = {0, 0, 0},
				LeftShoulder = {0, 0, 0},
				RightHip = {0, 0, 0},
				LeftHip = {0, 0, 0}
			})
		elseif moveDirection:Dot(Vector3.new(1,0,0).Unit) > dotThreshold then
			LerpJoints(moveDirection, {
				RootJoint = {0, 0, math.rad(-moveDirection.X) * 35},
				Neck = {0, 0, math.rad(moveDirection.X) * 35},
				RightShoulder = {0, math.rad(-moveDirection.X) * 15, 0},
				LeftShoulder = {0, math.rad(-moveDirection.X) * 15, 0},
				RightHip = {0, math.rad(-moveDirection.X) * 15, 0},
				LeftHip = {0, math.rad(-moveDirection.X) * 15, 0}
			})
		elseif moveDirection:Dot(Vector3.new(0,0,1).Unit) > dotThreshold then
			LerpJoints(moveDirection, {
				RootJoint = {math.rad(-moveDirection.Z) * 10, 0, 0},
				Neck = {math.rad(moveDirection.Z) * 10, 0, 0},
				RightShoulder = {0, 0, 0},
				LeftShoulder = {0, 0, 0},
				RightHip = {0, 0, 0},
				LeftHip = {0, 0, 0}
			})
		elseif moveDirection:Dot(Vector3.new(-1,0,0).Unit) > dotThreshold then
			LerpJoints(moveDirection, {
				RootJoint = {0, 0, math.rad(-moveDirection.X) * 35},
				Neck = {0, 0, math.rad(moveDirection.X) * 35},
				RightShoulder = {0, math.rad(-moveDirection.X) * 15, 0},
				LeftShoulder = {0, math.rad(-moveDirection.X) * 15, 0},
				RightHip = {0, math.rad(-moveDirection.X) * 15, 0},
				LeftHip = {0, math.rad(-moveDirection.X) * 15, 0}
			})
		else
			LerpJoints(moveDirection, {
				RootJoint = {0, 0, 0},
				Neck = {0, 0, 0},
				RightShoulder = {0, 0, 0},
				LeftShoulder = {0, 0, 0},
				RightHip = {0, 0, 0},
				LeftHip = {0, 0, 0}
			})
		end
	end
end

RunService.Heartbeat:Connect(UpdateDirectionalMovement)
