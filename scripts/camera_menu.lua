--@brinyiczki 2023
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")



function PlayerAdded(player : Player)
    print(player.Name.." has entered the server")
    local leaderstat = Instance.new("Folder",player)
    leaderstat.Name = "leaderstats"
    
    local level = Instance.new("IntValue",leaderstat)
    level.Name = "level"
    
    level.Value = 10

    local function CharacterAdded(character)
        print(character.Name .. " has spawned")
    end

    CharacterAdded(player.Character or player.CharacterAdded:Wait())
    player.CharacterAdded:Connect(CharacterAdded)
end

game.Players.PlayerAdded:Connect(PlayerAdded)
for _, player in pairs(game.Players:GetPlayers()) do
    spawn(function()
        PlayerAdded(player)
    end)
end