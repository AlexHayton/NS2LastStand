//________________________________
//
//  Last Stand Mod for NS2
//	Made by MCMLXXXIV, 2013
//  Concept by 
//________________________________

// LastStand_MarineTeam.lua

local function SpawnInfantryPortal(self, techPoint)

	local techPointOrigin = techPoint:GetOrigin() + Vector(0, 2, 0)
	
	local spawnPoint = nil
	
	// First check the predefined spawn points. Look for a close one.
	for p = 1, #Server.infantryPortalSpawnPoints do
	
		local predefinedSpawnPoint = Server.infantryPortalSpawnPoints[p]
		if (predefinedSpawnPoint - techPointOrigin):GetLength() <= kInfantryPortalAttachRange then
			spawnPoint = predefinedSpawnPoint
		end
		
	end
	
	// Fallback on the random method if there is no nearby spawn point.
	if not spawnPoint then
	
		for i = 1, 50 do
		
			local origin = CalculateRandomSpawn(nil, techPointOrigin, kTechId.InfantryPortal, true, kInfantryPortalMinSpawnDistance * 1, kInfantryPortalMinSpawnDistance * 2.5, 3)
			
			if origin then
				spawnPoint = origin - Vector(0, 0.1, 0)
			end
			
		end
		
	end
	
	if spawnPoint then
	
		local ip = CreateEntity(InfantryPortal.kMapName, spawnPoint, self:GetTeamNumber())
		
		SetRandomOrientation(ip)
		ip:SetConstructionComplete()
		
	end
	
end

local function SpawnArmory(self, techPoint)

	local techPointOrigin = techPoint:GetOrigin() + Vector(0, 2, 0)
	
	local spawnPoint = nil
	
	// First check the predefined spawn points. Look for a close one.
	for p = 1, #Server.armorySpawnPoints do
	
		local predefinedSpawnPoint = Server.armorySpawnPoints[p]
		if (predefinedSpawnPoint - techPointOrigin):GetLength() <= kInfantryPortalAttachRange then
			spawnPoint = predefinedSpawnPoint
		end
		
	end
	
	// Fallback on the random method if there is no nearby spawn point.
	if not spawnPoint then
	
		for i = 1, 50 do
		
			local origin = CalculateRandomSpawn(nil, techPointOrigin, kTechId.AdvancedArmory, true, kInfantryPortalMinSpawnDistance * 1, kInfantryPortalMinSpawnDistance * 4, 3)
			
			if origin then
				spawnPoint = origin - Vector(0, 0.1, 0)
			end
			
		end
		
	end
	
	if spawnPoint then
	
		local ip = CreateEntity(AdvancedArmory.kMapName, spawnPoint, self:GetTeamNumber())
		
		SetRandomOrientation(ip)
		ip:SetConstructionComplete()
		
	end
	
end

local function SpawnObservatory(self, techPoint)

	local techPointOrigin = techPoint:GetOrigin() + Vector(0, 2, 0)
	
	local spawnPoint = nil
	
	// First check the predefined spawn points. Look for a close one.
	for p = 1, #Server.observatorySpawnPoints do
	
		local predefinedSpawnPoint = Server.observatorySpawnPoints[p]
		if (predefinedSpawnPoint - techPointOrigin):GetLength() <= kInfantryPortalAttachRange then
			spawnPoint = predefinedSpawnPoint
		end
		
	end
	
	// Fallback on the random method if there is no nearby spawn point.
	if not spawnPoint then
	
		for i = 1, 50 do
		
			local origin = CalculateRandomSpawn(nil, techPointOrigin, kTechId.Observatory, true, kInfantryPortalMinSpawnDistance * 1, kInfantryPortalMinSpawnDistance * 4, 3)
			
			if origin then
				spawnPoint = origin - Vector(0, 0.1, 0)
			end
			
		end
		
	end
	
	if spawnPoint then
	
		local ip = CreateEntity(Observatory.kMapName, spawnPoint, self:GetTeamNumber())
		
		SetRandomOrientation(ip)
		ip:SetConstructionComplete()
		
	end
	
end

local function SpawnPrototypeLab(self, techPoint)

	local techPointOrigin = techPoint:GetOrigin() + Vector(0, 2, 0)
	
	local spawnPoint = nil
	
	// First check the predefined spawn points. Look for a close one.
	for p = 1, #Server.protolabSpawnPoints do
	
		local predefinedSpawnPoint = Server.protolabSpawnPoints[p]
		if (predefinedSpawnPoint - techPointOrigin):GetLength() <= kInfantryPortalAttachRange then
			spawnPoint = predefinedSpawnPoint
		end
		
	end
	
	// Fallback on the random method if there is no nearby spawn point.
	if not spawnPoint then
	
		for i = 1, 50 do
		
			local origin = CalculateRandomSpawn(nil, techPointOrigin, kTechId.PrototypeLab, true, kInfantryPortalMinSpawnDistance * 1, kInfantryPortalMinSpawnDistance * 4, 3)
			
			if origin then
				spawnPoint = origin - Vector(0, 0.1, 0)
			end
			
		end
		
	end
	
	if spawnPoint then
	
		local ip = CreateEntity(PrototypeLab.kMapName, spawnPoint, self:GetTeamNumber())
		
		SetRandomOrientation(ip)
		ip:SetConstructionComplete()
		
	end
	
end

local function SpawnArmsLab(self, techPoint)

	local techPointOrigin = techPoint:GetOrigin() + Vector(0, 2, 0)
	
	local spawnPoint = nil
	
	// First check the predefined spawn points. Look for a close one.
	for p = 1, #Server.armslabSpawnPoints do
	
		local predefinedSpawnPoint = Server.armslabSpawnPoints[p]
		if (predefinedSpawnPoint - techPointOrigin):GetLength() <= kInfantryPortalAttachRange then
			spawnPoint = predefinedSpawnPoint
		end
		
	end
	
	// Fallback on the random method if there is no nearby spawn point.
	if not spawnPoint then
	
		for i = 1, 50 do
		
			local origin = CalculateRandomSpawn(nil, techPointOrigin, kTechId.ArmsLab, true, kInfantryPortalMinSpawnDistance * 1, kInfantryPortalMinSpawnDistance * 3.5, 3)
			
			if origin then
				spawnPoint = origin - Vector(0, 0.1, 0)
			end
			
		end
		
	end
	
	if spawnPoint then
	
		local ip = CreateEntity(ArmsLab.kMapName, spawnPoint, self:GetTeamNumber())
		
		SetRandomOrientation(ip)
		ip:SetConstructionComplete()
		
	end
	
end

// Use a replace hook for the Spawn logic.
function MarineTeam:SpawnInitialStructures(techPoint)

	local tower, commandStation = PlayingTeam.SpawnInitialStructures(self, techPoint)
	
	// Spawn two infantry portals
	SpawnInfantryPortal(self, techPoint)
	SpawnInfantryPortal(self, techPoint)
	
	// Spawn an armory and other buildings that marines need.
	SpawnArmory(self, techPoint)
	SpawnObservatory(self, techPoint)
	SpawnPrototypeLab(self, techPoint)
	SpawnArmsLab(self, techPoint)
	
	return tower, commandStation
	
end