-- [[ STEALTH HUB MAIN ]] --
local _G = _G or {}
_G.AutoFarmRunning = false

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Toggle = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 300, 0, 150)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Active = true
MainFrame.Draggable = true
UICorner.Parent = MainFrame

Toggle.Parent = MainFrame
Toggle.Size = UDim2.new(0, 280, 0, 50)
Toggle.Position = UDim2.new(0, 10, 0, 50)
Toggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Toggle.Text = "Around The World: OFF"
Toggle.TextColor3 = Color3.new(1, 1, 1)
Toggle.Font = Enum.Font.GothamBold

-- Toggle Logic
Toggle.MouseButton1Click:Connect(function()
    _G.AutoFarmRunning = not _G.AutoFarmRunning
    if _G.AutoFarmRunning then
        Toggle.Text = "Around The World: ON"
        Toggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        
        -- FETCH THE FARM SCRIPT FROM GITHUB
        task.spawn(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimi3grn/Car_Zone_Autofarm/main/farms/around_the_world.lua"))()
        end)
    else
        Toggle.Text = "Around The World: OFF"
        Toggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)