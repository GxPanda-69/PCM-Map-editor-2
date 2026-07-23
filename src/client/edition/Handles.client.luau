local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SelectedPartsService = require(ReplicatedStorage.Shared.client.SelectedPartsService)

SelectedPartsService.SelectionUpdated:Connect(function()
	print(SelectedPartsService.CurrentlySelectedParts)
	if #SelectedPartsService.CurrentlySelectedParts ~= 0 then
		return
	end
end)
