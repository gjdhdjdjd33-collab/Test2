repeat task.wait() until game:IsLoaded()
local a,b,c,d,e=game:GetService("Players"),game:GetService("RunService"),game:GetService("Workspace"),game:GetService("UserInputService"),a.LocalPlayer
repeat task.wait() until e and e:FindFirstChild("PlayerGui")
local f,g=c.CurrentCamera,"ПУЗО"
for _,h in ipairs(e.PlayerGui:GetChildren())do if h.Name=="BCP"or h.Name=="BKW"then pcall(function()h:Destroy()end)end end
local i=Instance.new("Frame")i.Name="BKW"i.Size=UDim2.new(0,280,0,150)i.Position=UDim2.new(0.5,-140,0.5,-75)i.BackgroundColor3=Color3.fromRGB(30,60,120)i.BorderSizePixel=0i.ZIndex=60000i.Parent=e.PlayerGui
local j=Instance.new("TextLabel")j.Size=UDim2.new(1,0,0,25)j.Position=UDim2.new(0,0,0,12)j.BackgroundTransparency=1j.Text="KEY"j.TextColor3=Color3.fromRGB(255,255,255)j.Font=Enum.Font.SourceSansBoldj.TextSize=16j.Parent=i
local k=Instance.new("TextBox")k.Size=UDim2.new(0,240,0,35)k.Position=UDim2.new(0.5,-120,0,48)k.BackgroundColor3=Color3.fromRGB(45,80,150)k.Text=""k.PlaceholderText="Key..."k.TextColor3=Color3.fromRGB(255,255,255)k.Font=Enum.Font.SourceSansBoldk.TextSize=16k.Parent=i
local l=Instance.new("TextButton")l.Size=UDim2.new(0,240,0,32)l.Position=UDim2.new(0.5,-120,0,100)l.BackgroundColor3=Color3.fromRGB(60,100,180)l.Text="SUBMIT"l.TextColor3=Color3.fromRGB(255,255,255)l.Font=Enum.Font.SourceSansBoldl.TextSize=14l.Parent=i
local m=false l.MouseButton1Click:Connect(function()if k.Text:gsub("%s+",""):upper()==g then m=true i:Destroy()else j.Text="WRONG"j.TextColor3=Color3.fromRGB(255,80,80)k.Text=""task.wait(1)j.Text="KEY"j.TextColor3=Color3.fromRGB(255,255,255)end end)repeat task.wait()until m
local n=Instance.new("ScreenGui")n.Name="BCP"n.Parent=e.PlayerGui
local o=Instance.new("Frame")o.Size=UDim2.new(0,500,0,360)o.Position=UDim2.new(0.5,-250,0.5,-180)o.BackgroundColor3=Color3.fromRGB(35,50,90)o.BorderSizePixel=0o.Visible=false o.Parent=n
local p=Instance.new("Frame")p.Size=UDim2.new(1,0,0,35)p.BackgroundColor3=Color3.fromRGB(25,38,70)p.BorderSizePixel=0p.Parent=o
local q=Instance.new("TextLabel")q.Size=UDim2.new(0,300,1,0)q.Position=UDim2.new(0,12,0,0)q.BackgroundTransparency=1q.Text="BURMALDA"q.TextColor3=Color3.fromRGB(255,255,255)q.Font=Enum.Font.SourceSansBoldq.TextSize=16q.TextXAlignment=Enum.TextXAlignment.Leftq.Parent=p
local r=Instance.new("TextButton")r.Size=UDim2.new(0,35,0,35)r.Position=UDim2.new(1,-35,0,0)r.BackgroundTransparency=1r.Text="X"r.TextColor3=Color3.fromRGB(255,255,255)r.Font=Enum.Font.SourceSansBoldr.TextSize=18r.Parent=p r.MouseButton1Click:Connect(function()n:Destroy()end)
local s=Instance.new("TextButton")s.Size=UDim2.new(0,45,0,45)s.Position=UDim2.new(0,10,0.5,-22)s.BackgroundColor3=Color3.fromRGB(25,38,70)s.BorderSizePixel=0s.Text="B"s.TextColor3=Color3.fromRGB(255,255,255)s.Font=Enum.Font.SourceSansBolds.TextSize=22s.Parent=n s.MouseButton1Click:Connect(function()o.Visible=not o.Visible end)
local t,u,v,w,x,y,z,A,B,C,D=false,"ENEMIES","Head",false,false,"ENEMIES","Head",false,false,"ENEMIES",false,false,false
local E,F=500,150
local function G(parent,text,y,state,callback)
    local btn=Instance.new("TextButton")btn.Size=UDim2.new(0,200,0,30)btn.Position=UDim2.new(0.5,-100,0,y)btn.BackgroundColor3=state and Color3.fromRGB(40,150,60)or Color3.fromRGB(60,100,180)btn.Text=text..(state and": ON"or": OFF")btn.TextColor3=Color3.fromRGB(255,255,255)btn.Font=Enum.Font.SourceSansBoldbtn.TextSize=13btn.Parent=parent
    btn.MouseButton1Click:Connect(function()state=not state btn.Text=text..(state and": ON"or": OFF")btn.BackgroundColor3=state and Color3.fromRGB(40,150,60)or Color3.fromRGB(60,100,180)if callback then callback(state)end end)
end
local function H(parent,text,y,current,options,callback)
    local btn=Instance.new("TextButton")btn.Size=UDim2.new(0,200,0,30)btn.Position=UDim2.new(0.5,-100,0,y)btn.BackgroundColor3=Color3.fromRGB(60,100,180)btn.Text=text..": "..current btn.TextColor3=Color3.fromRGB(255,255,255)btn.Font=Enum.Font.SourceSansBoldbtn.TextSize=13btn.Parent=parent
    local idx=1 for i,v in ipairs(options)do if v==current then idx=i break end end
    btn.MouseButton1Click:Connect(function()idx=idx%#options+1 btn.Text=text..": "..options[idx]if callback then callback(options[idx])end end)
end
local function I(parent,text,y,min,max,default,callback)
    local fr=Instance.new("Frame")fr.Size=UDim2.new(0,200,0,50)fr.Position=UDim2.new(0.5,-100,0,y)fr.BackgroundColor3=Color3.fromRGB(45,80,150)fr.BorderSizePixel=0fr.Parent=parent
    local lb=Instance.new("TextLabel")lb.Size=UDim2.new(1,0,0,18)lb.BackgroundTransparency=1lb.Text=text..": "..default lb.TextColor3=Color3.fromRGB(255,255,255)lb.Font=Enum.Font.SourceSansBoldlb.TextSize=11lb.Parent=fr
    local bg=Instance.new("Frame")bg.Size=UDim2.new(0,180,0,5)bg.Position=UDim2.new(0.5,-90,0,28)bg.BackgroundColor3=Color3.fromRGB(30,43,80)bg.BorderSizePixel=0bg.Parent=fr
    local fl=Instance.new("Frame")fl.Size=UDim2.new((default-min)/(max-min),0,1,0)fl.BackgroundColor3=Color3.fromRGB(40,150,60)fl.BorderSizePixel=0fl.Parent=bg
    local dr=false
    local function up(input)local p=math.clamp((input.Position.X-bg.AbsolutePosition.X)/bg.AbsoluteSize.X,0,1)fl.Size=UDim2.new(p,0,1,0)local v=math.floor(min+(max-min)*p)lb.Text=text..": "..v if callback then callback(v)end end
    bg.InputBegan:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 then dr=true up(input)end end)
    d.InputChanged:Connect(function(input)if dr and input.UserInputType==Enum.UserInputType.MouseMovement then up(input)end end)
    d.InputEnded:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 then dr=false end end)
end
G(o,"Aimbot",50,false,function(v)t=v end)H(o,"Target",90,u,{"ENEMIES","ALL","TEAM"},function(v)u=v end)H(o,"Hit Part",130,v,{"Head","Body"},function(v)v=v end)G(o,"WallCheck",170,false,function(v)w=v end)I(o,"Distance",210,50,1000,E,function(v)E=v end)I(o,"FOV",250,30,500,F,function(v)F=v end)
G(o,"Aim Assist",50,false,function(v)x=v end)H(o,"Assist Target",90,y,{"ENEMIES","ALL","TEAM"},function(v)y=v end)H(o,"Assist Hit",130,z,{"Head","Body"},function(v)z=v end)G(o,"Assist Wall",170,false,function(v)A=v end)I(o,"Assist Dist",210,50,1000,E,function(v)E=v end)I(o,"Assist FOV",250,30,500,F,function(v)F=v end)
local J=Drawing.new("Circle")J.Color=Color3.fromRGB(255,255,255)J.Thickness=1J.NumSides=64J.Transparency=0.4J.Visible=false J.Filled=false
local function K(p)if p.Team then return p.Team end return p:FindFirstChild("Team")end
local function L(p,mode)if p==e then return false end local c=p.Character if not c then return false end local h=c:FindFirstChild("HumanoidRootPart")if not h then return false end local hu=c:FindFirstChildOfClass("Humanoid")if not hu or hu.Health<=0 then return false end if mode=="ALL"then return true end local mt=K(e)local tt=K(p)if mode=="ENEMIES"then return mt~=tt end return mt==tt end
local function M(pos)local s,v=f:WorldToViewportPoint(pos)return Vector2.new(s.X,s.Y),v end
local function N(mode,dist,fv,hp,wc)
    local mp=d:GetMouseLocation()local bd=fv or F local best=nil
    for _,p in ipairs(a:GetPlayers())do if not L(p,mode)then continue end local c=p.Character local pt=c:FindFirstChild(hp=="Head"and"Head"or"HumanoidRootPart")if not pt then continue end local sp,vis=M(pt.Position)if not vis then continue end local dd=(sp-mp).Magnitude if dd>=bd then continue end local mr=e.Character and e.Character:FindFirstChild("HumanoidRootPart")if mr and(mr.Position-pt.Position).Magnitude>(dist or E)then continue end bd=dd best=pt end return best
end
b.Heartbeat:Connect(function()
    J.Radius=F J.Position=Vector2.new(f.ViewportSize.X/2,f.ViewportSize.Y/2)J.Visible=t or x
    if t then local tg=N(u,E,F,v,w)if tg then f.CFrame=CFrame.lookAt(f.CFrame.Position,tg.Position)end end
    if x then local c=e.Character if c then local h=c:FindFirstChild("HumanoidRootPart")local hu=c:FindFirstChildOfClass("Humanoid")if h and hu and hu.Health>0 then local tg=N(y,E,F,z,A)if tg then local dir=(tg.Position-h.Position).Unit h.CFrame=h.CFrame:Lerp(CFrame.lookAt(h.Position,h.Position+dir),0.25)h.Velocity=dir*30 end end end end
    if B then pcall(function()local c=e.Character if c then local h=c:FindFirstChildOfClass("Humanoid")if h then h:SetStateEnabled(Enum.HumanoidStateType.Physics,false)h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)end for _,v in ipairs(c:GetDescendants())do if v:IsA("BasePart")then v.CustomPhysicalProperties=PhysicalProperties.new(100,1,1,1,1)end end end end)end
    if C then pcall(function()local c=e.Character if c then local h=c:FindFirstChild("HumanoidRootPart")if h then h.Velocity=Vector3.zero h.RotVelocity=Vector3.zero h.AssemblyLinearVelocity=Vector3.zero h.AssemblyAngularVelocity=Vector3.zero end end end)end
    if D then pcall(function()for _,v in ipairs(c:GetDescendants())do if v:IsA("Script")and(v.Name:lower():find("anti")or v.Name:lower():find("detect"))then v.Enabled=false end end end)end
end)
