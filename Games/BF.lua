ColabDev.Utilities.UI = loadstring(game:HttpGet(ColabDev.Config.DevMode.Source.."/Utilities/UI.lua"))()
local Players = game.Players

local Window = ColabDev.Utilities.UI:Window({
    Name = ("COLABDev %s %s"):format(utf8.char(8212),ColabDev.Game.Name),
    Position = UDim2.new(0.5,0.5)
}) do

    local CombatTab = Window:Tab({Name = "Combat"})

    local AimbotSession = CombatTab:Section({Name = "Aimbot",Side = "Left"})
    AimbotSession:Toggle({Name = "Enabled",Flag = "Aimbot/Enabled",Value = false})

    local VisualsTab = Window:Tab({Name = "Visuals"})
    local ESPSession = VisualsTab:Section({Name = "ESP",Side = "Left"})
    ESPSession:Toggle({Name = "Enabled",Flag = "Visuals/ESP/Enabled",Value = false})
end

for _,Player in pairs(Players:GetPlayers()) do
    print(Player:WaitForChild("HumanoidRootPart"))
end