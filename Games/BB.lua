local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Tortoiseshell = getupvalue(require(ReplicatedStorage.TS),1)
ColabDev.Utilities.UI = loadstring(game:HttpGet("http://localhost:8080/Utilities/UI.lua"))()


local Window = ColabDev.Utilities.UI:Window({
    Name = ("COLABDev %s %s"):format(utf8.char(8212),ColabDev.Game.Name),
    Position = UDim2.new(0.5,-248 * 3,0.5,-248)
}) do

    local CombatTab = Window:Tab({Name = "Combat"})
    local AimbotSession = CombatTab:Section({Name = "Aimbot",Side = "Left"})
    AimbotSession:Toggle({Name = "Enabled",Flag = "Aimbot/Enabled",Value = false})
    
    local WeaponSession = CombatTab:Section({Name = "Weapon",Side = "Left"})
    WeaponSession:Toggle({Name = "Enabled",Flag = "Weapon/Recoil/Enabled",Value = false})
    WeaponSession:Slider({Name = "Bullet Drop",Flag = "Weapon/Recoil/BulletDrop",Min = 0,Max = 100,Value = 0,Unit = "%"})


    local VisualsTab = Window:Tab({Name = "Visuals"})
    local ESPSession = VisualsTab:Section({Name = "ESP",Side = "Left"})
    ESPSession:Toggle({Name = "Enabled",Flag = "ESP/Enabled",Value = false})
end




ColabDev.Utilities.FixUpValue(Tortoiseshell.Raycast.CastGeometryAndEnemies,function(Old,Self,...)
    if Window.Flags["Weapon/Recoil/Enabled"] then
        local Args = {...} if Args[4] and Args[4].Gravity then
            Args[4].Gravity = Args[4].Gravity * (Window.Flags["Weapon/Recoil/BulletDrop"] / 100)
            return Old(Self,unpack(Args))
        end
    end

    return Old(Self,...)
end)

RunService.RenderSteped:Connect(function()
    print(Window.Flags["Weapon/Recoil/Enabled"])
end)