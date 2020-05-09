include("shared.lua")
include("loadout.lua")

function KillCounter()
    draw.WordBox(
        8,
        ScrW() - 920,
        ScrH() - 98,
        "Kill Streak: " .. LocalPlayer():GetNWInt("killstreak"),
        "Default",
        Color(255, 100, 100, 200),
        Color(255, 255, 255, 255)
    )
end

hook.Add("HUDPaint", "KillCounter", KillCounter)
