repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
repeat task.wait() until LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
local Camera = Workspace.CurrentCamera

for _, v in ipairs(LocalPlayer.PlayerGui:GetChildren()) do
    if v.Name == "BHub" then pcall(function() v:Destroy() end) end
end

local aimbotOn = false
local aimbotMode = "ENEMIES"
local aimbotPart = "Head"
local aimbotWall = false
local aimbotDist = 500
local aimbotFov = 150

local assistOn = false
local assistMode = "ENEMIES"
local assistPart = "Head"
local assistDist = 500
local assistFov = 150

local espOn = false
local espMode = "ENEMIES"

local antiKick = false
local antiFling = false
local antiDetect = false

local bgImageId = "rbxassetid://7483871523"

local gui = Instance.new("ScreenGui")
gui.Name = "BHub"
gui.Parent = LocalPlayer.PlayerGui

local bgImage = Instance.new("ImageLabel")
bgImage.Name = "BG"
bgImage.Size = UDim2.new(0, 500, 0, 300)
bgImage.Position = UDim2.new(0.5, -250, 0.5, -150)
bgImage.BackgroundTransparency = 1
bgImage.Image = bgImageId
bgImage.ImageTransparency = 0.85
bgImage.ScaleType = Enum.ScaleType.Crop
bgImage.Visible = false
bgImage.Parent = gui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 500, 0, 300)
main.Position = UDim2.new(0.5, -250, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(25, 30, 50)
main.BackgroundTransparency = 0.15
main.BorderSizePixel = 0
main.Visible = false
main.Parent = gui

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
titleBar.BackgroundTransparency = 0.3
titleBar.BorderSizePixel = 0
titleBar.Parent = main

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(0, 200, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "BURMALDA HUB"
titleText.TextColor3 = Color3.fromRGB(255, 150, 50)
titleText.Font = Enum.Font.SourceSansBold
titleText.TextSize = 16
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

local hideBtn = Instance.new("TextButton")
hideBtn.Size = UDim2.new(0, 35, 0, 35)
hideBtn.Position = UDim2.new(1, -35, 0, 0)
hideBtn.BackgroundTransparency = 1
hideBtn.Text = "_"
hideBtn.TextColor3 = Color3.fromRGB(255, 150, 50)
hideBtn.Font = Enum.Font.SourceSansBold
hideBtn.TextSize = 22
hideBtn.Parent = titleBar
hideBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    bgImage.Visible = false
end)

local dragMain = false
local mainStart = Vector2.zero
local mainPosX = 0
local mainPosY = 0
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragMain = true
        mainStart = input.Position
        mainPosX = main.Position.X.Offset
        mainPosY = main.Position.Y.Offset
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragMain and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - mainStart
        main.Position = UDim2.new(0, mainPosX + delta.X, 0, mainPosY + delta.Y)
        bgImage.Position = main.Position
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragMain = false end
end)

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 45, 0, 45)
toggleBtn.Position = UDim2.new(0, 10, 0.5, -22)
toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = "B"
toggleBtn.TextColor3 = Color3.fromRGB(255, 150, 50)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 22
toggleBtn.ZIndex = 10
toggleBtn.Parent = gui
toggleBtn.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
    bgImage.Visible = main.Visible
end)

local dragBtn = false
local btnStart = Vector2.zero
local btnPosX = 0
local btnPosY = 0
toggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragBtn = true
        btnStart = input.Position
        btnPosX = toggleBtn.Position.X.Offset
        btnPosY = toggleBtn.Position.Y.Offset
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragBtn and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - btnStart
        toggleBtn.Position = UDim2.new(0, btnPosX + delta.X, 0, btnPosY + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragBtn = false end
end)

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 130, 1, -35)
sidebar.Position = UDim2.new(0, 0, 0, 35)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
sidebar.BackgroundTransparency = 0.3
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local container = Instance.new("Frame")
container.Size = UDim2.new(1, -140, 1, -45)
container.Position = UDim2.new(0, 135, 0, 40)
container.BackgroundColor3 = Color3.fromRGB(30, 35, 55)
container.BackgroundTransparency = 0.2
container.BorderSizePixel = 0
container.Parent = main

local tabs = {}
local tabBtns = {}

local function createTab(name)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 1, 0)
    f.BackgroundTransparency = 1
    f.Visible = false
    f.Parent = container
    tabs[name] = f
    return f
end

local aimbotTab = createTab("Aimbot")
local assistTab = createTab("Assist")
local espTab = createTab("ESP")
local protTab = createTab("Protect")
local bgTab = createTab("Background")
aimbotTab.Visible = true

local function addTabBtn(name, text, pos)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 110, 0, 32)
    b.Position = UDim2.new(0, 10, 0, 10 + (pos-1)*40)
    b.BackgroundColor3 = (name == "Aimbot") and Color3.fromRGB(255, 120, 40) or Color3.fromRGB(35, 40, 60)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 13
    b.Parent = sidebar
    tabBtns[name] = b
    b.MouseButton1Click:Connect(function()
        for n, f in pairs(tabs) do f.Visible = false end
        tabs[name].Visible = true
        for n, btn in pairs(tabBtns) do
            btn.BackgroundColor3 = (n == name) and Color3.fromRGB(255, 120, 40) or Color3.fromRGB(35, 40, 60)
        end
    end)
end

addTabBtn("Aimbot", "AIMBOT", 1)
addTabBtn("Assist", "ASSIST", 2)
addTabBtn("ESP", "ESP", 3)
addTabBtn("Protect", "PROTECT", 4)
addTabBtn("Background", "STYLE", 5)

local function addToggle(parent, text, state, y, cb)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 180, 0, 30)
    btn.Position = UDim2.new(0, 15, 0, y)
    btn.BackgroundColor3 = state and Color3.fromRGB(255, 120, 40) or Color3.fromRGB(50, 55, 75)
    btn.Text = text .. (state and ": ON" or ": OFF")
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    btn.Parent = parent
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. (state and ": ON" or ": OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(255, 120, 40) or Color3.fromRGB(50, 55, 75)
        if cb then cb(state) end
    end)
end

local function addMode(parent, text, current, options, y, cb)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 180, 0, 30)
    btn.Position = UDim2.new(0, 15, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(50, 55, 75)
    btn.Text = text .. ": " .. current
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    btn.Parent = parent
    local idx = 1
    for i, v in ipairs(options) do if v == current then idx = i break end end
    btn.MouseButton1Click:Connect(function()
        idx = idx % #options + 1
        btn.Text = text .. ": " .. options[idx]
        if cb then cb(options[idx]) end
    end)
end

local function addSlider(parent, text, min, max, default, y, cb)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 220, 0, 45)
    frame.Position = UDim2.new(0, 15, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(45, 50, 65)
    frame.BorderSizePixel = 0
    frame.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 16)
    lbl.BackgroundTransparency = 1
    lbl.Text = text .. ": " .. default
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 10
    lbl.Parent = frame

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0, 200, 0, 5)
    bg.Position = UDim2.new(0, 10, 0, 25)
    bg.BackgroundColor3 = Color3.fromRGB(30, 35, 50)
    bg.BorderSizePixel = 0
    bg.Parent = frame

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 120, 40)
    fill.BorderSizePixel = 0
    fill.Parent = bg

    local drag = false
    local function update(input)
        local pos = math.clamp((input.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
        fill.Size = UDim2.new(pos, 0, 1, 0)
        local val = math.floor(min + (max - min) * pos)
        lbl.Text = text .. ": " .. val
        if cb then cb(val) end
    end
    bg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then drag = true update(input) end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if drag and input.UserInputType == Enum.UserInputType.MouseMovement then update(input) end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
    end)
end

-- ЗАПОЛНЕНИЕ ВКЛАДОК
addToggle(aimbotTab, "Aimbot", false, 5, function(v) aimbotOn = v end)
addMode(aimbotTab, "Target", "ENEMIES", {"ENEMIES", "ALL", "TEAM"}, 40, function(v) aimbotMode = v end)
addMode(aimbotTab, "Hit Part", "Head", {"Head", "Body"}, 75, function(v) aimbotPart = v end)
addToggle(aimbotTab, "Wall Check", false, 110, function(v) aimbotWall = v end)
addSlider(aimbotTab, "Distance", 50, 1000, 500, 150, function(v) aimbotDist = v end)
addSlider(aimbotTab, "FOV", 30, 500, 150, 200, function(v) aimbotFov = v end)

addToggle(assistTab, "Aim Assist", false, 5, function(v) assistOn = v end)
addMode(assistTab, "Target", "ENEMIES", {"ENEMIES", "ALL", "TEAM"}, 40, function(v) assistMode = v end)
addMode(assistTab, "Hit Part", "Head", {"Head", "Body"}, 75, function(v) assistPart = v end)
addSlider(assistTab, "Distance", 50, 1000, 500, 115, function(v) assistDist = v end)
addSlider(assistTab, "FOV", 30, 500, 150, 165, function(v) assistFov = v end)

addToggle(espTab, "ESP", false, 10, function(v) espOn = v end)
addMode(espTab, "ESP Mode", "ENEMIES", {"ENEMIES", "ALL", "TEAM"}, 50, function(v) espMode = v end)

addToggle(protTab, "Anti Kick", false, 10, function(v) antiKick = v end)
addToggle(protTab, "Anti Fling", false, 50, function(v) antiFling = v end)
addToggle(protTab, "Anti Detect", false, 90, function(v) antiDetect = v end)

local bgLabel = Instance.new("TextLabel")
bgLabel.Size = UDim2.new(0, 200, 0, 30)
bgLabel.Position = UDim2.new(0, 10, 0, 10)
bgLabel.BackgroundTransparency = 1
bgLabel.Text = "Choose Background"
bgLabel.TextColor3 = Color3.fromRGB(255, 150, 50)
bgLabel.Font = Enum.Font.SourceSansBold
bgLabel.TextSize = 14
bgLabel.Parent = bgTab

local bgInput = Instance.new("TextBox")
bgInput.Size = UDim2.new(0, 200, 0, 35)
bgInput.Position = UDim2.new(0, 10, 0, 50)
bgInput.BackgroundColor3 = Color3.fromRGB(50, 55, 75)
bgInput.Text = ""
bgInput.PlaceholderText = "Image ID (numbers)"
bgInput.TextColor3 = Color3.fromRGB(255, 255, 255)
bgInput.Font = Enum.Font.SourceSansBold
bgInput.TextSize = 12
bgInput.Parent = bgTab

local bgApply = Instance.new("TextButton")
bgApply.Size = UDim2.new(0, 200, 0, 30)
bgApply.Position = UDim2.new(0, 10, 0, 95)
bgApply.BackgroundColor3 = Color3.fromRGB(255, 120, 40)
bgApply.Text = "APPLY"
bgApply.TextColor3 = Color3.fromRGB(255, 255, 255)
bgApply.Font = Enum.Font.SourceSansBold
bgApply.TextSize = 13
bgApply.Parent = bgTab
bgApply.MouseButton1Click:Connect(function()
    local id = bgInput.Text
    if id ~= "" and tonumber(id) then
        bgImage.Image = "rbxassetid://" .. id
    end
end)

local bgToggle = Instance.new("TextButton")
bgToggle.Size = UDim2.new(0, 200, 0, 30)
bgToggle.Position = UDim2.new(0, 10, 0, 135)
bgToggle.BackgroundColor3 = Color3.fromRGB(50, 55, 75)
bgToggle.Text = "Background: ON"
bgToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
bgToggle.Font = Enum.Font.SourceSansBold
bgToggle.TextSize = 12
bgToggle.Parent = bgTab
local bgOn = true
bgToggle.MouseButton1Click:Connect(function()
    bgOn = not bgOn
    bgToggle.Text = "Background: " .. (bgOn and "ON" or "OFF")
    bgToggle.BackgroundColor3 = bgOn and Color3.fromRGB(255, 120, 40) or Color3.fromRGB(50, 55, 75)
    bgImage.Visible = bgOn and main.Visible
end)

-- ФУНКЦИИ
local function getTeam(p)
    if p.Team then return p.Team end
    if p:FindFirstChild("Team") then return p.Team end
    return nil
end

local function isValid(p, mode)
    if p == LocalPlayer then return false end
    local c = p.Character
    if not c then return false end
    local h = c:FindFirstChild("HumanoidRootPart")
    if not h then return false end
    local hu = c:FindFirstChildOfClass("Humanoid")
    if not hu or hu.Health <= 0 then return false end
    if mode == "ALL" then return true end
    local mt = getTeam(LocalPlayer)
    local tt = getTeam(p)
    if not mt or not tt then return mode == "ALL" end
    if mode == "ENEMIES" then return mt ~= tt end
    return mt == tt
end

local function w2s(pos)
    local s, v = Camera:WorldToViewportPoint(pos)
    return Vector2.new(s.X, s.Y), v
end

local function getTarget(mode, dist, fov, part, wall)
    local mp = UserInputService:GetMouseLocation()
    local best = nil
    local bestDist = fov
    for _, p in ipairs(Players:GetPlayers()) do
        if not isValid(p, mode) then continue end
        local c = p.Character
        local pt = c:FindFirstChild(part == "Head" and "Head" or "HumanoidRootPart")
        if not pt then continue end
        local sp, vis = w2s(pt.Position)
        if not vis then continue end
        local d = (sp - mp).Magnitude
        if d >= bestDist then continue end
        local mr = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if mr and (mr.Position - pt.Position).Magnitude > dist then continue end
        if wall and mr then
            local rayParams = RaycastParams.new()
            rayParams.FilterType = Enum.RaycastFilterType.Exclude
            rayParams.FilterDescendantsInstances = {LocalPlayer.Character, c}
            local rayResult = Workspace:Raycast(mr.Position, (pt.Position - mr.Position).Unit * dist, rayParams)
            if rayResult then continue end
        end
        bestDist = d
        best = pt
    end
    return best
end

local espData = {}
local function clearESP(p)
    if espData[p] then for _, d in ipairs(espData[p]) do d:Remove() end espData[p] = nil end
end
local function createESP(p)
    clearESP(p)
    local d = {}
    d[1] = Drawing.new("Square"); d[1].Thickness = 1; d[1].Filled = false
    d[2] = Drawing.new("Line"); d[2].Thickness = 1; d[2].Transparency = 0.7
    d[3] = Drawing.new("Text"); d[3].Size = 14; d[3].Center = true; d[3].Outline = true
    d[4] = Drawing.new("Text"); d[4].Size = 12; d[4].Center = true; d[4].Outline = true
    espData[p] = d
end

local aimbotFovCircle = Drawing.new("Circle")
aimbotFovCircle.Color = Color3.fromRGB(255, 150, 50)
aimbotFovCircle.Thickness = 1
aimbotFovCircle.NumSides = 64
aimbotFovCircle.Transparency = 0.4
aimbotFovCircle.Visible = false
aimbotFovCircle.Filled = false

local assistFovCircle = Drawing.new("Circle")
assistFovCircle.Color = Color3.fromRGB(50, 150, 255)
assistFovCircle.Thickness = 1
assistFovCircle.NumSides = 64
assistFovCircle.Transparency = 0.4
assistFovCircle.Visible = false
assistFovCircle.Filled = false

Players.PlayerRemoving:Connect(function(p) clearESP(p) end)
Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function()
        if espOn then task.wait(0.5) end
    end)
end)

RunService.Heartbeat:Connect(function()
    aimbotFovCircle.Radius = aimbotFov
    aimbotFovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    aimbotFovCircle.Visible = aimbotOn

    assistFovCircle.Radius = assistFov
    assistFovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    assistFovCircle.Visible = assistOn

    if aimbotOn then
        local t = getTarget(aimbotMode, aimbotDist, aimbotFov, aimbotPart, aimbotWall)
        if t then Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, t.Position) end
    end

    if assistOn then
        local c = LocalPlayer.Character
        if c then
            local h = c:FindFirstChild("HumanoidRootPart")
            local hu = c:FindFirstChildOfClass("Humanoid")
            if h and hu and hu.Health > 0 then
                local t = getTarget(assistMode, assistDist, assistFov, assistPart, false)
                if t then
                    local dir = (t.Position - h.Position).Unit
                    h.Velocity = dir * 50
                    h.CFrame = CFrame.lookAt(h.Position, h.Position + dir)
                end
            end
        end
    end

    if antiKick then
        pcall(function()
            local c = LocalPlayer.Character
            if c then
                local hu = c:FindFirstChildOfClass("Humanoid")
                if hu then
                    hu:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
                    hu:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                end
                for _, v in ipairs(c:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = true
                        v.CustomPhysicalProperties = PhysicalProperties.new(100, 1, 1, 1, 1)
                    end
                end
            end
        end)
    end

    if antiFling then
        pcall(function()
            local c = LocalPlayer.Character
            if c then
                local h = c:FindFirstChild("HumanoidRootPart")
                if h then
                    h.Velocity = Vector3.zero
                    h.RotVelocity = Vector3.zero
                    h.AssemblyLinearVelocity = Vector3.zero
                    h.AssemblyAngularVelocity = Vector3.zero
                end
                for _, v in ipairs(c:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.Velocity = Vector3.zero
                        v.RotVelocity = Vector3.zero
                    end
                end
            end
        end)
    end

    if antiDetect then
        pcall(function()
            -- Отключение античит-скриптов
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("Script") or v:IsA("LocalScript") or v:IsA("ModuleScript") then
                    local n = v.Name:lower()
                    if n:find("anti") or n:find("detect") or n:find("check") or n:find("ban") or n:find("kick") or n:find("ac") or n:find("guard") then
                        v.Enabled = false
                    end
                end
                if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                    local n = v.Name:lower()
                    if n:find("anti") or n:f
