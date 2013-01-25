//________________________________
//
//  Last Stand Mod for NS2
//	Made by MCMLXXXIV, 2013
//  Concept by 
//________________________________

// LastStand_AlienTeam.lua
kAnyTeamIndex = 999

// Define the hive types and their associated buildings here.
local HiveTypes = { { kHiveType = kTechId.CragHive, 	kBuildingTechId = kTechId.Crag, 	kBuildingMapName = Crag.kMapName 		},
					{ kHiveType = kTechId.ShiftHive, 	kBuildingTechId = kTechId.Shift, 	kBuildingMapName = Shift.kMapName 		},
					{ kHiveType = kTechId.ShadeHive, 	kBuildingTechId = kTechId.Shade, 	kBuildingMapName = Shade.kMapName 		} }

// Shuffle the table to distribute the buildings randomly.
local function shuffle(t)
    local rand = math.random 
    assert(t, "table.shuffle() expected a table, got nil")
    local iterations = #t
    local j
    
    for i = iterations, 2, -1 do
        j = rand(i)
        t[i], t[j] = t[j], t[i]
    end
end

shuffle(HiveTypes)

// Function to spawn alien buildings.
local function SpawnAlienBuilding(self, techPoint, techId, mapName)

	local techPointOrigin = techPoint:GetOrigin() + Vector(0, 2, 0)
	
	for i = 1, 50 do
	
		local origin = CalculateRandomSpawn(nil, techPointOrigin, techId, true, kInfantryPortalMinSpawnDistance * 1, kInfantryPortalMinSpawnDistance * 2.5, 3)
		
		if origin then
			spawnPoint = origin - Vector(0, 0.1, 0)
		end
		
	end
	
	if spawnPoint then
	
		local alienStructure = CreateEntity(mapName, spawnPoint, self:GetTeamNumber())
		
		SetRandomOrientation(alienStructure)
		alienStructure:SetConstructionComplete()
		alienStructure:SetMature()
		
	end
	
end

// Add extra hives at 3 locations.
function AlienTeam:ResetTeam()

	PlayingTeam.ResetTeam(self)

    // Build list of tech points and make sure there are 3 if we can.
	local techPoints = EntityListToTable(Shared.GetEntitiesWithClassname("TechPoint"))
	if table.maxn(techPoints) < 2 then
		Print("Warning -- Found only %d %s entities.", table.maxn(techPoints), TechPoint.kMapName)
	end
	local initialTechPoint = self:GetInitialTechPoint()
	local alienTechPoints = {}
	table.insert(alienTechPoints, initialTechPoint)
	
	if #techPoints > 2 then
		local techPoint2 = GetGamerules():ChooseTechPoint(techPoints, kAnyTeamIndex)
		self:SpawnInitialStructures(techPoint2)
		table.insert(alienTechPoints, techPoint2)
	end
	
	if #techPoints > 3 then
		local techPoint3 = GetGamerules():ChooseTechPoint(techPoints, kAnyTeamIndex)
		self:SpawnInitialStructures(techPoint3)
		table.insert(alienTechPoints, techPoint3)
	end
	
	// Assign the tech points and mature the hives.
	for index, techPoint in ipairs(alienTechPoints) do
		local techInfo = HiveTypes[index]
		local hive = techPoint:GetAttached()
		
		if hive then
			hive:SetMature()
			success = hive:UpgradeToTechId(techInfo.kHiveType)
		end
		
		SpawnAlienBuilding(self, techPoint, techInfo.kBuildingTechId, techInfo.kBuildingMapName)
	end
	
end

// Post-hook the tech tree to upgrade everything at the start.
local overrideTechTree = AlienTeam.InitTechTree
function AlienTeam:InitTechTree()

	// Call the original function.
	overrideTechTree(self)
	
	// Upgrade all the items in the tech tree.
	self.techTree:ResearchAll()

end