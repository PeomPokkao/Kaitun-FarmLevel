_G.AutoFarmLevel = true

local player = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")

--------------------------------------------------
-- HRP
--------------------------------------------------
local function HRP()
    return (player.Character or player.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
end

--------------------------------------------------
-- QUEST TABLE (ครบ)
--------------------------------------------------
local QuestTable = {

-- FIRST SEA
{1,10,"Bandit","BanditQuest1",1,CFrame.new(1060,16,1547),CFrame.new(1150,17,1630)},
{11,30,"Monkey","JungleQuest",1,CFrame.new(-1600,36,153),CFrame.new(-1440,67,11)},
{31,60,"Gorilla","JungleQuest",2,CFrame.new(-1600,36,153),CFrame.new(-1100,40,-500)},
{61,100,"Pirate","BuggyQuest1",1,CFrame.new(-1140,4,3830),CFrame.new(-1200,5,4000)},
{101,150,"Brute","BuggyQuest1",2,CFrame.new(-1140,4,3830),CFrame.new(-1000,5,4300)},
{151,225,"Desert Bandit","DesertQuest",1,CFrame.new(894,5,4392),CFrame.new(1000,10,4500)},
{226,300,"Desert Officer","DesertQuest",2,CFrame.new(894,5,4392),CFrame.new(1600,10,4300)},
{301,375,"Snow Bandit","SnowQuest",1,CFrame.new(1389,87,-1298),CFrame.new(1200,120,-1400)},
{376,450,"Snowman","SnowQuest",2,CFrame.new(1389,87,-1298),CFrame.new(1200,150,-1600)},
{451,525,"Chief Petty Officer","MarineQuest2",1,CFrame.new(-5035,29,4324),CFrame.new(-4900,60,4100)},
{526,625,"Sky Bandit","SkyQuest",1,CFrame.new(-4842,717,-2623),CFrame.new(-4700,750,-2600)},
{626,700,"Dark Master","SkyQuest",2,CFrame.new(-4842,717,-2623),CFrame.new(-5200,800,-2300)},

-- SECOND SEA
{700,775,"Raider","Area1Quest",1,CFrame.new(-429,72,1836),CFrame.new(-300,80,1700)},
{776,875,"Mercenary","Area1Quest",2,CFrame.new(-429,72,1836),CFrame.new(-100,80,1500)},
{876,950,"Swan Pirate","Area2Quest",1,CFrame.new(638,71,918),CFrame.new(700,80,1000)},
{951,1050,"Factory Staff","Area2Quest",2,CFrame.new(638,71,918),CFrame.new(500,80,700)},
{1051,1200,"Marine Lieutenant","MarineQuest3",1,CFrame.new(-2440,73,-3210),CFrame.new(-2300,80,-3000)},
{1201,1350,"Marine Captain","MarineQuest3",2,CFrame.new(-2440,73,-3210),CFrame.new(-2000,80,-3000)},
{1351,1450,"Zombie","ZombieQuest",1,CFrame.new(-5497,48,-794),CFrame.new(-5600,60,-900)},
{1451,1500,"Vampire","ZombieQuest",2,CFrame.new(-5497,48,-794),CFrame.new(-5800,60,-1200)},

-- THIRD SEA
{1500,1575,"Pirate Millionaire","PiratePortQuest",1,CFrame.new(-290,42,5580),CFrame.new(-200,50,5700)},
{1576,1675,"Pistol Billionaire","PiratePortQuest",2,CFrame.new(-290,42,5580),CFrame.new(-400,50,5900)},
{1676,1775,"Dragon Crew Warrior","AmazonQuest",1,CFrame.new(5830,52,-1100),CFrame.new(5900,60,-900)},
{1776,1875,"Dragon Crew Archer","AmazonQuest",2,CFrame.new(5830,52,-1100),CFrame.new(6100,60,-800)},
{1876,1975,"Female Islander","AmazonQuest2",1,CFrame.new(5440,602,749),CFrame.new(5500,650,800)},
{1976,2075,"Giant Islander","AmazonQuest2",2,CFrame.new(5440,602,749),CFrame.new(5700,650,900)},
{2076,2175,"Marine Commodore","MarineTreeIsland",1,CFrame.new(2179,29,-6737),CFrame.new(2300,50,-7000)},
{2176,2275,"Marine Rear Admiral","MarineTreeIsland",2,CFrame.new(2179,29,-6737),CFrame.new(2600,50,-7200)},
{2276,2375,"Fishman Raider","DeepForestIsland3",1,CFrame.new(-10581,332,-8758),CFrame.new(-10500,350,-8800)},
{2376,2475,"Fishman Captain","DeepForestIsland3",2,CFrame.new(-10581,332,-8758),CFrame.new(-10700,350,-9000)},
{2476,2550,"Forest Pirate","DeepForestIsland",1,CFrame.new(-13232,332,-7627),CFrame.new(-13300,350,-7700)},
{2551,2625,"Mythological Pirate","DeepForestIsland",2,CFrame.new(-13232,332,-7627),CFrame.new(-13500,350,-7800)},
{2626,2700,"Jungle Pirate","DeepForestIsland2",1,CFrame.new(-12682,390,-9902),CFrame.new(-12700,400,-10000)},
{2701,2800,"Musketeer Pirate","DeepForestIsland2",2,CFrame.new(-12682,390,-9902),CFrame.new(-12900,400,-10200)},
}

--------------------------------------------------
-- GET QUEST
--------------------------------------------------
function getQuest()
    local Lv = player.Data.Level.Value
    for _,v in pairs(QuestTable) do
        if Lv >= v[1] and Lv <= v[2] then
            return {
                Mob = v[3],
                QuestName = v[4],
                QuestLv = v[5],
                QuestPos = v[6],
                MobPos = v[7]
            }
        end
    end
end

--------------------------------------------------
-- AUTO FARM
--------------------------------------------------
task.spawn(function()
    while task.wait(0.2) do
        if not _G.AutoFarmLevel then continue end

        local q = getQuest()
        if not q then continue end

        pcall(function()
            RS.Remotes.CommF_:InvokeServer("StartQuest", q.QuestName, q.QuestLv)
        end)

        local mob = workspace.Enemies:FindFirstChild(q.Mob)

        if mob and mob:FindFirstChild("HumanoidRootPart") then
            repeat
                task.wait()

                Posmon = mob.HumanoidRootPart.CFrame
                HRP().CFrame = Posmon * CFrame.new(0,25,0)

            until not _G.AutoFarmLevel or mob.Humanoid.Health <= 0
        else
            HRP().CFrame = q.MobPos
        end
    end
end)

--------------------------------------------------
-- BRING MOB
--------------------------------------------------
task.spawn(function()
    while task.wait() do
        if not _G.AutoFarmLevel then continue end

        for _,v in pairs(workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                if (v.HumanoidRootPart.Position - HRP().Position).Magnitude <= 400 then
                    v.HumanoidRootPart.CFrame = Posmon
                    v.Humanoid.WalkSpeed = 0
                    v.Humanoid.JumpPower = 0
                    v.HumanoidRootPart.CanCollide = false
                    v.HumanoidRootPart.Transparency = 1
                    v.Humanoid:ChangeState(11)
                end
            end
        end
    end
end)

--------------------------------------------------
-- FAST ATTACK
--------------------------------------------------
task.spawn(function()
    while task.wait() do
        if _G.AutoFarmLevel then
            pcall(function()
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
            end)
        end
    end
end)
