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
spawn(function()
  while wait(Sec) do 
    if _G.AutoFarm_Bone then
      pcall(function()        
        local player = game.Players.LocalPlayer
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        local questUI = player.PlayerGui.Main.Quest
        local BonesTable = {"Reborn Skeleton","Living Zombie","Demonic Soul","Posessed Mummy"}
        if not root then return end
        local bone = GetConnectionEnemies(BonesTable)
          if bone then
	        if _G.AcceptQuestC and not questUI.Visible then
              local questPos = CFrame.new(-9516.99316,172.017181,6078.46533,0,0,-1,0,1,0,1,0,0)
              _tp(questPos)
              while (questPos.Position - root.Position).Magnitude > 50 do
                wait(0.2)
              end
              local randomQuest = math.random(1, 4)
              local questData = {
                [1] = {"StartQuest", "HauntedQuest2", 2},
                [2] = {"StartQuest", "HauntedQuest2", 1},
                [3] = {"StartQuest", "HauntedQuest1", 1},
                [4] = {"StartQuest", "HauntedQuest1", 2}
              }                    
              local success, response = pcall(function()
                return game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(questData[randomQuest]))
              end)
            end
		    repeat task.wait() Attack.Kill(bone, _G.AutoFarm_Bone) until not _G.AutoFarm_Bone or bone.Humanoid.Health <= 0 or not bone.Parent or (_G.AcceptQuestC and not questUI.Visible)
          else
            _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)) 	      
        end
      end)
    end
  end
end)
    

Tab2:AddToggle({
    Name = "Tự Động Soul Reaper",
    Description = "Triệu hồi và tiêu diệt Soul Reaper",
    Default = false,
    Callback = function()

    end
})

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
