//________________________________
//
//  Last Stand Mod for NS2
//	Made by MCMLXXXIV, 2013
//  Concept by 
//________________________________

// LastStand_MarineTeam.lua

local function SpawnMarineStructure(self, techPoint, techId, mapName, spawnPointsTable, maxRange)

	local techPointOrigin = techPoint:GetOrigin() + Vector(0, 2, 0)
	
	local spawnPoint = nil
	
	// First check the predefined spawn points. Look for a close one.
	for p = 1, #spawnPointsTable do
	
		local predefinedSpawnPoint = spawnPointsTable[p]
		if (predefinedSpawnPoint - techPointOrigin):GetLength() <= kInfantryPortalAttachRange then
			spawnPoint = predefinedSpawnPoint
		end
		
	end
	
	// Fallback on the random method if there is no nearby spawn point.
	if not spawnPoint then
	
		for i = 1, 50 do
		
			local origin = CalculateRandomSpawn(nil, techPointOrigin, techId, true, kInfantryPortalMinSpawnDistance * 1, maxRange, 3)
			
			if origin then
				spawnPoint = origin - Vector(0, 0.1, 0)
			end
			
		end
		
	end
	
	if spawnPoint then
	
		local structure = CreateEntity(mapName, spawnPoint, self:GetTeamNumber())
		
		SetRandomOrientation(structure)
		structure:SetConstructionComplete()
		
	end
	
end

// Use a replace hook for the Spawn logic.
function MarineTeam:SpawnInitialStructures(techPoint)

	local tower, commandStation = PlayingTeam.SpawnInitialStructures(self, techPoint)
	
	// Spawn two infantry portals
	SpawnMarineStructure(self, techPoint, kTechId.InfantryPortal, InfantryPortal.kMapName, Server.infantryPortalSpawnPoints, kInfantryPortalMaxSpawnDistance)
	SpawnMarineStructure(self, techPoint, kTechId.InfantryPortal, InfantryPortal.kMapName, Server.infantryPortalSpawnPoints, kInfantryPortalMaxSpawnDistance)
	
	// Spawn an armory and other buildings that marines need.
	SpawnMarineStructure(self, techPoint, kTechId.Armory, Armory.kMapName, Server.armorySpawnPoints, kArmoryMaxSpawnDistance)
	SpawnMarineStructure(self, techPoint, kTechId.Observatory, Observatory.kMapName, Server.observatorySpawnPoints, kObservatoryMaxSpawnDistance)
	SpawnMarineStructure(self, techPoint, kTechId.PrototypeLab, PrototypeLab.kMapName, Server.protolabSpawnPoints, kProtoLabMaxSpawnDistance)
	SpawnMarineStructure(self, techPoint, kTechId.ArmsLab, ArmsLab.kMapName, Server.armslabSpawnPoints, kArmsLabMaxSpawnDistance)
	SpawnMarineStructure(self, techPoint, kTechId.RoboticsFactory, RoboticsFactory.kMapName, Server.roboFactorySpawnPoints, kRoboticsFactoryMaxSpawnDistance)
	SpawnMarineStructure(self, techPoint, kTechId.SentryBattery, SentryBattery.kMapName, Server.sentryBatterySpawnPoints, kSentryBatteryMaxSpawnDistance)
	
	return tower, commandStation
	
end

// Post-hook the tech tree to upgrade everything at the start.
local overrideTechTree = MarineTeam.InitTechTree
function MarineTeam:InitTechTree()

	// Call the original function.
	overrideTechTree(self)
	
	// Upgrade all the items in the tech tree, except a couple that we want the team to have to research.
	local dontResearchTech = { }
	dontResearchTech[kTechId.Weapons3] = true
	dontResearchTech[kTechId.Armor3] = true
	self.techTree:ResearchAll(dontResearchTech)

end