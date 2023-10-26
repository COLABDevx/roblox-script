local UserInputService = game:GetService("UserInputService")

local KeyPress = {
    LeftControl = false,
    R = false
}

local Games = {
    {
        PlaceId = {7449423635},
        Name = "Blox Fruit",
        File = "Games/BF"
    },
    
}

ColabDev.Utilities = {}

function ColabDev.Utilities.FindGame()
    for i, g in ipairs(Games) do
        for _, placeId in ipairs(g.PlaceId) do
            if placeId == game.PlaceId then
                return g
            end
        end
    end

    return nil
end



function ColabDev.Utilities.Log(type,message)
    if type ~= nil and message ~= nil then
        return game:HttpGet(string.format("%s/api/log-service?type=%s&message=%s",ColabDev.Config.DevMode.LogService.Ip,type,message))
    end

   return nil 
end

-- ColabDev.Utilities.Log("Success","Script Init...")

function ColabDev.Utilities.FixUpValue(fn,hook,gvar)
    if gvar then
        old = hookfunction(fn,function(...)
            return hook(old,...)
        end)
    else
        local old = nil
        old = hookfunction(fn,function(...)
            return hook(old,...)
        end)
    end
end

if ColabDev.Config.DevMode.Enable then

    UserInputService.InputBegan:Connect(function(input, _gameProcessed)
        if input.KeyCode  == Enum.KeyCode.LeftControl then
            KeyPress.LeftControl = true
        end
        if input.KeyCode == Enum.KeyCode.R then
            KeyPress.R = true
        end

        if KeyPress.R and KeyPress.LeftControl then
            

            local Game = ColabDev.Utilities.FindGame()

            if Game == nil then 
                -- ColabDev.Utilities.Log("ERROR",)
                return game:GetService("StarterGui"):SetCore("SendNotification",{
                    Title = "Script Error...", 
                    Text = "Game PlaceId"..game.PlaceId.." Not Found", 
                    Icon = "rbxassetid://1234567890"
                })
            end
            
            ColabDev.Game = {Name = Game.Name}

            -- ColabDev.Utilities.Log("Success","Found Game "..Game.Name)

            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "Script Loading...", 
                Text = "Game Name : "..Game.Name, 
                Icon = "rbxassetid://1234567890"
            })
            
            

            loadstring(game:HttpGet(ColabDev.Config.DevMode.Source.Ip.."/"..Game.File..".lua"))()
        end
    end)

    UserInputService.InputEnded:Connect(function(input, _gameProcessed)
        if input.KeyCode  == Enum.KeyCode.LeftControl then
            KeyPress.LeftControl = false
        end

        if input.KeyCode == Enum.KeyCode.R then
            KeyPress.R = false
        end
    end)

end