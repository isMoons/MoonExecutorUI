
local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local RS = game:GetService("ReplicatedStorage")
local piles = workspace.Map.TreasurePiles
local dig = RS.Source.Network.RemoteFunctions.Digging

local plr = game.Players.LocalPlayer
local playerPos = plr.Character.HumanoidRootPart.Position

_G.autodig = true

local function getClosestPile()
    local closestPile = nil
    local closestDist = 10

    for _, pile in pairs(piles:GetChildren()) do
        if pile:IsA("Model") then
            local pilePos = pile:GetPivot().Position
            local distance = (pilePos - playerPos).Magnitude
            if distance < closestDist then
                closestPile = pile
                closestDist = distance
            end
        end
    end

    return closestPile
end

if not getClosestPile() then 
	        game:GetService("ReplicatedStorage").Source.Network.RemoteFunctions.Digging:InvokeServer({
            Command = "CreatePile"
        })
end

while _G.autodig do
    local closestPile = getClosestPile()

    if closestPile then
        local target = closestPile
        local index = target.Name

        repeat
            task.wait()
            if not piles:FindFirstChild(target.Name) then
                target = nil
                break
            end

            dig:InvokeServer({
                Command = "DigPile",
                TargetPileIndex = tonumber(index)
            })

        until not _G.autodig or not piles:FindFirstChild(target.Name)
    else
        game:GetService("ReplicatedStorage").Source.Network.RemoteFunctions.Digging:InvokeServer({
            Command = "CreatePile"
        })
    end
end
