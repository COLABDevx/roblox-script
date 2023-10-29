local LocalPlayer = game.Players.LocalPlayer


local Configs = {
    ["Enemies"] = {
        ["Bandit"] = {
            ["Level"] = 5,
            ["QuestLevel"] = 0,
            ["IsLand"] = "Starter Prirate"
        }
    },
    ["NPCS"] = {
        ["Bandit Quest Giver"] = {
            ["Level"] = 0,
            ["Sea"] = 1,
            ["IsQuest"] = true,
            ["QuestEnemyType"] = "prirate",
            ["Island"] = "Starter Prirate",
        }
    },
    ["Quests"] = {
        ["Bandits"] = {
            ["NPC"] = "Bandit",
            ["Level"] = 0,
        }
    }
}

function GetPlayerData(Type)
    if Type == "Level" then
        return LocalPlayer.Data.Level.Value
    end
end

function GetCurrentPlayerQuestNpc(PlayerLevel)
    for _,npc in pairs(Configs["NPCS"]) do
        if PlayerLevel >= npc.Level then
            return _,npc
        end
    end

    return nil
end

function GetCurrentPlayerQuest(PlayerLevel)
    -- local GetNPC = Configs["NPCS"][""]
    local Name,Data = GetCurrentPlayerQuestNpc(PlayerLevel)

    local NPC_HumanoidRootPart = workspace.NPCs[Name].HumanoidRootPart

    print(NPC_HumanoidRootPart.CFrame)

    -- print(workspace["NPCs"]:GetChildren()[Data])
end

-- local PlayerLevel = GetPlayerData("Level")
GetCurrentPlayerQuest(1)


local function WalkOnWater(SizeY)
    local WaterBasePlane = workspace.Map["WaterBase-Plane"]
    -- print(workspace.Map["WaterBase-Plane"].Size.Y)
    workspace.Map["WaterBase-Plane"].Size = Vector3.new(workspace.Map["WaterBase-Plane"].Size.X,SizeY,workspace.Map["WaterBase-Plane"].Size.Z)
end

WalkOnWater(113)