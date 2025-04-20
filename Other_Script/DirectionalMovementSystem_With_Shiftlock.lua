loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Script/Script_start.lua"))()

local gui = Instance.new("ScreenGui")
gui.Name = "Ask"
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Majn = Instance.new("Frame")
Majn.Size = UDim2.new(0.5, 0, 0.5, 0)
Majn.Position = UDim2.new(0.25, 0, 0.25, 0)
Majn.BackgroundColor3 = Color3.new(0)
Majn.BorderColor3 = Color3.new(1, 1, 1)
Majn.BorderSizePixel = 1
Majn.Active = true
Majn.BackgroundTransparency = 0.5
Majn.Draggable = true
Majn.Parent = gui

local main2 = Instance.new("TextLabel")
main2.Size = UDim2.new(0.3, 0, 0.2, 0)
main2.Position = UDim2.new(0.37, 0, 0.05, 0)
main2.BackgroundColor3 = Color3.new(0, 0, 0)
main2.BorderColor3 = Color3.new(0, 0, 0)
main2.BorderSizePixel = 1
main2.Text = "Heyy-"
main2.TextSize = 50
main2.BackgroundTransparency = 1
main2.TextColor3 = Color3.new(1, 1, 1)
main2.Font = Enum.Font.Code
main2.Parent = Majn

local mainText = Instance.new("TextLabel")
mainText.Size = UDim2.new(0.3, 0, 0.2, 0)
mainText.Position = UDim2.new(0.37, 0, 0.29, 0)
mainText.BackgroundColor3 = Color3.new(0, 0, 0)
mainText.BorderColor3 = Color3.new(0, 0, 0)
mainText.BorderSizePixel = 1
mainText.TextSize = 35
mainText.Text = "Do u wanna load shiftlock?"
mainText.BackgroundTransparency = 1
mainText.TextColor3 = Color3.new(1, 1, 1)
mainText.Font = Enum.Font.Code
mainText.Parent = Majn

local Sure = Instance.new("TextButton")
Sure.Size = UDim2.new(0.3, 0, 0.2, 0)
Sure.Position = UDim2.new(0.12, 0, 0.55, 0)
Sure.BackgroundColor3 = Color3.new(0, 0, 0)
Sure.BorderColor3 = Color3.new(1, 1, 1)
Sure.BorderSizePixel = 1
Sure.Text = "Sure!"
Sure.TextSize = 35
Sure.BackgroundTransparency = 0.4
Sure.TextColor3 = Color3.new(1, 1, 1)
Sure.Font = Enum.Font.Code
Sure.Parent = Majn

local No = Instance.new("TextButton")
No.Size = UDim2.new(0.3, 0, 0.2, 0)
No.Position = UDim2.new(0.6, 0, 0.55, 0)
No.BackgroundColor3 = Color3.new(0, 0, 0)
No.BorderColor3 = Color3.new(1, 1, 1)
No.BorderSizePixel = 1
No.Text = " No."
No.TextSize = 35
No.BackgroundTransparency = 0.4
No.TextColor3 = Color3.new(1, 1, 1)
No.Font = Enum.Font.Code
No.Parent = Majn

Sure.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Other_Script/Shiftlock.lua"))()
    wait(1)
    gui:Destroy()
end)

No.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

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
