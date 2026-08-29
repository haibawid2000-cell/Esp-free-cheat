-- ESP для Xeno / Salary (загрузка с GitHub)
-- Автор:haibawid2000 (author) 

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Настройки
local ESP_COLOR = Color3.fromRGB(0, 255, 0)   -- Зелёный (можешь менять)
local ESP_THICKNESS = 2.5
local ESP_FILL_TRANSPARENCY = 0.5

-- Создание ESP
local function createESP(player)
    if player == LocalPlayer then return end
    local character = player.Character
    if not character then return end
    
    local highlight = character:FindFirstChild("ESP_Highlight")
    if highlight then highlight:Destroy() end
    
    highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.Parent = character
    highlight.FillColor = ESP_COLOR
    highlight.OutlineColor = ESP_COLOR
    highlight.FillTransparency = ESP_FILL_TRANSPARENCY
    highlight.OutlineTransparency = 0.2
    highlight.Thickness = ESP_THICKNESS
    highlight.Enabled = true
end

-- Подсветка всех игроков
for _, player in ipairs(Players:GetPlayers()) do
    createESP(player)
end

-- Новые игроки
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(0.1)
        createESP(player)
    end)
end)

-- Обновление
RunService.Heartbeat:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            if not player.Character:FindFirstChild("ESP_Highlight") then
                createESP(player)
            end
        end
    end
end)

-- Очистка
Players.PlayerRemoving:Connect(function(player)
    local character = player.Character
    if character then
        local highlight = character:FindFirstChild("ESP_Highlight")
        if highlight then highlight:Destroy() end
    end
end)

print("ESP загружен с GitHub!")
