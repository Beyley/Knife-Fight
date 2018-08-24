function GM:PlayerLoadout( ply )
	ply:Give( "csgo_bowie" )
	ply:Give( "csgo_default_knife" )
	ply:Give( "csgo_flip" )
	ply:Give( "csgo_default_t" )
	ply:Give( "csgo_bayonet" )

	-- Prevent default Loadout.
	return true
end

hook.Add( "PlayerLoadout", "PlayerLoadout" )