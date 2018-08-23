GM.Name = "Knife Fight"
GM.Author = "Ep1c_M1n10n"
GM.Email = "ep1cm1n10n123@gmail.com"
GM.Website = "ep1cm1n10n.ddns.net"

models = {"models/player/kleiner.mdl", "models/player/police.mdl", "models/player/police_fem.mdl", "models/player/combine_soldier.mdl", "models/player/combine_super_soldier.mdl", "models/player/combine_soldier_prisonguard.mdl", "models/player/Group01/male_07.mdl"}
maps = {"gm_construct", "gm_flatgrass"}
knifes = {"csgo_flip", "csgo_default_knife", "csgo_bayonet", "csgo_default_t", "csgo_bowie"}
startTime = os.time()
endTime = startTime+3000
currentMap = game.GetMap()
isloaddone = 0

function GM:Initialize()
end

function GM:Tick()
	//RunConsoleCommand( "give", table.Random(knifes) )
if os.time() >= endTime then
	game.ConsoleCommand("changelevel " ..table.Random(maps).. "\n")
end
end

    function sql_value_stats ( ply )
	unique_id = sql.QueryValue("SELECT unique_id FROM player_info WHERE unique_id = '"..steamID.."'")
	kills = sql.QueryValue("SELECT kills FROM player_info WHERE unique_id = '"..steamID.."'")
	gitkills = sql.QueryValue("SELECT kills FROM player_info WHERE unique_id = '"..steamID.."'")
	ply:SetNWString("unique_id", unique_id)
	ply:SetNWInt("kills", kills)
end
 
function saveStat ( ply )
	kills=ply:GetNWInt("killcounter")
	print(ply:GetNWInt("killcounter"))
	print(kills)
	unique_id = ply:GetNWString ("SteamID")
	print(unique_id)
	print(ply:GetNWString ("SteamID"))
	sql.Query("UPDATE player_info SET kills = "..kills.." WHERE unique_id = "..unique_id.."")
	print("Stats updated !")
end

function tables_exist()
 
	if (sql.TableExists("player_info")) then
		Msg("The table already exists!")
	else
		if (!sql.TableExists("player_info")) then
			query = "CREATE TABLE player_info ( unique_id varchar(255), kills int, deaths int )"
			result = sql.Query(query)
			if (sql.TableExists("player_info")) then
				Msg("Success ! table 1 created \n")
			else
				Msg("Somthing went wrong with the player_info query ! \n")
				Msg( sql.LastError( result ) .. "\n" )
			end	
		end
		end
	end

function new_player( SteamID, ply )
 
		steamID = SteamID
		sql.Query( "INSERT INTO player_info (`unique_id`, `kills`)VALUES ('"..steamID.."', '0')" )
		result = sql.Query( "SELECT unique_id, kills FROM player_info WHERE unique_id = '"..steamID.."'" )
		if (result) then
 
		else
			Msg("Something went wrong with creating a players info !\n")
		end
end

function player_exists( ply )
 
	steamID = ply:GetNWString("SteamID")
 
	result = sql.Query("SELECT unique_id, kills FROM player_info WHERE unique_id = '"..steamID.."'")
	if (result) then
			sql_value_stats( ply ) // retrieve the stats
	else
		new_player( steamID, ply ) // Create a new player 
	end
end
 
function Initialize()
	tables_exist()
end
 
function PlayerInitialSpawn( ply )
 
	timer.Create("Steam_id_delay", 1, 1, function()
		SteamID = ply:SteamID()
		ply:SetNWString("SteamID", SteamID)
		timer.Create("SaveStat", 10, 0, function() saveStat( ply ) end)
		player_exists( ply ) 
	end)
ply:SetModel( table.Random(models) )

end

function GM:PlayerLoadout( ply )
	ply:Give( "csgo_bowie" )
	ply:Give( "csgo_default_knife" )
	ply:Give( "csgo_flip" )
	ply:Give( "csgo_default_t" )
	ply:Give( "csgo_bayonet" )


	-- Prevent default Loadout.
	return true
end

hook.Add( "PlayerInitialSpawn", "PlayerInitialSpawn", PlayerInitialSpawn )
hook.Add( "Initialize", "Initialize", Initialize )
hook.Add( "PlayerLoadout", "PlayerLoadout" )

function KillCounter( victim, weapon, killer )  --Sets up a new function called KillCounter
	            	if result~=nul then
            		if isloaddone==0 then
            killer:SetNWInt("killcounter", killer:GetNWInt("killcounter") + gitkills)
            print(isloaddone)
            isloaddone = 1
            print(isloaddone)
        else
        	//not used
        end
    end
        if killer:GetNWInt("killcounter") == 100000 then --If the killcounter variable equals 100000 then do something 
            PrintMessage(HUD_PRINTTALK, "Player" .. killer:GetName() .. "Has Won")  --When the killcounter equals 50 it will print this "Player <playername> has won
            timer.Simple(3, function()   --Sets up a timer for three seconds
                game.ConsoleCommand("changelevel " ..table.Random(maps).. "\n") --When the timer finishes it excecutes this console command   
            end)  
        end
            if killer~=victim then
            killer:SetNWInt("killcounter", killer:GetNWInt("killcounter") + 1)

        
        end

    end

hook.Add("PlayerDeath","KillCounter", KillCounter)
