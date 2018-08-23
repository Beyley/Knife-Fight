AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function KillCounter( victim, weapon, killer )  --Sets up a new function called KillCounter
        if killer:GetNWInt("killcounter") == 100000 then --If the killcounter variable equals 100000 then do something 
            PrintMessage(HUD_PRINTTALK, "Player" .. killer:GetName() .. "Has Won")  --When the killcounter equals 50 it will print this "Player <playername> has won
            timer.Simple(3, function()   --Sets up a timer for three seconds
                game.ConsoleCommand("changelevel " ..table.Random(maps).. "\n") --When the timer finishes it excecutes this console command   
            end)  
        end  
            killer:SetNWInt("killcounter", killer:GetNWInt("killcounter") + 1)  --Adds 1 everytime an NPC is killed.
    end

    hook.Add("PlayerDeath","KillCounter", KillCounter)
