local ReplicatedStorage = game:GetService("ReplicatedStorage")
local knit = require(ReplicatedStorage.Packages.knit)

local OctreeService = knit.CreateService({
	Name = "OctreeService",
})

knit.Start():catch(warn)
