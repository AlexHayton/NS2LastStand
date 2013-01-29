//________________________________
//
//  Last Stand Mod for NS2
//	Made by MCMLXXXIV, 2013
//  Concept by 
//________________________________

// LastStand_NS2Gamerules.lua

// Find team start with team 0 or for specified team. Check occupancy!
function NS2Gamerules:ChooseTechPoint(techPoints, teamNumber)

    local validTechPoints = { }
    local totalTechPointWeight = 0
    
    // Build list of valid starts (marked as "neutral" or for this team in map)
    for _, currentTechPoint in pairs(techPoints) do
    
		local validTeam = false
		if teamNumber == kAnyTeamIndex then
			
			// Last stand mod needs more tech points than normal so allow it to override default selection behaviour.
			validTeam = true
			
		else
			
			// Always include tech points with team 0 and never include team 3 into random selection process
			local teamNum = currentTechPoint:GetTeamNumberAllowed()
			if (teamNum == 0 or teamNum == teamNumber) and teamNum ~= 3 then
				validTeam = true
			end
			
		end
		
		if validTeam then
			
			// Also check for attachment to see if it's occupied already.
			if currentTechPoint:GetAttached() == nil then
        
				table.insert(validTechPoints, currentTechPoint)
				totalTechPointWeight = totalTechPointWeight + currentTechPoint:GetChooseWeight()
				
			end
				
        end
        
    end
    
    local chosenTechPointWeight = self.techPointRandomizer:random(0, totalTechPointWeight)
    local chosenTechPoint = nil
    local currentWeight = 0
    for _, currentTechPoint in pairs(validTechPoints) do
    
        currentWeight = currentWeight + currentTechPoint:GetChooseWeight()
        if chosenTechPointWeight - currentWeight <= 0 then
        
            chosenTechPoint = currentTechPoint
            break
            
        end
        
    end
    
    // Remove it from the list so it isn't chosen by other team
    if chosenTechPoint ~= nil then
        table.removevalue(techPoints, chosenTechPoint)
    else
        assert(false, "ChooseTechPoint couldn't find a tech point for team " .. teamNumber)
    end
    
    return chosenTechPoint
    
end

local overrideResetGame = NS2Gamerules.ResetGame

// Post-hooks ResetGame
function NS2Gamerules:ResetGame()

	overrideResetGame(self)
	
	// Assign any free resource points at the end of the reset process to the Marine team.
	local resourcePoints = Shared.GetEntitiesWithClassname("ResourcePoint")
	for index, resourcePoint in ientitylist(resourcePoints) do
		if resourcePoint:GetAttached() == nil then
			local extractor = resourcePoint:SpawnResourceTowerForTeam(self.team1, kTechId.Extractor)
			
			// Also build any power nodes nearby to an active resource tower so they begin powered.
			for index, powerPoint in ientitylist(Shared.GetEntitiesWithClassname("PowerPoint")) do

				if powerPoint:GetLocationName() == extractor:GetLocationName() then
					powerPoint:SetConstructionComplete()
				end

			end
		end
	end
	
end

local overrideOnClientConnect = NS2Gamerules.OnClientConnect

// Send a message to players when they connect.
function NS2Gamerules:OnClientConnect(client)

	overrideOnClientConnect(self, client)
	local player = client:GetControllingPlayer()
	
	player:BuildAndSendDirectMessage("Welcome to Last Stand v" .. kLastStandVersion .. "!")
	player:BuildAndSendDirectMessage("In this mod, the Marines start with a full base and surrounded by Aliens.")
	player:BuildAndSendDirectMessage("How long can you hold out?")
	
end