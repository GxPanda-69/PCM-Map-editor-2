local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local UserGameSettings = UserSettings().GameSettings

local camera = workspace.CurrentCamera

local FOV = 80
local MOUSE_SENS = 0.012 * UserGameSettings.MouseSensitivity
local CAM_SPEED = 50

local yaw, pitch = 0, 0
local base = CFrame.new()
local acceleration = 0

camera.CameraType = Enum.CameraType.Scriptable

UserInputService.InputChanged:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then
		return
	end

	if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition

		yaw -= input.Delta.X * MOUSE_SENS
		pitch -= input.Delta.Y * MOUSE_SENS
	else
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	end
end)

RunService.RenderStepped:Connect(function(deltaTime)
	if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
		acceleration = -0.5
	else
		acceleration = math.clamp(acceleration, 0, math.huge)
	end
	if
		UserInputService:IsKeyDown(Enum.KeyCode.W)
		or UserInputService:IsKeyDown(Enum.KeyCode.A)
		or UserInputService:IsKeyDown(Enum.KeyCode.S)
		or UserInputService:IsKeyDown(Enum.KeyCode.D)
		or UserInputService:IsKeyDown(Enum.KeyCode.Q)
		or UserInputService:IsKeyDown(Enum.KeyCode.E)
	then
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			base *= CFrame.new(0, 0, -CAM_SPEED * deltaTime * (1 + acceleration))
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			base *= CFrame.new(0, 0, CAM_SPEED * deltaTime * (1 + acceleration))
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			base *= CFrame.new(-CAM_SPEED * deltaTime * (1 + acceleration), 0, 0)
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			base *= CFrame.new(CAM_SPEED * deltaTime * (1 + acceleration), 0, 0)
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
			base *= CFrame.new(0, -CAM_SPEED * deltaTime * (1 + acceleration), 0)
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.E) then
			base *= CFrame.new(0, CAM_SPEED * deltaTime * (1 + acceleration), 0)
		end
		acceleration += deltaTime
	else
		acceleration = 0
	end

	pitch = math.clamp(pitch, -math.pi / 2, math.pi / 2)

	camera.FieldOfView = FOV
	camera.CFrame = CFrame.new(base.Position) * CFrame.Angles(0, yaw, 0) * CFrame.Angles(pitch, 0, 0)
	base = camera.CFrame
end)

camera.CameraType = Enum.CameraType.Scriptable
