local units = {
    UpGrade = function()
        for _,unit in pairs(workspace:WaitForChild("_UNITS"):GetChildren()) do
            local args = { [1] = unit }
            game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("upgrade_unit_ingame"):InvokeServer(unpack(args))
        end
    end,
    Replay = function()
        local args = { [1] = "replay" }
        game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("set_game_finished_vote"):InvokeServer(unpack(args))
    end,
    VoteStart = function()
        game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("vote_start"):InvokeServer()
    end,
    SellAllUnit = function()
        for _,unit in pairs(workspace:WaitForChild("_UNITS"):GetChildren()) do
            local args = { [1] = unit }
            game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("sell_unit_ingame"):InvokeServer(unpack(args))
        end
    end,
    RequestRoom = function(args)
       
        game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("request_join_lobby"):InvokeServer(unpack(args))
        
    end
}

units.Replay()
units.VoteStart()
units.UpGrade()


local args = {
    [1] = "_lobbytemplategreen5"
}

units.RequestRoom(args)