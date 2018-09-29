//This function runs every tick
function GM:Tick()
	grenades = GetConVar("kf_grenades"):GetInt() //This stuff sets variables every tick
	killrewards = GetConVar("kf_killrewards"):GetInt()
	phys = GetConVar("kf_phys"):GetInt()
	killrew1 = GetConVar("kf_killrew1"):GetInt()
	killrew2 = GetConVar("kf_killrew2"):GetInt()
end
//This function gives the player the set loadout
function GM:PlayerLoadout( ply )
	ply:Give( "csgo_bowie" )
	ply:Give( "csgo_default_knife" )
	ply:Give( "csgo_flip" )
	ply:Give( "csgo_default_t" )
	ply:Give( "csgo_bayonet" )
if grenades == 1 then
	ply:Give( "weapon_frag" )
	if phys == 1 then
	ply:Give( "weapon_physcannon")
	end
end
if killrewards == 1 then
	if ply:GetNWInt("killcounter") >= killrew1 then
	ply:Give( "weapon_pistol" )
end
	if ply:GetNWInt("killcounter") >= killrew2 then
	ply:Give( "weapon_357" )
end
end
	-- Prevent default Loadout.
	return true
end


//These are just the hooks used by my code
hook.Add( "PlayerLoadout", "PlayerLoadout" )
hook.Add( "PlayerSpawn", "playerSetSpeedtest", playerSetSpeed )
//This sets the players speed
function playerSetSpeed(ply)
timer.Simple(2, function()
    GAMEMODE:SetPlayerSpeed(ply, 130, 250))
end
end
