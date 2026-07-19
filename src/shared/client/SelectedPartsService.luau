local SelectedPartsService = {}

local currentlySelectedParts = {}

function updateSelection()
	print(currentlySelectedParts)

	for part, isSelected in currentlySelectedParts do
		if isSelected then
			local selectionBox: SelectionBox = Instance.new("SelectionBox")

			selectionBox.Parent = part
			selectionBox.Adornee = part

			local highlight: Highlight = Instance.new("Highlight")

			highlight.Adornee = part
			highlight.Parent = part
			highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			highlight.FillTransparency = 1
			highlight.OutlineColor = Color3.new(0.4, 0.623529, 0.807843)
		else
			if part:FindFirstChild("SelectionBox") then
				part:FindFirstChild("SelectionBox"):Destroy()
			end
			if part:FindFirstChild("Highlight") then
				part:FindFirstChild("Highlight"):Destroy()
			end
		end
	end
end

function SelectedPartsService:TogglePartSelection(part: Part)
	if currentlySelectedParts[part] then
		currentlySelectedParts[part] = nil
	else
		currentlySelectedParts[part] = true
	end

	updateSelection()
end

return SelectedPartsService
