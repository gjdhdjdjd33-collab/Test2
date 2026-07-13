repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
repeat task.wait() until LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
local Camera = Workspace.CurrentCamera

-- Очистка старых UI
for _, old in ipairs(LocalPlayer.PlayerGui:GetChildren()) do
    if old.Name == "BCP" or old.Name == "BKW" then
        pcall(function() old:Destroy() end)
    end
end

-- Ключ-система
local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "BKW"
KeyFrame.Size = UDim2.new(0, 280, 0, 150)
KeyFrame.Position = UDim2.new(0.5, -140, 0.5, -75)
KeyFrame.BackgroundColor3 = Color3.fromRGB(30, 60, 120)
KeyFrame.BorderSizePixel = 0
KeyFrame.ZIndex = 60000
KeyFrame.Parent = LocalPlayer.PlayerGui

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 25)
KeyTitle.Position = UDim2.new(0, 0, 0, 12)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "KEY"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.Font = Enum.Font.SourceSansBold
KeyTitle.TextSize = 16
KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0, 240, 0, 35)
KeyInput.Position = UDim2.new(0.5, -120, 0, 48)
KeyInput.BackgroundColor3 = Color3.fromRGB(45, 80, 150)
KeyInput.Text = ""
KeyInput.PlaceholderText = "Key..."
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Font = Enum.Font.SourceSansBold
KeyInput.TextSize = 16
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = KeyFrame

local KeyButton = Instance.new("TextButton")
KeyButton.Size = UDim2.new(0, 240, 0, 32)
KeyButton.Position = UDim2.new(0.5, -120, 0, 100)
KeyButton.BackgroundColor3 = Color3.fromRGB(60, 100, 180)
KeyButton.Text = "SUBMIT"
KeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyButton.Font = Enum.Font.SourceSansBold
KeyButton.TextSize = 14
KeyButton.Parent = KeyFrame

local keyAccepted = false
KeyButton.MouseButton1Click:Connect(function()
    local input = KeyInput.Text:gsub("%s+", ""):upper()
    if input == "ПУЗО" then
        keyAccepted = true
        KeyFrame:Destroy()
    else
        KeyTitle.Text = "WRONG"
        KeyTitle.TextColor3 = Color3.fromRGB(255, 80, 80)
        KeyInput.Text = ""
        task.wait(1)
        KeyTitle.Text = "KEY"
        KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)

repeat task.wait() until keyAccepted

-- Настройки
local AimbotEnabled = false
local AimbotWallCheck = false
local AimAssistEnabled = false
local AimAssistWallCheck = false
local AimbotMode = "ENEMIES"
local AimAssistMode = "ENEMIES"
local ESPMode = "ENEMIES"
local ESPEnabled = false
local AimbotHitPart = "Head"
local AimAssistHitPart = "Head"
local AntiKick = false
local AntiFling = false
local AntiDetect = false
local MaxDistance = 500
local FovRadius = 150

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BCP"
ScreenGui.Parent = LocalPlayer.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 420)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 50, 90)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 38, 70)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "BURMALDA COMBAT PRO"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 45, 0, 45)
CloseBtn.Position = UDim2.new(1, -45, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 22
CloseBtn.Parent = TitleBar
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 10, 0.5, -25)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 38, 70)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Text = "B"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 24
ToggleBtn.Parent = ScreenGui
ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, -45)
Sidebar.Position = UDim2.new(0, 0, 0, 45)
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 38, 70)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -130, 1, -55)
Container.Position = UDim2.new(0, 125, 0, 50)
Container.BackgroundColor3 = Color3.fromRGB(30, 43, 80)
Container.BorderSizePixel = 0
Container.Parent = MainFrame

-- Вкладки
local Tabs = {}
local TabBtns = {}
local function CreateTab(name)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 1, 0)
    f.BackgroundTransparency = 1
    f.Visible = false
    f.Parent = Container
    Tabs[name] = f
    return f
end
local AimbotTab = CreateTab("Aimbot")
local AssistTab = CreateTab("AimAssist")
local ESPTab = CreateTab("ESP")
local ProtTab = CreateTab("Protection")
local SettTab = CreateTab("Settings")
AimbotTab.Visible = true

local function AddTab(name, text, pos)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 105, 0, 35)
    b.Position = UDim2.new(0, 7, 0, 15 + (pos-1)*45)
    b.BackgroundColor3 = (name == "Aimbot") and Color3.fromRGB(60, 100, 180) or Color3.fromRGB(35, 50, 90)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 14
    b.Parent = Sidebar
    TabBtns[name] = b
    b.MouseButton1Click:Connect(function()
        for n, f in pairs(Tabs) do f.Visible = false end
        Tabs[name].Visible = true
        for n, btn in pairs(TabBtns) do
            btn.BackgroundColor3 = (n == name) and Color3.fromRGB(60, 100, 180) or Color3.fromRGB(35, 50, 90)
        end
    end)
end
AddTab("Aimbot", "AIMBOT", 1)
AddTab("AimAssist", "AIM ASSIST", 2)
AddTab("ESP", "ESP", 3)
AddTab("Protection", "PROTECT", 4)
AddTab("Settings", "SETTINGS", 5)

-- Элементы
local function MakeToggle(parent, text, y, default, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 200, 0, 35)
    b.Position = UDim2.new(0.5, -100, 0, y)
    b.BackgroundColor3 = default and Color3.fromRGB(40, 150, 60) or Color3.fromRGB(60, 100, 180)
    b.Text = text .. (default and ": ON" or ": OFF")
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 14
    b.Parent = parent
    local state = default
    b.MouseButton1Click:Connect(function()
        state = not state
        b.Text = text .. (state and ": ON" or ": OFF")
        b.BackgroundColor3 = state and Color3.fromRGB(40, 150, 60) or Color3.fromRGB(60, 100, 180)
        if cb then cb(state) end
    end)
end

local function MakeMode(parent, text, y, current, options, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 200, 0, 35)
    b.Position = UDim2.new(0.5, -100, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(60, 100, 180)
    b.Text = text .. ": " .. current
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 14
    b.Parent = parent
    local idx = 1
    for i, v in ipairs(options) do if v == current then idx = i break end end
    b.MouseButton1Click:Connect(function()
        idx = idx % #options + 1
        b.Text = text .. ": " .. options[idx]
        if cb then cb(options[idx]) end
    end)
end

local function MakeSlider(parent, text, y, min, max, default, cb)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 60)
    frame.Position = UDim2.new(0.5, -100, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(45, 80, 150)
    frame.BorderSizePixel = 0
    frame.Parent = parent
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.Position = UDim2.new(0, 0, 0, 3)
    lbl.BackgroundTransparency = 1
    lbl.Text = text .. ": " .. tostring(default)
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 12
    lbl.Parent = frame
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0, 180, 0, 6)
    bg.Position = UDim2.new(0.5, -90, 0, 30)
    bg.BackgroundColor3 = Color3.fromRGB(30, 43, 80)
    bg.BorderSizePixel = 0
    bg.Parent = frame
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(40, 150, 60)
    fill.BorderSizePixel = 0
    fill.Parent = bg
    local drag = false
    local function upd(input)
        local pos = math.clamp((input.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
        fill.Size = UDim2.new(pos, 0, 1, 0)
        local val = math.floor(min + (max - min) * pos)
        lbl.Text = text .. ": " .. tostring(val)
        if cb then cb(val) end
    end
    bg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then drag = true upd(input) end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if drag and input.UserInputType == Enum.UserInputType.MouseMovement then upd(input) end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
    end)
end

-- Заполнение вкладок
MakeToggle(AimbotTab, "Aimbot", 10, false, function(v) AimbotEnabled = v end)
MakeMode(AimbotTab, "Target", 60, "ENEMIES", {"ENEMIES", "ALL", "TEAM"}, function(v) AimbotMode = v end)
MakeMode(AimbotTab, "Hit Part", 110, "Head", {"Head", "Body"}, function(v) AimbotHitPart = v end)
MakeToggle(AimbotTab, "WallCheck", 165, false, function(v) AimbotWallCheck = v end)
MakeSlider(AimbotTab, "Distance", 215, 50, 1000, 500, function(v) MaxDistance = v end)
MakeSlider(AimbotTab, "FOV", 290, 30, 500, 150, function(v) FovRadius = v end)

MakeToggle(AssistTab, "Aim Assist", 10, false, function(v) AimAssistEnabled = v end)
MakeMode(AssistTab, "Target", 60, "ENEMIES", {"ENEMIES", "ALL", "TEAM"}, function(v) AimAssistMode = v end)
MakeMode(AssistTab, "Hit Part", 110, "Head", {"Head", "Body"}, function(v) AimAssistHitPart = v end)
MakeToggle(AssistTab, "WallCheck", 165, false, function(v) AimAssistWallCheck = v end)
MakeSlider(AssistTab, "Distance", 215, 50, 1000, 500, function(v) MaxDistance = v end)
MakeSlider(AssistTab, "FOV", 290, 30, 500, 150, function(v) FovRadius = v end)

MakeToggle(ESPTab, "ESP", 10, false, function(v) ESPEnabled = v end)
MakeMode(ESPTab, "ESP Mode", 60, "ENEMIES", {"ENEMIES", "ALL", "TEAM"}, function(v) ESPMode = v end)

MakeToggle(ProtTab, "Anti Kick", 10, false, function(v) AntiKick = v end)
MakeToggle(ProtTab, "Anti Fling", 60, false, function(v) AntiFling = v end)
MakeToggle(ProtTab, "Anti Detect", 110, false, function(v) AntiDetect = v end)

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(0, 200, 0, 30)
InfoLabel.Position = UDim2.new(0.5, -100, 0, 20)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "BURMALDA COMBAT PRO"
InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoLabel.Font = Enum.Font.SourceSansBold
InfoLabel.TextSize = 14
InfoLabel.Parent = SettTab

-- FOV круг
local FovCircle = Drawing.new("Circle")
FovCircle.Color = Color3.fromRGB(255, 255, 255)
FovCircle.Thickness = 1
FovCircle.NumSides = 64
FovCircle.Radius = FovRadius
FovCircle.Transparency = 0.4
FovCircle.Visible = false
FovCircle.Filled = false

-- Вспомогательные функции
local function GetTeam(plr)
    if plr.Team then return plr.Team end
    if plr:FindFirstChild("Team") then return plr.Team end
    return nil
end

local function IsValid(plr, mode)
    if plr == LocalPlayer then return false end
    local char = plr.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    if mode == "ALL" then return true end
    local myTeam = GetTeam(LocalPlayer)
    local tTeam = GetTeam(plr)
    if mode == "ENEMIES" then return myTeam ~= tTeam end
    if mode == "TEAM" then return myTeam == tTeam end
    return false
end

local function World2Screen(pos)
    local sp, vis = Camera:WorldToViewportPoint(pos)
    return Vector2.new(sp.X, sp.Y), vis
end

local function WallCheck(from, to, enabled)
    if not enabled then return false end
    local dir = (to - from).Unit
    local dist = (to - from).Magnitude
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {LocalPlayer.Character}
    local result = Workspace:Raycast(from, dir * dist, params)
    if result then
        local hitPlayer = Players:GetPlayerFromCharacter(result.Instance.Parent)
        if hitPlayer then return false end
        return true
    end
    return false
end

local function GetTarget(mode, dist, fov, hitPart, wall)
    local mousePos = UserInputService:GetMouseLocation()
    local bestDist = fov or FovRadius
    local best = nil
    for _, plr in ipairs(Players:GetPlayers()) do
        if not IsValid(plr, mode) then continue end
        local char = plr.Character
        local part = char:FindFirstChild(hitPart == "Head" and "Head" or "HumanoidRootPart")
        if not part then continue end
        local sp, vis = World2Screen(part.Position)
        if not vis then continue end
        local d = (sp - mousePos).Magnitude
        if d >= bestDist then continue end
        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local wDist = myRoot and (myRoot.Position - part.Position).Magnitude or 0
        if wDist > (dist or MaxDistance) then continue end
        if myRoot and WallCheck(myRoot.Position, part.Position, wall) then continue end
        bestDist = d
        best = part
    end
    return best
end

-- ESP
local ESPData = {}
local function ClearESP(plr)
    if ESPData[plr] then
        for _, d in ipairs(ESPData[plr]) do d:Remove() end
        ESPData[plr] = nil
    end
end
local function CreateESP(plr)
    ClearESP(plr)
    local d = {}
    d[1] = Drawing.new("Square"); d[1].Thickness = 1; d[1].Filled = false
    d[2] = Drawing.new("Line"); d[2].Thickness = 1; d[2].Transparency = 0.7
    d[3] = Drawing.new("Text"); d[3].Size = 14; d[3].Center = true; d[3].Outline = true
    d[4] = Drawing.new("Text"); d[4].Size = 12; d[4].Center = true; d[4].Outline = true
    ESPData[plr] = d
end

-- Главный цикл
RunService.Heartbeat:Connect(function()
    FovCircle.Radius = FovRadius
    FovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    FovCircle.Visible = AimbotEnabled or AimAssistEnabled

    if AimbotEnabled then
        local target = GetTarget(AimbotMode, MaxDistance, FovRadius, AimbotHitPart, AimbotWallCheck)
        if target then
            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, target.Position)
        end
    end

    if AimAssistEnabled then
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local target = GetTarget(AimAssistMode, MaxDistance, FovRadius, AimAssistHitPart, AimAssistWallCheck)
                if target then
                    local dir = (target.Position - hrp.Position).Unit
                    hrp.CFrame = hrp.CFrame:Lerp(CFrame.lookAt(hrp.Position, hrp.Position + dir), 0.25)
                    hrp.Velocity = dir * 30
                end
            end
        end
    end

    if AntiKick then
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
                    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                end
                for _, v in ipairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = true
                        v.CustomPhysicalProperties = PhysicalProperties.new(100, 1, 1, 1, 1)
                    end
                end
            end
        end)
    end

    if AntiFling then
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.Velocity = Vector3.zero
                    hrp.RotVelocity = Vector3.zero
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.AssemblyAngularVelocity = Vector3.zero
                end
            end
        end)
    end

    if AntiDetect then
        pcall(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("Script") and (v.Name:lower():find("anti") or v.Name:lower():find("detect") or v.Name:lower():find("check")) then
                    v.Enabled = false
                end
            end
        end)
    end
end)

-- ESP цикл
RunService.RenderStepped:Connect(function()
    if not ESPEnabled then
        for plr, _ in pairs(ESPData) do ClearESP(plr) end
        return
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if not IsValid(plr, ESPMode) and ESPMode ~= "ALL" then
            ClearESP(plr)
            continue
        end
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local head = char and char:FindFirstChild("Head")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hrp or not head or not hum or hum.Health <= 0 then
            ClearESP(plr)
            continue
        end
        if not ESPData[plr] then CreateESP(plr) end
        local d = ESPData[plr]
        if not d then continue end

        local myTeam = GetTeam(LocalPlayer)
        local tTeam = GetTeam(plr)
        local isEnemy = myTeam ~= tTeam
        local color = ESPMode == "ALL" and (isEnemy and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(50, 200, 100)) or (ESPMode == "ENEMIES" and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(50, 120, 255))

        local headPos, headVis = World2Screen(head.Position)
        local hrpPos, hrpVis = World2Screen(hrp.Position)

        if headVis or hrpVis then
            local h = (headPos - hrpPos).Magnitude
            local boxSize = Vector2.new(h * 0.6, h)
            local boxPos = Vector2.new(hrpPos.X - boxSize.X / 2, headPos.Y)
            d[1].Color = color; d[1].Size = boxSize; d[1].Position = boxPos; d[1].Visible = true
            d[2].From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y); d[2].To = hrpPos; d[2].Color = color; d[2].Visible = true
            local dist = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude) or 0
            d[3].Text = dist .. "m"; d[3].Pos
