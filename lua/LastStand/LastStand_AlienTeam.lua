//________________________________
//
//  Last Stand Mod for NS2
//	Made by MCMLXXXIV, 2013
//  Concept by 
//________________________________

// LastStand_AlienTeam.lua

kAnyTeamIndex = 999

// Add extra hives at 3 locations.
function AlienTeam:ResetTeam()

	PlayingTeam.ResetTeam(self)

    // Build list of tech points
	local techPoints = EntityListToTable(Shared.GetEntitiesWithClassname("TechPoint"))
	if table.maxn(techPoints) < 2 then
		Print("Warning -- Found only %d %s entities.", table.maxn(techPoints), TechPoint.kMapName)
	end
	
	if #techPoints > 2 then
		local techPoint2 = GetGamerules():ChooseTechPoint(techPoints, kAnyTeamIndex)
		self:SpawnInitialStructures(techPoint2)
	end
	
	if #techPoints > 3 then
		local techPoint3 = GetGamerules():ChooseTechPoint(techPoints, kAnyTeamIndex)
		self:SpawnInitialStructures(techPoint3)
	end
    
end