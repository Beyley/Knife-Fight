include( "shared.lua" )

function killcounter()  
        draw.WordBox( 8, ScrW() - 920, ScrH() - 98, "KillCount: "..LocalPlayer():GetNWInt("killcounter"),"ScoreboardText",Color(200,0,0,0),Color(255,255,255,255))  
    end  

hook.Add("HUDPaint","KillCounter",killcounter)  