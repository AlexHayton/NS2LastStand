//________________________________
//
//  Last Stand Mod for NS2
//	Made by MCMLXXXIV, 2013
//  Concept by 
//________________________________

// LastStand_TechTree.lua

local networkVars = 
{
}

// Unlock all abilities.
function TechTree:ResearchAll()

	for index, node in pairs(self.nodeList) do
		node:SetResearched(true)
		node.available = true
		self:SetTechNodeChanged(node)
	end
	
	self:ComputeAvailability()
	
end

Class_Reload("TechTree", networkVars)