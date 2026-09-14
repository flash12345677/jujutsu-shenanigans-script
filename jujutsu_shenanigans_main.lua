-- Jujutsu Shenanigans - Auto Farm & Combat Script
-- No Key Required - Auto Run
-- Features: Auto-Farm, Auto-Combat, Teleport, Auto-Spam, GUI

local game = game
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- ============ CONFIG ============
local Config = {
    AutoFarm = true,
    AutoCombat = true,
    AutoSpam = true,
    AutoHeal = true,
    Teleport = true,
    ShowGUI = true,
    FarmRange = 100,
    CombatRange = 50,
    SpamDelay = 0.1,
}

-- ============ VARIABLES ============
local scriptActive = true
local autoFarmActive = Config.AutoFarm
local autoCombatActive = Config.AutoCombat
local autoSpamActive = Config.AutoSpam
local autoHealActive = Config.AutoHeal
local selectedEnemy = nil

-- ============ UTILITY FUNCTIONS ============
local function getEnemies()
    local enemies = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local distance = (humanoidRootPart.Position - character:FindFirstChild("HumanoidRootPart").Position).Magnitude
                if distance <= Config.FarmRange then
                    table.insert(enemies, {player = player, character = character, distance = distance})
                end
            end
        end
    end
    table.sort(enemies, function(a, b) return a.distance < b.distance end)
    return enemies
end

local function teleportTo(targetPosition)
    if humanoidRootPart then
        humanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0))
    end
end

local function attack()
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid:MoveTo(humanoid.Parent:FindFirstChild("HumanoidRootPart").Position)
        -- Trigger attack animation/input
        local uis = game:GetService("UserInputService")
        uis:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        wait(0.05)
        uis:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    end
end

local function spamAttacks()
    for i = 1, 5 do
        attack()
        wait(Config.SpamDelay)
    end
end

-- ============ AUTO FARM ============
local function autoFarm()
    while autoFarmActive and scriptActive do
        local enemies = getEnemies()
        
        if #enemies > 0 then
            selectedEnemy = enemies[1]
            local targetPosition = selectedEnemy.character:FindFirstChild("HumanoidRootPart").Position
            
            -- Move towards enemy
            teleportTo(targetPosition)
            
            -- Attack when close
            if (humanoidRootPart.Position - targetPosition).Magnitude <= Config.CombatRange then
                if autoCombatActive then
                    spamAttacks()
                end
            end
        end
        
        wait(0.1)
    end
end

-- ============ AUTO HEAL ============
local function autoHeal()
    while autoHealActive and scriptActive do
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid and humanoid.Health < humanoid.MaxHealth * 0.5 then
            -- Use healing item/ability (adjust based on game mechanics)
            local uis = game:GetService("UserInputService")
            uis:SendKeyEvent(true, Enum.KeyCode.H, false, game)
            wait(0.05)
            uis:SendKeyEvent(false, Enum.KeyCode.H, false, game)
        end
        wait(1)
    end
end

-- ============ GUI SETUP ============
local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "JujutsuGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 250, 0, 300)
    mainFrame.Position = UDim2.new(0, 10, 0, 10)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    mainFrame.BorderSizePixel = 2
    mainFrame.Parent = screenGui

    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Text = "JUJUTSU SHENANIGANS"
    title.TextSize = 14
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame

    -- Helper function to create buttons
    local function createButton(name, text, position, callback)
        local button = Instance.new("TextButton")
        button.Name = name
        button.Size = UDim2.new(1, -10, 0, 30)
        button.Position = position
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        button.TextColor3 = Color3.fromRGB(0, 255, 0)
        button.Text = text
        button.TextSize = 12
        button.Font = Enum.Font.Gotham
        button.BorderSizePixel = 0
        button.Parent = mainFrame
        button.MouseButton1Click:Connect(callback)
        return button
    end

    -- Auto Farm Button
    createButton("AutoFarmBtn", "Auto Farm: " .. (autoFarmActive and "ON" or "OFF"), UDim2.new(0, 5, 0, 40), function()
        autoFarmActive = not autoFarmActive
        local text = autoFarmActive and "Auto Farm: ON" or "Auto Farm: OFF"
        mainFrame:FindFirstChild("AutoFarmBtn").Text = text
    end)

    -- Auto Combat Button
    createButton("AutoCombatBtn", "Auto Combat: " .. (autoCombatActive and "ON" or "OFF"), UDim2.new(0, 5, 0, 75), function()
        autoCombatActive = not autoCombatActive
        local text = autoCombatActive and "Auto Combat: ON" or "Auto Combat: OFF"
        mainFrame:FindFirstChild("AutoCombatBtn").Text = text
    end)

    -- Auto Spam Button
    createButton("AutoSpamBtn", "Auto Spam: " .. (autoSpamActive and "ON" or "OFF"), UDim2.new(0, 5, 0, 110), function()
        autoSpamActive = not autoSpamActive
        local text = autoSpamActive and "Auto Spam: ON" or "Auto Spam: OFF"
        mainFrame:FindFirstChild("AutoSpamBtn").Text = text
    end)

    -- Auto Heal Button
    createButton("AutoHealBtn", "Auto Heal: " .. (autoHealActive and "ON" or "OFF"), UDim2.new(0, 5, 0, 145), function()
        autoHealActive = not autoHealActive
        local text = autoHealActive and "Auto Heal: ON" or "Auto Heal: OFF"
        mainFrame:FindFirstChild("AutoHealBtn").Text = text
    end)

    -- Stop Script Button
    createButton("StopBtn", "STOP SCRIPT", UDim2.new(0, 5, 0, 180), function()
        scriptActive = false
        screenGui:Destroy()
    end)

    -- Info Label
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, 0, 0, 80)
    infoLabel.Position = UDim2.new(0, 0, 0, 220)
    infoLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    infoLabel.Text = "Script Running\n\nStatus: ACTIVE\nEnemies Found: 0"
    infoLabel.TextSize = 11
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextWrapped = true
    infoLabel.Parent = mainFrame

    return screenGui, infoLabel
end

-- ============ MAIN LOOP ============
local gui, infoLabel = createGUI()

-- Auto update enemy count
spawn(function()
    while scriptActive do
        local enemies = getEnemies()
        if infoLabel then
            infoLabel.Text = "Script Running\n\nStatus: ACTIVE\nEnemies Found: " .. #enemies
        end
        wait(1)
    end
end)

-- Start auto farm
spawn(function()
    autoFarm()
end)

-- Start auto heal
spawn(function()
    autoHeal()
end)

-- Keyboard shortcuts
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F then
        autoFarmActive = not autoFarmActive
        print("Auto Farm: " .. (autoFarmActive and "ON" or "OFF"))
    elseif input.KeyCode == Enum.KeyCode.C then
        autoCombatActive = not autoCombatActive
        print("Auto Combat: " .. (autoCombatActive and "ON" or "OFF"))
    elseif input.KeyCode == Enum.KeyCode.S then
        autoSpamActive = not autoSpamActive
        print("Auto Spam: " .. (autoSpamActive and "ON" or "OFF"))
    elseif input.KeyCode == Enum.KeyCode.H then
        autoHealActive = not autoHealActive
        print("Auto Heal: " .. (autoHealActive and "ON" or "OFF"))
    elseif input.KeyCode == Enum.KeyCode.End then
        scriptActive = false
        print("Script Stopped")
        gui:Destroy()
    end
end)

print("Jujutsu Shenanigans Script Loaded!")
print("Press F - Toggle Auto Farm")
print("Press C - Toggle Auto Combat")
print("Press S - Toggle Auto Spam")
print("Press H - Toggle Auto Heal")
print("Press End - Stop Script")
