local function createESP(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Name = "ESP"
        billboardGui.Adornee = player.Character:FindFirstChild("HumanoidRootPart")
        billboardGui.Size = UDim2.new(4, 0, 1, 0)
        billboardGui.StudsOffset = Vector3.new(0, 2, 0)
        billboardGui.AlwaysOnTop = true

        local textLabel = Instance.new("TextLabel")
        textLabel.Text = player.Name
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextStrokeTransparency = 0.5
        textLabel.Font = Enum.Font.SourceSans
        textLabel.TextScaled = true
        textLabel.Parent = billboardGui

        billboardGui.Parent = player.Character:FindFirstChild("HumanoidRootPart")
    end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function()
        wait(1) -- Tunggu karakter selesai dimuat
        createESP(player)
    end)
end

for _, player in pairs(game.Players:GetPlayers()) do
    onPlayerAdded(player)
end

game.Players.PlayerAdded:Connect(onPlayerAdded)
