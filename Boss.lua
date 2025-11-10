-- https://scriptblox.com/script/Bee-Swarm-Simulator-bee-swarm-simulator-script-open-source-57248

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character
local HRP = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local toolCollect = ReplicatedStorage.Events.ToolCollect -- RemoteEvent 
local Hives = Workspace:FindFirstChild("Honeycombs")
local claimHive = ReplicatedStorage.Events.ClaimHive
local playerHive = nil
local playerHiveCommand = ReplicatedStorage.Events.PlayerHiveCommand
local hiddenStickers = Workspace.HiddenStickers
local hiddenStickerRemoteCollect = ReplicatedStorage.Events.HiddenStickerEvent
local flowerFields = {}
local coreStats = Player.CoreStats
local exampleRadius = 10
--auto farm stuff
local autofarmField = nil
local autoTool = false
local autofarmVar = false
local autoFarmRadius = 20
-- auto farm checking(so that it doesnt glitch out)
local earned = 0
--rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Bee Swarm Simulator GUI",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "by Sirius",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "BSSScript"
   },

})

local function getRandomPointInRadius(radius, pointCFrame)
    local pointPosition = pointCFrame.Position
    local topRight = pointPosition + Vector3.new(radius, 0, radius)
    local bottomLeft = pointPosition - Vector3.new(radius, 0, radius)

    local randX = math.random() * (topRight.X - bottomLeft.X) + bottomLeft.X
    local randZ = math.random() * (topRight.Z - bottomLeft.Z) + bottomLeft.Z

    local randPos = Vector3.new(randX, pointPosition.Y, randZ)
    return randPos
end


print(#Workspace.FlowerZones:GetChildren())
for _,v in pairs(Workspace.FlowerZones:GetChildren()) do
    table.insert(flowerFields, v.Name)
end


local function claimPlayerHive()
    for _,Hive in pairs(Hives:GetChildren()) do
        if Hive.Owner.Value == nil then
            print("Found Empty Hive")
            HRP.CFrame = Hive.SpawnPos.Value + Vector3.new(0,3,0)
            print("Teleport To Empty Hive")
            task.wait(1)
            local args ={
                [1] = Hive.HiveID.Value
            }
            print("Claimed Hive!")
            claimHive:FireServer(unpack(args))
            break
        end
    end
end

local function teleportPlayerHive()
HRP.CFrame = playerHive.SpawnPos.Value + Vector3.new(0,3,0)
end

local autoFarm

local function convertBackpack(fromAutoFarm)
    if coreStats.Pollen.Value == 0 then
        Rayfield:Notify({
           Title = "Warning",
           Content = "Pollen is 0, not converting",
           Duration = 6.5,
           Image = "alert-triangle",
        })
        return
    end
teleportPlayerHive()
task.wait(1)
playerHiveCommand:FireServer("ToggleHoneyMaking")
if fromAutoFarm then
    local timeWaited = 0
    print("Waiting..")
    repeat 
        task.wait(1) 
        timeWaited +=1
        if timeWaited > 60 then
            autoFarm(autofarmField, autoFarmRadius)
            return
        end
    until coreStats.Pollen.Value == 0
   print("returning to auto farm!")
    
    task.wait(6)
    autoFarm(autofarmField, autoFarmRadius)
end
end

autoFarm = function(field,radius)
    if not autofarmVar then
        autoTool = false
        return
    end
    autoTool = true
    local fieldString = field[1]
    local field = Workspace.FlowerZones:FindFirstChild(fieldString) 
    HRP.CFrame = field.CFrame + Vector3.new(0,5,0)
    task.wait(0.2)
    local fieldCapacity = coreStats.Capacity.Value
    repeat
        local randomPosition = getRandomPointInRadius(radius, field.CFrame)
        Humanoid.WalkToPoint = randomPosition
        repeat task.wait() until (HRP.CFrame.Position - randomPosition).Magnitude < 5
        print(coreStats.Pollen.Value , fieldCapacity)

    until coreStats.Pollen.Value >= fieldCapacity
    print(tostring(autofarmVar))
    if autofarmVar then
        print("Converting Backpack")
        convertBackpack(true)
    end
end

local function getPlayerHive()
    for _,Hive in pairs(Hives:GetChildren()) do
        print(Hive.Owner.Value, Player.Name)
        if tostring(Hive.Owner.Value) == tostring(Player.Name) then
            print("Found Hive!")
            return Hive
        end
    end
    claimPlayerHive()
    task.wait(2)
    return getPlayerHive()
end
playerHive = getPlayerHive()




local function collectHiddenStickers()
    if #(hiddenStickers:GetChildren()) > 0 then
        for i = 1,100 do
            hiddenStickerRemoteCollect:FireServer(i)
        end
    end
end

spawn(function()
    while true do
        if autoTool then
            toolCollect:FireServer()
        end
        task.wait()
    end
end)

    --gui

    local autoFarmTab = Window:CreateTab("Auto Farm")
    local autofarmFieldsDropdown = autoFarmTab:CreateDropdown({
        Name = "Choose A Field To Farm In",
        Options = flowerFields,
        CurrentOption = {"None Selected"},
        MultipleOptions = false,
        Flag = "PlantToRemove", 
        Callback = function(Options)
            autofarmField = Options
        end,
})

    autoFarmToggle = autoFarmTab:CreateToggle({
        Name = "Toggle Auto Farm",
        CurrentValue = false,
        Callback = function(Value)
            autofarmVar = Value
            if autofarmField ~= {"None Selected"} then
                if Value then
                    autoFarm(autofarmField, autoFarmRadius)
                end
            end
        end,
    })

        autoFarmTab:CreateSlider({
           Name = "Auto Farm Radius(square, around 30 recommended)",
           Range = {0, 500},
           Increment = 5,
           Suffix = "studs",
           CurrentValue = 20,
           Flag = "AutoFarmRadius",
           Callback = function(Value)
           autoFarmRadius = Value
           end,
    })


    local specificTasksTab = Window:CreateTab("Specific Tasks")
    specificTasksTab:CreateButton({
        Name = "Convert Backpack",
        Callback = function()
            convertBackpack(false)
        end,

    })

    specificTasksTab:CreateButton({
        Name = "Teleport to location in radius",
        Callback = function()
            print("Teleport player with radius:", exampleRadius)
            HRP.CFrame = CFrame.new(getRandomPointInRadius(exampleRadius, HRP.CFrame))
        end,
    })

    specificTasksTab:CreateSlider({
           Name = "Example Radius",
           Range = {1, 500},
           Increment = 5,
           Suffix = "studs",
           CurrentValue = 10,
           Flag = "ExampleRadius",
           Callback = function(Value)
           exampleRadius = Value
           end,
    })

local stickersTab = Window:CreateTab("Stickers")
stickersTab:CreateButton({

    Name = "Collect all hidden stickers",
    Callback = function()
        collectHiddenStickers()
    end,

})

