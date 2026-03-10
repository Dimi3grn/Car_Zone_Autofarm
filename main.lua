local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TabFrame = Instance.new("Frame")
local ContentFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")

-- GUI Setup
ScreenGui.Parent = game.CoreGui
MainFrame.Name = "StealthHub"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true -- So you can move it

UICorner.Parent = MainFrame

Title.Parent = MainFrame
Title.Text = "STEALTH HUB V1"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

-- Tabs Configuration
local AutofarmTab = Instance.new("TextButton")
AutofarmTab.Parent = MainFrame
AutofarmTab.Position = UDim2.new(0, 10, 0, 40)
AutofarmTab.Size = UDim2.new(0, 135, 0, 30)
AutofarmTab.Text = "Autofarm"
AutofarmTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AutofarmTab.TextColor3 = Color3.new(1,1,1)

local SettingsTab = Instance.new("TextButton")
SettingsTab.Parent = MainFrame
SettingsTab.Position = UDim2.new(0, 155, 0, 40)
SettingsTab.Size = UDim2.new(0, 135, 0, 30)
SettingsTab.Text = "Settings"
SettingsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SettingsTab.TextColor3 = Color3.new(0.7,0.7,0.7)

-- Toggle for Around The World
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = MainFrame
ToggleBtn.Position = UDim2.new(0, 20, 0, 90)
ToggleBtn.Size = UDim2.new(0, 260, 0, 40)
ToggleBtn.Text = "Around The World: OFF"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)

local _G = _G or {}
_G.AutoFarmRunning = false

ToggleBtn.MouseButton1Click:Connect(function()
    _G.AutoFarmRunning = not _G.AutoFarmRunning
    if _G.AutoFarmRunning then
        ToggleBtn.Text = "Around The World: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        -- Trigger the V7 Farm Logic
        task.spawn(function()
            while _G.AutoFarmRunning do
                -- (Insert V7 Logic Here - Compressed for GUI)
                local Player = game.Players.LocalPlayer
                local Character = Player.Character
                local platformPos = Vector3.new(-1127.35, 1.5, -4202.63)

                local function findCar()
                    for _, car in pairs(workspace.SpawnedCars:GetChildren()) do
                        local seat = car:FindFirstChild("DriveSeat")
                        if seat and seat.Occupant and seat.Occupant.Parent == Character then return car end
                    end
                end

                local myCar = findCar()
                if myCar and _G.AutoFarmRunning then
                    local driveSeat = myCar:FindFirstChild("DriveSeat")
                    driveSeat.Anchored = true
                    myCar:PivotTo(CFrame.new(platformPos))
                    task.wait(0.5)
                    driveSeat.Anchored = false
                    driveSeat.AssemblyLinearVelocity = Vector3.new(0, -20, 0)
                    driveSeat.Throttle = 1
                    task.wait(0.5)
                    driveSeat.Throttle = 0
                    
                    task.wait(20) -- The wait you requested
                    
                    local checkpoints = workspace:FindFirstChild("Around The World") and workspace["Around The World"]:FindFirstChild("Checkpoints")
                    if checkpoints and _G.AutoFarmRunning then
                        for lap = 1, 2 do
                            for i = 1, 29 do
                                if not _G.AutoFarmRunning then break end
                                local target = checkpoints:FindFirstChild("Checkpoint" .. i)
                                if target then
                                    driveSeat.Anchored = true
                                    myCar:PivotTo(target.CFrame) -- Faster TP for UI test
                                    task.wait(2.1)
                                end
                            end
                        end
                    end
                    task.wait(25)
                end
                task.wait(1)
            end
        end)
    else
        ToggleBtn.Text = "Around The World: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)