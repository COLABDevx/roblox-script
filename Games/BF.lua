local LocalPlayer = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local Character = LocalPlayer.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character.HumanoidRootPart
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")


local Configs = {
    ["Islands"] = {
        ["Starter Prirate"] = {
            ["NickName"] = "Windmill",
            ["Sea"] = 1,
            ["CFrame"] = CFrame.new(1110.41284, 16.2993984, 1450.15393, 0.626955211, -5.22833687e-08, -0.779055297, -1.25271375e-08, 1, -7.71926238e-08, 0.779055297, 5.81556492e-08, 0.626955211)
        }
    },
    ["Shop"] = {
        ["Remotes"] = {
            ["EvilFruitShop"] = function()
                local args = {
                    [1] = "GetFruits",
                    [2] = false
                }

            
                
                local data = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))                
                
                -- print(ColabDev.Utilities.DumpTable(data))
            end
        }
    },
    ["Enemies"] = {
        ["Bandit"] = {
            ["Level"] = 5,
            ["QuestLevel"] = 0,
            ["IsLand"] = "Starter Prirate",
        }
    },
    ["NPCS"] = {
        ["Bandit Quest Giver"] = {
            ["Level"] = 0,
            ["Sea"] = 1,
            ["IsQuest"] = true,
            ["QuestEnemyType"] = "prirate",
            ["Island"] = "Starter Prirate",
            ["CFrame"] = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544)
        }
    },
    ["Quests"] = {
        ["_IsAttack"] = false,
        ["_Attack_Emnemy"] = nil,
        ["_Remotes"] = {
            ["GetQuest"] = function(args)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(
                args))
            end,
            ["AbandonQuest"] = function()
                local args = { [1] = "AbandonQuest" }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(
                args))
            end
        },
        ["Bandits"] = {
            ["EnemyName"] = "Bandit",
            ["NPC"] = "Bandit Quest Giver",
            ["Level"] = 0,
            ["QuestRemoteArgs"] = {
                [1] = "StartQuest",
                [2] = "BanditQuest1",
                [3] = 1
            }
        }
    }
}

-- Configs["Shop"]["Remotes"]:EvilFruitShop()

local Trades = {}

local Tween = {
    ["Current"] = nil,
    ["ToCFrame"] = function(CFrame)
        local speed = 250

        local distance = (CFrame.Position - HumanoidRootPart.Position).Magnitude
        local time = distance / speed

        local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear)

        return TweenService:Create(HumanoidRootPart, tweenInfo, {
            CFrame = CFrame
        })
    end,
    ["StopTween"] = function()
        if Tween.Current ~= nil then
            Tween.Current.Cancel()
        end
    end
}

-- print(setclipboard(tostring(HumanoidRootPart.CFrame)))

-- Configs["Quests"]["_Remotes"].AbandonQuest()

function GetPlayerData(Type)
    if Type == "Level" then
        return LocalPlayer.Data.Level.Value
    end
end

function GetCurrentPlayerQuestNpc(PlayerLevel)
    for _, npc in pairs(Configs["NPCS"]) do
        if PlayerLevel >= npc.Level then
            return npc
        end
    end

    return nil
end

function GetCurrentPlayerNPCQuest(PlayerLevel)
    local Data = GetCurrentPlayerQuestNpc(PlayerLevel)

    -- local NPC = workspace.NPCs[Name]

    return Data
end

function FindNearEenemy(Name)
    local nearestEnemy = nil
    local minDistance = math.huge -- Initialize to a very large number

    -- print(Name)

    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
        if enemy.Name == Name then
            -- print(Name)
            

            local enemyRootPart = enemy:FindFirstChild("HumanoidRootPart")
            -- print(enemyRootPart)
            enemyRootPart.Anchored = true
            enemyRootPart.Size = Vector3.new(50,50,50)
            enemyRootPart.CanCollide = false

            if enemyRootPart and enemy.Humanoid.Health > 0 then
                local distance = (enemyRootPart.CFrame.Position - HumanoidRootPart.Position).Magnitude
                if distance < minDistance then
                    minDistance = distance
                    nearestEnemy = enemy
                end
            end
        end
    end

    return nearestEnemy
end

-- local PlayerLevel = GetPlayerData("Level")
local function AutoFarmLevel()
    local Data = GetCurrentPlayerNPCQuest(1)

    HumanoidRootPart.Anchored = false
    Tween.Current = Tween.ToCFrame(Data["CFrame"])
    Tween.Current:Play()
    Tween.Current.Completed:Connect(function()
        local QuestRemoteArgs = Configs["Quests"]["Bandits"]["QuestRemoteArgs"]
        Configs["Quests"]["_Remotes"].GetQuest(QuestRemoteArgs)

        local target = FindNearEenemy(Configs["Quests"]["Bandits"]["EnemyName"])
        Configs.Quests._Attack_Emnemy = target
        
        if target ~= nil then
            Tween.Current = Tween.ToCFrame(target.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(0, 15, 0)))
            Tween.Current:Play()

            Tween.Current.Completed:Connect(function ()
                Configs["Quests"]["_IsAttack"] = true
                -- HumanoidRootPart.Anchored = true
            end)
        end
    end)
end

local function CheckQuestGUIActive()
    return game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
end

local function WalkOnWater(SizeY)
    local WaterBasePlane = workspace.Map["WaterBase-Plane"]
    workspace.Map["WaterBase-Plane"].Size = Vector3.new(WaterBasePlane.Size.X, SizeY, WaterBasePlane.Size.Z)
end

WalkOnWater(113)

-- AutoFarmLevel()

Trades.Main = RunService.Stepped:Connect(function ()
    if(Configs["Quests"]["_IsAttack"]) and Configs["Quests"]["_Attack_Emnemy"] ~= nil and Configs["Quests"]["_Attack_Emnemy"]:FindFirstChild("HumanoidRootPart") then
        if Configs["Quests"]["_Attack_Emnemy"].Humanoid.Health > 0 then
            HumanoidRootPart.CFrame = Configs["Quests"]["_Attack_Emnemy"].HumanoidRootPart.CFrame * CFrame.new(Vector3.new(0,30,0))
        end
    end

    if  Configs["Quests"]["_Attack_Emnemy"] ~= nil and Configs["Quests"]["_Attack_Emnemy"].Humanoid.Health <= 0 then
        local target = FindNearEenemy(Configs["Quests"]["Bandits"]["EnemyName"])
        Configs.Quests._Attack_Emnemy = target
        
        if target ~= nil then
            Tween.Current = Tween.ToCFrame(target.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(0, 15, 0)))
            Tween.Current:Play()
    
            Tween.Current.Completed:Connect(function ()
                
               if CheckQuestGUIActive() == false then
                Configs["Quests"]["_IsAttack"] = false
                AutoFarmLevel()
               else
                Configs["Quests"]["_IsAttack"] = true
               end
            end)
        end
    end
end)

local KeyPress = {
    LeftControl = false,
    R = false,
}

UserInputService.InputBegan:Connect(function(input, _gameProcessed)
    if input.KeyCode  == Enum.KeyCode.LeftControl then
        KeyPress.LeftControl = true
    end
    if input.KeyCode == Enum.KeyCode.R then
        KeyPress.R = true
    end

    if KeyPress.R and KeyPress.LeftControl then
       for _, t in pairs(Trades) do
            t:Disconnect()
       end
       Trades = {}
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