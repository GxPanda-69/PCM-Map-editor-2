local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Packages.Signal)

local SelectedPartsService = {
	CurrentlySelectedParts = {},
	SelectionUpdated = Signal.new(),
}

local partsSelectedFwSearch = {}
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
	SelectedPartsService.CurrentlySelectedParts = {}
	for part, isSelected in partsSelectedFwSearch do
		if isSelected then
			table.insert(SelectedPartsService.CurrentlySelectedParts, part)
			if not partsWithIndicators[part] then
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
	end
	for part, _ in partsWithIndicators do
		if not partsSelectedFwSearch[part] then
			removeIndicators(part)
		end
	end
	SelectedPartsService.SelectionUpdated:Fire()
end

function SelectedPartsService:TogglePartSelection(part: Part)
	if partsSelectedFwSearch[part] == true then
		partsSelectedFwSearch[part] = nil
	else
		partsSelectedFwSearch[part] = true
	end
end

function SelectedPartsService:ClearSelection()
	for part, isSelected in partsSelectedFwSearch do
		if not isSelected then
			continue
		end

		partsSelectedFwSearch[part] = nil
		removeIndicators(part)
	end
end

function SelectedPartsService:IsSelected(part: Part)
	return partsSelectedFwSearch[part] or false
end

return SelectedPartsService
