-- [[ AROUND THE WORLD MODULE ]] --
local Player = game.Players.LocalPlayer
local Character = Player.Character
local platformPos = Vector3.new(-1127.35, 1.5, -4202.63)

local function findMyCar()
    for _, car in pairs(workspace.SpawnedCars:GetChildren()) do
        local seat = car:FindFirstChild("DriveSeat")
        if seat and seat.Occupant and seat.Occupant.Parent == Character then return car end
    end
end

-- The Loop
while _G.AutoFarmRunning do
    local myCar = findMyCar()
    if myCar then
        local driveSeat = myCar:FindFirstChild("DriveSeat")
        
        -- 1. JOIN LOBBY
        driveSeat.Anchored = true
        myCar:PivotTo(CFrame.new(platformPos))
        task.wait(0.5)
        driveSeat.Anchored = false
        driveSeat.AssemblyLinearVelocity = Vector3.new(0, -20, 0)
        driveSeat.Throttle = 1
        task.wait(0.5)
        driveSeat.Throttle = 0
        
        -- 2. WAIT FOR RACE START
        task.wait(20) 

        local checkpoints = workspace:FindFirstChild("Around The World") and workspace["Around The World"]:FindFirstChild("Checkpoints")
        if checkpoints and _G.AutoFarmRunning then
            for lap = 1, 2 do
                if not _G.AutoFarmRunning then break end
                for i = 1, 29 do
                    if not _G.AutoFarmRunning then break end
                    local target = checkpoints:FindFirstChild("Checkpoint" .. i)
                    if target then
                        driveSeat.Anchored = true
                        local startP = myCar:GetPivot()
                        for s = 1, 15 do
                            myCar:PivotTo(startP:Lerp(target.CFrame, s/15))
                            task.wait(0.02)
                        end
                        driveSeat.Anchored = false
                        driveSeat.AssemblyLinearVelocity = Vector3.new(0, -12, 0)
                        task.wait(2.1)
                    end
                end
            end
        end
        task.wait(25) 
    end
    task.wait(1)
end