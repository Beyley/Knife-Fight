GM.Name = "Knife Fight"
GM.Author = "Ep1c_M1n10n"
GM.Email = "ep1cm1n10n123@gmail.com"
GM.Website = "ep1cm1n10n.ddns.net"

maps = {"gm_construct", "gm_flatgrass"}
startTime = os.time()
endTime = startTime+1000
currentMap = game.GetMap()

function GM:Initialize()
end

function GM:Tick()
RunConsoleCommand( "give", "csgo_flip_fade" )
if os.time() >= endTime then
	game.ConsoleCommand("changelevel " ..table.Random(maps).. "\n")
end
end

    function sql_value_stats ( ply )
	unique_id = sql.QueryValue("SELECT unique_id FROM player_info WHERE unique_id = '"..steamID.."'")
	kills = sql.QueryValue("SELECT kills FROM player_info WHERE unique_id = '"..steamID.."'")
	ply:SetNWString("unique_id", unique_id)
	ply:SetNWInt("kills", kills)
end
 
function saveStat ( ply )
	kills = ply:GetNWInt("kills")
	print( kills )
	unique_id = ply:GetNWString ("SteamID")
	sql.Query("UPDATE player_info SET kills = "..kills.." WHERE unique_id = '"..unique_id.."'")
	ply:ChatPrint("Stats updated !")
end

function tables_exist()
 
	if (sql.TableExists("player_info")) then
		Msg("The table already exists!")
	else
		if (!sql.TableExists("player_info")) then
			query = "CREATE TABLE player_info ( unique_id varchar(255), kills int )"
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
end
 
hook.Add( "PlayerInitialSpawn", "PlayerInitialS`pawn", PlayerInitialSpawn )
hook.Add( "Initialize", "Initialize", Initialize )