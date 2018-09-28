grenades = GetConVar("kf_grenades"):GetInt()
killrewards = GetConVar("kf_killrewards"):GetInt()

function GM:PlayerLoadout( ply )
	ply:Give( "csgo_bowie" )
	ply:Give( "csgo_default_knife" )
	ply:Give( "csgo_flip" )
	ply:Give( "csgo_default_t" )
	ply:Give( "csgo_bayonet" )
if grenades == 1 then
	ply:Give( "weapon_frag" )
	ply:Give( "weapon_physcannon")
end
if killrewards == 1 then
	if ply:GetNWInt("killcounter") >= 100 then
	ply:Give( "weapon_pistol" )
end
	if ply:GetNWInt("killcounter") >= 150 then
	ply:Give( "weapon_357" )
end
end
	-- Prevent default Loadout.
	return true
end



hook.Add( "PlayerLoadout", "PlayerLoadout" )

function playerSetSpeed(ply)

timer.Simple(2, function()
 
    GAMEMODE:SetPlayerSpeed(ply, 130, 250)
end)
end

hook.Add( "PlayerSpawn", "playerSetSpeedtest", playerSetSpeed )