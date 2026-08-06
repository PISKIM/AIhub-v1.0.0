-- ==========================================
-- 手机Delta专用 AI创意生成器
-- 触屏优化 | 可拖动 | 可最小化
-- ==========================================

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")

-- 检测是否触屏
local isTouch = UIS.TouchEnabled

-- 创建UI
local SG = Instance.new("ScreenGui")
SG.Name = "AIMaster"
SG.ResetOnSpawn = false
SG.Parent = Player:FindFirstChild("PlayerGui") or Player:WaitForChild("PlayerGui")

-- 主窗口
local MF = Instance.new("Frame")
MF.Size = UDim2.new(0, 300, 0, 320)
MF.Position = UDim2.new(0.5, -150, 0.15, 0)
MF.BackgroundColor3 = Color3.fromRGB(10, 10, 28)
MF.BackgroundTransparency = 0.05
MF.BorderSizePixel = 0
MF.ClipsDescendants = true
MF.Parent = SG

local C = Instance.new("UICorner")
C.CornerRadius = UDim.new(0, 14)
C.Parent = MF

-- 标题栏
local TB = Instance.new("Frame")
TB.Size = UDim2.new(1, 0, 0, 40)
TB.BackgroundColor3 = Color3.fromRGB(35, 35, 65)
TB.BackgroundTransparency = 0.1
TB.BorderSizePixel = 0
TB.Parent = MF
local TC = Instance.new("UICorner")
TC.CornerRadius = UDim.new(0, 14)
TC.Parent = TB

local TL = Instance.new("TextLabel")
TL.Size = UDim2.new(0.5, 0, 1, 0)
TL.Position = UDim2.new(0.05, 0, 0, 0)
TL.BackgroundTransparency = 1
TL.Text = "🧠 AI"
TL.TextColor3 = Color3.fromRGB(255, 255, 255)
TL.TextSize = 18
TL.TextXAlignment = Enum.TextXAlignment.Left
TL.Font = Enum.Font.SourceSansBold
TL.Parent = TB

-- 最小化
local MB = Instance.new("TextButton")
MB.Size = UDim2.new(0, 34, 0, 34)
MB.Position = UDim2.new(1, -72, 0, 3)
MB.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
MB.BackgroundTransparency = 0.2
MB.Text = "➖"
MB.TextColor3 = Color3.fromRGB(255, 255, 255)
MB.TextSize = 18
MB.Font = Enum.Font.SourceSansBold
MB.BorderSizePixel = 0
MB.Parent = TB
local MC = Instance.new("UICorner")
MC.CornerRadius = UDim.new(0, 8)
MC.Parent = MB

-- 关闭
local CB = Instance.new("TextButton")
CB.Size = UDim2.new(0, 34, 0, 34)
CB.Position = UDim2.new(1, -36, 0, 3)
CB.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CB.BackgroundTransparency = 0.15
CB.Text = "✕"
CB.TextColor3 = Color3.fromRGB(255, 255, 255)
CB.TextSize = 16
CB.Font = Enum.Font.SourceSansBold
CB.BorderSizePixel = 0
CB.Parent = TB
local CC = Instance.new("UICorner")
CC.CornerRadius = UDim.new(0, 8)
CC.Parent = CB

-- 输入框
local IF = Instance.new("Frame")
IF.Size = UDim2.new(1, -16, 0, 44)
IF.Position = UDim2.new(0, 8, 0, 48)
IF.BackgroundTransparency = 1
IF.Parent = MF

local IB = Instance.new("TextBox")
IB.Size = UDim2.new(0.6, -5, 1, 0)
IB.Position = UDim2.new(0, 0, 0, 0)
IB.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
IB.TextColor3 = Color3.fromRGB(255, 255, 255)
IB.PlaceholderText = "输入指令..."
IB.PlaceholderColor3 = Color3.fromRGB(150, 150, 190)
IB.TextSize = 16
IB.Font = Enum.Font.SourceSans
IB.ClearTextOnFocus = false
IB.BorderSizePixel = 0
IB.Parent = IF
local IC = Instance.new("UICorner")
IC.CornerRadius = UDim.new(0, 8)
IC.Parent = IB

local EB = Instance.new("TextButton")
EB.Size = UDim2.new(0.38, 0, 1, 0)
EB.Position = UDim2.new(0.62, 5, 0, 0)
EB.BackgroundColor3 = Color3.fromRGB(200, 100, 255)
EB.Text = "执行"
EB.TextColor3 = Color3.fromRGB(255, 255, 255)
EB.TextSize = 16
EB.Font = Enum.Font.SourceSansBold
EB.BorderSizePixel = 0
EB.Parent = IF
local EC = Instance.new("UICorner")
EC.CornerRadius = UDim.new(0, 8)
EC.Parent = EB

-- 快捷按钮（两行，触屏友好）
local QF = Instance.new("Frame")
QF.Size = UDim2.new(1, -16, 0, 78)
QF.Position = UDim2.new(0, 8, 0, 100)
QF.BackgroundTransparency = 1
QF.Parent = MF

local function qb(t, x, y, w, c)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(w or 0.23, 0, 0.44, 0)
    b.Position = UDim2.new(x, 0, y, 0)
    b.BackgroundColor3 = c or Color3.fromRGB(60, 60, 100)
    b.Text = t
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 14
    b.Font = Enum.Font.SourceSansBold
    b.BorderSizePixel = 0
    b.Parent = QF
    local n = Instance.new("UICorner")
    n.CornerRadius = UDim.new(0, 8)
    n.Parent = b
    return b
end

-- 第一行
local b1 = qb("💃跳舞", 0, 0, 0.23, Color3.fromRGB(255, 150, 50))
local b2 = qb("🕊️飞行", 0.255, 0, 0.23, Color3.fromRGB(100, 200, 255))
local b3 = qb("🌈彩虹", 0.51, 0, 0.23, Color3.fromRGB(200, 100, 255))
local b4 = qb("🧱生成", 0.765, 0, 0.23, Color3.fromRGB(180, 70, 220))

-- 第二行
local b5 = qb("💥爆炸", 0, 0.56, 0.23, Color3.fromRGB(220, 80, 80))
local b6 = qb("👥分身", 0.255, 0.56, 0.23, Color3.fromRGB(80, 200, 100))
local b7 = qb("🌤️天气", 0.51, 0.56, 0.23, Color3.fromRGB(70, 180, 220))
local b8 = qb("🌙夜晚", 0.765, 0.56, 0.23, Color3.fromRGB(150, 80, 200))

-- 底部额外按钮
local EF = Instance.new("Frame")
EF.Size = UDim2.new(1, -16, 0, 34)
EF.Position = UDim2.new(0, 8, 0, 186)
EF.BackgroundTransparency = 1
EF.Parent = MF

local b9 = qb("🌐全服", 0, 0, 0.32, Color3.fromRGB(255, 80, 180))
b9.Parent = EF
b9.Size = UDim2.new(0.32, 0, 1, 0)
b9.TextSize = 14

local b10 = qb("🎲随机", 0.34, 0, 0.32, Color3.fromRGB(255, 180, 50))
b10.Parent = EF
b10.Size = UDim2.new(0.32, 0, 1, 0)
b10.TextSize = 14

local b11 = qb("🧹清空", 0.68, 0, 0.32, Color3.fromRGB(200, 60, 60))
b11.Parent = EF
b11.Size = UDim2.new(0.32, 0, 1, 0)
b11.TextSize = 14

-- 日志
local LF = Instance.new("Frame")
LF.Size = UDim2.new(1, -16, 0, 78)
LF.Position = UDim2.new(0, 8, 0, 228)
LF.BackgroundColor3 = Color3.fromRGB(8, 8, 22)
LF.BackgroundTransparency = 0.15
LF.BorderSizePixel = 0
LF.Parent = MF
local LFC = Instance.new("UICorner")
LFC.CornerRadius = UDim.new(0, 8)
LFC.Parent = LF

local LB = Instance.new("ScrollingFrame")
LB.Size = UDim2.new(1, -8, 1, -4)
LB.Position = UDim2.new(0, 4, 0, 2)
LB.BackgroundTransparency = 1
LB.BorderSizePixel = 0
LB.ScrollBarThickness = 3
LB.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 160)
LB.Parent = LF

local LL = Instance.new("UIListLayout")
LL.Padding = UDim.new(0, 2)
LL.SortOrder = Enum.SortOrder.LayoutOrder
LL.Parent = LB

-- 状态栏
local SB = Instance.new("Frame")
SB.Size = UDim2.new(1, 0, 0, 28)
SB.Position = UDim2.new(0, 0, 1, -28)
SB.BackgroundColor3 = Color3.fromRGB(30, 30, 55)
SB.BackgroundTransparency = 0.15
SB.BorderSizePixel = 0
SB.Parent = MF
local SC = Instance.new("UICorner")
SC.CornerRadius = UDim.new(0, 14)
SC.Parent = SB

local SL = Instance.new("TextLabel")
SL.Size = UDim2.new(1, -10, 1, 0)
SL.Position = UDim2.new(0, 5, 0, 0)
SL.BackgroundTransparency = 1
SL.Text = "✅ 就绪"
SL.TextColor3 = Color3.fromRGB(150, 150, 210)
SL.TextSize = 13
SL.TextXAlignment = Enum.TextXAlignment.Left
SL.Font = Enum.Font.SourceSans
SL.Parent = SB

-- 变量
local isMin = false
local minSize = UDim2.new(0, 300, 0, 40)
local expSize = UDim2.new(0, 300, 0, 320)

-- ===== 日志 =====
local function log(msg, color)
    color = color or Color3.fromRGB(200, 200, 255)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 0, 18)
    l.BackgroundTransparency = 1
    l.Text = msg
    l.TextColor3 = color
    l.TextSize = 12
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Font = Enum.Font.SourceSans
    l.Parent = LB
    task.wait(0.05)
    LB.CanvasPosition = Vector2.new(0, LB.CanvasSize.Y.Offset)
    local kids = LB:GetChildren()
    for i = 1, #kids - 25 do
        if kids[i]:IsA("TextLabel") then kids[i]:Destroy() end
    end
end

local function setStatus(txt, err)
    SL.Text = txt
    SL.TextColor3 = err and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(150, 150, 210)
end

-- ===== AI引擎 =====
local function genCode(cmd)
    cmd = string.lower(cmd)
    
    if string.find(cmd, "舞") then
        return [[
            local p=game.Players.LocalPlayer
            local c=p.Character or p.CharacterAdded:Wait()
            local h=c:FindFirstChild("Humanoid")
            if h then
                for i=1,10 do
                    h:ChangeState(Enum.HumanoidStateType.Running)
                    task.wait(0.06)
                    h:ChangeState(Enum.HumanoidStateType.Jumping)
                    task.wait(0.06)
                end
            end
        ]]
    end
    
    if string.find(cmd, "飞") then
        return [[
            local p=game.Players.LocalPlayer
            local c=p.Character or p.CharacterAdded:Wait()
            local r=c:FindFirstChild("HumanoidRootPart")
            if r then
                local b=Instance.new("BodyVelocity")
                b.Velocity=Vector3.new(0,25,0)
                b.MaxForce=Vector3.new(0,4000,0)
                b.Parent=r
                task.wait(2)
                b:Destroy()
            end
        ]]
    end
    
    if string.find(cmd, "彩") or string.find(cmd, "虹") then
        return [[
            local p=game.Players.LocalPlayer
            local c=p.Character or p.CharacterAdded:Wait()
            for _,x in ipairs(c:GetDescendants()) do
                if x:IsA("BasePart") and x.Name~="HumanoidRootPart" then
                    x.Color=Color3.fromHSV(math.random(),1,1)
                end
            end
        ]]
    end
    
    if string.find(cmd, "生") or string.find(cmd, "造") then
        return [[
            local p=game.Players.LocalPlayer
            local c=p.Character or p.CharacterAdded:Wait()
            local r=c:FindFirstChild("HumanoidRootPart")
            if r then
                for i=1,3 do
                    local x=Instance.new("Part")
                    x.Size=Vector3.new(2.5,2.5,2.5)
                    x.Position=r.Position+Vector3.new(math.random(-5,5),4+math.random(0,3),math.random(-5,5))
                    x.Anchored=true
                    x.BrickColor=BrickColor.Random()
                    x.Material=Enum.Material.Neon
                    x.Parent=workspace
                    task.delay(5,function() x:Destroy() end)
                end
            end
        ]]
    end
    
    if string.find(cmd, "爆") or string.find(cmd, "炸") then
        return [[
            local p=game.Players.LocalPlayer
            local c=p.Character or p.CharacterAdded:Wait()
            local r=c:FindFirstChild("HumanoidRootPart")
            if r then
                local e=Instance.new("Explosion")
                e.Position=r.Position
                e.BlastRadius=15
                e.Parent=workspace
            end
        ]]
    end
    
    if string.find(cmd, "分") or string.find(cmd, "克隆") then
        return [[
            local p=game.Players.LocalPlayer
            local c=p.Character or p.CharacterAdded:Wait()
            if c then
                for i=1,3 do
                    local x=c:Clone()
                    x.Parent=workspace
                    x.HumanoidRootPart.CFrame=c.HumanoidRootPart.CFrame+Vector3.new(i*5-7,0,0)
                    task.delay(4,function() x:Destroy() end)
                end
            end
        ]]
    end
    
    if string.find(cmd, "天") or string.find(cmd, "雨") then
        return [[
            Lighting.Brightness=0.5
            Lighting.ClockTime=12
            Lighting.FogEnd=300
            local r=Instance.new("ReverbEffect")
            r.Parent=workspace
            task.delay(8,function() r:Destroy() end)
        ]]
    end
    
    if string.find(cmd, "夜") or string.find(cmd, "晚") or string.find(cmd, "黑") then
        return [[
            Lighting.Brightness=0.2
            Lighting.ClockTime=0
            Lighting.FogEnd=200
            Lighting.OutdoorAmbient=Color3.new(0.1,0.1,0.2)
        ]]
    end
    
    if string.find(cmd, "跳") then
        return [[
            local p=game.Players.LocalPlayer
            local c=p.Character or p.CharacterAdded:Wait()
            local h=c:FindFirstChild("Humanoid")
            if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
        ]]
    end
    
    if string.find(cmd, "走") or string.find(cmd, "进") then
        return [[
            local p=game.Players.LocalPlayer
            local c=p.Character or p.CharacterAdded:Wait()
            local r=c:FindFirstChild("HumanoidRootPart")
            local h=c:FindFirstChild("Humanoid")
            if r and h then h:MoveTo(r.Position+r.CFrame.LookVector*20) end
        ]]
    end
    
    if string.find(cmd, "传") or string.find(cmd, "瞬") then
        return [[
            local p=game.Players.LocalPlayer
            local c=p.Character or p.CharacterAdded:Wait()
            local r=c:FindFirstChild("HumanoidRootPart")
            if r then
                r.CFrame=CFrame.new(r.Position+Vector3.new(math.random(-40,40),10,math.random(-40,40)))
            end
        ]]
    end
    
    if string.find(cmd, "全服") then
        local es = {
            [[
                for _,p in ipairs(game.Players:GetPlayers()) do
                    if p.Character then
                        for _,x in ipairs(p.Character:GetDescendants()) do
                            if x:IsA("BasePart") and x.Name~="HumanoidRootPart" then
                                x.Color=Color3.fromHSV(math.random(),1,1)
                            end
                        end
                    end
                end
            ]],
            [[
                for _,p in ipairs(game.Players:GetPlayers()) do
                    if p.Character then
                        for _,x in ipairs(p.Character:GetDescendants()) do
                            if x:IsA("BasePart") then
                                x.Material=Enum.Material.Neon
                            end
                        end
                    end
                end
            ]],
            [[Lighting.Brightness=0.2 Lighting.ClockTime=0 Lighting.FogEnd=150]]
        }
        return es[math.random(#es)]
    end
    
    if string.find(cmd, "清空") then
        return [[
            for _,x in ipairs(workspace:GetChildren()) do
                if x:IsA("Part") and x.Anchored and x.Name~="Baseplate" then
                    if not x.Parent:IsA("Model") or not x.Parent:FindFirstChild("Humanoid") then
                        x:Destroy()
                    end
                end
            end
        ]]
    end
    
    if string.find(cmd, "帮助") then
        log("📖 指令: 跳舞 飞行 彩虹 生成 爆炸 分身 天气 夜晚 跳 走 传送 全服 清空", Color3.fromRGB(200, 200, 255))
        return "print('帮助已显示')"
    end
    
    return cmd
end

-- ===== 执行 =====
local function exec(cmd)
    if not cmd or cmd == "" then
        setStatus("⚠️ 输入指令", true)
        return
    end
    
    setStatus("🧠 生成中...")
    log("💬 " .. cmd, Color3.fromRGB(255, 200, 100))
    
    local code = genCode(cmd)
    log("📝 " .. string.sub(code, 1, 35) .. (#code > 35 and "..." or ""), Color3.fromRGB(150, 200, 255))
    
    local s, e = pcall(function()
        local f = loadstring(code)
        if f then
            f()
            setStatus("✅ 成功")
            log("✅ 成功", Color3.fromRGB(100, 255, 150))
        else
            error("编译失败")
        end
    end)
    
    if not s then
        setStatus("❌ " .. tostring(e), true)
        log("❌ " .. tostring(e), Color3.fromRGB(255, 100, 100))
    end
end

-- ===== 按钮绑定 =====
EB.MouseButton1Click:Connect(function()
    local t = IB.Text
    IB.Text = ""
    exec(t)
end)

IB.FocusLost:Connect(function(e)
    if e then
        local t = IB.Text
        IB.Text = ""
        exec(t)
    end
end)

b1.MouseButton1Click:Connect(function() exec("跳舞") end)
b2.MouseButton1Click:Connect(function() exec("飞行") end)
b3.MouseButton1Click:Connect(function() exec("彩虹") end)
b4.MouseButton1Click:Connect(function() exec("生成") end)
b5.MouseButton1Click:Connect(function() exec("爆炸") end)
b6.MouseButton1Click:Connect(function() exec("分身") end)
b7.MouseButton1Click:Connect(function() exec("天气") end)
b8.MouseButton1Click:Connect(function() exec("夜晚") end)

b9.MouseButton1Click:Connect(function()
    local opts = {"全服彩虹", "全服发光", "全服黑夜"}
    exec(opts[math.random(#opts)])
end)

b10.MouseButton1Click:Connect(function()
    local acts = {"跳舞","飞行","彩虹","生成","爆炸","分身","传送","跳跃"}
    local c = {}
    for i = 1, math.random(2, 3) do
        table.insert(c, acts[math.random(#acts)])
    end
    log("🎲 随机: " .. table.concat(c, "+"), Color3.fromRGB(255, 180, 255))
    exec(table.concat(c, " "))
end)

b11.MouseButton1Click:Connect(function() exec("清空") end)

-- ===== 拖动 =====
local drag = false
local ds = nil
local sp = nil

TB.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = true
        ds = i.Position
        sp = MF.Position
    end
end)

UIS.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
        local d = i.Position - ds
        MF.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
    end
end)

UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = false
    end
end)

-- ===== 最小化/关闭 =====
MB.MouseButton1Click:Connect(function()
    isMin = not isMin
    local target = isMin and minSize or expSize
    MB.Text = isMin and "➕" or "➖"
    local tw = TS:Create(MF, TweenInfo.new(0.3, Enum.EasingStyle.Quad), { Size = target })
    tw:Play()
    for _, child in ipairs(MF:GetChildren()) do
        if child ~= TB then
            child.Visible = not isMin
        end
    end
end)

CB.MouseButton1Click:Connect(function()
    SG:Destroy()
end)

-- ===== 启动 =====
log("🧠 AI大师已加载", Color3.fromRGB(100, 200, 255))
log("📱 手机触屏优化版", Color3.fromRGB(150, 200, 200))
log("💡 点击按钮或输入指令", Color3.fromRGB(150, 150, 200))
setStatus("✅ 就绪")

print("AI大师已加载")
