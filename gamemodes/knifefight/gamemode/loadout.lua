--This function runs every tick
function GM:Tick()
	ConVars = {}

	ConVars.grenades = GetConVar("kf_grenades"):GetInt() --This stuff sets variables every tick
	ConVars.phys = GetConVar("kf_phys"):GetInt()
end

--This function gives the player the set loadout
function GM:PlayerLoadout(ply)
	ply:Give("csgo_bowie")
	ply:Give("csgo_default_knife")
	ply:Give("csgo_flip")
	ply:Give("csgo_default_t")
	ply:Give("csgo_bayonet")
	if ConVars.grenades == 1 then
		ply:Give("weapon_frag")
		if ConVars.phys == 1 then
			ply:Give("weapon_physcannon")
		end
	end
	-- Prevent default Loadout.
	return true
end

--This sets the players speed
local function playerSetSpeed(ply)
	timer.Simple(
		2,
		function()
			--GAMEMODE:SetPlayerSpeed(ply, 130, 250)
		end
	)
end

--These are just the hooks used by my code
hook.Add("PlayerLoadout", "PlayerLoadout")
hook.Add("PlayerSpawn", "playerSetSpeedtest", playerSetSpeed)
