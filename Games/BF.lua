local LocalPlayer = game.Players.LocalPlayer

local function GetPlayerData(Type)
    if Type = "Level" then
        print(LocalPlayer.Data)
    end
end

GetPlayerData("Level")

local Config = {
    ["Enemies"] = {
        ["Bandit"] = {
            ["Level"] = 5,
            ["QuestLevel"] = 0,
            ["IsLand"] = "Starter Prirate"
        }
    },
    ["NPCS"] = {
        ["Bandit Quest Giver"] = {
            ["Sea"] = 1,
            ["IsQuest"] = true,
            ["QuestEnemyType"] = "prirate",
            ["Island"] = "Starter Prirate",
        }
    },
    ["Quests"] = {
        ["Bandits"] = {
            ["NPC"] = "Bandit",
            ["minLevel"] = 0,
        }
    }
}

local function WalkOnWater(SizeY)
    local WaterBasePlane = workspace.Map["WaterBase-Plane"]
    -- print(workspace.Map["WaterBase-Plane"].Size.Y)
    workspace.Map["WaterBase-Plane"].Size = Vector3.new(workspace.Map["WaterBase-Plane"].Size.X,SizeY,workspace.Map["WaterBase-Plane"].Size.Z)
end

WalkOnWater(113)