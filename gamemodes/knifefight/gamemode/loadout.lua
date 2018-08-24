function GM:PlayerLoadout( ply )
	ply:Give( "csgo_bowie" )
	ply:Give( "csgo_default_knife" )
	ply:Give( "csgo_flip" )
	ply:Give( "csgo_default_t" )
	ply:Give( "csgo_bayonet" )
if ply:GetNWInt("killcounter") >= 125 then
	ply:Give( "weapon_pistol" )
end
if ply:GetNWInt("killcounter") >= 175 then
	ply:Give( "weapon_357" )
end
	-- Prevent default Loadout.
	return true
end

hook.Add( "PlayerLoadout", "PlayerLoadout" )