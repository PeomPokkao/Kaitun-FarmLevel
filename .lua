--========================
-- 🔥 SETTINGS
--========================
_G.atf = false
_G.SelectWeapon = "Melee"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local currentTween

--========================
-- 📊 QUEST DATA (FULL)
--========================
local QuestData = {
-- SEA 1
{1,10,"Bandit [Lv. 5]","BanditQuest1",1,CFrame.new(1060,16,1547),CFrame.new(1150,16,1630)},
{10,30,"Monkey [Lv. 14]","JungleQuest",1,CFrame.new(-1600,36,150),CFrame.new(-1440,67,20)},
{30,60,"Pirate [Lv. 35]","BuggyQuest1",1,CFrame.new(-1140,5,3825),CFrame.new(-1200,5,4000)},
{60,90,"Desert Bandit [Lv. 60]","DesertQuest",1,CFrame.new(896,6,4390),CFrame.new(984,16,4417)},
{90,120,"Snow Bandit [Lv. 90]","SnowQuest",1,CFrame.new(1389,87,-1298),CFrame.new(1350,87,-1400)},
{120,150,"Chief Petty Officer [Lv. 120]","MarineQuest2",1,CFrame.new(-5035,29,4325),CFrame.new(-4880,22,4270)},
{150,190,"Sky Bandit [Lv. 150]","SkyQuest",1,CFrame.new(-4842,718,-2623),CFrame.new(-4950,718,-2800)},
{190,250,"Prisoner [Lv. 190]","PrisonerQuest",1,CFrame.new(5308,1,475),CFrame.new(5200,0,500)},
{250,300,"Toga Warrior [Lv. 250]","ColosseumQuest",1,CFrame.new(-1577,7,-2985),CFrame.new(-1800,7,-2740)},
{300,375,"Military Soldier [Lv. 300]","MagmaQuest",1,CFrame.new(-5316,12,8517),CFrame.new(-5400,12,8600)},
{375,450,"Fishman Warrior [Lv. 375]","FishmanQuest",1,CFrame.new(61123,18,1568),CFrame.new(61000,18,1500)},
{450,625,"God's Guard [Lv. 450]","SkyExp1Quest",1,CFrame.new(-4721,845,-1954),CFrame.new(-4600,845,-2000)},
{625,700,"Galley Pirate [Lv. 625]","FountainQuest",1,CFrame.new(5258,38,4050),CFrame.new(5500,38,3900)},

-- SEA 2
{700,800,"Raider [Lv. 700]","Area1Quest",1,CFrame.new(-429,72,1836),CFrame.new(-500,72,1800)},
{800,900,"Mercenary [Lv. 725]","Area1Quest",2,CFrame.new(-429,72,1836),CFrame.new(-600,72,2000)},
{900,1000,"Marine Captain [Lv. 900]","MarineQuest3",1,CFrame.new(-2440,72,-3215),CFrame.new(-2500,72,-3300)},
{1000,1100,"Snow Trooper [Lv. 1000]","SnowMountainQuest",1,CFrame.new(605,400,-5370),CFrame.new(550,400,-5300)},
{1100,1200,"Lab Subordinate [Lv. 1100]","IceSideQuest",1,CFrame.new(-6060,16,-4900),CFrame.new(-5800,16,-4800)},
{1200,1300,"Ship Deckhand [Lv. 1200]","ShipQuest1",1,CFrame.new(1037,125,32911),CFrame.new(1200,125,33000)},
{1300,1400,"Ship Engineer [Lv. 1300]","ShipQuest1",2,CFrame.new(1037,125,32911),CFrame.new(1400,125,33000)},
{1400,1500,"Arctic Warrior [Lv. 1400]","FrostQuest",1,CFrame.new(5667,28,-6484),CFrame.new(5800,28,-6400)},

-- SEA 3
{1500,1600,"Pirate Millionaire [Lv. 1500]","PiratePortQuest",1,CFrame.new(-290,44,5580),CFrame.new(-200,44,5600)},
{1600,1700,"Dragon Crew Warrior [Lv. 1600]","AmazonQuest",1,CFrame.new(5833,52,-1105),CFrame.new(5700,52,-1200)},
{1700,1800,"Marine Commodore [Lv. 1700]","MarineTreeIsland",1,CFrame.new(2180,28,-6740),CFrame.new(2200,28,-6800)},
{1800,1900,"Fishman Raider [Lv. 1800]","DeepForestIsland3",1,CFrame.new(-10580,332,-8750),CFrame.new(-10600,332,-8800)},
{1900,2000,"Jungle Pirate [Lv. 1900]","DeepForestIsland",1,CFrame.new(-13230,332,-7625),CFrame.new(-13300,332,-7700)},
{2000,2100,"Living Zombie [Lv. 2000]","HauntedQuest1",1,CFrame.new(-9480,142,5566),CFrame.new(-9500,142,5600)},
{2100,2200,"Peanut Scout [Lv. 2100]","NutsIslandQuest",1,CFrame.new(-2100,38,-10100),CFrame.new(-2200,38,-10200)},
{2200,2300,"Ice Cream Chef [Lv. 2200]","IceCreamQuest",1,CFrame.new(-900,38,-11000),CFrame.new(-1000,38,-11100)},
{2300,2400,"Cookie Crafter [Lv. 2300]","CakeQuest1",1,CFrame.new(-2020,38,-12000),CFrame.new(-2100,38,-12100)},
{2400,2500,"Candy Rebel [Lv. 2400]","CandyQuest1",1,CFrame.new(-1140,38,-14000),CFrame.new(-1200,38,-14100)},
{2500,2600,"Tiki Warrior [Lv. 2500]","TikiQuest1",1,CFrame.new(-16500,38,-17300),CFrame.new(-16600,38,-17400)},
{2600,2800,"Tiki Outlaw [Lv. 2600]","TikiQuest2",1,CFrame.new(-16500,38,-17300),CFrame.new(-16800,38,-17500)},
}

--========================
-- 📊 GET QUEST
--========================
function GetQuest()
    local lv = player.Data.Level.Value
    for _,q in pairs(QuestData) do
        if lv >= q[1] and lv <= q[2] then
            return q
        end
    end
end

--========================
-- ⚔️ EQUIP
--========================
function EquipWeapon()
    for _,v in pairs(player.Backpack:GetChildren()) do
        if _G.SelectWeapon == "Melee" and v.ToolTip == "Melee" then
            player.Character.Humanoid:EquipTool(v)
        end
    end
end

--========================
-- 🚀 TWEEN (ของคุณ)
--========================
function TweenTo(cf)
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local hrp = char.HumanoidRootPart
    local distance = (cf.Position - hrp.Position).Magnitude

    local speed =
        (distance < 250 and 600) or
        (distance < 500 and 500) or
        (distance < 1000 and 400) or
        250

    if currentTween then currentTween:Cancel() end

    currentTween = TweenService:Create(
        hrp,
        TweenInfo.new(distance / speed, Enum.EasingStyle.Linear),
        {CFrame = cf}
    )

    currentTween:Play()
end

--========================
-- 🌀 FARM AROUND MOB
--========================
local RandomCFrame = 0

function FarmAroundMob(mob)
    local cf = mob.HumanoidRootPart.CFrame

    if RandomCFrame <= 1 then
        TweenTo(cf * CFrame.new(0,20,50))
        RandomCFrame += 0.3
    elseif RandomCFrame <= 2 then
        TweenTo(cf * CFrame.new(50,20,0))
        RandomCFrame += 0.3
    elseif RandomCFrame <= 3 then
        TweenTo(cf * CFrame.new(0,20,-50))
        RandomCFrame += 0.3
    elseif RandomCFrame <= 4 then
        TweenTo(cf * CFrame.new(-50,20,0))
        RandomCFrame += 0.3
    else
        TweenTo(cf * CFrame.new(0,30,0))
        RandomCFrame = 0
    end
end

--========================
-- 👹 TARGET
--========================
function GetMob()
    local q = GetQuest()
    local enemies = workspace:FindFirstChild("Enemies")
    if not q or not enemies then return end

    for _,v in pairs(enemies:GetChildren()) do
        if v.Name == q[3] and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            return v
        end
    end
end

--========================
-- 🔥 CLICK
--========================
task.spawn(function()
    while task.wait(0.05) do
        if _G.atf then
            VirtualUser:CaptureController()
            VirtualUser:Button1Down(Vector2.new(0,0))
        end
    end
end)

--========================
-- 🧠 QUEST
--========================
function DoQuest()
    local q = GetQuest()
    TweenTo(q[6])
    task.wait(1)
    pcall(function()
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", q[4], q[5])
    end)
end

--========================
-- ⚡ MAIN
--========================
task.spawn(function()
    while task.wait(0.15) do
        if not _G.atf then continue end

        local q = GetQuest()
        if not q then continue end

        EquipWeapon()
        DoQuest()

        local mob = GetMob()

        if mob then
            mob.HumanoidRootPart.CanCollide = false
            mob.Humanoid:ChangeState(11)
            FarmAroundMob(mob)
        else
            TweenTo(q[7])
        end
    end
end)

--========================
-- 🟦 PART ใต้เท้า (ของคุณ)
--========================
task.spawn(function()
    while task.wait(0.1) do
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local part = workspace:FindFirstChild("LOL")

        if _G.atf and hrp then
            if not part then
                part = Instance.new("Part")
                part.Name = "LOL"
                part.Anchored = true
                part.Transparency = 1
                part.Size = Vector3.new(50, 0.5, 50)
                part.Material = Enum.Material.Neon
                part.CanCollide = true
                part.Parent = workspace
            end

            part.CFrame = hrp.CFrame * CFrame.new(0, -3, 0)
            part.AssemblyLinearVelocity = Vector3.zero
            part.AssemblyAngularVelocity = Vector3.zero
        else
            if part then part:Destroy() end
        end
    end
end)
