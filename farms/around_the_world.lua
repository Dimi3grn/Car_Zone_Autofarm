-- [[ AROUND THE WORLD MODULE - V7 ADAPTED ]] --
local Player = game.Players.LocalPlayer
local Character = Player.Character
local platformPos = Vector3.new(-1127.35, 1.5, -4202.63)

print("🔄 AUTO-FARMER: V7 GUI Edition...")

local function findMyCar()
    for _, car in pairs(workspace.SpawnedCars:GetChildren()) do
        local seat = car:FindFirstChild("DriveSeat")
        if seat and seat.Occupant and seat.Occupant.Parent == Character then
            return car
        end
    end
    return nil
end

while _G.AutoFarmRunning do
    local myCar = findMyCar()

    if myCar then
        local driveSeat = myCar:FindFirstChild("DriveSeat")
        
        -- 1. JOIN LOBBY
        print("📍 Joining platform...")
        driveSeat.Anchored = true
        myCar:PivotTo(CFrame.new(platformPos))
        task.wait(0.5)
        
        -- 2. TRIGGER COUNTDOWN
        driveSeat.Anchored = false
        driveSeat.AssemblyLinearVelocity = Vector3.new(0, -20, 0)
        driveSeat.Throttle = 1
        task.wait(0.5)
        driveSeat.Throttle = 0
        
        -- 3. THE UPDATED WAIT (20 SECONDS)
        print("⏳ Waiting for race start (20s)...")
        for i = 1, 40 do
            if not _G.AutoFarmRunning then return end -- Kills loop if button turned OFF
            task.wait(0.5)
        end

        -- 4. SEARCH FOR DATA (The V7 Method)
        local checkpoints = nil
        print("🔍 Searching for race data...")
        
        for i = 1, 20 do 
            if not _G.AutoFarmRunning then return end
            
            -- Keep searching for BOTH the new car and the checkpoints
            myCar = findMyCar()
            checkpoints = workspace:FindFirstChild("Around The World") and workspace["Around The World"]:FindFirstChild("Checkpoints")
            
            if myCar and checkpoints and #checkpoints:GetChildren() > 0 then
                print("✅ Race Data Found! Starting Laps...")
                break
            end
            task.wait(0.5)
        end
        
        if myCar and checkpoints then
            -- CRITICAL: Re-assign the drive seat to the NEW car that spawned on the track
            driveSeat = myCar:FindFirstChild("DriveSeat")
            
            for lap = 1, 2 do
                for i = 1, 29 do
                    -- Stop instantly if user clicks "OFF" mid-race
                    if not _G.AutoFarmRunning then 
                        if driveSeat then driveSeat.Anchored = false end
                        print("🛑 Autofarm Stopped.")
                        return 
                    end
                    
                    local target = checkpoints:FindFirstChild("Checkpoint" .. i)
                    if target then
                        driveSeat.Anchored = true
                        local startP = myCar:GetPivot()
                        
                        -- Stealth Slide
                        for s = 1, 15 do
                            myCar:PivotTo(startP:Lerp(target.CFrame, s/15))
                            task.wait(0.02)
                        end
                        
                        -- Drop
                        driveSeat.Anchored = false
                        driveSeat.AssemblyLinearVelocity = Vector3.new(0, -12, 0)
                        task.wait(2.1)
                    end
                end
            end
            print("💰 Race Finished.")
        else
            warn("❌ ERROR: Could not find race track. Check F9 for details.")
        end
        
        -- 5. RESET DELAY
        print("♻️ Resetting for next run...")
        for i = 1, 40 do
            if not _G.AutoFarmRunning then return end
            task.wait(0.5)
        end
    else
        warn("⚠️ Not in a car!")
        task.wait(5)
    end
end
print("🛑 Module Execution Ended.")