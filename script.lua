--[[
    ╔══════════════════════════════════════════╗
    ║      LINUX COMMUNITY HACK v4.0          ║
    ║      Best Executor Script - English     ║
    ╚══════════════════════════════════════════╝
    
    Keybinds:
    - RightShift = Toggle Menu
    - Q / Right Click (hold) = Aimbot
    - Ctrl + Click = Click Teleport
]]

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local RS = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
local Camera = Workspace.CurrentCamera

-- CONFIG
local C = {
    Key = Enum.KeyCode.RightShift,
    AimKey = Enum.KeyCode.Q,
    Title = "⚡ LINUX COMMUNITY HACK ⚡",
    Ver = "v4.0",
    Bg = Color3.fromRGB(12, 12, 22),
    Header = Color3.fromRGB(88, 30, 200),
    HeaderG = Color3.fromRGB(150, 50, 255),
    Btn = Color3.fromRGB(28, 28, 48),
    BtnA = Color3.fromRGB(88, 30, 200),
    Txt = Color3.fromRGB(230, 230, 255),
    TxtD = Color3.fromRGB(130, 130, 160),
    Acc = Color3.fromRGB(130, 80, 255),
    Sep = Color3.fromRGB(38, 38, 58),
    Ok = Color3.fromRGB(80, 200, 120),
    Bad = Color3.fromRGB(230, 60, 80),
    Warn = Color3.fromRGB(255, 180, 50),
}

-- KEYBINDS CONFIG
local KB = {
    Toggle    = Enum.KeyCode.RightShift,
    God       = Enum.KeyCode.G,
    Fly       = Enum.KeyCode.F,
    Noclip    = Enum.KeyCode.V,
    InfJump   = Enum.KeyCode.H,
    ESP       = Enum.KeyCode.X,
    Aimbot    = Enum.KeyCode.B,
    Fullbright= Enum.KeyCode.N,
    ClickTP   = Enum.KeyCode.Z,
    Triggerbot= Enum.KeyCode.T,
    AntiAFK   = Enum.KeyCode.J,
    TPWaypoint= Enum.KeyCode.P,
    SaveWP    = Enum.KeyCode.K,
    TPUp      = Enum.KeyCode.U,
}

-- STATE
local S = {
    Open = true, God = false, Fly = false, Noclip = false, InfJump = false,
    ESP = false, Aimbot = false, AimFOV = 120, AimSmooth = 5, AimPart = "Head",
    AimTeam = true, AimVis = true, AimShowFOV = true,
    Speed = 16, Jump = 50, FlySpd = 80, Tab = "Player",
    Fullbright = false, ClickTP = false, Triggerbot = false, AntiAFK = false,
    Conns = {}, ESPObj = {},
    Toggles = {},  -- UI toggle references for keybind sync
}

-- UTILS
local function GetChar() return LP.Character or LP.CharacterAdded:Wait() end
local function GetHum() local c = GetChar() return c and c:FindFirstChildOfClass("Humanoid") end
local function GetRoot() local c = GetChar() return c and c:FindFirstChild("HumanoidRootPart") end
local function Ntf(t, m, d) pcall(function() StarterGui:SetCore("SendNotification", {Title=t or"Admin",Text=m or"",Duration=d or 3}) end) end
local function Kill(n) if S.Conns[n] then S.Conns[n]:Disconnect() S.Conns[n]=nil end end

-- CLEANUP OLD
if CoreGui:FindFirstChild("LCHGui") then CoreGui:FindFirstChild("LCHGui"):Destroy() end

local SG = Instance.new("ScreenGui")
SG.Name = "LCHGui"
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() SG.Parent = CoreGui end)
if not SG.Parent then SG.Parent = LP:WaitForChild("PlayerGui") end

-- MAIN FRAME
local MF = Instance.new("Frame")
MF.Name = "Main"
MF.Size = UDim2.new(0, 550, 0, 470)
MF.Position = UDim2.new(0.5, -275, 0.5, -235)
MF.BackgroundColor3 = C.Bg
MF.BorderSizePixel = 0
MF.ClipsDescendants = true
MF.Parent = SG

Instance.new("UICorner", MF).CornerRadius = UDim.new(0, 12)
local ms = Instance.new("UIStroke", MF) ms.Color = C.Acc ms.Thickness = 1.5 ms.Transparency = 0.5

-- Shadow
local sh = Instance.new("ImageLabel", MF)
sh.BackgroundTransparency=1 sh.Position=UDim2.new(0,-15,0,-15) sh.Size=UDim2.new(1,30,1,30) sh.ZIndex=-1
sh.Image="rbxassetid://6014261993" sh.ImageColor3=Color3.new(0,0,0) sh.ImageTransparency=0.4
sh.ScaleType=Enum.ScaleType.Slice sh.SliceCenter=Rect.new(49,49,450,450)

-- HEADER
local HD = Instance.new("Frame", MF)
HD.Name="Header" HD.Size=UDim2.new(1,0,0,45) HD.BackgroundColor3=C.Header HD.BorderSizePixel=0
Instance.new("UICorner", HD).CornerRadius = UDim.new(0, 12)
local hb = Instance.new("Frame", HD) hb.Size=UDim2.new(1,0,0,15) hb.Position=UDim2.new(0,0,1,-15) hb.BackgroundColor3=C.Header hb.BorderSizePixel=0
local hg = Instance.new("UIGradient", HD) hg.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,C.Header),ColorSequenceKeypoint.new(1,C.HeaderG)} hg.Rotation=45

local tl = Instance.new("TextLabel", HD)
tl.Size=UDim2.new(1,-90,1,0) tl.Position=UDim2.new(0,15,0,0) tl.BackgroundTransparency=1
tl.Text=C.Title tl.TextColor3=C.Txt tl.TextSize=18 tl.Font=Enum.Font.GothamBold tl.TextXAlignment=Enum.TextXAlignment.Left

local vl = Instance.new("TextLabel", HD)
vl.Size=UDim2.new(0,60,1,0) vl.Position=UDim2.new(1,-75,0,0) vl.BackgroundTransparency=1
vl.Text=C.Ver vl.TextColor3=C.TxtD vl.TextSize=12 vl.Font=Enum.Font.Gotham vl.TextXAlignment=Enum.TextXAlignment.Right

-- DRAG
local dg,di,ds,sp
HD.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 then dg=true ds=i.Position sp=MF.Position
    i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dg=false end end) end
end)
HD.InputChanged:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseMovement then di=i end end)
UIS.InputChanged:Connect(function(i) if i==di and dg then local d=i.Position-ds MF.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y) end end)

-- CLOSE
local cb = Instance.new("TextButton", HD)
cb.Size=UDim2.new(0,30,0,30) cb.Position=UDim2.new(1,-38,0,7) cb.BackgroundColor3=C.Bad cb.BackgroundTransparency=0.3
cb.Text="✕" cb.TextColor3=C.Txt cb.TextSize=14 cb.Font=Enum.Font.GothamBold cb.BorderSizePixel=0
Instance.new("UICorner", cb).CornerRadius = UDim.new(0, 8)
cb.MouseButton1Click:Connect(function() S.Open=false MF.Visible=false end)
cb.MouseEnter:Connect(function() TweenService:Create(cb,TweenInfo.new(0.2),{BackgroundTransparency=0}):Play() end)
cb.MouseLeave:Connect(function() TweenService:Create(cb,TweenInfo.new(0.2),{BackgroundTransparency=0.3}):Play() end)

-- SIDEBAR
local SB = Instance.new("Frame", MF)
SB.Size=UDim2.new(0,130,1,-50) SB.Position=UDim2.new(0,5,0,48) SB.BackgroundTransparency=1
local sl = Instance.new("UIListLayout", SB) sl.SortOrder=Enum.SortOrder.LayoutOrder sl.Padding=UDim.new(0,3)

local Tabs = {"Player","Combat","Server","Visual","Teleport","Misc","Keybinds"}
local Icons = {Player="👤",Combat="🎯",Server="🌐",Visual="👁",Teleport="📌",Misc="⚙",Keybinds="⌨"}
local TBtns = {}

for i, tn in ipairs(Tabs) do
    local tb = Instance.new("TextButton", SB)
    tb.Name="T_"..tn tb.Size=UDim2.new(1,-6,0,32) tb.BackgroundColor3=C.Btn tb.BackgroundTransparency=0.3
    tb.Text=(Icons[tn] or "").."  "..tn tb.TextColor3=C.TxtD tb.TextSize=13 tb.Font=Enum.Font.GothamSemibold
    tb.TextXAlignment=Enum.TextXAlignment.Left tb.BorderSizePixel=0 tb.LayoutOrder=i
    Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 8)
    local pd = Instance.new("UIPadding", tb) pd.PaddingLeft = UDim.new(0, 10)
    TBtns[tn] = tb
    tb.MouseButton1Click:Connect(function()
        S.Tab = tn
        for n, b in pairs(TBtns) do
            if n==tn then TweenService:Create(b,TweenInfo.new(0.2),{BackgroundColor3=C.BtnA,BackgroundTransparency=0,TextColor3=C.Txt}):Play()
            else TweenService:Create(b,TweenInfo.new(0.2),{BackgroundColor3=C.Btn,BackgroundTransparency=0.3,TextColor3=C.TxtD}):Play() end
        end
        for _,ch in ipairs(MF:GetChildren()) do if ch.Name:sub(1,2)=="C_" then ch.Visible=(ch.Name=="C_"..tn) end end
    end)
    tb.MouseEnter:Connect(function() if S.Tab~=tn then TweenService:Create(tb,TweenInfo.new(0.15),{BackgroundTransparency=0.1}):Play() end end)
    tb.MouseLeave:Connect(function() if S.Tab~=tn then TweenService:Create(tb,TweenInfo.new(0.15),{BackgroundTransparency=0.3}):Play() end end)
end

-- UI BUILDERS
local function MkContent(name)
    local f = Instance.new("ScrollingFrame", MF)
    f.Name="C_"..name f.Size=UDim2.new(1,-145,1,-55) f.Position=UDim2.new(0,140,0,50)
    f.BackgroundTransparency=1 f.BorderSizePixel=0 f.ScrollBarThickness=3 f.ScrollBarImageColor3=C.Acc
    f.CanvasSize=UDim2.new(0,0,0,0) f.AutomaticCanvasSize=Enum.AutomaticSize.Y f.Visible=(name==S.Tab)
    local l = Instance.new("UIListLayout", f) l.SortOrder=Enum.SortOrder.LayoutOrder l.Padding=UDim.new(0,4)
    local p = Instance.new("UIPadding", f) p.PaddingTop=UDim.new(0,5) p.PaddingBottom=UDim.new(0,10) p.PaddingLeft=UDim.new(0,5) p.PaddingRight=UDim.new(0,10)
    return f
end

local function MkLabel(p, t, o)
    local l = Instance.new("TextLabel", p)
    l.Size=UDim2.new(1,0,0,20) l.BackgroundTransparency=1 l.Text="  "..t l.TextColor3=C.Acc
    l.TextSize=11 l.Font=Enum.Font.GothamBold l.TextXAlignment=Enum.TextXAlignment.Left l.LayoutOrder=o or 0
end

local function MkToggle(p, t, o, cb, regKey)
    local a = false
    local h = Instance.new("Frame", p) h.Size=UDim2.new(1,0,0,30) h.BackgroundColor3=C.Btn h.BackgroundTransparency=0.2 h.BorderSizePixel=0 h.LayoutOrder=o or 0
    Instance.new("UICorner", h).CornerRadius = UDim.new(0, 8)
    local l = Instance.new("TextLabel", h) l.Size=UDim2.new(1,-60,1,0) l.Position=UDim2.new(0,12,0,0) l.BackgroundTransparency=1 l.Text=t l.TextColor3=C.Txt l.TextSize=12 l.Font=Enum.Font.Gotham l.TextXAlignment=Enum.TextXAlignment.Left
    local bg = Instance.new("Frame", h) bg.Size=UDim2.new(0,40,0,20) bg.Position=UDim2.new(1,-50,0.5,-10) bg.BackgroundColor3=C.Sep bg.BorderSizePixel=0
    Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)
    local ci = Instance.new("Frame", bg) ci.Size=UDim2.new(0,14,0,14) ci.Position=UDim2.new(0,3,0.5,-7) ci.BackgroundColor3=C.TxtD ci.BorderSizePixel=0
    Instance.new("UICorner", ci).CornerRadius = UDim.new(1, 0)
    local bt = Instance.new("TextButton", h) bt.Size=UDim2.new(1,0,1,0) bt.BackgroundTransparency=1 bt.Text=""
    local function upd()
        if a then TweenService:Create(bg,TweenInfo.new(0.2),{BackgroundColor3=C.Ok}):Play() TweenService:Create(ci,TweenInfo.new(0.2),{Position=UDim2.new(1,-17,0.5,-7),BackgroundColor3=Color3.new(1,1,1)}):Play()
        else TweenService:Create(bg,TweenInfo.new(0.2),{BackgroundColor3=C.Sep}):Play() TweenService:Create(ci,TweenInfo.new(0.2),{Position=UDim2.new(0,3,0.5,-7),BackgroundColor3=C.TxtD}):Play() end
    end
    local function toggle() a=not a upd() if cb then cb(a) end end
    bt.MouseButton1Click:Connect(toggle)
    local ref = {Set=function(v) a=v upd() end, Get=function() return a end, Toggle=toggle}
    if regKey then S.Toggles[regKey] = ref end
    return ref
end

local function MkBtn(p, t, o, col, cb)
    local b = Instance.new("TextButton", p) b.Size=UDim2.new(1,0,0,30) b.BackgroundColor3=col or C.Btn b.BackgroundTransparency=0.1
    b.Text=t b.TextColor3=C.Txt b.TextSize=12 b.Font=Enum.Font.GothamSemibold b.BorderSizePixel=0 b.LayoutOrder=o or 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseEnter:Connect(function() TweenService:Create(b,TweenInfo.new(0.15),{BackgroundTransparency=0}):Play() end)
    b.MouseLeave:Connect(function() TweenService:Create(b,TweenInfo.new(0.15),{BackgroundTransparency=0.1}):Play() end)
    b.MouseButton1Click:Connect(function() if cb then cb() end end)
    return b
end

local function MkSlider(p, t, o, mn, mx, df, cb)
    local v = df or mn
    local h = Instance.new("Frame", p) h.Size=UDim2.new(1,0,0,48) h.BackgroundColor3=C.Btn h.BackgroundTransparency=0.2 h.BorderSizePixel=0 h.LayoutOrder=o or 0
    Instance.new("UICorner", h).CornerRadius = UDim.new(0, 8)
    local l = Instance.new("TextLabel", h) l.Size=UDim2.new(1,-50,0,18) l.Position=UDim2.new(0,12,0,2) l.BackgroundTransparency=1 l.Text=t l.TextColor3=C.Txt l.TextSize=11 l.Font=Enum.Font.Gotham l.TextXAlignment=Enum.TextXAlignment.Left
    local vl = Instance.new("TextLabel", h) vl.Size=UDim2.new(0,40,0,18) vl.Position=UDim2.new(1,-50,0,2) vl.BackgroundTransparency=1 vl.Text=tostring(math.floor(v)) vl.TextColor3=C.Acc vl.TextSize=11 vl.Font=Enum.Font.GothamBold vl.TextXAlignment=Enum.TextXAlignment.Right
    local sb = Instance.new("Frame", h) sb.Size=UDim2.new(1,-24,0,5) sb.Position=UDim2.new(0,12,0,30) sb.BackgroundColor3=C.Sep sb.BorderSizePixel=0
    Instance.new("UICorner", sb).CornerRadius = UDim.new(1, 0)
    local sf = Instance.new("Frame", sb) sf.Size=UDim2.new((v-mn)/(mx-mn),0,1,0) sf.BackgroundColor3=C.Acc sf.BorderSizePixel=0
    Instance.new("UICorner", sf).CornerRadius = UDim.new(1, 0)
    local sk = Instance.new("Frame", sb) sk.Size=UDim2.new(0,12,0,12) sk.Position=UDim2.new((v-mn)/(mx-mn),-6,0.5,-6) sk.BackgroundColor3=Color3.new(1,1,1) sk.BorderSizePixel=0 sk.ZIndex=2
    Instance.new("UICorner", sk).CornerRadius = UDim.new(1, 0)
    local sbt = Instance.new("TextButton", h) sbt.Size=UDim2.new(1,0,0,22) sbt.Position=UDim2.new(0,0,0,22) sbt.BackgroundTransparency=1 sbt.Text=""
    local sl = false
    sbt.MouseButton1Down:Connect(function() sl=true end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then sl=false end end)
    UIS.InputChanged:Connect(function(i)
        if sl and i.UserInputType==Enum.UserInputType.MouseMovement then
            local pc = math.clamp((i.Position.X-sb.AbsolutePosition.X)/sb.AbsoluteSize.X, 0, 1)
            v = math.floor(mn+(mx-mn)*pc) sf.Size=UDim2.new(pc,0,1,0) sk.Position=UDim2.new(pc,-6,0.5,-6) vl.Text=tostring(v)
            if cb then cb(v) end
        end
    end)
    return {Set=function(nv) v=math.clamp(nv,mn,mx) local pc=(v-mn)/(mx-mn) sf.Size=UDim2.new(pc,0,1,0) sk.Position=UDim2.new(pc,-6,0.5,-6) vl.Text=tostring(math.floor(v)) end}
end

local function MkTextInput(p, placeholder, o)
    local h = Instance.new("Frame", p) h.Size=UDim2.new(1,0,0,34) h.BackgroundColor3=C.Btn h.BackgroundTransparency=0.2 h.BorderSizePixel=0 h.LayoutOrder=o or 0
    Instance.new("UICorner", h).CornerRadius = UDim.new(0, 8)
    local tb = Instance.new("TextBox", h) tb.Size=UDim2.new(1,-16,1,-8) tb.Position=UDim2.new(0,8,0,4) tb.BackgroundTransparency=1
    tb.Text="" tb.PlaceholderText=placeholder tb.PlaceholderColor3=C.TxtD tb.TextColor3=C.Txt tb.TextSize=12 tb.Font=Enum.Font.Gotham tb.TextXAlignment=Enum.TextXAlignment.Left tb.ClearTextOnFocus=false
    return tb
end

-- ════════════════════════════════════
-- TAB: PLAYER
-- ════════════════════════════════════
local P1 = MkContent("Player")
MkLabel(P1, "MOVEMENT", 1)
MkSlider(P1, "Walk Speed", 2, 0, 500, 16, function(v) S.Speed=v local h=GetHum() if h then h.WalkSpeed=v end end)
MkSlider(P1, "Jump Power", 3, 0, 500, 50, function(v) S.Jump=v local h=GetHum() if h then h.JumpPower=v end end)

MkLabel(P1, "ABILITIES", 5)
MkToggle(P1, "God Mode  [G]", 6, function(a) S.God=a if a then Kill("God") S.Conns["God"]=RunService.Heartbeat:Connect(function() local h=GetHum() if h then h.Health=h.MaxHealth end end) Ntf("LCH","🛡 God Mode ON") else Kill("God") Ntf("LCH","🛡 God Mode OFF") end end, "God")

MkToggle(P1, "Fly  [F]", 7, function(a)
    S.Fly=a
    if a then
        Kill("Fly") local rp=GetRoot() if rp then
        local bv=Instance.new("BodyVelocity",rp) bv.MaxForce=Vector3.new(9e9,9e9,9e9) bv.Velocity=Vector3.zero
        local bg=Instance.new("BodyGyro",rp) bg.MaxTorque=Vector3.new(9e9,9e9,9e9) bg.P=9e4
        S.Conns["Fly"]=RunService.Heartbeat:Connect(function()
            if not S.Fly then return end local d=Vector3.zero
            if UIS:IsKeyDown(Enum.KeyCode.W) then d=d+Camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then d=d-Camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then d=d-Camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then d=d+Camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then d=d+Vector3.yAxis end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then d=d-Vector3.yAxis end
            if d.Magnitude>0 then d=d.Unit end bv.Velocity=d*S.FlySpd bg.CFrame=Camera.CFrame
        end) Ntf("LCH","✈ Fly ON (WASD+Space/Shift)") end
    else Kill("Fly") local rp=GetRoot() if rp then for _,o in ipairs(rp:GetChildren()) do if o:IsA("BodyVelocity") or o:IsA("BodyGyro") then o:Destroy() end end end Ntf("LCH","✈ Fly OFF") end
end, "Fly")

MkToggle(P1, "Noclip  [V]", 8, function(a) S.Noclip=a if a then Kill("NC") S.Conns["NC"]=RunService.Stepped:Connect(function() local c=GetChar() if c then for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end end) Ntf("LCH","👻 Noclip ON") else Kill("NC") Ntf("LCH","👻 Noclip OFF") end end, "Noclip")
MkToggle(P1, "Infinite Jump  [H]", 9, function(a) S.InfJump=a if a then Kill("IJ") S.Conns["IJ"]=UIS.JumpRequest:Connect(function() local h=GetHum() if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end) Ntf("LCH","🦘 Inf Jump ON") else Kill("IJ") Ntf("LCH","🦘 Inf Jump OFF") end end, "InfJump")

MkLabel(P1, "ACTIONS", 10)
MkBtn(P1, "🔄 Reset Character", 11, C.Warn, function() local h=GetHum() if h then h.Health=0 end end)
MkSlider(P1, "Fly Speed", 12, 10, 500, 80, function(v) S.FlySpd=v end)

-- ════════════════════════════════════
-- TAB: COMBAT
-- ════════════════════════════════════
local P2 = MkContent("Combat")
MkLabel(P2, "AIMBOT", 1)

local FOVCircle = Instance.new("Frame", SG)
FOVCircle.Size=UDim2.new(0,S.AimFOV*2,0,S.AimFOV*2) FOVCircle.Position=UDim2.new(0.5,-S.AimFOV,0.5,-S.AimFOV)
FOVCircle.BackgroundTransparency=1 FOVCircle.BorderSizePixel=0 FOVCircle.Visible=false
Instance.new("UICorner", FOVCircle).CornerRadius = UDim.new(1, 0)
local fvs = Instance.new("UIStroke", FOVCircle) fvs.Color=C.Bad fvs.Thickness=1.5 fvs.Transparency=0.3

local function GetTarget()
    local best, bestD = nil, S.AimFOV
    local sc = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    for _,pl in ipairs(Players:GetPlayers()) do
        if pl==LP or not pl.Character then continue end
        if S.AimTeam and pl.Team and LP.Team and pl.Team==LP.Team then continue end
        local tp = pl.Character:FindFirstChild(S.AimPart)
        if not tp then continue end
        local hm = pl.Character:FindFirstChildOfClass("Humanoid")
        if not hm or hm.Health<=0 then continue end
        if S.AimVis then
            local rp = RaycastParams.new() rp.FilterDescendantsInstances={LP.Character} rp.FilterType=Enum.RaycastFilterType.Exclude
            local r = Workspace:Raycast(Camera.CFrame.Position, tp.Position-Camera.CFrame.Position, rp)
            if r and r.Instance and not r.Instance:IsDescendantOf(pl.Character) then continue end
        end
        local sp, on = Camera:WorldToViewportPoint(tp.Position)
        if not on then continue end
        local d = (Vector2.new(sp.X,sp.Y)-sc).Magnitude
        if d<bestD then bestD=d best=pl end
    end
    return best
end

MkToggle(P2, "Aimbot (Hold Q / RMB)  [B]", 2, function(a)
    S.Aimbot=a if a then Kill("Aim")
    S.Conns["Aim"]=RunService.RenderStepped:Connect(function()
        if not S.Aimbot then return end
        if not UIS:IsKeyDown(C.AimKey) and not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then return end
        local t = GetTarget() if not t or not t.Character then return end
        local tp = t.Character:FindFirstChild(S.AimPart) if not tp then return end
        local tc = CFrame.new(Camera.CFrame.Position, tp.Position)
        Camera.CFrame = Camera.CFrame:Lerp(tc, 1/math.clamp(S.AimSmooth,1,50))
    end)
    FOVCircle.Visible = S.AimShowFOV Ntf("LCH","🎯 Aimbot ON")
    else Kill("Aim") FOVCircle.Visible=false Ntf("LCH","🎯 Aimbot OFF") end
end, "Aimbot")

MkLabel(P2, "SETTINGS", 3)
MkSlider(P2, "Aimbot FOV", 4, 20, 500, 120, function(v) S.AimFOV=v FOVCircle.Size=UDim2.new(0,v*2,0,v*2) FOVCircle.Position=UDim2.new(0.5,-v,0.5,-v) end)
MkSlider(P2, "Smoothness (1=Snap)", 5, 1, 50, 5, function(v) S.AimSmooth=v end)

MkLabel(P2, "TARGET PART", 6)
local tParts = {"Head","HumanoidRootPart","UpperTorso","LowerTorso"}
for i,pn in ipairs(tParts) do
    MkBtn(P2, (pn==S.AimPart and "✓ " or "  ")..pn, 6+i, pn==S.AimPart and C.BtnA or C.Btn, function()
        S.AimPart=pn
        for _,ch in ipairs(P2:GetChildren()) do if ch:IsA("TextButton") then for _,n in ipairs(tParts) do
            if ch.Text:find(n) then ch.Text=(n==pn and "✓ " or "  ")..n ch.BackgroundColor3=(n==pn and C.BtnA or C.Btn) end
        end end end
        Ntf("LCH","🎯 Target: "..pn)
    end)
end

MkLabel(P2, "OPTIONS", 12)
MkToggle(P2, "Team Check", 13, function(a) S.AimTeam=a end)
MkToggle(P2, "Wall Check", 14, function(a) S.AimVis=a end)
MkToggle(P2, "Show FOV Circle", 15, function(a) S.AimShowFOV=a FOVCircle.Visible=a and S.Aimbot end)

MkLabel(P2, "EXTRAS", 16)
MkToggle(P2, "Triggerbot (Auto Fire)  [T]", 17, function(a)
    S.Triggerbot=a
    if a then Kill("TB") S.Conns["TB"]=RunService.Heartbeat:Connect(function()
        local t = Mouse.Target if t then local m = t:FindFirstAncestorOfClass("Model")
        if m and m~=LP.Character and Players:GetPlayerFromCharacter(m) then
            pcall(function() local viu=game:GetService("VirtualInputManager")
            viu:SendMouseButtonEvent(Mouse.X,Mouse.Y,0,true,game,0) viu:SendMouseButtonEvent(Mouse.X,Mouse.Y,0,false,game,0) end)
        end end
    end) Ntf("LCH","🔫 Triggerbot ON") else Kill("TB") Ntf("LCH","🔫 Triggerbot OFF") end
end, "Triggerbot")
MkToggle(P2, "Auto Click (CPS Boost)", 18, function(a)
    if a then Kill("AC") S.Conns["AC"]=RunService.Heartbeat:Connect(function()
        pcall(function() local viu=game:GetService("VirtualInputManager") viu:SendMouseButtonEvent(Mouse.X,Mouse.Y,0,true,game,0) viu:SendMouseButtonEvent(Mouse.X,Mouse.Y,0,false,game,0) end)
    end) Ntf("LCH","🖱 Auto Click ON") else Kill("AC") Ntf("LCH","🖱 Auto Click OFF") end
end)
MkBtn(P2, "💀 Kill Aura (Activate Tools)", 19, C.Bad, function()
    pcall(function() for _,pl in ipairs(Players:GetPlayers()) do if pl~=LP and pl.Character then
        local tr=pl.Character:FindFirstChild("HumanoidRootPart") local mr=GetRoot()
        if tr and mr and (mr.Position-tr.Position).Magnitude<15 then local tl=LP.Character:FindFirstChildOfClass("Tool") if tl then tl:Activate() end end
    end end end) Ntf("LCH","💀 Kill Aura fired")
end)

-- ════════════════════════════════════
-- TAB: SERVER
-- ════════════════════════════════════
local P3 = MkContent("Server")
MkLabel(P3, "PLAYER LIST", 1)

local PLF = Instance.new("Frame", P3) PLF.Size=UDim2.new(1,0,0,110) PLF.BackgroundColor3=C.Btn PLF.BackgroundTransparency=0.3 PLF.BorderSizePixel=0 PLF.LayoutOrder=2
Instance.new("UICorner", PLF).CornerRadius = UDim.new(0, 8)
local PLS = Instance.new("ScrollingFrame", PLF) PLS.Size=UDim2.new(1,-8,1,-8) PLS.Position=UDim2.new(0,4,0,4) PLS.BackgroundTransparency=1 PLS.BorderSizePixel=0 PLS.ScrollBarThickness=2 PLS.AutomaticCanvasSize=Enum.AutomaticSize.Y
local pll = Instance.new("UIListLayout", PLS) pll.SortOrder=Enum.SortOrder.LayoutOrder pll.Padding=UDim.new(0,2)
local SelP = nil

local function RefreshPL()
    for _,c in ipairs(PLS:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for i,pl in ipairs(Players:GetPlayers()) do
        local pb = Instance.new("TextButton", PLS) pb.Size=UDim2.new(1,0,0,22) pb.BackgroundColor3=C.Sep pb.BackgroundTransparency=0.5
        pb.Text="  "..pl.Name.." ["..pl.DisplayName.."]" pb.TextColor3=C.Txt pb.TextSize=11 pb.Font=Enum.Font.Gotham pb.TextXAlignment=Enum.TextXAlignment.Left pb.BorderSizePixel=0 pb.LayoutOrder=i
        Instance.new("UICorner", pb).CornerRadius = UDim.new(0, 5)
        pb.MouseButton1Click:Connect(function() SelP=pl for _,c in ipairs(PLS:GetChildren()) do if c:IsA("TextButton") then c.BackgroundTransparency=0.5 c.BackgroundColor3=C.Sep end end pb.BackgroundTransparency=0 pb.BackgroundColor3=C.Acc Ntf("LCH","Selected: "..pl.Name) end)
    end
end
RefreshPL()

MkBtn(P3, "🔄 Refresh Players", 3, C.Btn, function() RefreshPL() end)
MkLabel(P3, "PLAYER ACTIONS", 4)
MkBtn(P3, "📍 Teleport to Player", 5, C.Acc, function() if SelP and SelP.Character and SelP.Character:FindFirstChild("HumanoidRootPart") then local r=GetRoot() if r then r.CFrame=SelP.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,5) Ntf("LCH","TP to "..SelP.Name) end else Ntf("LCH","⚠ Select a player first!") end end)
MkBtn(P3, "🎯 Spectate Player", 6, C.Btn, function() if SelP and SelP.Character then Camera.CameraSubject=SelP.Character:FindFirstChildOfClass("Humanoid") Ntf("LCH","Spectating "..SelP.Name) else Ntf("LCH","⚠ Select a player!") end end)
MkBtn(P3, "👁 Unspectate", 7, C.Btn, function() local h=GetHum() if h then Camera.CameraSubject=h end end)

MkLabel(P3, "SERVER INFO", 8)
MkBtn(P3, "📊 Server Info", 9, C.Btn, function() Ntf("Server","Players: "..#Players:GetPlayers().."/"..Players.MaxPlayers.."\nPlaceId: "..game.PlaceId.."\nJobId: "..game.JobId:sub(1,8).."...", 5) end)
MkBtn(P3, "🔁 Rejoin Server", 10, C.Warn, function() game:GetService("TeleportService"):Teleport(game.PlaceId, LP) end)

MkLabel(P3, "ANNOUNCEMENTS", 11)
local AnnBox = MkTextInput(P3, "Type announcement message here...", 12)

MkBtn(P3, "📢 Send Announcement (Everyone Sees)", 13, C.Warn, function()
    local msg = AnnBox.Text if msg=="" then Ntf("LCH","⚠ Type a message first!") return end
    -- Part with BillboardGui visible to ALL players
    local ap = Instance.new("Part", Workspace) ap.Name="Announcement" ap.Anchored=true ap.CanCollide=false ap.Transparency=1 ap.Size=Vector3.one ap.Position=Vector3.new(0,10000,0)
    local bb = Instance.new("BillboardGui", ap) bb.Size=UDim2.new(0,650,0,180) bb.AlwaysOnTop=true bb.MaxDistance=math.huge
    local bf = Instance.new("Frame", bb) bf.Size=UDim2.new(1,0,1,0) bf.BackgroundColor3=Color3.fromRGB(12,12,28) bf.BackgroundTransparency=0.12
    Instance.new("UICorner", bf).CornerRadius=UDim.new(0,14) local bs=Instance.new("UIStroke", bf) bs.Color=C.Acc bs.Thickness=2 bs.Transparency=0.3
    local tt = Instance.new("TextLabel", bf) tt.Size=UDim2.new(1,0,0,36) tt.Position=UDim2.new(0,0,0,8) tt.BackgroundTransparency=1 tt.Text="📢 SERVER ANNOUNCEMENT 📢" tt.TextColor3=C.Warn tt.TextSize=24 tt.Font=Enum.Font.GothamBold tt.TextStrokeTransparency=0.3 tt.TextStrokeColor3=Color3.new(0,0,0)
    local mt = Instance.new("TextLabel", bf) mt.Size=UDim2.new(1,-20,1,-55) mt.Position=UDim2.new(0,10,0,48) mt.BackgroundTransparency=1 mt.Text=msg mt.TextColor3=C.Txt mt.TextSize=18 mt.Font=Enum.Font.GothamSemibold mt.TextWrapped=true mt.TextStrokeTransparency=0.5 mt.TextStrokeColor3=Color3.new(0,0,0)
    local ac ac=RunService.Heartbeat:Connect(function() local cm=Workspace.CurrentCamera if cm then ap.Position=(cm.CFrame*CFrame.new(0,2,-18)).Position end end)
    task.delay(6, function() for i=0,1,0.05 do bf.BackgroundTransparency=0.12+0.88*i tt.TextTransparency=i mt.TextTransparency=i bs.Transparency=0.3+0.7*i task.wait(0.03) end ac:Disconnect() ap:Destroy() end)
    pcall(function() local h=Instance.new("Hint",Workspace) h.Text="📢 "..msg game:GetService("Debris"):AddItem(h,8) end)
    pcall(function() local cr=RS:FindFirstChild("DefaultChatSystemChatEvents") if cr then local sm=cr:FindFirstChild("SayMessageRequest") if sm then sm:FireServer("[📢 ANNOUNCEMENT] "..msg,"All") end end end)
    Ntf("LCH","📢 Announcement sent!") AnnBox.Text=""
end)
MkBtn(P3, "💬 Chat Spam Message", 14, C.Acc, function()
    local msg=AnnBox.Text if msg=="" then Ntf("LCH","⚠ Type a message!") return end
    pcall(function() local cr=RS:FindFirstChild("DefaultChatSystemChatEvents") if cr then local sm=cr:FindFirstChild("SayMessageRequest") if sm then for i=1,5 do sm:FireServer(msg,"All") task.wait(0.5) end end end end)
    Ntf("LCH","💬 Spam sent")
end)

-- ════════════════════════════════════
-- TAB: VISUAL
-- ════════════════════════════════════
local P4 = MkContent("Visual")
MkLabel(P4, "ESP & HIGHLIGHTS", 1)

local function ClearESP() for _,o in ipairs(S.ESPObj) do if o and o.Parent then o:Destroy() end end S.ESPObj={} end
local function MkESP(pl)
    if pl==LP or not pl.Character then return end
    local bb = Instance.new("BillboardGui", pl.Character) bb.Name="ESP" bb.Size=UDim2.new(0,140,0,50) bb.StudsOffset=Vector3.new(0,3,0) bb.AlwaysOnTop=true bb.Adornee=pl.Character:FindFirstChild("Head")
    local nl = Instance.new("TextLabel", bb) nl.Size=UDim2.new(1,0,0.35,0) nl.BackgroundTransparency=1 nl.Text=pl.DisplayName nl.TextColor3=C.Ok nl.TextSize=13 nl.Font=Enum.Font.GothamBold nl.TextStrokeTransparency=0.5 nl.TextStrokeColor3=Color3.new(0,0,0)
    local dl = Instance.new("TextLabel", bb) dl.Size=UDim2.new(1,0,0.25,0) dl.Position=UDim2.new(0,0,0.35,0) dl.BackgroundTransparency=1 dl.Text="0m" dl.TextColor3=C.Warn dl.TextSize=10 dl.Font=Enum.Font.Gotham dl.TextStrokeTransparency=0.5 dl.TextStrokeColor3=Color3.new(0,0,0)
    -- Health bar
    local hbg = Instance.new("Frame", bb) hbg.Size=UDim2.new(0.8,0,0,4) hbg.Position=UDim2.new(0.1,0,0.65,0) hbg.BackgroundColor3=C.Bad hbg.BorderSizePixel=0
    Instance.new("UICorner", hbg).CornerRadius=UDim.new(1,0)
    local hbf = Instance.new("Frame", hbg) hbf.Size=UDim2.new(1,0,1,0) hbf.BackgroundColor3=C.Ok hbf.BorderSizePixel=0
    Instance.new("UICorner", hbf).CornerRadius=UDim.new(1,0)
    local hl = Instance.new("Highlight", pl.Character) hl.Name="ESP_HL" hl.FillColor=Color3.fromRGB(255,0,0) hl.FillTransparency=0.7 hl.OutlineColor=C.Ok hl.OutlineTransparency=0
    table.insert(S.ESPObj, bb) table.insert(S.ESPObj, hl)
    local cn cn=RunService.Heartbeat:Connect(function()
        if not S.ESP or not pl.Character or not bb.Parent then cn:Disconnect() return end
        local mr=GetRoot() local tr=pl.Character:FindFirstChild("HumanoidRootPart") local hm=pl.Character:FindFirstChildOfClass("Humanoid")
        if mr and tr then local d=(mr.Position-tr.Position).Magnitude dl.Text=math.floor(d).."m"
            nl.TextColor3 = d<30 and C.Bad or d<80 and C.Warn or C.Ok
        end
        if hm then hbf.Size = UDim2.new(math.clamp(hm.Health/hm.MaxHealth,0,1),0,1,0) end
    end)
    table.insert(S.ESPObj, {Parent=true, Destroy=function() cn:Disconnect() end})
end

MkToggle(P4, "ESP (Players)  [X]", 2, function(a) S.ESP=a if a then for _,pl in ipairs(Players:GetPlayers()) do MkESP(pl) end Kill("ESPA") S.Conns["ESPA"]=Players.PlayerAdded:Connect(function(pl) pl.CharacterAdded:Connect(function() wait(1) if S.ESP then MkESP(pl) end end) end) Ntf("LCH","👁 ESP ON") else ClearESP() Kill("ESPA") Ntf("LCH","👁 ESP OFF") end end, "ESP")

MkLabel(P4, "LIGHTING", 5)
MkToggle(P4, "Fullbright  [N]", 6, function(a) S.Fullbright=a if a then Lighting.Brightness=2 Lighting.ClockTime=14 Lighting.FogEnd=100000 Lighting.GlobalShadows=false Ntf("LCH","☀ Fullbright ON") else Lighting.Brightness=1 Lighting.GlobalShadows=true Ntf("LCH","☀ Fullbright OFF") end end, "Fullbright")
MkToggle(P4, "No Fog", 7, function(a) if a then Lighting.FogStart=0 Lighting.FogEnd=999999 else Lighting.FogStart=0 Lighting.FogEnd=100000 end end)
MkSlider(P4, "Field of View", 8, 30, 120, 70, function(v) Camera.FieldOfView=v end)

-- ════════════════════════════════════
-- TAB: TELEPORT
-- ════════════════════════════════════
local P5 = MkContent("Teleport")
MkLabel(P5, "CLICK TELEPORT", 1)
local ctpA = false
MkToggle(P5, "Click Teleport (Ctrl+Click)  [Z]", 2, function(a) ctpA=a S.ClickTP=a Ntf("LCH","📌 Click TP "..(a and "ON" or "OFF")) end, "ClickTP")
Mouse.Button1Down:Connect(function() if ctpA and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then local r=GetRoot() if r and Mouse.Hit then r.CFrame=Mouse.Hit+Vector3.new(0,3,0) end end end)

MkLabel(P5, "WAYPOINTS", 3)
local WPs = {}
MkBtn(P5, "💾 Save Position", 4, C.Ok, function() local r=GetRoot() if r then table.insert(WPs,{N="WP #"..#WPs+1,CF=r.CFrame}) Ntf("LCH","Saved WP #"..#WPs) end end)
MkBtn(P5, "📍 TP to Last Waypoint", 5, C.Acc, function() if #WPs>0 then local r=GetRoot() if r then r.CFrame=WPs[#WPs].CF Ntf("LCH","TP to "..WPs[#WPs].N) end else Ntf("LCH","⚠ No waypoints!") end end)
MkBtn(P5, "🗑 Clear Waypoints", 6, C.Bad, function() WPs={} Ntf("LCH","Waypoints cleared") end)
MkLabel(P5, "QUICK TP", 7)
MkBtn(P5, "⬆ TP Up (+100 studs)", 8, C.Btn, function() local r=GetRoot() if r then r.CFrame=r.CFrame+Vector3.new(0,100,0) end end)
MkBtn(P5, "⬇ TP to Spawn", 9, C.Btn, function() local r=GetRoot() local sp=Workspace:FindFirstChildOfClass("SpawnLocation") if r then r.CFrame=sp and sp.CFrame+Vector3.new(0,5,0) or CFrame.new(0,50,0) end end)

-- ════════════════════════════════════
-- TAB: MISC
-- ════════════════════════════════════
local P6 = MkContent("Misc")
MkLabel(P6, "CHARACTER", 1)
MkBtn(P6, "🙈 Go Invisible (Local)", 2, C.Btn, function() local c=GetChar() if c then for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency=1 end end end end)
MkBtn(P6, "🙉 Go Visible", 3, C.Btn, function() local c=GetChar() if c then for _,p in ipairs(c:GetDescendants()) do if (p:IsA("BasePart") and p.Name~="HumanoidRootPart") or p:IsA("Decal") then p.Transparency=0 end end end end)

MkLabel(P6, "ANTI-AFK", 4)
MkToggle(P6, "Anti AFK  [J]", 5, function(a) S.AntiAFK=a if a then Kill("AAFK") local vu=game:GetService("VirtualUser") S.Conns["AAFK"]=LP.Idled:Connect(function() vu:CaptureController() vu:ClickButton2(Vector2.new()) end) Ntf("LCH","🔄 Anti-AFK ON") else Kill("AAFK") Ntf("LCH","🔄 Anti-AFK OFF") end end, "AntiAFK")

MkLabel(P6, "GUI CONTROL", 6)
MkBtn(P6, "🗑 Hide Game GUIs", 7, C.Bad, function() for _,g in ipairs(LP.PlayerGui:GetChildren()) do if g:IsA("ScreenGui") and g.Name~="LCHGui" then g.Enabled=false end end end)
MkBtn(P6, "🔄 Restore GUIs", 8, C.Ok, function() for _,g in ipairs(LP.PlayerGui:GetChildren()) do if g:IsA("ScreenGui") then g.Enabled=true end end end)

MkLabel(P6, "DESTROY", 9)
MkBtn(P6, "❌ Destroy Linux Menu", 10, C.Bad, function() for _,cn in pairs(S.Conns) do pcall(function() cn:Disconnect() end) end ClearESP() SG:Destroy() end)

-- SET DEFAULT TAB
local db = TBtns["Player"]
if db then db.BackgroundColor3=C.BtnA db.BackgroundTransparency=0 db.TextColor3=C.Txt end

-- ════════════════════════════════════
-- TAB: KEYBINDS (CUSTOMIZABLE)
-- ════════════════════════════════════
local P7 = MkContent("Keybinds")
MkLabel(P7, "CLICK A KEY TO REBIND", 1)

-- Default keybinds (for reset)
local KBDefaults = {
    Toggle    = Enum.KeyCode.RightShift,
    God       = Enum.KeyCode.G,
    Fly       = Enum.KeyCode.F,
    Noclip    = Enum.KeyCode.V,
    InfJump   = Enum.KeyCode.H,
    ESP       = Enum.KeyCode.X,
    Aimbot    = Enum.KeyCode.B,
    Fullbright= Enum.KeyCode.N,
    ClickTP   = Enum.KeyCode.Z,
    Triggerbot= Enum.KeyCode.T,
    AntiAFK   = Enum.KeyCode.J,
    TPWaypoint= Enum.KeyCode.P,
    SaveWP    = Enum.KeyCode.K,
    TPUp      = Enum.KeyCode.U,
}

-- Listening state for rebinding
local listeningFor = nil  -- which KB key we're rebinding
local listeningBtn = nil  -- the button UI element
local listeningConn = nil -- input connection

-- Nice name for KeyCode
local function KeyName(kc)
    local s = tostring(kc)
    return s:gsub("Enum.KeyCode.", "")
end

-- Rebindable keybind list: {KB_key, display_name}
local rebindList = {
    {"Toggle",     "Toggle Menu"},
    {"God",        "God Mode"},
    {"Fly",        "Fly"},
    {"Noclip",     "Noclip"},
    {"InfJump",    "Infinite Jump"},
    {"ESP",        "ESP"},
    {"Aimbot",     "Aimbot"},
    {"Fullbright", "Fullbright"},
    {"ClickTP",    "Click Teleport"},
    {"Triggerbot", "Triggerbot"},
    {"AntiAFK",    "Anti-AFK"},
    {"TPWaypoint", "TP to Waypoint"},
    {"SaveWP",     "Save Waypoint"},
    {"TPUp",       "TP Up (+100)"},
}

local kbButtons = {} -- store button refs for updating text

for idx, entry in ipairs(rebindList) do
    local kbKey, label = entry[1], entry[2]

    local row = Instance.new("Frame", P7)
    row.Size = UDim2.new(1, 0, 0, 30)
    row.BackgroundColor3 = C.Btn
    row.BackgroundTransparency = idx % 2 == 0 and 0.15 or 0.3
    row.BorderSizePixel = 0
    row.LayoutOrder = 1 + idx
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

    -- Action name label
    local descLbl = Instance.new("TextLabel", row)
    descLbl.Size = UDim2.new(0.55, 0, 1, 0)
    descLbl.Position = UDim2.new(0, 12, 0, 0)
    descLbl.BackgroundTransparency = 1
    descLbl.Text = label
    descLbl.TextColor3 = C.Txt
    descLbl.TextSize = 12
    descLbl.Font = Enum.Font.Gotham
    descLbl.TextXAlignment = Enum.TextXAlignment.Left

    -- Key button (clickable to rebind)
    local keyBtn = Instance.new("TextButton", row)
    keyBtn.Size = UDim2.new(0, 90, 0, 22)
    keyBtn.Position = UDim2.new(1, -100, 0.5, -11)
    keyBtn.BackgroundColor3 = C.Sep
    keyBtn.BackgroundTransparency = 0.2
    keyBtn.Text = "[" .. KeyName(KB[kbKey]) .. "]"
    keyBtn.TextColor3 = C.Acc
    keyBtn.TextSize = 11
    keyBtn.Font = Enum.Font.GothamBold
    keyBtn.BorderSizePixel = 0
    Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 6)

    kbButtons[kbKey] = keyBtn

    -- Hover effects
    keyBtn.MouseEnter:Connect(function()
        if listeningFor ~= kbKey then
            TweenService:Create(keyBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
        end
    end)
    keyBtn.MouseLeave:Connect(function()
        if listeningFor ~= kbKey then
            TweenService:Create(keyBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.2}):Play()
        end
    end)

    -- Click to start listening
    keyBtn.MouseButton1Click:Connect(function()
        -- Cancel previous listening
        if listeningConn then listeningConn:Disconnect() listeningConn = nil end
        if listeningBtn and listeningFor then
            listeningBtn.Text = "[" .. KeyName(KB[listeningFor]) .. "]"
            listeningBtn.TextColor3 = C.Acc
            TweenService:Create(listeningBtn, TweenInfo.new(0.2), {BackgroundColor3 = C.Sep}):Play()
        end

        -- Start listening for this key
        listeningFor = kbKey
        listeningBtn = keyBtn
        keyBtn.Text = "[ ... ]"
        keyBtn.TextColor3 = C.Warn
        TweenService:Create(keyBtn, TweenInfo.new(0.2), {BackgroundColor3 = C.Warn, BackgroundTransparency = 0.3}):Play()

        listeningConn = UIS.InputBegan:Connect(function(input, gpe)
            if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
            -- Escape cancels
            if input.KeyCode == Enum.KeyCode.Escape then
                keyBtn.Text = "[" .. KeyName(KB[kbKey]) .. "]"
                keyBtn.TextColor3 = C.Acc
                TweenService:Create(keyBtn, TweenInfo.new(0.2), {BackgroundColor3 = C.Sep}):Play()
                listeningFor = nil
                listeningBtn = nil
                listeningConn:Disconnect()
                listeningConn = nil
                Ntf("LCH", "❌ Rebind cancelled")
                return
            end

            -- Check for duplicate (another action already uses this key)
            local dupAction = nil
            for k, v in pairs(KB) do
                if v == input.KeyCode and k ~= kbKey then dupAction = k break end
            end
            if dupAction then
                -- Swap: give the other action our old key
                local oldKey = KB[kbKey]
                KB[dupAction] = oldKey
                if kbButtons[dupAction] then
                    kbButtons[dupAction].Text = "[" .. KeyName(oldKey) .. "]"
                end
            end

            -- Assign new key
            KB[kbKey] = input.KeyCode
            keyBtn.Text = "[" .. KeyName(input.KeyCode) .. "]"
            keyBtn.TextColor3 = C.Ok
            TweenService:Create(keyBtn, TweenInfo.new(0.3), {BackgroundColor3 = C.Ok, BackgroundTransparency = 0.3}):Play()

            -- Flash green then back to normal
            task.delay(0.5, function()
                keyBtn.TextColor3 = C.Acc
                TweenService:Create(keyBtn, TweenInfo.new(0.3), {BackgroundColor3 = C.Sep, BackgroundTransparency = 0.2}):Play()
            end)

            Ntf("LCH", "⌨ " .. label .. " → [" .. KeyName(input.KeyCode) .. "]" .. (dupAction and (" (swapped with " .. dupAction .. ")") or ""))
            listeningFor = nil
            listeningBtn = nil
            listeningConn:Disconnect()
            listeningConn = nil
        end)
    end)
end

MkLabel(P7, "ACTIONS", #rebindList + 3)

-- Reset all keybinds to default
MkBtn(P7, "🔄 Reset All to Default", #rebindList + 4, C.Warn, function()
    for k, v in pairs(KBDefaults) do
        KB[k] = v
        if kbButtons[k] then
            kbButtons[k].Text = "[" .. KeyName(v) .. "]"
            kbButtons[k].TextColor3 = C.Acc
        end
    end
    Ntf("LCH", "⌨ All keybinds reset to default!")
end)

MkLabel(P7, "INFO", #rebindList + 6)
local tipLbl = Instance.new("TextLabel", P7)
tipLbl.Size = UDim2.new(1, 0, 0, 42)
tipLbl.BackgroundTransparency = 1
tipLbl.Text = "Click a [Key] button, then press the new key.\nPress ESC to cancel. Duplicates are auto-swapped.\nKeybinds work when chat is NOT focused."
tipLbl.TextColor3 = C.TxtD
tipLbl.TextSize = 10
tipLbl.Font = Enum.Font.Gotham
tipLbl.TextWrapped = true
tipLbl.TextXAlignment = Enum.TextXAlignment.Left
tipLbl.LayoutOrder = #rebindList + 7
local tipPad = Instance.new("UIPadding", tipLbl)
tipPad.PaddingLeft = UDim.new(0, 6)

-- KEYBIND HANDLER
UIS.InputBegan:Connect(function(i, gp)
    if gp then return end

    -- Menu toggle
    if i.KeyCode == KB.Toggle then
        S.Open = not S.Open
        MF.Visible = S.Open
        return
    end

    -- Toggle features via keybind
    local keyMap = {
        [KB.God]       = "God",
        [KB.Fly]       = "Fly",
        [KB.Noclip]    = "Noclip",
        [KB.InfJump]   = "InfJump",
        [KB.ESP]       = "ESP",
        [KB.Aimbot]    = "Aimbot",
        [KB.Fullbright]= "Fullbright",
        [KB.ClickTP]   = "ClickTP",
        [KB.Triggerbot]= "Triggerbot",
        [KB.AntiAFK]   = "AntiAFK",
    }

    local toggleName = keyMap[i.KeyCode]
    if toggleName and S.Toggles[toggleName] then
        S.Toggles[toggleName].Toggle()
        return
    end

    -- Action keybinds (non-toggle)
    if i.KeyCode == KB.TPWaypoint then
        if #WPs > 0 then
            local r = GetRoot()
            if r then r.CFrame = WPs[#WPs].CF Ntf("LCH", "📍 TP to " .. WPs[#WPs].N) end
        else Ntf("LCH", "⚠ No waypoints saved!") end
    elseif i.KeyCode == KB.SaveWP then
        local r = GetRoot()
        if r then table.insert(WPs, {N = "WP #" .. #WPs + 1, CF = r.CFrame}) Ntf("LCH", "💾 Saved WP #" .. #WPs) end
    elseif i.KeyCode == KB.TPUp then
        local r = GetRoot()
        if r then r.CFrame = r.CFrame + Vector3.new(0, 100, 0) Ntf("LCH", "⬆ TP Up +100") end
    end
end)

-- WATERMARK
local wm = Instance.new("TextLabel", SG)
wm.Size=UDim2.new(0,260,0,26) wm.Position=UDim2.new(1,-270,0,5) wm.BackgroundColor3=C.Bg wm.BackgroundTransparency=0.3
wm.Text="  ⚡ LINUX COMMUNITY HACK "..C.Ver.." | FPS: --" wm.TextColor3=C.Txt wm.TextSize=10 wm.Font=Enum.Font.GothamSemibold wm.TextXAlignment=Enum.TextXAlignment.Left wm.BorderSizePixel=0
Instance.new("UICorner", wm).CornerRadius = UDim.new(0, 6)
local wmst = Instance.new("UIStroke", wm) wmst.Color=C.Acc wmst.Thickness=1 wmst.Transparency=0.6

local fc,lt = 0, tick()
RunService.Heartbeat:Connect(function() fc=fc+1 if tick()-lt>=1 then wm.Text="  ⚡ LINUX COMMUNITY HACK "..C.Ver.." | FPS: "..fc fc=0 lt=tick() end end)

Ntf("⚡ LINUX COMMUNITY HACK", "Menu loaded! RightShift=Toggle | See Keybinds tab", 5)
print("⚡ LINUX COMMUNITY HACK v4.0 Loaded | RightShift = Toggle | Keybinds: G,F,V,H,X,B,N,Z,T,J,P,K,U")

