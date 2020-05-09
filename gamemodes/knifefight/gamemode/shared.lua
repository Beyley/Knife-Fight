GM.Name = "Knife Fight"
GM.Author = "PoltixeTheDerg"
GM.Email = "ep1cm1n10n123@gmail.com"
GM.Website = "poltixe.ddns.net"

local playerModels = {
	"models/player/kleiner.mdl",
	"models/player/police.mdl",
	"models/player/police_fem.mdl",
	"models/player/combine_soldier.mdl",
	"models/player/combine_super_soldier.mdl",
	"models/player/combine_soldier_prisonguard.mdl",
	"models/player/Group01/male_07.mdl"
}
local mapRotation = {"gm_construct", "gm_flatgrass", "kf_spheres", "kf_quakena", "kf_arena"}
local gameStartTime = os.time()

function GM:Initialize()
end

function GM:Tick()
	local timeLimit = GetConVar("kf_timelimit"):GetInt() * 60
	local endTime = gameStartTime + timeLimit

	if os.time() >= endTime then
		game.ConsoleCommand("changelevel " .. table.Random(mapRotation) .. "\n")
	end
end

function PlayerInitialSpawn(ply)
	ply:SetModel(table.Random(playerModels))
end

hook.Add("PlayerInitialSpawn", "PlayerInitialSpawn", PlayerInitialSpawn)
hook.Add("Initialize", "Initialize", Initialize)

function KillCounter(victim, weapon, killer) --Sets up a new function called KillCounter
	if killer ~= victim then
		killer:SetNWInt("killstreak", killer:GetNWInt("killstreak") + 1)
	end

	victim:SetNWInt("killstreak", 0)
	--kills = victim:GetNWInt("killstreak")
end

hook.Add("PlayerDeath", "KillCounter", KillCounter)

function GM:PlayerSwitchFlashlight(ply, SwitchOn)
	return true
end
