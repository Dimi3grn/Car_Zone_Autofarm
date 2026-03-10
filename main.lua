-- [[ STEALTH HUB MAIN V1.0 ]] --
_G.AutoFarmRunning = false

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Prevent duplicate GUIs if you re-execute
if CoreGui:FindFirstChild("StealthHubGUI") then
    CoreGui.StealthHubGUI:Destroy()
end

-- 1. SCREEN GUI SETUP
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StealthHubGUI"
ScreenGui.Parent = CoreGui

-- 2. MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- 3. TOP BAR
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BorderSizePixel = 0

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

-- Fix bottom corners of TopBar so it connects smoothly
local TopCover = Instance.new("Frame")
TopCover.Parent = TopBar
TopCover.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopCover.Position = UDim2.new(0, 0, 1, -5)
TopCover.Size = UDim2.new(1, 0, 0, 5)
TopCover.BorderSizePixel = 0

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "STEALTH HUB V1.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize Button (-)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = TopBar
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Position = UDim2.new(1, -35, 0, 0)
MinimizeBtn.Size = UDim2.new(0, 35, 1, 0)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 20

-- 4. TAB CONTAINER
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TabContainer.Position = UDim2.new(0, 0, 0, 35)
TabContainer.Size = UDim2.new(1, 0, 0, 40)
TabContainer.BorderSizePixel = 0

local AutofarmTabBtn = Instance.new("TextButton")
AutofarmTabBtn.Parent = TabContainer
AutofarmTabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
AutofarmTabBtn.Position = UDim2.new(0, 15, 0, 8)
AutofarmTabBtn.Size = UDim2.new(0, 100, 0, 25)
AutofarmTabBtn.Font = Enum.Font.GothamSemibold
AutofarmTabBtn.Text = "Autofarm"
AutofarmTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutofarmTabBtn.TextSize = 12
Instance.new("UICorner", AutofarmTabBtn).CornerRadius = UDim.new(0, 4)

local SettingsTabBtn = Instance.new("TextButton")
SettingsTabBtn.Parent = TabContainer
SettingsTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SettingsTabBtn.Position = UDim2.new(0, 125, 0, 8)
SettingsTabBtn.Size = UDim2.new(0, 100, 0, 25)
SettingsTabBtn.Font = Enum.Font.GothamSemibold
SettingsTabBtn.Text = "Settings"
SettingsTabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
SettingsTabBtn.TextSize = 12
Instance.new("UICorner", SettingsTabBtn).CornerRadius = UDim.new(0, 4)

-- 5. PAGES CONTAINER
local PagesContainer = Instance.new("Frame")
PagesContainer.Name = "PagesContainer"
PagesContainer.Parent = MainFrame
PagesContainer.BackgroundTransparency = 1
PagesContainer.Position = UDim2.new(0, 0, 0, 75)
PagesContainer.Size = UDim2.new(1, 0, 1, -75)

-- Autofarm Page
local AutoFarmPage = Instance.new("Frame")
AutoFarmPage.Parent = PagesContainer
AutoFarmPage.BackgroundTransparency = 1
AutoFarmPage.Size = UDim2.new(1, 0, 1, 0)
AutoFarmPage.Visible = true

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = AutoFarmPage
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleBtn.Position = UDim2.new(0.5, -145, 0, 25)
ToggleBtn.Size = UDim2.new(0, 290, 0, 45)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "Around The World: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 14
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)

-- Settings Page
local SettingsPage = Instance.new("Frame")
SettingsPage.Parent = PagesContainer
SettingsPage.BackgroundTransparency = 1
SettingsPage.Size = UDim2.new(1, 0, 1, 0)
SettingsPage.Visible = false

local SettingsLabel = Instance.new("TextLabel")
SettingsLabel.Parent = SettingsPage
SettingsLabel.BackgroundTransparency = 1
SettingsLabel.Position = UDim2.new(0, 0, 0, 25)
SettingsLabel.Size = UDim2.new(1, 0, 0, 30)
SettingsLabel.Font = Enum.Font.Gotham
SettingsLabel.Text = "More settings coming soon..."
SettingsLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
SettingsLabel.TextSize = 13

local CreditsLabel = Instance.new("TextLabel")
CreditsLabel.Parent = SettingsPage
CreditsLabel.BackgroundTransparency = 1
CreditsLabel.Position = UDim2.new(0, 0, 1, -35)
CreditsLabel.Size = UDim2.new(1, 0, 0, 20)
CreditsLabel.Font = Enum.Font.GothamBold
CreditsLabel.Text = "Made by Dimi3zoo"
CreditsLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
CreditsLabel.TextSize = 12

-- 6. LOGIC: TABS
AutofarmTabBtn.MouseButton1Click:Connect(function()
    AutoFarmPage.Visible = true
    SettingsPage.Visible = false
    AutofarmTabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    AutofarmTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SettingsTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SettingsTabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
end)

SettingsTabBtn.MouseButton1Click:Connect(function()
    AutoFarmPage.Visible = false
    SettingsPage.Visible = true
    SettingsTabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    SettingsTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    AutofarmTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    AutofarmTabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
end)

-- 7. LOGIC: MINIMIZE
local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame.Size = UDim2.new(0, 350, 0, 35)
        TabContainer.Visible = false
        PagesContainer.Visible = false
        MinimizeBtn.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 350, 0, 250)
        TabContainer.Visible = true
        PagesContainer.Visible = true
        MinimizeBtn.Text = "-"
    end
end)

-- 8. LOGIC: KEYBIND (RightControl)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

-- 9. LOGIC: FARM TOGGLE
ToggleBtn.MouseButton1Click:Connect(function()
    _G.AutoFarmRunning = not _G.AutoFarmRunning
    if _G.AutoFarmRunning then
        ToggleBtn.Text = "Around The World: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        
        task.spawn(function()
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimi3grn/Car_Zone_Autofarm/main/farms/around_the_world.lua"))()
            end)
            if not success then 
                warn("🚩 GITHUB LOADER ERROR: " .. tostring(err)) 
            end
        end)
    else
        ToggleBtn.Text = "Around The World: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

-- Error Logger
game:GetService("LogService").MessageOut:Connect(function(Message, Type)
    if Type == Enum.MessageType.MessageError then print("🚩 ERROR: " .. Message) end
end)

print("✅ Stealth Hub Loaded. Press RightControl to show/hide GUI.")