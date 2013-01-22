// ======= Copyright (c) 2003-2013, Unknown Worlds Entertainment, Inc. All rights reserved. =======
//
// lua\Server_Modded.lua
//
//    Created by:   Andreas Urwalek (andi@unknownworlds.com)
//
// ========= For more information, visit us at http://www.unknownworlds.com =====================

Script.Load("lua/PreLoadMod.lua")

Script.Load("lua/Shared.lua")
Script.Load("lua/ClassUtility.lua")
Script.Load("lua/Shared_Modded.lua")

Script.Load("lua/Server.lua")

// Hooks for that are not in Shared.lua need to go here.
Script.Load("lua/LastStand/LastStand_Server.lua")
Script.Load("lua/LastStand/LastStand_NS2Gamerules.lua")
Script.Load("lua/LastStand/LastStand_AlienTeam.lua")
Script.Load("lua/LastStand/LastStand_MarineTeam.lua")

Script.Load("lua/PostLoadMod.lua")