-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local localPlayer = Players.LocalPlayer

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MaintenanceUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Try to protect UI from simple exploits, otherwise parent to PlayerGui
local success, _ = pcall(function()
	screenGui.Parent = localPlayer:WaitForChild("PlayerGui")
end)

-- Main Background Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 250)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 27) -- Dark slate
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(63, 63, 70)
mainStroke.Thickness = 1
mainStroke.Parent = mainFrame

-- Warning Icon / Emoji
local iconLabel = Instance.new("TextLabel")
iconLabel.Name = "Icon"
iconLabel.Size = UDim2.new(1, 0, 0, 50)
iconLabel.Position = UDim2.new(0, 0, 0, 25)
iconLabel.BackgroundTransparency = 1
iconLabel.Text = "⚠️"
iconLabel.TextSize = 40
iconLabel.Font = Enum.Font.GothamBold
iconLabel.Parent = mainFrame

-- Title Text
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, -40, 0, 30)
titleLabel.Position = UDim2.new(0.5, 0, 0, 85)
titleLabel.AnchorPoint = Vector2.new(0.5, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Under Maintenance"
titleLabel.TextColor3 = Color3.fromRGB(250, 250, 250)
titleLabel.TextSize = 22
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

-- Description Text
local descLabel = Instance.new("TextLabel")
descLabel.Name = "Description"
descLabel.Size = UDim2.new(1, -40, 0, 40)
descLabel.Position = UDim2.new(0.5, 0, 0, 120)
descLabel.AnchorPoint = Vector2.new(0.5, 0)
descLabel.BackgroundTransparency = 1
descLabel.Text = "The script is currently updating to improve stability. Please check back later."
descLabel.TextColor3 = Color3.fromRGB(161, 161, 170)
descLabel.TextSize = 14
descLabel.Font = Enum.Font.Gotham
descLabel.TextWrapped = true
descLabel.Parent = mainFrame

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(1, -40, 0, 45)
closeButton.Position = UDim2.new(0.5, 0, 1, -25)
closeButton.AnchorPoint = Vector2.new(0.5, 1)
closeButton.BackgroundColor3 = Color3.fromRGB(239, 68, 68) -- Red Accent
closeButton.Text = "Close Game"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 16
closeButton.Font = Enum.Font.GothamBold
closeButton.AutoButtonColor = false
closeButton.Parent = mainFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = closeButton

-- UI Animations & Interactions
mainFrame.Size = UDim2.new(0, 0, 0, 0) -- Start small for animation
mainFrame.BackgroundTransparency = 1
iconLabel.TextTransparency = 1
titleLabel.TextTransparency = 1
descLabel.TextTransparency = 1
closeButton.BackgroundTransparency = 1
closeButton.TextTransparency = 1

-- Animate Intro
TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 400, 0, 250), BackgroundTransparency = 0}):Play()
task.wait(0.2)
TweenService:Create(iconLabel, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
TweenService:Create(titleLabel, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
TweenService:Create(descLabel, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
TweenService:Create(closeButton, TweenInfo.new(0.2), {BackgroundTransparency = 0, TextTransparency = 0}):Play()

-- Button Hover Effects
closeButton.MouseEnter:Connect(function()
	TweenService:Create(closeButton, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(220, 38, 38)}):Play()
end)

closeButton.MouseLeave:Connect(function()
	TweenService:Create(closeButton, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(239, 68, 68)}):Play()
end)

-- Close / Kick Action
closeButton.MouseButton1Click:Connect(function()
	-- Shrink window animation before kicking
	TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
	TweenService:Create(iconLabel, TweenInfo.new(0.1), {TextTransparency = 1}):Play()
	TweenService:Create(titleLabel, TweenInfo.new(0.1), {TextTransparency = 1}):Play()
	TweenService:Create(descLabel, TweenInfo.new(0.1), {TextTransparency = 1}):Play()
	TweenService:Create(closeButton, TweenInfo.new(0.1), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
	
	task.wait(0.25)
	localPlayer:Kick("Script is down for maintenance. Please re-join later.")
end)
