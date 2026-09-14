-- Jujutsu Shenanigans - Advanced Utilities
-- Extra features and helper functions

-- ============ TELEPORT MENU ============
local TeleportLocations = {
    ["School"] = Vector3.new(0, 50, 0),
    ["Arena"] = Vector3.new(100, 50, 100),
    ["Training Ground"] = Vector3.new(-100, 50, -100),
    ["Boss Arena"] = Vector3.new(200, 50, 200),
}

local function createTeleportMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TeleportGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 200, 0, 250)
    mainFrame.Position = UDim2.new(0, 10, 0, 350)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderColor3 = Color3.fromRGB(0, 150, 255)
    mainFrame.BorderSizePixel = 2
    mainFrame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Text = "TELEPORT MENU"
    title.TextSize = 12
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame

    local yOffset = 35
    for locationName, position in pairs(TeleportLocations) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 25)
        btn.Position = UDim2.new(0, 5, 0, yOffset)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.TextColor3 = Color3.fromRGB(0, 200, 255)
        btn.Text = locationName
        btn.TextSize = 10
        btn.Font = Enum.Font.Gotham
        btn.BorderSizePixel = 0
        btn.Parent = mainFrame

        btn.MouseButton1Click:Connect(function()
            local player = game.Players.LocalPlayer
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(position + Vector3.new(0, 3, 0))
                print("Teleported to " .. locationName)
            end
        end)

        yOffset = yOffset + 30
    end
end

-- ============ STAT BOOSTER ============
local function boostStats()
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        local humanoid = player.Character.Humanoid
        humanoid.MaxHealth = humanoid.MaxHealth * 1.5
        humanoid.Health = humanoid.MaxHealth
        print("Stats Boosted!")
    end
end

-- ============ MONEY FARM HELPER ============
local moneyFarmActive = false

local function startMoneyFarm()
    moneyFarmActive = true
    print("Money Farm Started")
    
    while moneyFarmActive do
        local player = game.Players.LocalPlayer
        if player.Character then
            -- Look for money items in workspace
            for _, item in pairs(workspace:FindPartByCFrame(player.Character.HumanoidRootPart.CFrame)) or {} do
                if item.Name:lower():match("money") or item.Name:lower():match("cash") then
                    player.Character.HumanoidRootPart.CFrame = item.CFrame
                    wait(0.5)
                    item:Destroy()
                end
            end
        end
        wait(1)
    end
end

local function stopMoneyFarm()
    moneyFarmActive = false
    print("Money Farm Stopped")
end

-- ============ ANTI-AFK ============
local function enableAntiAFK()
    local player = game.Players.LocalPlayer
    local userInputService = game:GetService("UserInputService")
    
    local antiAFKActive = true
    
    spawn(function()
        while antiAFKActive do
            -- Simulate small movements to avoid AFK detection
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:MoveTo(humanoid.Parent.HumanoidRootPart.Position + Vector3.new(0.1, 0, 0))
                end
            end
            wait(60) -- Move every 60 seconds
        end
    end)
    
    print("Anti-AFK Enabled - You won't get kicked for inactivity")
end

-- ============ ESP/PLAYER TRACKER ============
local function createESP()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            local character = player.Character
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            
            if humanoidRootPart then
                -- Create billboard GUI for player names
                local billboardGui = Instance.new("BillboardGui")
                billboardGui.Adornee = humanoidRootPart
                billboardGui.Size = UDim2.new(4, 0, 2, 0)
                billboardGui.MaxDistance = 500
                billboardGui.Parent = humanoidRootPart

                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.BackgroundTransparency = 0
                textLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                textLabel.Text = player.Name
                textLabel.TextSize = 14
                textLabel.Font = Enum.Font.GothamBold
                textLabel.Parent = billboardGui
            end
        end
    end
    print("ESP Enabled - Player positions shown")
end

-- ============ SPEED HACK ============
local speedMultiplier = 1.5

local function enableSpeedHack()
    local player = game.Players.LocalPlayer
    local humanoid = player.Character:FindFirstChild("Humanoid")
    
    if humanoid then
        humanoid.WalkSpeed = 16 * speedMultiplier
        print("Speed Hack Enabled: " .. (16 * speedMultiplier) .. " studs/sec")
    end
end

-- ============ INFINITE STAMINA ============
local function enableInfiniteStamina()
    local player = game.Players.LocalPlayer
    
    spawn(function()
        while true do
            if player.Character then
                -- Look for stamina value and max it out
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    -- Many games store stamina as a custom attribute
                    humanoid:SetAttribute("Stamina", 9999)
                end
            end
            wait(0.5)
        end
    end)
    print("Infinite Stamina Enabled")
end

-- ============ MAIN UTILITIES GUI ============
local function createUtilitiesGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UtilitiesGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 220, 0, 450)
    mainFrame.Position = UDim2.new(0, 250, 0, 10)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mainFrame.BorderColor3 = Color3.fromRGB(255, 150, 0)
    mainFrame.BorderSizePixel = 2
    mainFrame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    title.TextColor3 = Color3.fromRGB(0, 0, 0)
    title.Text = "UTILITIES"
    title.TextSize = 14
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame

    local function createButton(name, text, position, callback)
        local button = Instance.new("TextButton")
        button.Name = name
        button.Size = UDim2.new(1, -10, 0, 35)
        button.Position = position
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        button.TextColor3 = Color3.fromRGB(255, 200, 0)
        button.Text = text
        button.TextSize = 11
        button.Font = Enum.Font.Gotham
        button.BorderSizePixel = 0
        button.Parent = mainFrame
        button.MouseButton1Click:Connect(callback)
        return button
    end

    createButton("Teleport", "📍 Teleport Menu", UDim2.new(0, 5, 0, 40), createTeleportMenu)
    createButton("Boost", "⚡ Boost Stats", UDim2.new(0, 5, 0, 80), boostStats)
    createButton("Speed", "🏃 Speed Hack x1.5", UDim2.new(0, 5, 0, 120), enableSpeedHack)
    createButton("Stamina", "♾️ Infinite Stamina", UDim2.new(0, 5, 0, 160), enableInfiniteStamina)
    createButton("AntiAFK", "🔄 Anti-AFK", UDim2.new(0, 5, 0, 200), enableAntiAFK)
    createButton("ESP", "👁️ ESP/Tracker", UDim2.new(0, 5, 0, 240), createESP)
    
    -- Money Farm Toggle
    local moneyFarmBtn = createButton("MoneyFarm", "💰 Money Farm: OFF", UDim2.new(0, 5, 0, 280), function()
        if moneyFarmActive then
            stopMoneyFarm()
            moneyFarmBtn.Text = "💰 Money Farm: OFF"
        else
            startMoneyFarm()
            moneyFarmBtn.Text = "💰 Money Farm: ON"
        end
    end)

    -- Close Button
    createButton("Close", "❌ Close Utilities", UDim2.new(0, 5, 0, 400), function()
        screenGui:Destroy()
    end)
end

-- ============ AUTO START ============
createUtilitiesGUI()
print("Jujutsu Shenanigans Utilities Loaded!")
print("Available Commands:")
print("- createTeleportMenu()")
print("- boostStats()")
print("- enableSpeedHack()")
print("- enableInfiniteStamina()")
print("- enableAntiAFK()")
print("- createESP()")
print("- startMoneyFarm() / stopMoneyFarm()")
