--// CONFIG
_G.AutoFarmLevel = true

--// SERVICES
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

--------------------------------------------------
-- CHARACTER
--------------------------------------------------
local function GetChar()
    return player.Character or player.CharacterAdded:Wait()
end

local function HRP()
    return GetChar():WaitForChild("HumanoidRootPart")
end

--------------------------------------------------
-- QUEST DATA (1-2800)
--------------------------------------------------
local QuestData = {
    {1,10,"Bandit","BanditQuest1",1,Vector3.new(1150,17,1630)},
    {11,30,"Monkey","JungleQuest",1,Vector3.new(-1440,67,11)},
    {31,60,"Gorilla","JungleQuest",2,Vector3.new(-1100,40,-500)},
    {61,100,"Pirate","BuggyQuest1",1,Vector3.new(-1200,5,4000)},
    {101,150,"Brute","BuggyQuest1",2,Vector3.new(-1000,5,4300)},
    {151,225,"Desert Bandit","DesertQuest",1,Vector3.new(1000,10,4500)},
    {226,300,"Desert Officer","DesertQuest",2,Vector3.new(1600,10,4300)},
    {301,375,"Snow Bandit","SnowQuest",1,Vector3.new(1200,120,-1400)},
    {376,450,"Snowman","SnowQuest",2,Vector3.new(1200,150,-1600)},
    {451,525,"Chief Petty Officer","MarineQuest2",1,Vector3.new(-4900,60,4100)},
    {526,625,"Sky Bandit","SkyQuest",1,Vector3.new(-4700,750,-2600)},
    {626,700,"Dark Master","SkyQuest",2,Vector3.new(-5200,800,-2300)},

    {700,775,"Raider","Area1Quest",1,Vector3.new(-300,80,1700)},
    {776,875,"Mercenary","Area1Quest",2,Vector3.new(-100,80,1500)},
    {876,950,"Swan Pirate","Area2Quest",1,Vector3.new(700,80,1000)},
    {951,1050,"Factory Staff","Area2Quest",2,Vector3.new(500,80,700)},
    {1051,1200,"Marine Lieutenant","MarineQuest3",1,Vector3.new(-2300,80,-3000)},
    {1201,1350,"Marine Captain","MarineQuest3",2,Vector3.new(-2000,80,-3000)},
    {1351,1450,"Zombie","ZombieQuest",1,Vector3.new(-5600,60,-900)},
    {1451,1500,"Vampire","ZombieQuest",2,Vector3.new(-5800,60,-1200)},

    {1500,1575,"Pirate Millionaire","PiratePortQuest",1,Vector3.new(-200,50,5700)},
    {1576,1675,"Pistol Billionaire","PiratePortQuest",2,Vector3.new(-400,50,5900)},
    {1676,1775,"Dragon Crew Warrior","AmazonQuest",1,Vector3.new(5900,60,-900)},
    {1776,1875,"Dragon Crew Archer","AmazonQuest",2,Vector3.new(6100,60,-800)},
    {1876,1975,"Female Islander","AmazonQuest2",1,Vector3.new(5500,650,800)},
    {1976,2075,"Giant Islander","AmazonQuest2",2,Vector3.new(5700,650,900)},
    {2076,2175,"Marine Commodore","MarineTreeIsland",1,Vector3.new(2300,50,-7000)},
    {2176,2275,"Marine Rear Admiral","MarineTreeIsland",2,Vector3.new(2600,50,-7200)},
    {2276,2375,"Fishman Raider","DeepForestIsland3",1,Vector3.new(-10500,350,-8800)},
    {2376,2475,"Fishman Captain","DeepForestIsland3",2,Vector3.new(-10700,350,-9000)},
    {2476,2550,"Forest Pirate","DeepForestIsland",1,Vector3.new(-13300,350,-7700)},
    {2551,2625,"Mythological Pirate","DeepForestIsland",2,Vector3.new(-13500,350,-7800)},
    {2626,2700,"Jungle Pirate","DeepForestIsland2",1,Vector3.new(-12700,400,-10000)},
    {2701,2800,"Musketeer Pirate","DeepForestIsland2",2,Vector3.new(-12900,400,-10200)},
}

--------------------------------------------------
-- GET QUEST
--------------------------------------------------
local function GetQuest()
    local level = player.Data.Level.Value
    for _,q in pairs(QuestData) do
        if level >= q[1] and level <= q[2] then
            return q
        end
    end
end

--------------------------------------------------
-- FAST ATTACK (เรียบๆ เสถียร)
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

--------------------------------------------------
-- BRING MOB
--------------------------------------------------
local function BringMob(pos)
    for _,v in pairs(Workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
            if (v.HumanoidRootPart.Position - HRP().Position).Magnitude < 300 then
                v.HumanoidRootPart.CFrame = pos
                v.Humanoid.WalkSpeed = 0
                v.Humanoid.JumpPower = 0
                v.HumanoidRootPart.CanCollide = false
                v.HumanoidRootPart.Transparency = 1
            end
        end
    end
end

--------------------------------------------------
-- AUTO FARM (หลัก)
--------------------------------------------------
task.spawn(function()
    while task.wait(0.2) do
        if not _G.AutoFarmLevel then continue end

        local q = GetQuest()
        if not q then continue end

        local mobName = q[3]
        local questName = q[4]
        local questLv = q[5]
        local mobPos = q[6]

        -- รับเควส
        pcall(function()
            RS.Remotes.CommF_:InvokeServer("StartQuest", questName, questLv)
        end)

        local mob = Workspace.Enemies:FindFirstChild(mobName)

        if mob and mob:FindFirstChild("HumanoidRootPart") then
            repeat
                task.wait()

                local pos = mob.HumanoidRootPart.CFrame
                HRP().CFrame = pos * CFrame.new(0,25,0)

                BringMob(pos)

            until not _G.AutoFarmLevel or mob.Humanoid.Health <= 0
        else
            HRP().CFrame = CFrame.new(mobPos)
        end
    end
end)
