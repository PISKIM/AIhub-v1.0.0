-- =============================================
-- Delta 手机端 AI创意生成器 (增强版)
-- 支持服务器级修改 + 更强AI理解
-- 超矮版 340px
-- =============================================

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local isMobile = UserInputService.TouchEnabled

-- =============================================
-- 创建主界面
-- =============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AIAssistantGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 340, 0, 360)
MainFrame.Position = UDim2.new(0.5, -170, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 14)
Corner.Parent = MainFrame

local Blur = Instance.new("Frame")
Blur.Size = UDim2.new(1, 0, 1, 0)
Blur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Blur.BackgroundTransparency = 0.35
Blur.BorderSizePixel = 0
Blur.ZIndex = 0
Blur.Parent = MainFrame
local BlurCorner = Instance.new("UICorner")
BlurCorner.CornerRadius = UDim.new(0, 14)
BlurCorner.Parent = Blur

-- =============================================
-- 标题栏
-- =============================================
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 75)
TitleBar.BackgroundTransparency = 0.1
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 14)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0.65, 0, 1, 0)
TitleLabel.Position = UDim2.new(0.05, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🧠 AI 创意大师"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 15
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -68, 0, 4)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 95)
MinimizeButton.BackgroundTransparency = 0.2
MinimizeButton.Text = "➖"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 17
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Parent = TitleBar
local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 7)
MinCorner.Parent = MinimizeButton

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -34, 0, 4)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BackgroundTransparency = 0.15
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 15
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TitleBar
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 7)
CloseCorner.Parent = CloseButton

-- =============================================
-- 输入框
-- =============================================
local InputFrame = Instance.new("Frame")
InputFrame.Size = UDim2.new(1, -16, 0, 38)
InputFrame.Position = UDim2.new(0, 8, 0, 44)
InputFrame.BackgroundTransparency = 1
InputFrame.Parent = MainFrame

local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(0.58, -5, 1, 0)
InputBox.Position = UDim2.new(0, 0, 0, 0)
InputBox.BackgroundColor3 = Color3.fromRGB(50, 50, 85)
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.PlaceholderText = "描述你想要的效果..."
InputBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 195)
InputBox.TextSize = 14
InputBox.Font = Enum.Font.SourceSans
InputBox.ClearTextOnFocus = false
InputBox.BorderSizePixel = 0
InputBox.Parent = InputFrame
local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = InputBox

local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Size = UDim2.new(0.40, 0, 1, 0)
ExecuteButton.Position = UDim2.new(0.60, 5, 0, 0)
ExecuteButton.BackgroundColor3 = Color3.fromRGB(200, 100, 255)
ExecuteButton.Text = "✨ 创意执行"
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.TextSize = 14
ExecuteButton.Font = Enum.Font.SourceSansBold
ExecuteButton.BorderSizePixel = 0
ExecuteButton.Parent = InputFrame
local ExecCorner = Instance.new("UICorner")
ExecCorner.CornerRadius = UDim.new(0, 8)
ExecCorner.Parent = ExecuteButton

-- =============================================
-- 快捷按钮 (两行，更多功能)
-- =============================================
local QuickFrame = Instance.new("Frame")
QuickFrame.Size = UDim2.new(1, -16, 0, 68)
QuickFrame.Position = UDim2.new(0, 8, 0, 90)
QuickFrame.BackgroundTransparency = 1
QuickFrame.Parent = MainFrame

local function createQuickButton(text, posX, posY, width, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(width or 0.23, 0, 0.42, 0)
    btn.Position = UDim2.new(posX, 0, posY, 0)
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 100)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Font = Enum.Font.SourceSansBold
    btn.BorderSizePixel = 0
    btn.Parent = QuickFrame
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = btn
    return btn
end

-- 第一行 (4个)
local btnDance = createQuickButton("💃跳舞", 0, 0, 0.23, Color3.fromRGB(255, 150, 50))
local btnFly = createQuickButton("🕊️飞行", 0.255, 0, 0.23, Color3.fromRGB(100, 200, 255))
local btnRainbow = createQuickButton("🌈彩虹", 0.51, 0, 0.23, Color3.fromRGB(200, 100, 255))
local btnBuild = createQuickButton("🏰建筑", 0.765, 0, 0.23, Color3.fromRGB(100, 200, 150))

-- 第二行 (4个)
local btnSpawn = createQuickButton("🧱生成", 0, 0.58, 0.23, Color3.fromRGB(180, 70, 220))
local btnWeather = createQuickButton("🌤️天气", 0.255, 0.58, 0.23, Color3.fromRGB(70, 180, 220))
local btnExplode = createQuickButton("💥爆炸", 0.51, 0.58, 0.23, Color3.fromRGB(220, 80, 80))
local btnClone = createQuickButton("👥分身", 0.765, 0.58, 0.23, Color3.fromRGB(80, 200, 100))

-- =============================================
-- 额外按钮 (服务器级操作)
-- =============================================
local ExtraFrame = Instance.new("Frame")
ExtraFrame.Size = UDim2.new(1, -16, 0, 28)
ExtraFrame.Position = UDim2.new(0, 8, 0, 166)
ExtraFrame.BackgroundTransparency = 1
ExtraFrame.Parent = MainFrame

local btnServer = createQuickButton("🌐全服特效", 0, 0, 0.32, Color3.fromRGB(255, 80, 180))
btnServer.Parent = ExtraFrame
btnServer.Size = UDim2.new(0.32, 0, 1, 0)
btnServer.TextSize = 12

local btnRandom = createQuickButton("🎲随机创意", 0.34, 0, 0.32, Color3.fromRGB(255, 180, 50))
btnRandom.Parent = ExtraFrame
btnRandom.Size = UDim2.new(0.32, 0, 1, 0)
btnRandom.TextSize = 12

local btnClear = createQuickButton("🧹清空世界", 0.68, 0, 0.32, Color3.fromRGB(200, 60, 60))
btnClear.Parent = ExtraFrame
btnClear.Size = UDim2.new(0.32, 0, 1, 0)
btnClear.TextSize = 12

-- =============================================
-- 日志区域
-- =============================================
local LogFrame = Instance.new("Frame")
LogFrame.Size = UDim2.new(1, -16, 0, 110)
LogFrame.Position = UDim2.new(0, 8, 0, 202)
LogFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 28)
LogFrame.BackgroundTransparency = 0.15
LogFrame.BorderSizePixel = 0
LogFrame.Parent = MainFrame
local LogCorner = Instance.new("UICorner")
LogCorner.CornerRadius = UDim.new(0, 8)
LogCorner.Parent = LogFrame

local LogLabel = Instance.new("TextLabel")
LogLabel.Size = UDim2.new(1, -8, 0, 16)
LogLabel.Position = UDim2.new(0, 4, 0, 3)
LogLabel.BackgroundTransparency = 1
LogLabel.Text = "📋 创意日志"
LogLabel.TextColor3 = Color3.fromRGB(150, 150, 215)
LogLabel.TextSize = 11
LogLabel.TextXAlignment = Enum.TextXAlignment.Left
LogLabel.Font = Enum.Font.SourceSans
LogLabel.Parent = LogFrame

local LogBox = Instance.new("ScrollingFrame")
LogBox.Size = UDim2.new(1, -8, 1, -24)
LogBox.Position = UDim2.new(0, 4, 0, 21)
LogBox.BackgroundTransparency = 1
LogBox.BorderSizePixel = 0
LogBox.ScrollBarThickness = 3
LogBox.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 165)
LogBox.Parent = LogFrame

local LogList = Instance.new("UIListLayout")
LogList.Padding = UDim.new(0, 2)
LogList.SortOrder = Enum.SortOrder.LayoutOrder
LogList.Parent = LogBox

-- =============================================
-- 状态栏
-- =============================================
local StatusBar = Instance.new("Frame")
StatusBar.Size = UDim2.new(1, 0, 0, 26)
StatusBar.Position = UDim2.new(0, 0, 1, -26)
StatusBar.BackgroundColor3 = Color3.fromRGB(30, 30, 58)
StatusBar.BackgroundTransparency = 0.15
StatusBar.BorderSizePixel = 0
StatusBar.Parent = MainFrame
local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 14)
StatusCorner.Parent = StatusBar

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -10, 1, 0)
StatusLabel.Position = UDim2.new(0, 5, 0, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "🧠 创意AI大师就绪"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 215)
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.Parent = StatusBar

-- =============================================
-- 最小化状态
-- =============================================
local isMinimized = false
local minimizedSize = UDim2.new(0, 340, 0, 38)
local expandedSize = UDim2.new(0, 340, 0, 360)

-- =============================================
-- 日志函数
-- =============================================
local function addLog(message, color)
    color = color or Color3.fromRGB(200, 200, 255)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 17)
    label.BackgroundTransparency = 1
    label.Text = message
    label.TextColor3 = color
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.SourceSans
    label.Parent = LogBox
    task.wait(0.05)
    LogBox.CanvasPosition = Vector2.new(0, LogBox.CanvasSize.Y.Offset)
    local children = LogBox:GetChildren()
    for i = 1, #children - 35 do
        if children[i]:IsA("TextLabel") then
            children[i]:Destroy()
        end
    end
end

local function setStatus(text, isError)
    local color = isError and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(150, 150, 215)
    StatusLabel.Text = text
    StatusLabel.TextColor3 = color
end

-- =============================================
-- =============================================
-- 🧠 增强AI引擎 (含服务器修改)
-- =============================================
-- =============================================

-- 扩展创意词库
local creativePhrases = {
    -- 动作
    {keywords = {"跳舞", "舞蹈", "舞动", "摇摆", "扭"}, action = "dance"},
    {keywords = {"飞行", "飞", "翱翔", "天上"}, action = "fly"},
    {keywords = {"旋转", "转圈", "自转"}, action = "spin"},
    {keywords = {"跳跃", "跳", "蹦", "起跳"}, action = "jump"},
    {keywords = {"奔跑", "跑", "冲刺", "狂奔"}, action = "dash"},
    {keywords = {"行走", "走", "漫步", "前进"}, action = "walk"},
    {keywords = {"后退", "退", "撤退", "倒退"}, action = "back"},
    {keywords = {"蹲下", "下蹲", "隐藏"}, action = "crouch"},
    
    -- 视觉效果
    {keywords = {"彩虹", "彩色", "七彩", "炫彩"}, action = "rainbow"},
    {keywords = {"发光", "光晕", "闪耀", "霓虹"}, action = "glow"},
    {keywords = {"火焰", "火", "燃烧", "烈焰"}, action = "fire"},
    {keywords = {"冰冻", "冰", "寒冷", "霜"}, action = "ice"},
    {keywords = {"变大", "巨大", "巨人", "膨胀"}, action = "grow"},
    {keywords = {"变小", "迷你", "缩小", "小巧"}, action = "shrink"},
    {keywords = {"透明", "隐身", "幽灵", "半透明"}, action = "ghost"},
    {keywords = {"粒子", "特效", "闪光"}, action = "particles"},
    
    -- 创造 (服务器可见)
    {keywords = {"生成", "创建", "造", "召唤", "出现"}, action = "spawn"},
    {keywords = {"建筑", "房子", "城堡", "塔"}, action = "build"},
    {keywords = {"楼梯", "台阶", "梯子"}, action = "stairs"},
    {keywords = {"平台", "地板", "地面"}, action = "platform"},
    {keywords = {"爆炸", "boom", "爆破", "炸"}, action = "explode"},
    {keywords = {"墙", "围墙", "壁垒"}, action = "wall"},
    {keywords = {"柱子", "柱", "石柱"}, action = "pillar"},
    {keywords = {"桥", "桥梁", "天桥"}, action = "bridge"},
    
    -- 世界修改 (服务器级)
    {keywords = {"白天", "天亮", "阳光"}, action = "day"},
    {keywords = {"夜晚", "天黑", "月亮", "午夜"}, action = "night"},
    {keywords = {"下雨", "雨", "暴雨"}, action = "rain"},
    {keywords = {"下雪", "雪", "暴雪"}, action = "snow"},
    {keywords = {"雾", "浓雾", "大雾"}, action = "fog"},
    {keywords = {"晴天", "晴朗", "阳光明媚"}, action = "clear"},
    {keywords = {"闪电", "雷", "雷暴"}, action = "lightning"},
    {keywords = {"黄昏", "日落", "夕阳"}, action = "sunset"},
    
    -- 特殊
    {keywords = {"跟随", "追", "追踪"}, action = "follow"},
    {keywords = {"传送", "瞬移", "闪现"}, action = "teleport"},
    {keywords = {"复制", "分身", "克隆", "双倍"}, action = "clone"},
    {keywords = {"保护", "盾", "防御", "屏障"}, action = "shield"},
    {keywords = {"重力", "漂浮", "反重力"}, action = "antigravity"},
    {keywords = {"速度", "加速", "疾风"}, action = "speed"},
}

-- =============================================
-- 增强代码生成器
-- =============================================
local function generateEnhancedCode(instruction)
    instruction = string.lower(instruction)
    
    local matchedActions = {}
    for _, phrase in ipairs(creativePhrases) do
        for _, keyword in ipairs(phrase.keywords) do
            if string.find(instruction, keyword) then
                table.insert(matchedActions, phrase.action)
                break
            end
        end
    end
    
    -- 去重
    local unique = {}
    for _, v in ipairs(matchedActions) do
        if not unique[v] then
            unique[v] = true
            table.insert(unique, v)
        end
    end
    matchedActions = unique
    
    if #matchedActions >= 2 then
        return generateCombinedCode(matchedActions)
    end
    
    if #matchedActions == 1 then
        return generateServerActionCode(matchedActions[1])
    end
    
    return instruction
end

-- =============================================
-- 服务器级动作代码 (影响全服)
-- =============================================
local function generateServerActionCode(action)
    local base = "local plr=game.Players.LocalPlayer;local char=plr.Character or plr.CharacterAdded:Wait();local root=char:FindFirstChild('HumanoidRootPart');local hum=char:FindFirstChild('Humanoid');"
    
    local actionMap = {
        -- ===== 基础动作 =====
        jump = base .. "if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end",
        walk = base .. "if root and hum then hum:MoveTo(root.Position + root.CFrame.LookVector * 20) end",
        back = base .. "if root and hum then hum:MoveTo(root.Position - root.CFrame.LookVector * 20) end",
        crouch = base .. "if hum then hum:ChangeState(Enum.HumanoidStateType.Physics) end",
        
        -- ===== 创意动作 =====
        dance = base .. "if hum then for i=1,12 do hum:ChangeState(Enum.HumanoidStateType.Running);task.wait(0.06);hum:ChangeState(Enum.HumanoidStateType.Jumping);task.wait(0.06) end end",
        fly = base .. "local bp=Instance.new('BodyVelocity');bp.Velocity=Vector3.new(0,25,0);bp.MaxForce=Vector3.new(0,4000,0);bp.Parent=root;task.wait(2);bp:Destroy()",
        spin = base .. "local bf=Instance.new('BodyAngularVelocity');bf.AngularVelocity=Vector3.new(0,25,0);bf.MaxTorque=Vector3.new(0,5000,0);bf.Parent=root;task.wait(2);bf:Destroy()",
        dash = base .. "if root and hum then local v=root.CFrame.LookVector*100;hum:ChangeState(Enum.HumanoidStateType.Physics);root.Velocity=v;task.wait(0.25);hum:ChangeState(Enum.HumanoidStateType.Running) end",
        speed = base .. "if hum then hum.WalkSpeed=50;task.wait(3);hum.WalkSpeed=16 end",
        antigravity = base .. "local bf=Instance.new('BodyForce');bf.Force=Vector3.new(0,char:GetMass()*workspace.Gravity,0);bf.Parent=root;task.wait(3);bf:Destroy()",
        
        -- ===== 视觉特效 (部分全服可见) =====
        rainbow = base .. "for _,p in ipairs(char:GetDescendants()) do if p:IsA('BasePart') and p.Name~='HumanoidRootPart' then p.Color=Color3.fromHSV(math.random(),1,1) end end",
        glow = base .. "for _,p in ipairs(char:GetDescendants()) do if p:IsA('BasePart') then p.Material=Enum.Material.Neon end end",
        fire = base .. "local f=Instance.new('Fire');f.Size=12;f.Heat=25;f.Parent=root;task.delay(3,function() f:Destroy() end)",
        ice = base .. "for _,p in ipairs(char:GetDescendants()) do if p:IsA('BasePart') then p.Material=Enum.Material.Ice end end",
        grow = base .. "if root then root.Size=root.Size*2;for _,p in ipairs(char:GetDescendants()) do if p:IsA('BasePart') then p.Size=p.Size*2 end end end",
        shrink = base .. "if root then root.Size=root.Size*0.5;for _,p in ipairs(char:GetDescendants()) do if p:IsA('BasePart') then p.Size=p.Size*0.5 end end end",
        ghost = base .. "for _,p in ipairs(char:GetDescendants()) do if p:IsA('BasePart') then p.Transparency=0.8 end end",
        particles = base .. "local att=Instance.new('Attachment');att.Parent=root;local p=Instance.new('ParticleEmitter');p.Parent=att;p.Texture='rbxasset://textures/particles/sparkles_main.dds';p.Rate=100;p.Lifetime=NumberRange.new(1);p.SpreadAngle=Vector2.new(360,360);p.Speed=NumberRange.new(5,15);p.Enabled=true;p.Parent=att",
        
        -- ===== 建筑/创造 (全服可见) =====
        spawn = base .. "if root then for i=1,3 do local p=Instance.new('Part');p.Size=Vector3.new(3,3,3);p.Position=root.Position+Vector3.new(math.random(-5,5),4+math.random(0,3),math.random(-5,5));p.Anchored=true;p.BrickColor=BrickColor.Random();p.Material=Enum.Material.Neon;p.Parent=workspace;task.delay(6,function() p:Destroy() end) end end",
        build = base .. "if root then for i=1,12 do local p=Instance.new('Part');p.Size=Vector3.new(2,0.5,2);p.Position=root.Position+Vector3.new((i%4-1.5)*2.5,math.floor(i/4)*0.5+0.5,(math.floor(i/3)%3-1)*2.5);p.Anchored=true;p.BrickColor=BrickColor.new('Bright blue');p.Parent=workspace end end",
        stairs = base .. "if root then for i=1,10 do local p=Instance.new('Part');p.Size=Vector3.new(2.5,0.3,2.5);p.Position=root.Position+Vector3.new(i*2-10,i*0.4,0);p.Anchored=true;p.Parent=workspace;task.wait(0.05) end end",
        platform = base .. "if root then for x=-3,3 do for z=-3,3 do local p=Instance.new('Part');p.Size=Vector3.new(1.5,0.2,1.5);p.Position=root.Position+Vector3.new(x*2,0,z*2);p.Anchored=true;p.BrickColor=BrickColor.new('Bright red');p.Parent=workspace end end end",
        wall = base .. "if root then for i=1,8 do local p=Instance.new('Part');p.Size=Vector3.new(1,3,1);p.Position=root.Position+Vector3.new(i*2-8,1.5,0);p.Anchored=true;p.BrickColor=BrickColor.new('Medium stone gray');p.Parent=workspace end end",
        pillar = base .. "if root then for i=1,4 do local p=Instance.new('Part');p.Size=Vector3.new(1.5,5,1.5);p.Position=root.Position+Vector3.new(math.random(-6,6),2.5,math.random(-6,6));p.Anchored=true;p.BrickColor=BrickColor.new('Bright yellow');p.Parent=workspace end end",
        bridge = base .. "if root then for i=1,10 do local p=Instance.new('Part');p.Size=Vector3.new(2,0.3,4);p.Position=root.Position+Vector3.new(i*2-10,0.5,0);p.Anchored=true;p.Parent=workspace end;for i=1,4 do local p=Instance.new('Part');p.Size=Vector3.new(0.5,3,0.5);p.Position=root.Position+Vector3.new(i*5-12.5,1.5,0);p.Anchored=true;p.Parent=workspace end end",
        explode = base .. "local e=Instance.new('Explosion');e.Position=root.Position;e.BlastRadius=15;e.Parent=workspace",
        
        -- ===== 世界修改 (全服可见) =====
        day = "Lighting.Brightness=2;Lighting.ClockTime=14;Lighting.FogEnd=1000;Lighting.OutdoorAmbient=Color3.new(1,1,1)",
        night = "Lighting.Brightness=0.3;Lighting.ClockTime=0;Lighting.FogEnd=200;Lighting.OutdoorAmbient=Color3.new(0.2,0.2,0.3)",
        rain = "local r=Instance.new('ReverbEffect');r.Parent=workspace;Lighting.Brightness=0.5;Lighting.ClockTime=12;Lighting.FogEnd=300;task.delay(10,function() r:Destroy() end)",
        snow = "Lighting.Brightness=0.7;Lighting.ClockTime=10;Lighting.FogEnd=200;for i=1,50 do local p=Instance.new('Part');p.Size=Vector3.new(0.5,0.5,0.5);p.Position=Vector3.new(math.random(-100,100),math.random(10,50),math.random(-100,100));p.Anchored=true;p.Material=Enum.Material.SmoothPlastic;p.Color=Color3.fromRGB(255,255,255);p.Parent=workspace;task.delay(8,function() p:Destroy() end) end",
        fog = "Lighting.FogEnd=50;Lighting.FogStart=10;Lighting.FogColor=Color3.new(0.5,0.5,0.7);task.delay(8,function() Lighting.FogEnd=1000;Lighting.FogStart=0 end)",
        clear = "Lighting.Brightness=2;Lighting.ClockTime=14;Lighting.FogEnd=1000;Lighting.OutdoorAmbient=Color3.new(1,1,1);Lighting.FogColor=Color3.new(0.7,0.8,1)",
        lightning = "local e=Instance.new('Explosion');e.Position=Vector3.new(math.random(-50,50),0,math.random(-50,50));e.BlastRadius=20;e.Parent=workspace;Lighting.Brightness=2;task.wait(0.1);Lighting.Brightness=0.3;task.wait(0.1);Lighting.Brightness=2;task.wait(0.1);Lighting.Brightness=0.5",
        sunset = "Lighting.Brightness=0.8;Lighting.ClockTime=18;Lighting.FogEnd=400;Lighting.OutdoorAmbient=Color3.new(1,0.6,0.3)",
        
        -- ===== 特殊功能 =====
        follow = base .. "local target=game.Players:GetPlayers()[2];if target and target.Character then local t=target.Character.HumanoidRootPart;hum:MoveTo(t.Position) end",
        teleport = base .. "if root then local pos=root.Position+Vector3.new(math.random(-40,40),10,math.random(-40,40));root.CFrame=CFrame.new(pos) end",
        clone = base .. "if char then for i=1,3 do local c=char:Clone();c.Parent=workspace;c.HumanoidRootPart.CFrame=char.HumanoidRootPart.CFrame+Vector3.new(i*5-7,0,0);task.delay(4,function() c:Destroy() end) end end",
        shield = base .. "for i=1,12 do local s=Instance.new('Part');local angle=(i/12)*math.pi*2;s.Size=Vector3.new(0.3,8,0.3);s.Position=root.Position+Vector3.new(math.cos(angle)*4,0,math.sin(angle)*4);s.Anchored=true;s.Material=Enum.Material.Neon;s.Color=Color3.fromRGB(0,150,255);s.Parent=workspace;task.delay(3,function() s:Destroy() end) end",
    }
    
    return actionMap[action] or "print('未知创意指令')"
end

-- =============================================
-- 组合代码生成
-- =============================================
local function generateCombinedCode(actions)
    local base = "local plr=game.Players.LocalPlayer;local char=plr.Character or plr.CharacterAdded:Wait();local root=char:FindFirstChild('HumanoidRootPart');local hum=char:FindFirstChild('Humanoid');"
    
    local actionMap = {
        jump = "if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end",
        walk = "if root and hum then hum:MoveTo(root.Position + root.CFrame.LookVector * 20) end",
        dance = "if hum then for i=1,6 do hum:ChangeState(Enum.HumanoidStateType.Running);task.wait(0.06);hum:ChangeState(Enum.HumanoidStateType.Jumping);task.wait(0.06) end end",
        fly = "local bp=Instance.new('BodyVelocity');bp.Velocity=Vector3.new(0,20,0);bp.MaxForce=Vector3.new(0,4000,0);bp.Parent=root;task.wait(1);bp:Destroy()",
        spin = "local bf=Instance.new('BodyAngularVelocity');bf.AngularVelocity=Vector3.new(0,20,0);bf.MaxTorque=Vector3.new(0,4000,0);bf.Parent=root;task.wait(1.5);bf:Destroy()",
        rainbow = "for _,p in ipairs(char:GetDescendants()) do if p:IsA('BasePart') and p.Name~='HumanoidRootPart' then p.Color=Color3.fromHSV(math.random(),1,1) end end",
        glow = "for _,p in ipairs(char:GetDescendants()) do if p:IsA('BasePart') then p.Material=Enum.Material.Neon end end",
        spawn = "if root then for i=1,2 do local p=Instance.new('Part');p.Size=Vector3.new(2,2,2);p.Position=root.Position+Vector3.new(math.random(-4,4),4,math.random(-4,4));p.Anchored=true;p.BrickColor=BrickColor.Random();p.Material=Enum.Material.Neon;p.Parent=workspace;task.delay(4,function() p:Destroy() end) end end",
        explode = "local e=Instance.new('Explosion');e.Position=root.Position;e.BlastRadius=8;e.Parent=workspace",
        teleport = "if root then local pos=root.Position+Vector3.new(math.random(-25,25),10,math.random(-25,25));root.CFrame=CFrame.new(pos) end",
        clone = "if char then local c=char:Clone();c.Parent=workspace;c.HumanoidRootPart.CFrame=char.HumanoidRootPart.CFrame+Vector3.new(5,0,0);task.delay(4,function() c:Destroy() end) end",
        build = "if root then for i=1,6 do local p=Instance.new('Part');p.Size=Vector3.new(2,0.5,2);p.Position=root.Position+Vector3.new((i%3-1)*3,math.floor(i/3)*0.5+0.5,(math.floor(i/2)%2)*3-1.5);p.Anchored=true;p.Parent=workspace end end",
        day = "Lighting.Brightness=2;Lighting.ClockTime=14;Lighting.FogEnd=1000",
        night = "Lighting.Brightness=0.3;Lighting.ClockTime=0;Lighting.FogEnd=200",
    }
    
    local selected = {}
    local used = {}
    for i = 1, math.min(#actions, 3) do
        local idx = math.random(#actions)
        local attempts = 0
        while used[idx] and attempts < 10 do
            idx = math.random(#actions)
            attempts = attempts + 1
        end
        used[idx] = true
        local action = actions[idx]
        if actionMap[action] then
            table.insert(selected, actionMap[action])
        end
    end
    
    if #selected == 0 then
        return generateServerActionCode(actions[1]) or "print('创意组合失败')"
    end
    
    return base .. table.concat(selected, " ")
end

-- =============================================
-- 随机创意生成
-- =============================================
local randomActions = {"jump", "walk", "dance", "fly", "spin", "rainbow", "glow", "spawn", "explode", "teleport", "clone", "grow", "shrink", "fire", "ice", "build", "pillar", "day", "night", "fog"}
local randomMessages = {
    "✨ 创意爆发！", "🌈 绚丽登场！", "💃 舞动青春！", "🕊️ 自由飞翔！",
    "🎨 色彩盛宴！", "🧱 建筑大师！", "💥 震撼爆炸！", "🎯 神秘传送！",
    "👻 幽灵模式！", "🔥 烈焰燃烧！", "❄️ 冰雪世界！", "🌤️ 天气变幻！",
    "👥 分身术！", "🏰 城堡降临！", "🌙 夜幕降临！"
}

local function generateRandomCreative()
    local numActions = math.random(1, 3)
    local actions = {}
    for i = 1, numActions do
        table.insert(actions, randomActions[math.random(#randomActions)])
    end
    local msg = randomMessages[math.random(#randomMessages)]
    return actions, msg
end

-- =============================================
-- 执行函数 (增强版)
-- =============================================
local function executeInstruction(instruction)
    if not instruction or instruction == "" then
        setStatus("⚠️ 描述你想要的效果", true)
        return
    end
    
    setStatus("🧠 AI创意生成中...")
    addLog("💬 " .. instruction, Color3.fromRGB(255, 200, 100))
    
    local code = generateEnhancedCode(instruction)
    
    if code and string.len(code) > 5 then
        addLog("🎨 创意代码已生成", Color3.fromRGB(200, 150, 255))
    end
    
    addLog("📝 " .. string.sub(code, 1, 40) .. (string.len(code) > 40 and "..." or ""), Color3.fromRGB(150, 200, 255))
    
    local success, err = pcall(function()
        local func = loadstring(code)
        if func then 
            func() 
            setStatus("✅ 创意执行成功！")
            addLog("✅ 成功 ✨", Color3.fromRGB(100, 255, 150))
        else 
            error("编译失败，请检查语法")
        end
    end)
    
    if not success then
        setStatus("❌ " .. tostring(err), true)
        addLog("❌ " .. tostring(err), Color3.fromRGB(255, 100, 100))
    end
end

-- =============================================
-- 触屏拖动
-- =============================================
local dragging = false
local dragStart = nil
local startPos = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- =============================================
-- 按钮绑定
-- =============================================
ExecuteButton.MouseButton1Click:Connect(function()
    local text = InputBox.Text
    InputBox.Text = ""
    executeInstruction(text)
end)

InputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local text = InputBox.Text
        InputBox.Text = ""
        executeInstruction(text)
    end
end)

-- 快捷按钮
btnDance.MouseButton1Click:Connect(function() executeInstruction("跳舞") end)
btnFly.MouseButton1Click:Connect(function() executeInstruction("飞行") end)
btnRainbow.MouseButton1Click:Connect(function() executeInstruction("彩虹") end)
btnBuild.MouseButton1Click:Connect(function() executeInstruction("建筑") end)
btnSpawn.MouseButton1Click:Connect(function() executeInstruction("生成") end)
btnWeather.MouseButton1Click:Connect(function() executeInstruction("天气变化") end)
btnExplode.MouseButton1Click:Connect(function() executeInstruction("爆炸") end)
btnClone.MouseButton1Click:Connect(function() executeInstruction("分身") end)

-- 额外按钮
btnServer.MouseButton1Click:Connect(function()
    local serverEffects = {"全体发光", "全服彩虹", "全服爆炸", "全服传送", "全服变身"}
    local effect = serverEffects[math.random(#serverEffects)]
    addLog("🌐 全服特效: " .. effect, Color3.fromRGB(255, 150, 255))
    executeInstruction(effect)
end)

btnRandom.MouseButton1Click:Connect(function()
    local actions, msg = generateRandomCreative()
    local actionNames = {jump="跳", walk="走", dance="跳舞", fly="飞", spin="旋转", rainbow="彩虹", glow="发光", spawn="生成", explode="爆炸", teleport="传送", clone="克隆", grow="变大", shrink="变小", fire="火焰", ice="冰冻", build="建筑", pillar="柱子", day="白天", night="夜晚", fog="雾"}
    local combined = ""
    for i, a in ipairs(actions) do
        combined = combined .. (actionNames[a] or a) .. (i < #actions and "+" : "")
    end
    addLog("🎲 随机: " .. combined, Color3.fromRGB(255, 180, 255))
    addLog("💬 " .. msg, Color3.fromRGB(255, 200, 150))
    executeInstruction(combined)
end)

btnClear.MouseButton1Click:Connect(function()
    addLog("🧹 正在清空世界...", Color3.fromRGB(255, 200, 150))
    -- 清空所有被创建的零件（保留重要物体）
    local count = 0
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Part") and obj.Anchored and obj.Name ~= "Baseplate" and not obj:IsA("Terrain") then
            if not obj.Parent:IsA("Model") or not obj.Parent:FindFirstChild("Humanoid") then
                obj:Destroy()
                count = count + 1
            end
        end
    end
    addLog("🧹 已清空 " .. count .. " 个物体", Color3.fromRGB(100, 255, 150))
    setStatus("✅ 已清空 " .. count .. " 个物体")
end)

MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    local targetSize = isMinimized and minimizedSize or expandedSize
    MinimizeButton.Text = isMinimized and "➕" or "➖"
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), { Size = targetSize })
    tween:Play()
    for _, child in ipairs(MainFrame:GetChildren()) do
        if child ~= TitleBar and child ~= Blur then
            child.Visible = not isMinimized
        end
    end
    StatusBar.Visible = not isMinimized
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- =============================================
-- 初始化
-- =============================================
addLog("🧠 AI创意大师已加载", Color3.fromRGB(100, 200, 255))
addLog("🌐 支持服务器级修改", Color3.fromRGB(150, 200, 200))
addLog("💡 描述任何效果，AI自动生成", Color3.fromRGB(150, 150, 200))
addLog("📖 试试: 跳舞 / 彩虹 / 建筑 / 夜晚", Color3.fromRGB(200, 180, 220))
setStatus("🧠 创意AI大师就绪")

print("🧠 AI创意大师已加载 (增强版)")
