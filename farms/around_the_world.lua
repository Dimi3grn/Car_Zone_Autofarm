-- [[ FIXED AROUND THE WORLD MODULE V2 ]] --
local Player = game.Players.LocalPlayer
local Character = Player.Character
local platformPos = Vector3.new(-1127.35, 1.5, -4202.63)

local function findMyCar()
    local carFolder = workspace:FindFirstChild("SpawnedCars")
    if not carFolder then return nil end
    for _, car in pairs(carFolder:GetChildren()) do
        local seat = car:FindFirstChild("DriveSeat")
        if seat and seat.Occupant and seat.Occupant.Parent == Character then 
            return car 
        end
    end
    return nil
end

print("🚀 Autofarm Module Started!")

while _G.AutoFarmRunning do
    local myCar = findMyCar()
    
    if not myCar then 
        print("⏳ Waiting for car...")
        task.wait(2)
    else
        local driveSeat = myCar:FindFirstChild("DriveSeat")
        if not driveSeat then task.wait(1) continue end
        
        -- 1. JOIN LOBBY
        print("📍 Teleporting to lobby platform...")
        driveSeat.Anchored = true
        myCar:PivotTo(CFrame.new(platformPos))
        task.wait(0.5)
        driveSeat.Anchored = false
        driveSeat.AssemblyLinearVelocity = Vector3.new(0, -20, 0)
        task.wait(1)
        
        -- 2. WAIT FOR RACE START (Interruptible Wait)
        print("⏳ Waiting 20 seconds for race to start...")
        for i = 1, 40 do
            if not _G.AutoFarmRunning then return end -- KILLS SCRIPT INSTANTLY IF TOGGLED OFF
            task.wait(0.5)
        end

        -- 3. HUNT FOR CHECKPOINTS
        local world = workspace:FindFirstChild("Around The World")
        local checkpoints = world and world:FindFirstChild("Checkpoints")
        
        -- Wait up to 5 extra seconds for checkpoints to load if server is laggy
        if not checkpoints or #checkpoints:GetChildren() == 0 then
            print("🔍 Hunting for checkpoints...")
            for i = 1, 10 do
                if not _G.AutoFarmRunning then return end
                world = workspace:FindFirstChild("Around The World")
                checkpoints = world and world:FindFirstChild("Checkpoints")
                if checkpoints and #checkpoints:GetChildren() > 0 then break end
                task.wait(0.5)
            end
        end

        if checkpoints and #checkpoints:GetChildren() > 0 then
            print("🏁 Race found! Running laps...")
            for lap = 1, 2 do
                for i = 1, 29 do
                    -- KILLS SCRIPT INSTANTLY IF TOGGLED OFF MID-RACE
                    if not _G.AutoFarmRunning then 
                        if driveSeat then driveSeat.Anchored = false end
                        print("🛑 Autofarm Stopped by User.")
                        return 
                    end
                    
                    local target = checkpoints:FindFirstChild("Checkpoint" .. i)
                    if target then
                        driveSeat.Anchored = true
                        myCar:PivotTo(target.CFrame)
                        task.wait(2.1)
                    else
                        warn("❌ Checkpoint " .. i .. " missing!")
                    end
                end
            end
            print("💰 Race complete. Cooling down for 25s...")
            
            -- INTERRUPTIBLE COOLDOWN
            for i = 1, 50 do
                if not _G.AutoFarmRunning then return end
                task.wait(0.5)
            end
        else
            warn("❌ Failed to find active checkpoints. Resetting loop.")
            task.wait(5)
        end
    end
end
print("🛑 Module Execution Ended.")