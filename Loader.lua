local UserInputService = game:GetService("UserInputService")

local KeyPress = {
    LeftControl = false,
    R = false,
    D = false
}

local Games = {
    {
        PlaceId = {2753915549,7449423635},
        Name = "Blox Fruit",
        File = "Games/BF"
    },
    
}

ColabDev.Utilities = {}
ColabDev.Utilities.UI = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

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



-- function ColabDev.Utilities.Log(type,message)
--     if type ~= nil and message ~= nil then
--         return game:HttpGet(string.format("%s/api/log-service?type=%s&message=%s",ColabDev.Config.DevMode.LogService,type,message))
--     end

--    return nil 
-- end


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

function ColabDev.Utilities.DumpTable(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

function ColabDev.Utilities.loadScript()
    local Game = ColabDev.Utilities.FindGame()

    if Game == nil then 
        return game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Script Error...", 
            Text = "Game PlaceId "..game.PlaceId.." Not Found", 
            Icon = "rbxassetid://1234567890"
        })
    end
            
    ColabDev.Game = {Name = Game.Name}

    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Script Loading...", 
        Text = "Game Name : "..Game.Name, 
        Icon = "rbxassetid://1234567890"
    })
            
            
    loadstring(game:HttpGet(ColabDev.Config.DevMode.Source.."/"..Game.File..".lua"))()
end

if ColabDev.Config.DevMode.Enable then

    UserInputService.InputBegan:Connect(function(input, _gameProcessed)
        if input.KeyCode  == Enum.KeyCode.LeftControl then
            KeyPress.LeftControl = true
        end
        if input.KeyCode == Enum.KeyCode.R then
            KeyPress.R = true
        end

        if input.KeyCode == Enum.KeyCode.D then
            KeyPress.D = true
        end

        if KeyPress.R and KeyPress.LeftControl then
            ColabDev.Utilities.loadScript()
        end

        if KeyPress.D and KeyPress.LeftControl then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end
    end)

    UserInputService.InputEnded:Connect(function(input, _gameProcessed)
        if input.KeyCode  == Enum.KeyCode.LeftControl then
            KeyPress.LeftControl = false
        end

        if input.KeyCode == Enum.KeyCode.R then
            KeyPress.R = false
        end

        if input.KeyCode == Enum.KeyCode.D then
            KeyPress.D = false
        end
    end)

else
    ColabDev.Utilities.loadScript()
end