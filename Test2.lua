repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
repeat task.wait() until LocalPlayer and LocalPlayer:FindFirstChild("Character") and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
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

local gui = Instance.new("ScreenGui")
gui.Name = "BHub"
gui.Parent = LocalPlayer.PlayerGui

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
hideBtn.MouseButton1Click:Connect(function() main.Visible = false end)

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
toggleBtn.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)

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

addToggle(aimbotTab, "Aimbot", false, 10, function(v) aimbotOn = v end)
addMode(aimbotTab, "Target", "ENEMIES", {"ENEMIES", "ALL", "TEAM"}, 50, function(v) aimbotMode = v end)
addMode(aimbotTab, "Hit Part", "Head", {"Head", "Body"}, 90, function(v) aimbotPart = v end)
addToggle(aimbotTab, "Wall Check", false, 130, function(v) aimbotWall = v end)

addToggle(assistTab, "Aim Assist", false, 10, function(v) assistOn = v end)
addMode(assistTab, "Target", "ENEMIES", {"ENEMIES", "ALL", "TEAM"}, 50, function(v) assistMode = v end)
addMode(assistTab, "Hit Part", "Head", {"Head", "Body"}, 90, function(v) assistPart = v end)

addToggle(espTab, "ESP", false, 10, function(v) espOn = v end)
addMode(espTab, "ESP Mode", "ENEMIES", {"ENEMIES", "ALL", "TEAM"}, 50, function(v) espMode = v end)

addToggle(protTab, "Anti Kick", false, 10, function(v) antiKick = v end)
addToggle(protTab, "Anti Fling", false, 50, function(v) antiFling = v end)
addToggle(protTab, "Anti Detect", false, 90, function(v) antiDetect = v end)

local function getTeam(p)
    if p.Team then return p.Team end
    return p:FindFirstChild("Team")
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
    if mode == "ENEMIES" then return mt ~= tt end
    return mt == tt
end

local function w2s(pos)
    local s, v = Camera:WorldToViewportPoint(pos)
    return Vector2.new(s.X, s.Y), v
end

local function getTarget(mode, dist, fov, part)
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
        bestDist = d
        best = pt
    end
    return best
end

local espData = {}
local function clearESP(p)
    if espData[p] then
        for _, d in ipairs(espData[p]) do d:Remove() end
        espData[p] = nil
    end
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

Players.PlayerRemoving:Connect(function(p) clearESP(p) end)

RunService.Heartbeat:Connect(function()
    if aimbotOn then
        local t = getTarget(aimbotMode, aimbotDist, aimbotFov, aimbotPart)
        if t then
            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, t.Position)
        end
    end

    if assistOn then
        local c = LocalPlayer.Character
        if c then
            local h = c:FindFirstChild("HumanoidRootPart")
            local hu = c:FindFirstChildOfClass("Humanoid")
            if h and hu and hu.Health > 0 then
                local t = getTarget(assistMode, assistDist, assistFov, assistPart)
                if t then
                    local dir = (t.Position - h.Position).Unit
                    h.Velocity = dir * 50
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
                end
            end
        end)
    end

    if antiDetect then
        pcall(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("Script") or v:IsA("LocalScript") then
                    local n = v.Name:lower()
                    if n:find("anti") or n:find("detect") or n:find("check") then
                        v.Enabled = false
                    end
                end
            end
        end)
    end
end)

RunService.RenderStepped:Connect(function()
    if not espOn then
        for p, _ in pairs(espData) do clearESP(p) end
        return
    end

    for _, p in ipairs(Players:GetPlayers()) do
        if not isValid(p, espMode) and espMode ~= "ALL" then
            clearESP(p)
            continue
        end
        local c = p.Character
        local h = c and c:FindFirstChild("HumanoidRootPart")
        local hd = c and c:FindFirstChild("Head")
        local hu = c and c:FindFirstChildOfClass("Humanoid")
        if not h or not hd or not hu or hu.Health <= 0 then
            clearESP(p)
            continue
        end
        if not espData[p] then createESP(p) end
        local d = espData[p]
        if not d then continue end

        local mt = getTeam(LocalPlayer)
        local tt = getTeam(p)
        local enemy = mt ~= tt
        local clr = espMode == "ALL" and (enemy and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(50, 200, 100)) or (espMode == "ENEMIES" and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(50, 120, 255))

        local hp, hv = w2s(hd.Position)
        local rp, rv = w2s(h.Position)
        if hv or rv then
            local s = (hp - rp).Magnitude
            d[1].Color = clr
            d[1].Size = Vector2.new(s*0.6, s)
            d[1].Position = Vector2.new(rp.X - s*0.3, hp.Y)
            d[1].Visible = true
            d[2].From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
            d[2].To = rp
            d[2].Color = clr
            d[2].Visible = true
            local dist = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and math.floor((LocalPlayer.Character.HumanoidRootPart.Position - h.Position).Magnitude) or 0
            d[3].Text = dist.."m"
            d[3].Position = Vector2.new(rp.X, rp.Y+15)
            d[3].Color = clr
            d[3].Visible = true
            d[4].Text = p.Name
            d[4].Position = Vector2.new(rp.X, rp.Y-15)
            d[4].Color = clr
            d[4].Visible = true
        else
            for _, v in ipairs(d) do v.Visible = false end
        end
    end
end)
