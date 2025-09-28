local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui"))()

local Window = redzlib:MakeWindow({
  Title = "Namer Hub",
  SubTitle = "by NamerDepZai",
  SaveFolder = "Redz | redz lib v5.lua"
})

-- Services for Blox Fruits
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- Config file path
local CONFIG_PATH = "GayHubConfig.json"

-- Load config function
local function LoadConfig()
    if isfile(CONFIG_PATH) then
        local success, configData = pcall(function()
            return HttpService:JSONDecode(readfile(CONFIG_PATH))
        end)
        if success then
            return configData
        end
    end
    return nil
end

-- Save config function
local function SaveConfig(config)
    local success, err = pcall(function()
        writefile(CONFIG_PATH, HttpService:JSONEncode(config, Enum.HttpContentEncoding.QuotedPrintable))
    end)
    if not success then
        warn("Failed to save config: " .. tostring(err))
    end
end

-- Config with defaults
local Config = LoadConfig() or {
    WebhookURL = "https://discord.com/api/webhooks/1224660732117778532/OdROQ1Hf2SKDgGVhKt41dtYEmIMrdXB-DeGvFxe9rQWPmuthNQD_AgnvKpr9H6H4f6n8",
    RefreshInterval = 30,
    AutoRefreshEnabled = false
}

-- Auto-refresh variables
local autoRefreshCoroutine = nil

-- Wait for data to load
repeat wait() until LocalPlayer:FindFirstChild("Data") and LocalPlayer:FindFirstChild("leaderstats")

local Data = LocalPlayer.Data
local Leaderstats = LocalPlayer.leaderstats

-- Optimized GetStats with caching
local lastInvTime = 0
local cachedInv = nil
local INV_CACHE_TIME = 5
local function GetStats()
    local now = tick()
    if now - lastInvTime > INV_CACHE_TIME then
        cachedInv = ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")
        lastInvTime = now
    end
    local inv = cachedInv
    
    local Level = Data.Level.Value
    local Beli = Data.Beli.Value
    local Fragments = Data.Fragments.Value
    local Valr = Data.Valr.Value
    local Bounty = Leaderstats["Bounty/Honor"].Value
    local Crew = Data.Crew.Value or "None"
    
    local Melee = Data.Melee.Value
    local Defense = Data.Defense.Value
    local Sword = Data.Sword.Value
    local Gun = Data.Gun.Value
    local Fruit = Data.Fruit.Value
    
    local UnlockedSwords = #(inv.Swords or {})
    local UnlockedGuns = #(inv.Guns or {})
    local OwnedFruits = #(inv.Fruits or {})
    local MasteredFruits = 0
    
    local UnlockedStyles = 11
    local RacesEvolved = 7
    
    local PermanentItems = {}
    if inv.PermanentFruits then
        for _, v in pairs(inv.PermanentFruits) do
            table.insert(PermanentItems, "Permanent " .. v)
        end
    end
    if inv.PermanentStyles then
        for _, v in pairs(inv.PermanentStyles) do
            table.insert(PermanentItems, "Permanent " .. v)
        end
    end
    if inv.PermanentSwords then
        for _, v in pairs(inv.PermanentSwords) do
            table.insert(PermanentItems, "Permanent " .. v)
        end
    end
    if #PermanentItems == 0 then
        for _, item in pairs(inv) do
            if type(item) == "string" and item:find("Permanent") then
                table.insert(PermanentItems, item)
            elseif type(item) == "table" and item.Name and item.Name:find("Permanent") then
                table.insert(PermanentItems, item.Name)
            end
        end
    end
    
    return {
        Level = Level, Beli = Beli, Fragments = Fragments, Valr = Valr, Bounty = Bounty, Crew = Crew,
        Melee = Melee, Defense = Defense, Sword = Sword, Gun = Gun, Fruit = Fruit,
        UnlockedSwords = UnlockedSwords, UnlockedGuns = UnlockedGuns, UnlockedStyles = UnlockedStyles, RacesEvolved = RacesEvolved,
        OwnedFruits = OwnedFruits, MasteredFruits = MasteredFruits, PermanentItems = PermanentItems
    }
end

-- Function to send stats to Discord
local function SendToDiscord(stats)
    if Config.WebhookURL == "" then
        redzlib:Notify("❌ Webhook URL trống! Vui lòng nhập webhook.", "Gay Hub")
        return
    end
    
    local embed = {
        title = "🕷️ Blox Fruits Stats (Gay Hub)",
        color = 0x00FF00,
        fields = {
            {name = "📊 Basic Stats", value = "Level: " .. stats.Level .. "\nBeli: $ " .. stats.Beli .. "\nFragments: " .. stats.Fragments .. "\nValor: " .. stats.Valr .. "\nCrew: " .. stats.Crew .. "\nBounty: " .. stats.Bounty, inline = true},
            {name = "⚔️ Unlocks", value = "Swords: " .. stats.UnlockedSwords .. "/40\nGuns: " .. stats.UnlockedGuns .. "/14\nStyles: " .. stats.UnlockedStyles .. "/11\nRaces: " .. stats.RacesEvolved .. "/7", inline = true},
            {name = "📈 Stats", value = "Melee: " .. stats.Melee .. "\nDefense: " .. stats.Defense .. "\nSword: " .. stats.Sword .. "\nGun: " .. stats.Gun .. "\nFruit: " .. stats.Fruit, inline = true},
            {name = "🍎 Fruits", value = "Owned: " .. stats.OwnedFruits .. "/41\nMastered: " .. stats.MasteredFruits .. "/41", inline = true},
            {name = "⭐ Premium Items", value = table.concat(stats.PermanentItems, "\n") or "None", inline = false}
        },
        footer = {text = "Updated: " .. os.date("%Y-%m-%d %H:%M:%S") .. " | Gay Hub by BelBelDepZai"}
    }
    
    local payload = HttpService:JSONEncode({embeds = {embed}})
    local success, err = pcall(function()
        HttpService:PostAsync(Config.WebhookURL, payload, Enum.HttpContentType.ApplicationJson)
    end)
    
    if success then
        redzlib:Notify("✅ Đã gửi stats về Discord thành công!", "Gay Hub")
    else
        redzlib:Notify("❌ Lỗi gửi: " .. tostring(err), "Gay Hub")
    end
end

-- Discord Tab (only for sending info)
local DiscordTab = Window:NewTab("📤 Discord")
local DiscordSection = DiscordTab:NewSection("Send Stats")
DiscordSection:NewButton("Gửi Stats về Discord", "Gửi embed stats hiện tại", function()
    local currentStats = GetStats()
    SendToDiscord(currentStats)
end)

-- Settings Tab (for config)
local SettingsTab = Window:NewTab("⚙️ Settings")
local SettingsSection = SettingsTab:NewSection("Config")

-- TextBox for Webhook URL (auto-save on change)
SettingsSection:NewTextbox("Webhook URL", "Nhập link Discord webhook", function(value)
    Config.WebhookURL = value
    SaveConfig(Config)
    redzlib:Notify("📝 Webhook URL đã cập nhật và lưu: " .. value, "Gay Hub")
end)
SettingsSection:NewLabel("Current Webhook: " .. Config.WebhookURL)

-- Toggle for Test Send
local TestToggle
TestToggle = SettingsSection:NewToggle("Test Send", "Test gửi stats ngay lập tức", function(state)
    if state then
        local testStats = GetStats()
        SendToDiscord(testStats)
        redzlib:Notify("🧪 Test gửi hoàn tất!", "Gay Hub")
        TestToggle:Set(false)
    end
end)

-- Slider for Update Interval (auto-save)
local IntervalSlider = SettingsSection:NewSlider("Update Interval", "Thời gian cập nhật tự động (giây)", 500, 10, function(value)
    Config.RefreshInterval = value
    SaveConfig(Config)
    redzlib:Notify("⏱️ Interval cập nhật: " .. value .. "s (đã lưu)", "Gay Hub")
end)

-- Toggle for Auto Update & Send (auto-save)
local AutoToggle
AutoToggle = SettingsSection:NewToggle("Auto Update & Send", "Tự động cập nhật và gửi Discord mỗi interval", function(state)
    Config.AutoRefreshEnabled = state
    SaveConfig(Config)
    if state then
        autoRefreshCoroutine = coroutine.create(function()
            while Config.AutoRefreshEnabled do
                wait(Config.RefreshInterval)
                if not Config.AutoRefreshEnabled then break end
                local currentStats = GetStats()
                SendToDiscord(currentStats)
                redzlib:Notify("🔄 Auto-update & gửi hoàn tất!", "Gay Hub")
            end
        end)
        coroutine.resume(autoRefreshCoroutine)
        redzlib:Notify("▶️ Auto-update đã bật (mỗi " .. Config.RefreshInterval .. "s)", "Gay Hub")
    else
        Config.AutoRefreshEnabled = false
        if autoRefreshCoroutine then
            coroutine.close(autoRefreshCoroutine)
        end
        redzlib:Notify("⏹️ Auto-update đã tắt", "Gay Hub")
    end
end)

-- Manual Refresh (just for testing GetStats)
local RefreshSection = SettingsTab:NewSection("Manual Actions")
RefreshSection:NewButton("Test Refresh Stats", "Test lấy stats mới", function()
    local currentStats = GetStats()
    redzlib:Notify("🔄 Stats test: Level " .. currentStats.Level .. " | Items: " .. #currentStats.PermanentItems, "Gay Hub")
end)

-- Save config button (full save)
RefreshSection:NewButton("Save All Config", "Lưu toàn bộ config vào file", function()
    SaveConfig(Config)
    redzlib:Notify("💾 Toàn bộ config đã lưu vào " .. CONFIG_PATH .. "!", "Gay Hub")
end)

-- Load config button (reload from file)
RefreshSection:NewButton("Load Config", "Tải config từ file", function()
    local loaded = LoadConfig()
    if loaded then
        Config = loaded
        redzlib:Notify("📂 Config đã tải: Webhook=" .. (Config.WebhookURL or "default") .. " | Interval=" .. (Config.RefreshInterval or 30), "Gay Hub")
    else
        redzlib:Notify("❌ Không tìm thấy file config!", "Gay Hub")
    end
end)

print("🕷️ Namer Hub với Config JSON! File lưu tại workspace: " .. CONFIG_PATH .. ". Auto-save khi thay đổi.")
