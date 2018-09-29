GM.Name = "Knife Fight"
GM.Author = "Ep1c_M1n10n"
GM.Email = "ep1cm1n10n123@gmail.com"
GM.Website = "ep1cm1n10n.ddns.net"

//This code sets the needed variables for the rest of the code
models = {"models/player/kleiner.mdl", "models/player/police.mdl", "models/player/police_fem.mdl", "models/player/combine_soldier.mdl", "models/player/combine_super_soldier.mdl", "models/player/combine_soldier_prisonguard.mdl", "models/player/Group01/male_07.mdl"}
maps = {"gm_construct", "gm_flatgrass", "kf_spheres"}
knifes = {"csgo_flip", "csgo_default_knife", "csgo_bayonet", "csgo_default_t", "csgo_bowie"}
startTime = os.time()
currentMap = game.GetMap()
//Not used by my code
function GM:Initialize()
end
//This function runs every tick
function GM:Tick()
timelimit = GetConVar("kf_timelimit"):GetInt()*60
maxkills = GetConVar("kf_maxkills"):GetInt()
endTime = startTime+timelimit //Constantly updates the time the game ends in realtime so you can change it on the fly
timeleft = os.time()-endTime //Updates the lime left (NOT USED)
if os.time() >= endTime then //Checks when to end the round
	game.ConsoleCommand("changelevel " ..table.Random(maps).. "\n")
end
end
//This function runs on the player inital spawn
function PlayerInitialSpawn( ply )
ply:SetModel( table.Random(models) ) //This code sets a players playermodel
end
//Some hooks
hook.Add( "PlayerInitialSpawn", "PlayerInitialSpawn", PlayerInitialSpawn )
hook.Add( "Initialize", "Initialize", Initialize )
//Killcounter Code
function KillCounter( victim, weapon, killer )  --Sets up a new function called KillCounter
        if killer:GetNWInt("killcounter") == maxkills then --If the killcounter variable equals 100000 then do something 
            PrintMessage(HUD_PRINTTALK, "Player" .. killer:GetName() .. "Has Won")  --When the killcounter equals 50 it will print this "Player <playername> has won
            timer.Simple(3, function()   --Sets up a timer for three seconds
                game.ConsoleCommand("changelevel " ..table.Random(maps).. "\n") --When the timer finishes it excecutes this console command   
            end)  
        end
            if killer~=victim then
            killer:SetNWInt("killcounter", killer:GetNWInt("killcounter") + 1)

        
        end
	kills=victim:GetNWInt("killcounter")
    end

hook.Add("PlayerDeath","KillCounter", KillCounter)

function GM:PlayerSwitchFlashlight(ply, SwitchOn)
	return true
end