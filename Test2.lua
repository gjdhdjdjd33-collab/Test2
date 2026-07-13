local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui")
gui.Name = "BHub"
gui.Parent = LocalPlayer.PlayerGui

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 45, 0, 45)
btn.Position = UDim2.new(0, 10, 0.5, -22)
btn.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
btn.Text = "B"
btn.TextColor3 = Color3.fromRGB(255, 150, 50)
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 22
btn.Parent = gui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 500, 0, 300)
main.Position = UDim2.new(0.5, -250, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(25, 30, 50)
main.BorderSizePixel = 0
main.Visible = false
main.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
title.Text = "BURMALDA HUB"
title.TextColor3 = Color3.fromRGB(255, 150, 50)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16
title.Parent = main

btn.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)
