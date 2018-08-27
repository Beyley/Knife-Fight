AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "loadout.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
include( "loadout.lua" )

function playerSetSpeed(ply)

timer.Simple(2, function()
 
    GAMEMODE:SetPlayerSpeed(ply, 250, 130)
end)
end

hook.Add( "PlayerSpawn", "playerSetSpeedtest", playerSetSpeed )