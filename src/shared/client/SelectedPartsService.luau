local SelectedPartsService = {
	CurrentlySelectedParts = {},
}

local partsWithIndicators = {}

function removeIndicators(part: Part)
	for _, child in ipairs(part:GetChildren()) do
		if child:IsA("Highlight") and child:HasTag("selection") then
			child:Destroy()
		end
		if child:IsA("SelectionBox") and child:HasTag("selection") then
			child:Destroy()
		end
	end
	partsWithIndicators[part] = nil
end

function SelectedPartsService:UpdateSelection()
	for part, isSelected in SelectedPartsService.CurrentlySelectedParts do
		if isSelected and not partsWithIndicators[part] then
			local selectionBox: SelectionBox = Instance.new("SelectionBox")

			selectionBox.Parent = part
			selectionBox.Adornee = part

			selectionBox:AddTag("selection")

			local highlight: Highlight = Instance.new("Highlight")

			highlight.Adornee = part
			highlight.Parent = part
			highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			highlight.FillTransparency = 1
			highlight.OutlineColor = Color3.new(0.4, 0.623529, 0.807843)

			highlight:AddTag("selection")

			partsWithIndicators[part] = true
		end
	end
	for part, _ in partsWithIndicators do
		if not SelectedPartsService.CurrentlySelectedParts[part] then
			removeIndicators(part)
		end
	end
end

function SelectedPartsService:TogglePartSelection(part: Part)
	if SelectedPartsService.CurrentlySelectedParts[part] == true then
		SelectedPartsService.CurrentlySelectedParts[part] = nil
	else
		SelectedPartsService.CurrentlySelectedParts[part] = true
	end
end

function SelectedPartsService:ClearSelection()
	for part, isSelected in SelectedPartsService.CurrentlySelectedParts do
		if not isSelected then
			continue
		end

		SelectedPartsService.CurrentlySelectedParts[part] = nil
		removeIndicators(part)
	end
end

function SelectedPartsService:IsSelected(part: Part)
	return SelectedPartsService.CurrentlySelectedParts[part] or false
end

return SelectedPartsService
