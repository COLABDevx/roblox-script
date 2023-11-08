-- local LocalPlayer = game.Players.LocalPlayer
-- local TweenService = game:GetService("TweenService")
-- local Character = LocalPlayer.Character or Player.CharacterAdded:Wait()
-- local HumanoidRootPart = Character.HumanoidRootPart
-- local RunService = game:GetService("RunService")
-- local UserInputService = game:GetService("UserInputService")


-- local Configs = {
--     ["Islands"] = {
--         ["Starter Prirate"] = {
--             ["NickName"] = "Windmill",
--             ["Sea"] = 1,
--             ["CFrame"] = CFrame.new(1110.41284, 16.2993984, 1450.15393, 0.626955211, -5.22833687e-08, -0.779055297, -1.25271375e-08, 1, -7.71926238e-08, 0.779055297, 5.81556492e-08, 0.626955211)
--         }
--     },
--     ["Shop"] = {
--         ["Remotes"] = {
--             ["EvilFruitShop"] = function()
--                 local args = {
--                     [1] = "GetFruits",
--                     [2] = false
--                 }

            
                
--                 local data = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))                
                
--                 -- print(ColabDev.Utilities.DumpTable(data))
--             end
--         }
--     },
--     ["Enemies"] = {
--         ["Bandit"] = {
--             ["Level"] = 5,
--             ["QuestLevel"] = 0,
--             ["IsLand"] = "Starter Prirate",
--         }
--     },
--     ["NPCS"] = {
--         ["Bandit Quest Giver"] = {
--             ["Level"] = 0,
--             ["Sea"] = 1,
--             ["IsQuest"] = true,
--             ["QuestEnemyType"] = "prirate",
--             ["Island"] = "Starter Prirate",
--             ["CFrame"] = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544)
--         }
--     },
--     ["Quests"] = {
--         ["_IsAttack"] = false,
--         ["_Attack_Emnemy"] = nil,
--         ["_Remotes"] = {
--             ["GetQuest"] = function(args)
--                 game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(
--                 args))
--             end,
--             ["AbandonQuest"] = function()
--                 local args = { [1] = "AbandonQuest" }
--                 game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(
--                 args))
--             end
--         },
--         ["Bandits"] = {
--             ["EnemyName"] = "Bandit",
--             ["NPC"] = "Bandit Quest Giver",
--             ["Level"] = 0,
--             ["QuestRemoteArgs"] = {
--                 [1] = "StartQuest",
--                 [2] = "BanditQuest1",
--                 [3] = 1
--             }
--         }
--     }
-- }

-- -- Configs["Shop"]["Remotes"]:EvilFruitShop()

-- local Trades = {}

-- local Tween = {
--     ["Current"] = nil,
--     ["ToCFrame"] = function(CFrame)
--         local speed = 250

--         local distance = (CFrame.Position - HumanoidRootPart.Position).Magnitude
--         local time = distance / speed

--         local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear)

--         return TweenService:Create(HumanoidRootPart, tweenInfo, {
--             CFrame = CFrame
--         })
--     end,
--     ["StopTween"] = function()
--         if Tween.Current ~= nil then
--             Tween.Current.Cancel()
--         end
--     end
-- }

-- -- print(setclipboard(tostring(HumanoidRootPart.CFrame)))

-- -- Configs["Quests"]["_Remotes"].AbandonQuest()

-- function GetPlayerData(Type)
--     if Type == "Level" then
--         return LocalPlayer.Data.Level.Value
--     end
-- end

-- function GetCurrentPlayerQuestNpc(PlayerLevel)
--     for _, npc in pairs(Configs["NPCS"]) do
--         if PlayerLevel >= npc.Level then
--             return npc
--         end
--     end

--     return nil
-- end

-- function GetCurrentPlayerNPCQuest(PlayerLevel)
--     local Data = GetCurrentPlayerQuestNpc(PlayerLevel)

--     -- local NPC = workspace.NPCs[Name]

--     return Data
-- end

-- function FindNearEenemy(Name)
--     local nearestEnemy = nil
--     local minDistance = math.huge -- Initialize to a very large number

--     -- print(Name)

--     for _, enemy in pairs(workspace.Enemies:GetChildren()) do
--         if enemy.Name == Name then
--             -- print(Name)
            

--             local enemyRootPart = enemy:FindFirstChild("HumanoidRootPart")
--             -- print(enemyRootPart)
--             enemyRootPart.Anchored = true
--             enemyRootPart.Size = Vector3.new(50,50,50)
--             enemyRootPart.CanCollide = false

--             if enemyRootPart and enemy.Humanoid.Health > 0 then
--                 local distance = (enemyRootPart.CFrame.Position - HumanoidRootPart.Position).Magnitude
--                 if distance < minDistance then
--                     minDistance = distance
--                     nearestEnemy = enemy
--                 end
--             end
--         end
--     end

--     return nearestEnemy
-- end

-- -- local PlayerLevel = GetPlayerData("Level")
-- local function AutoFarmLevel()
--     local Data = GetCurrentPlayerNPCQuest(1)

--     HumanoidRootPart.Anchored = false
--     Tween.Current = Tween.ToCFrame(Data["CFrame"])
--     Tween.Current:Play()
--     Tween.Current.Completed:Connect(function()
--         local QuestRemoteArgs = Configs["Quests"]["Bandits"]["QuestRemoteArgs"]
--         Configs["Quests"]["_Remotes"].GetQuest(QuestRemoteArgs)

--         local target = FindNearEenemy(Configs["Quests"]["Bandits"]["EnemyName"])
--         Configs.Quests._Attack_Emnemy = target
        
--         if target ~= nil then
--             Tween.Current = Tween.ToCFrame(target.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(0, 15, 0)))
--             Tween.Current:Play()

--             Tween.Current.Completed:Connect(function ()
--                 Configs["Quests"]["_IsAttack"] = true
--                 -- HumanoidRootPart.Anchored = true
--             end)
--         end
--     end)
-- end

-- local function CheckQuestGUIActive()
--     return game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
-- end

-- local function WalkOnWater(SizeY)
--     local WaterBasePlane = workspace.Map["WaterBase-Plane"]
--     workspace.Map["WaterBase-Plane"].Size = Vector3.new(WaterBasePlane.Size.X, SizeY, WaterBasePlane.Size.Z)
-- end

-- WalkOnWater(113)

-- AutoFarmLevel()

-- Trades.Main = RunService.Stepped:Connect(function ()
--     if(Configs["Quests"]["_IsAttack"]) and Configs["Quests"]["_Attack_Emnemy"] ~= nil and Configs["Quests"]["_Attack_Emnemy"]:FindFirstChild("HumanoidRootPart") then
--         if Configs["Quests"]["_Attack_Emnemy"].Humanoid.Health > 0 then
--             HumanoidRootPart.CFrame = Configs["Quests"]["_Attack_Emnemy"].HumanoidRootPart.CFrame * CFrame.new(Vector3.new(0,30,0))
--         end
--     end

--     if  Configs["Quests"]["_Attack_Emnemy"] ~= nil and Configs["Quests"]["_Attack_Emnemy"].Humanoid.Health <= 0 then
--         local target = FindNearEenemy(Configs["Quests"]["Bandits"]["EnemyName"])
--         Configs.Quests._Attack_Emnemy = target
        
--         if target ~= nil then
--             Tween.Current = Tween.ToCFrame(target.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(0, 15, 0)))
--             Tween.Current:Play()
    
--             Tween.Current.Completed:Connect(function ()
                
--                if CheckQuestGUIActive() == false then
--                 Configs["Quests"]["_IsAttack"] = false
--                 AutoFarmLevel()
--                else
--                 Configs["Quests"]["_IsAttack"] = true
--                end
--             end)
--         end
--     end
-- end)

-- local KeyPress = {
--     LeftControl = false,
--     R = false,
-- }

-- UserInputService.InputBegan:Connect(function(input, _gameProcessed)
--     if input.KeyCode  == Enum.KeyCode.LeftControl then
--         KeyPress.LeftControl = true
--     end
--     if input.KeyCode == Enum.KeyCode.R then
--         KeyPress.R = true
--     end

--     if KeyPress.R and KeyPress.LeftControl then
--        for _, t in pairs(Trades) do
--             t:Disconnect()
--        end
--        Trades = {}
--     end

-- end)

-- UserInputService.InputEnded:Connect(function(input, _gameProcessed)
--     if input.KeyCode  == Enum.KeyCode.LeftControl then
--         KeyPress.LeftControl = false
--     end

--     if input.KeyCode == Enum.KeyCode.R then
--         KeyPress.R = false
--     end
-- end)

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Fluent " .. Fluent.Version,
    SubTitle = "by dawid",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do
    Fluent:Notify({
        Title = "Notification",
        Content = "This is a notification",
        SubContent = "SubContent", -- Optional
        Duration = 5 -- Set to nil to make the notification not disappear
    })



    Tabs.Main:AddParagraph({
        Title = "Paragraph",
        Content = "This is a paragraph.\nSecond line!"
    })



    Tabs.Main:AddButton({
        Title = "Button",
        Description = "Very important button",
        Callback = function()
            Window:Dialog({
                Title = "Title",
                Content = "This is a dialog",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            print("Confirmed the dialog.")
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Cancelled the dialog.")
                        end
                    }
                }
            })
        end
    })



    local Toggle = Tabs.Main:AddToggle("MyToggle", {Title = "Toggle", Default = false })

    Toggle:OnChanged(function()
        print("Toggle changed:", Options.MyToggle.Value)
    end)

    Options.MyToggle:SetValue(false)


    
    local Slider = Tabs.Main:AddSlider("Slider", {
        Title = "Slider",
        Description = "This is a slider",
        Default = 2,
        Min = 0,
        Max = 5,
        Rounding = 1,
        Callback = function(Value)
            print("Slider was changed:", Value)
        end
    })

    Slider:OnChanged(function(Value)
        print("Slider changed:", Value)
    end)

    Slider:SetValue(3)



    local Dropdown = Tabs.Main:AddDropdown("Dropdown", {
        Title = "Dropdown",
        Values = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen"},
        Multi = false,
        Default = 1,
    })

    Dropdown:SetValue("four")

    Dropdown:OnChanged(function(Value)
        print("Dropdown changed:", Value)
    end)


    
    local MultiDropdown = Tabs.Main:AddDropdown("MultiDropdown", {
        Title = "Dropdown",
        Description = "You can select multiple values.",
        Values = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen"},
        Multi = true,
        Default = {"seven", "twelve"},
    })

    MultiDropdown:SetValue({
        three = true,
        five = true,
        seven = false
    })

    MultiDropdown:OnChanged(function(Value)
        local Values = {}
        for Value, State in next, Value do
            table.insert(Values, Value)
        end
        print("Mutlidropdown changed:", table.concat(Values, ", "))
    end)



    local Colorpicker = Tabs.Main:AddColorpicker("Colorpicker", {
        Title = "Colorpicker",
        Default = Color3.fromRGB(96, 205, 255)
    })

    Colorpicker:OnChanged(function()
        print("Colorpicker changed:", Colorpicker.Value)
    end)
    
    Colorpicker:SetValueRGB(Color3.fromRGB(0, 255, 140))



    local TColorpicker = Tabs.Main:AddColorpicker("TransparencyColorpicker", {
        Title = "Colorpicker",
        Description = "but you can change the transparency.",
        Transparency = 0,
        Default = Color3.fromRGB(96, 205, 255)
    })

    TColorpicker:OnChanged(function()
        print(
            "TColorpicker changed:", TColorpicker.Value,
            "Transparency:", TColorpicker.Transparency
        )
    end)



    local Keybind = Tabs.Main:AddKeybind("Keybind", {
        Title = "KeyBind",
        Mode = "Toggle", -- Always, Toggle, Hold
        Default = "LeftControl", -- String as the name of the keybind (MB1, MB2 for mouse buttons)

        -- Occurs when the keybind is clicked, Value is `true`/`false`
        Callback = function(Value)
            print("Keybind clicked!", Value)
        end,

        -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
        ChangedCallback = function(New)
            print("Keybind changed!", New)
        end
    })

    -- OnClick is only fired when you press the keybind and the mode is Toggle
    -- Otherwise, you will have to use Keybind:GetState()
    Keybind:OnClick(function()
        print("Keybind clicked:", Keybind:GetState())
    end)

    Keybind:OnChanged(function()
        print("Keybind changed:", Keybind.Value)
    end)

    task.spawn(function()
        while true do
            wait(1)

            -- example for checking if a keybind is being pressed
            local state = Keybind:GetState()
            if state then
                print("Keybind is being held down")
            end

            if Fluent.Unloaded then break end
        end
    end)

    Keybind:SetValue("MB2", "Toggle") -- Sets keybind to MB2, mode to Hold


    local Input = Tabs.Main:AddInput("Input", {
        Title = "Input",
        Default = "Default",
        Placeholder = "Placeholder",
        Numeric = false, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            print("Input changed:", Value)
        end
    })

    Input:OnChanged(function()
        print("Input updated:", Input.Value)
    end)
end


-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()