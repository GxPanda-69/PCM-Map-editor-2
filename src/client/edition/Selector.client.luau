local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local SelectedPartsService = require(ReplicatedStorage.Shared.client.SelectedPartsService)

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then
		return
	end
	if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
		return
	end

	if not (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or SelectedPartsService:IsSelected(Mouse.Target)) then
		SelectedPartsService:ClearSelection()
	end

	if Mouse.Target and not Mouse.Target.Locked then
		SelectedPartsService:TogglePartSelection(Mouse.Target)
	end
	SelectedPartsService:UpdateSelection()
end)
