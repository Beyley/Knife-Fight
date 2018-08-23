GM.Name = "Knife Fight"
GM.Author = "Ep1c_M1n10n"
GM.Email = "ep1cm1n10n123@gmail.com"
GM.Website = "ep1cm1n10n.ddns.net"

startTime = os.time()
endTime = startTime+1000
currentMap = game.GetMap()

function GM:Initialize()
		tables_exist()
end

function GM:Tick()

RunConsoleCommand( "give", "csgo_flip_fade" )

if os.time() >= endTime then
	RunConsoleCommand( "map", currentMap )
end
end

function sql_value_stats ( ply )
	unique_id = sql.QueryValue("SELECT unique_id FROM player_info WHERE unique_id = '"..steamID.."'")
	money = sql.QueryValue("SELECT money FROM player_info WHERE unique_id = '"..steamID.."'")
	ply:SetNWString("unique_id", unique_id)
	ply:SetNWInt("money", money)
end
 
function sql_value_skills ( ply )
	unique_id = sql.QueryValue("SELECT unique_id FROM player_skills WHERE unique_id = '"..steamID.."'")
	speech = sql.QueryValue("SELECT speech FROM player_skills WHERE unique_id = '"..steamID.."'")
	fish = sql.QueryValue("SELECT fish FROM player_skills WHERE unique_id = '"..steamID.."'")
	farm = sql.QueryValue("SELECT farm FROM player_skills WHERE unique_id = '"..steamID.."'")
	ply:SetNWString("unique_id", unique_id)
	ply:SetNWInt("speech", speech)
	ply:SetNWInt("fish", fish)
	ply:SetNWInt("farm", farm)
end
 
function saveStat ( ply )
	money = ply:GetNWInt("money")
	unique_id = ply:GetNWString ("SteamID")
	speech = ply:GetNWInt("speech")
	fish = ply:GetNWInt("fish")
	farm = ply:GetNWInt("farm")
	sql.Query("UPDATE player_skills SET speech = "..speech..", fish = "..fish..", farm = "..farm.." WHERE unique_id = '"..unique_id.."'")
	sql.Query("UPDATE player_info SET money = "..money.." WHERE unique_id = '"..unique_id.."'")
	ply:ChatPrint("Stats updated !")
end
 
function tables_exist()
 
	if (sql.TableExists("player_info") && sql.TableExists("player_skills")) then
		Msg("Both tables already exist !")
	else
		if (!sql.TableExists("player_info")) then
			query = "CREATE TABLE player_info ( unique_id varchar(255), money int )"
			result = sql.Query(query)
			if (sql.TableExists("player_info")) then
				Msg("Succes ! table 1 created \n")
			else
				Msg("Somthing went wrong with the player_info query ! \n")
				Msg( sql.LastError( result ) .. "\n" )
			end	
		end
		if (!sql.TableExists("player_skills")) then
			query = "CREATE TABLE player_skills ( unique_id varchar(255), speech int, fish int, farm int )"
			result = sql.Query(query)
			if (sql.TableExists("player_skills")) then
				Msg("Succes ! table 2 created \n")
			else
				Msg("Somthing went wrong with the player_skills query ! \n")
				Msg( sql.LastError( result ) .. "\n" )
			end	
		end
	end
 
end
 
function new_player( SteamID, ply )
 
		steamID = SteamID
		sql.Query( "INSERT INTO player_info (`unique_id`, `money`)VALUES ('"..steamID.."', '100')" )
		result = sql.Query( "SELECT unique_id, money FROM player_info WHERE unique_id = '"..steamID.."'" )
		if (result) then
 
			sql.Query( "INSERT INTO player_skills (`unique_id`, `speech`, `fish`, `farm`)VALUES ('"..steamID.."', '1', '1', '1')" )
			result = sql.Query( "SELECT unique_id, speech, fish, farm FROM player_skills WHERE unique_id = '"..steamID.."'" )
			if (result) then
				Msg("Player account created !\n")
				sql_value_stats( ply )
				sql_value_skills( ply )
			else
				Msg("Something went wrong with creating a players skills !\n")
			end
 
		else
			Msg("Something went wrong with creating a players info !\n")
		end
end
 
function player_exists( ply )
 
	steamID = ply:GetNWString("SteamID")
 
	result = sql.Query("SELECT unique_id, money FROM player_info WHERE unique_id = '"..steamID.."'")
	if (result) then
			sql_value_stats( ply ) // We will call this to retrieve the stats
			sql_value_skills( ply ) // We will call this to retrieve the skills
	else
		new_player( steamID, ply ) // Create a new player :D
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
 
hook.Add( "PlayerInitialSpawn", "PlayerInitialSpawn", PlayerInitialSpawn )
hook.Add( "Initialize", "Initialize", Initialize )
 