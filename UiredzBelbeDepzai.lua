local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui"))()

local Window = redzlib:MakeWindow({
  Title = "Namer Hub",
  SubTitle = "by NamerDepZai",
  SaveFolder = "Redz | redz lib v5.lua"
})

Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://93777653674500", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(0, 5) },
})
local PosMsList = {["Pirate Millionaire"] = CFrame.new(-712.8272705078125, 98.5770492553711, 5711.9541015625),["Pistol Billionaire"] = CFrame.new(-723.4331665039062, 147.42906188964844, 5931.9931640625),["Dragon Crew Warrior"] = CFrame.new(7021.50439453125, 55.76270294189453, -730.1290893554688),["Dragon Crew Archer"] = CFrame.new(6625, 378, 244),["Female Islander"] = CFrame.new(4692.7939453125, 797.9766845703125, 858.8480224609375),["Venomous Assailant"] = CFrame.new(4902, 670, 39), ["Marine Commodore"] = CFrame.new(2401, 123, -7589),["Marine Rear Admiral"] = CFrame.new(3588, 229, -7085),["Fishman Raider"] = CFrame.new(-10941, 332, -8760),["Fishman Captain"] = CFrame.new(-11035, 332, -9087),["Forest Pirate"] = CFrame.new(-13446, 413, -7760),["Mythological Pirate"] = CFrame.new(-13510, 584, -6987),["Jungle Pirate"] = CFrame.new(-11778, 426, -10592),["Musketeer Pirate"] = CFrame.new(-13282, 496, -9565),["Reborn Skeleton"] = CFrame.new(-8764, 142, 5963),["Living Zombie"] = CFrame.new(-10227, 421, 6161),["Demonic Soul"] = CFrame.new(-9579, 6, 6194),["Posessed Mummy"] = CFrame.new(-9579, 6, 6194),["Peanut Scout"] = CFrame.new(-1993, 187, -10103),["Peanut President"] = CFrame.new(-2215, 159, -10474),["Ice Cream Chef"] = CFrame.new(-877, 118, -11032),["Ice Cream Commander"] = CFrame.new(-877, 118, -11032),["Cookie Crafter"] = CFrame.new(-2021, 38, -12028),["Cake Guard"] = CFrame.new(-2024, 38, -12026),["Baking Staff"] = CFrame.new(-1932, 38, -12848),["Head Baker"] = CFrame.new(-1932, 38, -12848),["Cocoa Warrior"] = CFrame.new(95, 73, -12309),["Chocolate Bar Battler"] = CFrame.new(647, 42, -12401),["Sweet Thief"] = CFrame.new(116, 36, -12478),["Candy Rebel"] = CFrame.new(47, 61, -12889),["Ghost"] = CFrame.new(5251, 5, 1111)}

local Tab = Window:MakeTab({"Discord", "info"})

local Tab4 = Window:MakeTab({"Trái/Đột Kích", "cherry"})

local Tab5 = Window:MakeTab({"Stats", "signal"})

local Tab6 = Window:MakeTab({"Dịch Chuyển", "locate"})

local Tab7 = Window:MakeTab({"Giao Diện", "user"})

local Tab8 = Window:MakeTab({"Cửa Hàng", "shoppingCart"})

local Tab9 = Window:MakeTab({"Khác", "settings"})

Tab:AddDiscordInvite({
    Name = "Gay Hub | Community",
    Description = "Join our discord community to receive information about the next update",
    Logo = "rbxassetid://93777653674500",
    Invite = "http://discord.gg/7aR7kNVt4g",
})

local Tab2 = Window:MakeTab({"Farm", "home"})

local Dropdown = Tab2:AddDropdown({
  Name = "Chọn Công Cụ",
  Description = "Chọn công cụ bạn muốn sử dụng",
  Options = {"Melee", "Blox Fruit", "Sword"},
  Default = "Melee",
  Flag = "Melee",
  Callback = function()
    
  end
})

local Dropdown = Tab2:AddDropdown({
  Name = "Kích Thước Ui",
  Description = "Điều chỉnh kích thước giao diện",
  Options = {"Small", "Medium", "Large", "Bigger"},
  Default = "Large",
  Flag = "Large",
  Callback = function()
    
  end
})

local Section = Tab2:AddSection({"Farm"})

Tab2:AddToggle({
    Name = "Tự Động lên cấp",
    Description = "Tự động farm cấp",
    Default = false,
    Callback = function()

    end
})

Tab2:AddToggle({
    Name = "Farm Kẻ Địch Gần",
    Description = "Tự động tiêu diệt kẻ địch gần nhất",
    Default = false,
    Callback = function()

    end
})

Tab2:AddToggle({
    Name = "Farm Hải Tặc Biển",
    Description = "Tự động hoàn thành sự kiện hải tặc ở Castelo do Mar",
    Default = false,
    Callback = function()

    end
})

local Section = Tab2:AddSection({"Xương"})
    
Tab2:AddToggle({
    Name = "Farm Xương",
    Description = "Tự động farm xương",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm_Bone = Value
    end
})

Tab2:AddToggle({
    Name = "Nhận Nhiệm Vụ Xương",
    Description = "Tự động nhận nhiệm vụ xương",
    Default = true,
    Callback = function(Value)
        _G.AcceptQuestC = Value
    end
})

spawn(function()
    while task.wait(Sec or 0.1) do
        if _G.AutoFarm_Bone and World3 then
            pcall(function()
                if not game:IsLoaded() then return end
                local player = game.Players.LocalPlayer
                local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
                local questUI = player.PlayerGui.Main.Quest
                if not root or not humanoid or humanoid.Health <= 0 then return end

                local boneEnemies = {"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"}
                local farmPos = PosMsList["Reborn Skeleton"] or CFrame.new(-8764, 142, 5963)

                if _G.AcceptQuestC and questUI and questUI.Container and questUI.Container.QuestTitle and questUI.Container.QuestTitle.Title and not (questUI.Visible and questUI.Container.QuestTitle.Title.Text:find("Haunted")) then
                    local questPos = CFrame.new(-9516.99316, 172.017181, 6078.46533)
                    TW:Create(root, TweenInfo.new((questPos.Position - root.Position).Magnitude / 200), {CFrame = questPos}):Play()
                    wait(0.5)
                    local questData = {
                        [1] = {"StartQuest", "HauntedQuest2", 2},
                        [2] = {"StartQuest", "HauntedQuest2", 1},
                        [3] = {"StartQuest", "HauntedQuest1", 1},
                        [4] = {"StartQuest", "HauntedQuest1", 2}
                    }
                    for i = 1, 3 do
                        local success = pcall(function()
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(questData[math.random(1, 4)]))
                        end)
                        if success and questUI.Visible and questUI.Container.QuestTitle.Title.Text:find("Haunted") then break end
                        task.wait(0.2)
                    end
                end

                TW:Create(root, TweenInfo.new((farmPos.Position - root.Position).Magnitude / 200), {CFrame = farmPos}):Play()
                wait(0.5)
                local enemy = GetConnectionEnemies(boneEnemies)
                if enemy and _G.Attack_Mob then
                    if _B then BringEnemy() end
                    EquipWeapon(_G.SelectWeapon or "Melee")
                    repeat task.wait() Attack.Kill(enemy, _G.AutoFarm_Bone)
                    until not _G.AutoFarm_Bone or not enemy.Parent or enemy.Humanoid.Health <= 0 or (_G.AcceptQuestC and not questUI.Visible)
                elseif not enemy then
                    TW:Create(root, TweenInfo.new((farmPos.Position - root.Position).Magnitude / 200), {CFrame = farmPos}):Play()
                end
            end)
        elseif _G.AutoFarm_Bone then
            Tab2:AddParagraph({
                Name = "Cảnh Báo Farm Xương",
                Description = "Chỉ hoạt động ở Third Sea"
            })
            _G.AutoFarm_Bone = false
            Tab2:AddToggle({ Name = "Farm Xương" }):SetValue(false)
        end
    end
end)


Tab2:AddToggle({
    Name = "Đổi Xương",
    Description = "Tự động đổi xương lấy phần thưởng",
    Default = false,
    Callback = function()

    end
})

local Section = Tab2:AddSection({"Rương"})

Tab2:AddToggle({
    Name = "Tự Động Rương [ Tween ]",
    Description = "Tự động mở rương bằng tween",
    Default = false,
    Callback = function()

    end
})

local Section = Tab2:AddSection({"Boss"})

Tab2:AddButton({
    Name = "Cập Nhật Boss",
    Description = "Làm mới danh sách boss",
    Default = false,
    Callback = function()

    end
})

local Dropdown = Tab2:AddDropdown({
  Name = "Danh Sách Boss",
  Description = "Chọn boss để tấn công",
  Options = {"Boss1", "Boss2", "Boss3"},
  Default = "nil",
  Flag = "nil",
  Callback = function()
    
  end
})

Tab2:AddToggle({
    Name = "Giết Boss Đã Chọn",
    Description = "Tự động tấn công boss đã chọn",
    Default = false,
    Callback = function()

    end
})

Tab2:AddToggle({
    Name = "Farm Tất Cả Boss",
    Description = "Tự động tấn công mọi boss có sẵn",
    Default = false,
    Callback = function()

    end
})

Tab2:AddToggle({
    Name = "Nhận Nhiệm Vụ Boss",
    Description = "Tự động nhận nhiệm vụ boss",
    Default = true,
    Callback = function()

    end
})

local Section = Tab2:AddSection({"Material"})

local Dropdown = Tab2:AddDropdown({
  Name = "Danh Sách Nguyên Liệu",
  Description = "Chọn boss để tấn công",
  Options = {"Nguyên Liệu1", "Nguyên Liệu2", "Nguyên Liệu3"},
  Default = "nil",
  Flag = "nil",
  Callback = function()
    
  end
})

Tab2:AddToggle({
    Name = "Farm Nguyên Liệu",
    Description = "Tự động farm nguyên liệu",
    Default = false,
    Callback = function()

    end
})

local Section = Tab2:AddSection({"Mastery"})

Tab2:AddSlider({
  Name = "Chọn Máu Kẻ Địch [ % ]",
  Description = "Thiết lập phần trăm máu kẻ địch để tấn công",
  Min = 10,
  Max = 100,
  Increase = 1,
  Default = 16,
  Callback = function()
  
  end
})

local Dropdown = Tab2:AddDropdown({
  Name = "Chọn Công Cụ",
  Description = "Chọn công cụ bạn muốn sử dụng",
  Options = {"Blox Fruit", "Gun"},
  Default = "Blox Fruit",
  Flag = "Blox Fruit",
  Callback = function()
    
  end
})

local Dropdown = Tab2:AddDropdown({
  Name = "Chọn Kỹ Năng",
  Description = "Chọn kỹ năng để sử dụng",
  Options = {"Z", "X", "C", "V", "F"},
  Default = "Z",
  Flag = "Z",
  Callback = function()
    
  end
})

Tab2:AddToggle({
    Name = "Farm Thông Thạo",
    Description = "Tăng thành thạo kỹ năng tự động",
    Default = false,
    Callback = function()

    end
})




local Tab3 = Window:MakeTab({"Nhiệm Vụ/Vật Phẩm", "swords"})

local Section = Tab3:AddSection({"Dragon Dojo"})

Tab3:AddToggle({
    Name = "Nhiệm Vụ Dojo",
    Description = "Tự động hoàn thành nhiệm vụ đai",
    Default = false,
    Callback = function()

    end
})

Tab3:AddToggle({
    Name = "Nhiệm Vụ Dragon Hunter",
    Description = "Mỗi nhiệm vụ hoàn thành nhận 'Blaze Ember'",
    Default = false,
    Callback = function()

    end
})

Tab3:AddToggle({
    Name = "Auto Draco V2 & V3",
    Description = "Tự động lên cấp Draco V2 và V3",
    Default = false,
    Callback = function()

    end
})
