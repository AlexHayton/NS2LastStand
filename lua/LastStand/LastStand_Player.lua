//________________________________
//
//  Last Stand Mod for NS2
//	Made by MCMLXXXIV, 2013
//  Concept by 
//________________________________

// LastStand_Player.lua

local networkVars = 
{
}

function Player:BuildAndSendDirectMessage(message)

	local playerName = "LastStand: " .. self:GetName()
	local playerLocationId = -1
	local playerTeamNumber = kTeamReadyRoom
	local playerTeamType = kNeutralTeamType

	Server.SendNetworkMessage(self, "Chat", BuildChatMessage(true, playerName, playerLocationId, playerTeamNumber, playerTeamType, message), true)

end

Class_Reload("Player", networkVars)