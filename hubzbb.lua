-- ==========================================
-- AIHub 手机版 v9
-- 完整功能 + 超级关键词库
-- 含: 重力 速度 跳跃高度 行走速度 等
-- ==========================================

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- ===== 配色 =====
local Theme = {
    BG = Color3.fromRGB(12, 12, 28),
    Surface = Color3.fromRGB(25, 25, 55),
    Primary = Color3.fromRGB(140, 80, 255),
    Text = Color3.fromRGB(255, 255, 255),
    TextSec = Color3.fromRGB(170, 170, 210),
    Success = Color3.fromRGB(0, 255, 150),
    Error = Color3.fromRGB(255, 80, 80),
    Warn = Color3.fromRGB(255, 200, 50),
}

-- ===== 工具 =====
local function corner(obj, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 10)
    c.Parent = obj
end

local function stroke(obj, t)
    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(255, 255, 255)
    s.Thickness = t or 0.5
    s.Transparency = 0.3
    s.Parent = obj
end

-- ===== 创建UI =====
local SG = Instance.new("ScreenGui")
SG.Name = "AIHub"
SG.ResetOnSpawn = false
local pg = Player:FindFirstChild("PlayerGui") or Player:WaitForChild("PlayerGui")
SG.Parent = pg

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 300, 0, 320)
Main.Position = UDim2.new(0.5, -150, 0.2, 0)
Main.BackgroundColor3 = Theme.BG
Main.BackgroundTransparency = 0.03
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = SG
corner(Main, 14)
stroke(Main)

local Shadow = Instance.new("Frame")
Shadow.Size = UDim2.new(1, 6, 1, 6)
Shadow.Position = UDim2.new(0, 6, 0, 6)
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.5
Shadow.BorderSizePixel = 0
Shadow.ZIndex = 0
Shadow.Parent = Main
corner(Shadow, 14)

-- ===== 标题栏 =====
local TB = Instance.new("Frame")
TB.Size = UDim2.new(1, 0, 0, 36)
TB.BackgroundColor3 = Theme.Surface
TB.BackgroundTransparency = 0.1
TB.BorderSizePixel = 0
TB.Parent = Main
corner(TB, 14)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ AIHub"
Title.TextColor3 = Theme.Text
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.SourceSansBold
Title.Parent = TB

local Dot = Instance.new("Frame")
Dot.Size = UDim2.new(0, 7, 0, 7)
Dot.Position = UDim2.new(0.30, 0, 0.5, -3.5)
Dot.BackgroundColor3 = Theme.Success
Dot.BackgroundTransparency = 0.1
Dot.BorderSizePixel = 0
Dot.Parent = TB
corner(Dot, 4)

local DotLabel = Instance.new("TextLabel")
DotLabel.Size = UDim2.new(0.1, 0, 1, 0)
DotLabel.Position = UDim2.new(0.32, 0, 0, 0)
DotLabel.BackgroundTransparency = 1
DotLabel.Text = "在线"
DotLabel.TextColor3 = Theme.Success
DotLabel.TextSize = 11
DotLabel.TextXAlignment = Enum.TextXAlignment.Left
DotLabel.Font = Enum.Font.SourceSans
DotLabel.Parent = TB

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -32, 0, 4)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.BackgroundTransparency = 0.3
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Theme.Text
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TB
corner(CloseBtn, 7)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -70, 0, 4)
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
MinBtn.BackgroundTransparency = 0.3
MinBtn.Text = "─"
MinBtn.TextColor3 = Theme.Text
MinBtn.TextSize = 18
MinBtn.Font = Enum.Font.SourceSansBold
MinBtn.BorderSizePixel = 0
MinBtn.Parent = TB
corner(MinBtn, 7)

-- ===== 内容容器 =====
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, 0, 1, -36)
ContentContainer.Position = UDim2.new(0, 0, 0, 36)
ContentContainer.BackgroundTransparency = 1
ContentContainer.ClipsDescendants = true
ContentContainer.Parent = Main

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -16, 1, 0)
Content.Position = UDim2.new(0, 8, 0, 0)
Content.BackgroundTransparency = 1
Content.Parent = ContentContainer

-- ===== 日志区 =====
local LogFrame = Instance.new("Frame")
LogFrame.Size = UDim2.new(1, 0, 0, 110)
LogFrame.BackgroundColor3 = Color3.fromRGB(6, 6, 18)
LogFrame.BackgroundTransparency = 0.2
LogFrame.BorderSizePixel = 0
LogFrame.Parent = Content
corner(LogFrame, 8)
stroke(LogFrame, 0.5)

local LogScroll = Instance.new("ScrollingFrame")
LogScroll.Size = UDim2.new(1, -6, 1, -6)
LogScroll.Position = UDim2.new(0, 3, 0, 3)
LogScroll.BackgroundTransparency = 1
LogScroll.BorderSizePixel = 0
LogScroll.ScrollBarThickness = 2
LogScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 160)
LogScroll.Parent = LogFrame

local LogList = Instance.new("UIListLayout")
LogList.Padding = UDim.new(0, 2)
LogList.SortOrder = Enum.SortOrder.LayoutOrder
LogList.Parent = LogScroll

-- ===== 快捷按钮 =====
local QuickBar = Instance.new("Frame")
QuickBar.Size = UDim2.new(1, 0, 0, 32)
QuickBar.Position = UDim2.new(0, 0, 0, 118)
QuickBar.BackgroundTransparency = 1
QuickBar.Parent = Content

local function qb(t, x, color)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.18, 0, 1, 0)
    b.Position = UDim2.new(x, 0, 0, 0)
    b.BackgroundColor3 = color or Theme.Primary
    b.BackgroundTransparency = 0.2
    b.Text = t
    b.TextColor3 = Theme.Text
    b.TextSize = 11
    b.Font = Enum.Font.SourceSansBold
    b.BorderSizePixel = 0
    b.Parent = QuickBar
    corner(b, 6)
    return b
end

local q1 = qb("🦘跳", 0, Color3.fromRGB(70, 130, 220))
local q2 = qb("💃舞", 0.205, Color3.fromRGB(255, 150, 50))
local q3 = qb("🕊️飞", 0.41, Color3.fromRGB(100, 200, 255))
local q4 = qb("🌈彩", 0.615, Color3.fromRGB(200, 100, 255))
local q5 = qb("🧱生", 0.82, Color3.fromRGB(180, 70, 220))

local QuickBar2 = Instance.new("Frame")
QuickBar2.Size = UDim2.new(1, 0, 0, 32)
QuickBar2.Position = UDim2.new(0, 0, 0, 154)
QuickBar2.BackgroundTransparency = 1
QuickBar2.Parent = Content

local q6 = qb("💥爆", 0, Color3.fromRGB(220, 80, 80))
q6.Parent = QuickBar2
local q7 = qb("👥分", 0.205, Color3.fromRGB(80, 200, 100))
q7.Parent = QuickBar2
local q8 = qb("🌤️天", 0.41, Color3.fromRGB(70, 180, 220))
q8.Parent = QuickBar2
local q9 = qb("🌐服", 0.615, Color3.fromRGB(255, 80, 180))
q9.Parent = QuickBar2
local q10 = qb("🎲随", 0.82, Color3.fromRGB(255, 180, 50))
q10.Parent = QuickBar2

-- ===== 输入框 =====
local InputArea = Instance.new("Frame")
InputArea.Size = UDim2.new(1, 0, 0, 34)
InputArea.Position = UDim2.new(0, 0, 1, -38)
InputArea.BackgroundTransparency = 1
InputArea.Parent = Content

local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(0.68, -4, 1, 0)
InputBox.Position = UDim2.new(0, 0, 0, 0)
InputBox.BackgroundColor3 = Color3.fromRGB(35, 35, 65)
InputBox.BackgroundTransparency = 0.15
InputBox.Text = ""
InputBox.TextColor3 = Theme.Text
InputBox.PlaceholderText = "说你想做的事..."
InputBox.PlaceholderColor3 = Theme.TextSec
InputBox.TextSize = 13
InputBox.Font = Enum.Font.SourceSans
InputBox.ClearTextOnFocus = false
InputBox.BorderSizePixel = 0
InputBox.Parent = InputArea
corner(InputBox, 8)

local SendBtn = Instance.new("TextButton")
SendBtn.Size = UDim2.new(0.30, 0, 1, 0)
SendBtn.Position = UDim2.new(0.70, 4, 0, 0)
SendBtn.BackgroundColor3 = Theme.Primary
SendBtn.BackgroundTransparency = 0.15
SendBtn.Text = "执行"
SendBtn.TextColor3 = Theme.Text
SendBtn.TextSize = 13
SendBtn.Font = Enum.Font.SourceSansBold
SendBtn.BorderSizePixel = 0
SendBtn.Parent = InputArea
corner(SendBtn, 8)

-- ===== 状态栏 =====
local SB = Instance.new("Frame")
SB.Size = UDim2.new(1, 0, 0, 22)
SB.Position = UDim2.new(0, 0, 1, -22)
SB.BackgroundColor3 = Color3.fromRGB(18, 18, 38)
SB.BackgroundTransparency = 0.1
SB.BorderSizePixel = 0
SB.Parent = ContentContainer
corner(SB, 14)

local SL = Instance.new("TextLabel")
SL.Size = UDim2.new(1, -8, 1, 0)
SL.Position = UDim2.new(0, 4, 0, 0)
SL.BackgroundTransparency = 1
SL.Text = "⚡ 就绪"
SL.TextColor3 = Theme.TextSec
SL.TextSize = 11
SL.TextXAlignment = Enum.TextXAlignment.Left
SL.Font = Enum.Font.SourceSans
SL.Parent = SB

-- ===== 变量 =====
local isMin = false
local weatherOverlay = nil
local processing = false
local activeEffects = {}

-- ===== 日志 =====
local function log(msg, color)
    color = color or Theme.TextSec
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 0, 16)
    l.BackgroundTransparency = 1
    l.Text = msg
    l.TextColor3 = color
    l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Font = Enum.Font.SourceSans
    l.Parent = LogScroll
    task.wait()
    LogScroll.CanvasPosition = Vector2.new(0, LogScroll.CanvasSize.Y.Offset)
    local kids = LogScroll:GetChildren()
    for i = 1, #kids - 20 do
        if kids[i]:IsA("TextLabel") then kids[i]:Destroy() end
    end
end

local function setStatus(txt, color)
    SL.Text = txt
    SL.TextColor3 = color or Theme.TextSec
end

local function setDot(color, label)
    Dot.BackgroundColor3 = color or Theme.Success
    DotLabel.Text = label or "在线"
    DotLabel.TextColor3 = color or Theme.Success
end

-- ==========================================
-- ===== 超级关键词库 (完整版) =====
-- ==========================================

local Keywords = {
    -- ===== 跳跃 =====
    jump = {
        "跳", "蹦", "跃", "起跳", "弹跳", "跳跃", "跳起", "跳高", "跳远",
        "往上", "升高", "腾空", "飞跳", "弹射", "蹦跳", "蹦起", "跃起",
        "跳一下", "跳起来", "蹦起来", "跃起来", "往上跳", "向上跳",
        "高跳", "猛跳", "大跳", "超级跳", "强化跳",
    },
    
    -- ===== 跳舞 =====
    dance = {
        "舞", "跳舞", "舞蹈", "摇摆", "扭动", "晃动", "蹦迪", "迪斯科",
        "扭起来", "摇起来", "晃起来", "蹦起来", "舞动", "热舞", "街舞",
        "跳支舞", "跳个舞", "舞一曲", "一起跳舞", "疯狂跳舞",
        "扭一扭", "摇一摇", "晃一晃", "动一动",
    },
    
    -- ===== 飞行 =====
    fly = {
        "飞", "飞行", "翱翔", "飞翔", "升空", "起飞", "升天", "腾飞",
        "高飞", "远飞", "自由飞", "空中飞", "飞起来", "飞上天",
        "向上飞", "滑翔", "盘旋", "让我飞", "我想飞", "我要飞",
    },
    
    -- ===== 彩虹/变色 =====
    rainbow = {
        "彩", "彩虹", "变色", "七彩", "彩色", "炫彩", "缤纷", "多彩", "斑斓",
        "五彩", "色彩", "颜色", "换色", "改色", "染彩", "彩虹色",
        "彩色模式", "变彩", "多彩色", "五颜六色", "花里胡哨",
    },
    
    -- ===== 生成 =====
    spawn = {
        "生", "生成", "造", "创建", "制造", "召唤", "出现", "产生", "摆放",
        "放置", "建立", "建造", "制作", "方块", "零件", "物体", "东西",
        "造东西", "生东西", "召唤物", "凭空造",
    },
    
    -- ===== 爆炸 =====
    explode = {
        "爆", "爆炸", "炸", "爆破", "引爆", "轰", "冲击", "震动", "炸裂",
        "爆裂", "炸开", "炸毁", "轰隆", "火光", "boom",
    },
    
    -- ===== 分身 =====
    clone = {
        "分", "分身", "克隆", "复制", "分裂", "镜像", "双倍", "多重",
        "分身术", "影分身", "镜像分身", "多重分身", "复制人",
        "双胞胎", "clone", "duplicate", "copy",
    },
    
    -- ===== 天气 =====
    weather = {
        "天", "天气", "雨", "下雨", "落雨", "降雨", "暴雨", "雷雨", "大雨", "小雨",
        "雪", "下雪", "落雪", "降雪", "暴雪", "大雪", "小雪", "雪花",
        "雾", "起雾", "大雾", "浓雾", "雾气", "雾霾",
        "晴", "晴天", "晴朗", "放晴", "天晴", "艳阳天",
        "阴", "阴天", "多云", "乌云", "风暴", "雷电",
    },
    
    -- ===== 全服 =====
    server = {
        "服", "全服", "全体", "所有", "全部", "全局", "全图", "全屏",
        "所有人", "大家", "全部人", "全体人", "全员", "全玩家",
    },
    
    -- ===== 清空 =====
    clear = {
        "清", "清除", "清空", "清理", "打扫", "净化", "移除", "删除",
        "去掉", "消除", "消掉", "抹去", "擦除", "摧毁", "毁灭",
        "清一下", "扫除", "肃清",
    },
    
    -- ==========================================
    -- ===== 🆕 重力相关 (30+ 种说法) =====
    -- ==========================================
    gravity = {
        "重", "重力", "引力", "地心", "地心引力", "引力场",
        "低重力", "轻", "变轻", "减轻", "失重", "无重力", "零重力",
        "高重力", "加重", "变重", "增加重力", "加强重力",
        "重力加大", "重力减小", "重力变化", "改变重力",
        "月球重力", "火星重力", "地球重力", "太空重力",
        "漂浮", "飘起来", "轻飘飘", "沉重", "压扁",
        "重力调节", "重力控制", "重力设置",
    },
    
    -- ==========================================
    -- ===== 🆕 速度相关 (30+ 种说法) =====
    -- ==========================================
    speed = {
        "速", "速度", "移速", "移动速度", "行走速度", "跑步速度",
        "加速", "提速", "加快", "变快", "快速", "飞快", "极速",
        "减速", "变慢", "减慢", "缓慢", "慢速",
        "超速", "高速", "低速", "匀速",
        "速度变快", "速度变慢", "调速度", "改速度",
        "快一点", "慢一点", "跑快点", "走慢点",
        "速度调节", "速度控制", "速度设置",
        "疾跑", "冲刺", "狂奔", "飞驰",
    },
    
    -- ==========================================
    -- ===== 🆕 跳跃高度 (20+ 种说法) =====
    -- ==========================================
    jumpPower = {
        "跳跃高度", "跳高", "弹跳力", "弹跳高度", "跳跃力",
        "跳得高", "跳更高", "超高跳", "跳低", "跳矮",
        "跳跃倍率", "跳高一点", "跳矮一点", "调跳跃",
        "超级跳", "月球跳", "高跳", "低跳",
        "跳跃增强", "跳跃减弱",
    },
    
    -- ==========================================
    -- ===== 🆕 大小变化 (20+ 种说法) =====
    -- ==========================================
    size = {
        "大", "变大", "增大", "扩大", "放大", "巨型", "巨大",
        "小", "变小", "缩小", "减小", "微型", "迷你",
        "大小", "体型", "尺寸", "缩放",
        "变大一点", "变小一点", "巨人", "矮人",
        "大小变化", "调大小",
    },
    
    -- ==========================================
    -- ===== 🆕 透明度 (15+ 种说法) =====
    -- ==========================================
    transparency = {
        "透", "透明", "半透明", "隐身", "隐形", "消失", "隐",
        "变透明", "透明度", "调透明", "透明化",
        "完全透明", "部分透明", "幽灵", "鬼魂",
    },
    
    -- ==========================================
    -- ===== 🆕 跳跃增强 (已有功能) =====
    -- ==========================================
    help = {
        "帮", "帮助", "说明", "指南", "教程", "用法", "操作",
        "功能", "介绍", "列表", "菜单", "能做什么", "怎么用",
    }
}

-- ===== 匹配函数 =====
local function matchKeyword(text, keywords)
    for _, kw in ipairs(keywords) do
        if string.find(text, kw) then
            return true
        end
    end
    return false
end

local function getMatches(text)
    local matches = {}
    local lower = string.lower(text)
    
    for action, keywords in pairs(Keywords) do
        if matchKeyword(lower, keywords) then
            table.insert(matches, action)
        end
    end
    
    return matches
end

-- ===== 获取动作名称 =====
local function getActionName(action)
    local names = {
        jump = "🦘 跳跃",
        dance = "💃 跳舞",
        fly = "🕊️ 飞行",
        rainbow = "🌈 彩虹",
        spawn = "🧱 生成",
        explode = "💥 爆炸",
        clone = "👥 分身",
        weather = "🌤️ 天气",
        server = "🌐 全服",
        clear = "🧹 清空",
        gravity = "⚡ 重力",
        speed = "🏃 速度",
        jumpPower = "📈 跳跃高度",
        size = "📏 大小",
        transparency = "👻 透明",
        help = "❓ 帮助"
    }
    return names[action] or action
end

-- ===== 提取数字 =====
local function extractNumber(text)
    local num = string.match(text, "(%d+)")
    if num then return tonumber(num) end
    return nil
end

-- ===== 获取动作代码 =====
local function getActionCode(action, rawCmd)
    local lower = string.lower(rawCmd)
    local num = extractNumber(rawCmd)
    
    local base = [[
        local p=game.Players.LocalPlayer
        local c=p.Character
        local r=c and c:FindFirstChild("HumanoidRootPart")
        local h=c and c:FindFirstChild("Humanoid")
    ]]
    
    if action == "jump" then
        return base .. [[if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end]]
    end
    
    if action == "dance" then
        return base .. [[
            if h then
                for i=1,10 do
                    h:ChangeState(Enum.HumanoidStateType.Running)
                    task.wait(0.05)
                    h:ChangeState(Enum.HumanoidStateType.Jumping)
                    task.wait(0.05)
                end
            end
        ]]
    end
    
    if action == "fly" then
        return base .. [[
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
    
    if action == "rainbow" then
        return base .. [[
            if c then
                for _,x in ipairs(c:GetDescendants()) do
                    if x:IsA("BasePart") and x.Name~="HumanoidRootPart" then
                        x.Color=Color3.fromHSV(math.random(),1,1)
                    end
                end
            end
        ]]
    end
    
    if action == "spawn" then
        return base .. [[
            if r then
                for i=1,3 do
                    local x=Instance.new("Part")
                    x.Size=Vector3.new(2,2,2)
                    x.Position=r.Position+Vector3.new(math.random(-4,4),3+math.random(0,2),math.random(-4,4))
                    x.Anchored=true
                    x.BrickColor=BrickColor.Random()
                    x.Material=Enum.Material.Neon
                    x.Parent=workspace
                    task.delay(4,function() pcall(function() x:Destroy() end) end)
                end
            end
        ]]
    end
    
    if action == "explode" then
        return base .. [[
            if r then
                local e=Instance.new("Explosion")
                e.Position=r.Position
                e.BlastRadius=12
                e.Parent=workspace
            end
        ]]
    end
    
    if action == "clone" then
        return [[
            local p=game.Players.LocalPlayer
            local char=p.Character
            if not char then return end
            local root=char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local model=Instance.new("Model")
            model.Name="Follower"
            model.Parent=workspace
            local body=Instance.new("Part")
            body.Size=Vector3.new(2,2.5,1.2)
            body.Position=root.Position+Vector3.new(math.random(-3,3),0,math.random(-3,3))
            body.BrickColor=BrickColor.Random()
            body.Material=Enum.Material.Neon
            body.Anchored=false
            body.CanCollide=false
            body.Parent=model
            local head=Instance.new("Part")
            head.Size=Vector3.new(1.2,1.2,1.2)
            head.Position=body.Position+Vector3.new(0,1.8,0)
            head.BrickColor=BrickColor.new("White")
            head.Material=Enum.Material.SmoothPlastic
            head.Anchored=false
            head.CanCollide=false
            head.Parent=model
            local conn
            conn=game:GetService("RunService").Heartbeat:Connect(function()
                if not model.Parent then conn:Disconnect() return end
                local nr=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                if nr then
                    local tp=nr.Position+Vector3.new(0,0,4)
                    body.Position=body.Position+(tp-body.Position)*0.1
                    head.Position=body.Position+Vector3.new(0,1.8,0)
                end
            end)
            task.delay(5,function()
                pcall(function() model:Destroy() end)
                pcall(function() conn:Disconnect() end)
            end)
        ]]
    end
    
    if action == "weather" then
        local wtype = "rain"
        if string.find(lower, "雪") then wtype = "snow" end
        if string.find(lower, "雾") or string.find(lower, "霾") then wtype = "fog" end
        if string.find(lower, "晴") or string.find(lower, "停") or string.find(lower, "清除") or string.find(lower, "消") then wtype = "clear" end
        if string.find(lower, "暴") or string.find(lower, "雷") or (string.find(lower, "大") and string.find(lower, "雨")) then wtype = "storm" end
        return [[
            local sg=game.Players.LocalPlayer:FindFirstChild("PlayerGui")
            if not sg then return end
            for _,x in ipairs(sg:GetChildren()) do
                if x.Name=="WeatherOverlay" then pcall(function() x:Destroy() end) end
            end
            if "]] .. wtype .. [[" == "clear" then return end
            local ov=Instance.new("Frame")
            ov.Name="WeatherOverlay"
            ov.Size=UDim2.new(1,0,1,0)
            ov.BackgroundTransparency=0.5
            ov.BorderSizePixel=0
            ov.ZIndex=999
            ov.Parent=sg
            if "]] .. wtype .. [[" == "rain" then
                ov.BackgroundColor3=Color3.fromRGB(60,80,120)
                ov.BackgroundTransparency=0.4
                for i=1,25 do
                    local d=Instance.new("Frame")
                    d.Size=UDim2.new(0.003,0,0.02,0)
                    d.Position=UDim2.new(math.random()/1.2,0,math.random()/1.2,0)
                    d.BackgroundColor3=Color3.fromRGB(180,200,255)
                    d.BackgroundTransparency=0.3
                    d.Rotation=20
                    d.BorderSizePixel=0
                    d.Parent=ov
                    task.spawn(function()
                        while d and d.Parent do
                            d.Position=d.Position+UDim2.new(0.005,0,0.008,0)
                            if d.Position.Y.Scale>1.2 then d.Position=UDim2.new(math.random()/1.2,0,-0.1,0) end
                            task.wait(0.05)
                        end
                    end)
                end
            elseif "]] .. wtype .. [[" == "snow" then
                ov.BackgroundColor3=Color3.fromRGB(200,210,230)
                ov.BackgroundTransparency=0.3
                for i=1,20 do
                    local d=Instance.new("Frame")
                    local sz=0.008+math.random()*0.015
                    d.Size=UDim2.new(sz,0,sz,0)
                    d.Position=UDim2.new(math.random()/1.2,0,math.random()/1.2,0)
                    d.BackgroundColor3=Color3.fromRGB(255,255,255)
                    d.BackgroundTransparency=0.2
                    d.BorderSizePixel=0
                    d.Parent=ov
                    local c=Instance.new("UICorner")
                    c.CornerRadius=UDim.new(1,0)
                    c.Parent=d
                    task.spawn(function()
                        while d and d.Parent do
                            d.Position=d.Position+UDim2.new(0,0,0.005,0)
                            if d.Position.Y.Scale>1.2 then d.Position=UDim2.new(math.random()/1.2,0,-0.1,0) end
                            task.wait(0.05)
                        end
                    end)
                end
            elseif "]] .. wtype .. [[" == "fog" then
                ov.BackgroundColor3=Color3.fromRGB(150,150,170)
                ov.BackgroundTransparency=0.45
            elseif "]] .. wtype .. [[" == "storm" then
                ov.BackgroundColor3=Color3.fromRGB(30,30,50)
                ov.BackgroundTransparency=0.3
                for i=1,30 do
                    local d=Instance.new("Frame")
                    d.Size=UDim2.new(0.005,0,0.03,0)
                    d.Position=UDim2.new(math.random()/1.2,0,math.random()/1.2,0)
                    d.BackgroundColor3=Color3.fromRGB(200,220,255)
                    d.BackgroundTransparency=0.2
                    d.Rotation=30
                    d.BorderSizePixel=0
                    d.Parent=ov
                    task.spawn(function()
                        while d and d.Parent do
                            d.Position=d.Position+UDim2.new(0.008,0,0.015,0)
                            if d.Position.Y.Scale>1.2 then d.Position=UDim2.new(math.random()/1.2,0,-0.1,0) end
                            task.wait(0.03)
                        end
                    end)
                end
                for i=1,3 do
                    task.wait(0.5+math.random()*0.5)
                    local flash=Instance.new("Frame")
                    flash.Size=UDim2.new(1,0,1,0)
                    flash.BackgroundColor3=Color3.fromRGB(255,255,255)
                    flash.BackgroundTransparency=0.5
                    flash.BorderSizePixel=0
                    flash.ZIndex=1000
                    flash.Parent=ov
                    task.spawn(function()
                        local tween=TS:Create(flash,TweenInfo.new(0.1),{BackgroundTransparency=0.8})
                        tween:Play()
                        task.wait(0.1)
                        flash:Destroy()
                    end)
                end
            end
            task.delay(6,function() pcall(function() ov:Destroy() end) end)
        ]]
    end
    
    if action == "server" then
        return [[
            for _,p in ipairs(game.Players:GetPlayers()) do
                local c=p.Character
                if c then
                    for _,x in ipairs(c:GetDescendants()) do
                        if x:IsA("BasePart") and x.Name~="HumanoidRootPart" then
                            x.Color=Color3.fromHSV(math.random(),1,1)
                        end
                    end
                end
            end
        ]]
    end
    
    if action == "clear" then
        return [[
            for _,x in ipairs(workspace:GetChildren()) do
                if x:IsA("Part") and x.Anchored and x.Name~="Baseplate" then
                    if not x.Parent:IsA("Model") or not x.Parent:FindFirstChild("Humanoid") then
                        pcall(function() x:Destroy() end)
                    end
                end
            end
            for _,x in ipairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
                if x.Name=="WeatherOverlay" then pcall(function() x:Destroy() end) end
            end
            for _,x in ipairs(workspace:GetChildren()) do
                if x.Name=="Follower" then pcall(function() x:Destroy() end) end
            end
        ]]
    end
    
    -- ===== 🆕 重力 =====
    if action == "gravity" then
        local val = num or 50
        if string.find(lower, "低") or string.find(lower, "轻") or string.find(lower, "小") or string.find(lower, "失重") or string.find(lower, "零") then
            val = math.max(1, val)
            return [[
                workspace.Gravity=]] .. val .. [[
                print("重力已设置为: ]] .. val .. [[" )
            ]]
        elseif string.find(lower, "高") or string.find(lower, "重") or string.find(lower, "大") or string.find(lower, "强") then
            val = math.min(500, val)
            return [[
                workspace.Gravity=]] .. val .. [[
                print("重力已设置为: ]] .. val .. [[" )
            ]]
        else
            return [[
                workspace.Gravity=50
                print("重力已重置为50")
            ]]
        end
    end
    
    -- ===== 🆕 速度 =====
    if action == "speed" then
        local val = num or 30
        if string.find(lower, "低") or string.find(lower, "慢") or string.find(lower, "小") then
            val = math.max(1, val)
            return [[
                local p=game.Players.LocalPlayer
                local c=p.Character
                if c then
                    local h=c:FindFirstChild("Humanoid")
                    if h then h.WalkSpeed=]] .. val .. [[ end
                end
                print("行走速度已设置为: ]] .. val .. [[" )
            ]]
        elseif string.find(lower, "高") or string.find(lower, "快") or string.find(lower, "大") or string.find(lower, "冲刺") or string.find(lower, "狂奔") then
            val = math.min(200, val)
            return [[
                local p=game.Players.LocalPlayer
                local c=p.Character
                if c then
                    local h=c:FindFirstChild("Humanoid")
                    if h then h.WalkSpeed=]] .. val .. [[ end
                end
                print("行走速度已设置为: ]] .. val .. [[" )
            ]]
        else
            return [[
                local p=game.Players.LocalPlayer
                local c=p.Character
                if c then
                    local h=c:FindFirstChild("Humanoid")
                    if h then h.WalkSpeed=16 end
                end
                print("行走速度已重置为16")
            ]]
        end
    end
    
    -- ===== 🆕 跳跃高度 =====
    if action == "jumpPower" then
        local val = num or 70
        if string.find(lower, "低") or string.find(lower, "小") or string.find(lower, "矮") then
            val = math.max(1, val)
            return [[
                local p=game.Players.LocalPlayer
                local c=p.Character
                if c then
                    local h=c:FindFirstChild("Humanoid")
                    if h then h.JumpPower=]] .. val .. [[ end
                end
                print("跳跃高度已设置为: ]] .. val .. [[" )
            ]]
        elseif string.find(lower, "高") or string.find(lower, "大") or string.find(lower, "增强") then
            val = math.min(500, val)
            return [[
                local p=game.Players.LocalPlayer
                local c=p.Character
                if c then
                    local h=c:FindFirstChild("Humanoid")
                    if h then h.JumpPower=]] .. val .. [[ end
                end
                print("跳跃高度已设置为: ]] .. val .. [[" )
            ]]
        else
            return [[
                local p=game.Players.LocalPlayer
                local c=p.Character
                if c then
                    local h=c:FindFirstChild("Humanoid")
                    if h then h.JumpPower=50 end
                end
                print("跳跃高度已重置为50")
            ]]
        end
    end
    
    -- ===== 🆕 大小 =====
    if action == "size" then
        local val = num or 2
        if string.find(lower, "小") or string.find(lower, "迷你") or string.find(lower, "缩小") then
            val = math.max(0.3, val)
            val = 1 / val
            return [[
                local p=game.Players.LocalPlayer
                local c=p.Character
                if c then
                    for _,x in ipairs(c:GetDescendants()) do
                        if x:IsA("BasePart") then
                            x.Size=x.Size*]] .. val .. [[
                        end
                    end
                end
                print("角色已缩小")
            ]]
        elseif string.find(lower, "大") or string.find(lower, "巨大") or string.find(lower, "放大") or string.find(lower, "巨人") then
            val = math.min(10, val)
            return [[
                local p=game.Players.LocalPlayer
                local c=p.Character
                if c then
                    for _,x in ipairs(c:GetDescendants()) do
                        if x:IsA("BasePart") then
                            x.Size=x.Size*]] .. val .. [[
                        end
                    end
                end
                print("角色已放大")
            ]]
        else
            return "print('请输入 变大 或 变小')"
        end
    end
    
    -- ===== 🆕 透明度 =====
    if action == "transparency" then
        if string.find(lower, "隐") or string.find(lower, "消失") or string.find(lower, "完全") then
            return [[
                local p=game.Players.LocalPlayer
                local c=p.Character
                if c then
                    for _,x in ipairs(c:GetDescendants()) do
                        if x:IsA("BasePart") then
                            x.Transparency=1
                            x.CanCollide=false
                        end
                    end
                end
                print("已隐身")
            ]]
        elseif string.find(lower, "半") then
            return [[
                local p=game.Players.LocalPlayer
                local c=p.Character
                if c then
                    for _,x in ipairs(c:GetDescendants()) do
                        if x:IsA("BasePart") then
                            x.Transparency=0.5
                        end
                    end
                end
                print("已半透明")
            ]]
        elseif string.find(lower, "恢复") or string.find(lower, "取消") or string.find(lower, "关") then
            return [[
                local p=game.Players.LocalPlayer
                local c=p.Character
                if c then
                    for _,x in ipairs(c:GetDescendants()) do
                        if x:IsA("BasePart") then
                            x.Transparency=0
                            x.CanCollide=true
                        end
                    end
                end
                print("已恢复可见")
            ]]
        else
            return [[
                local p=game.Players.LocalPlayer
                local c=p.Character
                if c then
                    for _,x in ipairs(c:GetDescendants()) do
                        if x:IsA("BasePart") and x.Name~="HumanoidRootPart" then
                            x.Transparency=0.7
                        end
                    end
                end
                print("已半透明")
            ]]
        end
    end
    
    if action == "help" then
        return [[
            print("=== 🧠 AIHub v9 完整功能 ===")
            print("")
            print("🦘 跳跃 | 跳 蹦 跃 起跳")
            print("💃 跳舞 | 舞 舞蹈 摇摆 蹦迪")
            print("🕊️ 飞行 | 飞 飞行 翱翔 升空")
            print("🌈 彩虹 | 彩 彩虹 变色 七彩")
            print("🧱 生成 | 生 生成 造 创建 方块")
            print("💥 爆炸 | 爆 爆炸 炸 爆破")
            print("👥 分身 | 分 分身 克隆 影分身")
            print("🌤️ 天气 | 雨 雪 雾 晴 风暴")
            print("🌐 全服 | 服 全服 全体 所有人")
            print("🧹 清空 | 清 清除 清空 删除")
            print("")
            print("⚡ 重力 | 低重力 高重力 失重 漂浮")
            print("🏃 速度 | 加速 减速 冲刺 慢速")
            print("📈 跳跃高度 | 跳高 跳低 增强跳跃")
            print("📏 大小 | 变大 变小 巨人 迷你")
            print("👻 透明 | 隐身 半透明 恢复")
            print("")
            print("💡 可加数字: 重力50 速度30")
            print("💡 多个功能可组合使用")
        ]]
    end
    
    return "未知", "print('未知指令，输入 帮助 查看')"
end

-- ===== 组合代码 =====
local function generateCombinedCode(matches, rawCmd)
    local codes = {}
    local seen = {}
    for _, action in ipairs(matches) do
        if not seen[action] then
            seen[action] = true
            local _, code = getActionCode(action, rawCmd)
            if code and code ~= "" then
                table.insert(codes, code)
            end
        end
    end
    return table.concat(codes, "\n")
end

-- ===== 主生成函数 =====
local function genCode(cmd)
    local matches = getMatches(cmd)
    
    if #matches >= 2 then
        return "组合(" .. table.concat(matches, "+") .. ")", generateCombinedCode(matches, cmd)
    end
    
    if #matches == 1 then
        local action = matches[1]
        return getActionName(action), getActionCode(action, cmd)
    end
    
    return "自定义代码", cmd
end

-- ===== 执行 =====
local function exec(cmd)
    if processing then return end
    if not cmd or cmd == "" then
        setStatus("⚠️ 输入指令", Theme.Error)
        return
    end
    
    processing = true
    setDot(Theme.Warn, "思考中")
    setStatus("⏳ 处理中...", Theme.Warn)
    
    local actionName, code = genCode(cmd)
    
    log("💬 " .. cmd, Theme.Text)
    log("🤖 " .. actionName, Theme.Primary)
    
    local s, e = pcall(function()
        local f = loadstring(code)
        if f then
            f()
            return true
        end
        return false, "编译失败"
    end)
    
    if s then
        setDot(Theme.Success, "在线")
        setStatus("✅ " .. actionName, Theme.Success)
        log("✅ 成功", Theme.Success)
    else
        setDot(Theme.Error, "错误")
        setStatus("❌ " .. tostring(e), Theme.Error)
        log("❌ " .. tostring(e), Theme.Error)
    end
    
    processing = false
end

-- ===== 事件绑定 =====
SendBtn.MouseButton1Click:Connect(function()
    local t = InputBox.Text
    if t and t ~= "" then
        InputBox.Text = ""
        exec(t)
    end
end)

InputBox.FocusLost:Connect(function(e)
    if e then
        local t = InputBox.Text
        if t and t ~= "" then
            InputBox.Text = ""
            exec(t)
        end
    end
end)

q1.MouseButton1Click:Connect(function() exec("跳") end)
q2.MouseButton1Click:Connect(function() exec("舞") end)
q3.MouseButton1Click:Connect(function() exec("飞") end)
q4.MouseButton1Click:Connect(function() exec("彩") end)
q5.MouseButton1Click:Connect(function() exec("生") end)
q6.MouseButton1Click:Connect(function() exec("爆") end)
q7.MouseButton1Click:Connect(function() exec("分") end)
q8.MouseButton1Click:Connect(function() exec("雨") end)
q9.MouseButton1Click:Connect(function() exec("服") end)
q10.MouseButton1Click:Connect(function()
    local acts = {"跳","舞","飞","彩","生","爆","分","雨","重力","速度"}
    local c = {}
    for i = 1, math.random(2, 3) do
        table.insert(c, acts[math.random(#acts)])
    end
    log("🎲 " .. table.concat(c, "+"), Theme.Warn)
    exec(table.concat(c, " "))
end)

-- ===== 拖动 =====
local drag = false
local ds = nil
local sp = nil

TB.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = true
        ds = i.Position
        sp = Main.Position
    end
end)

UIS.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
        local d = i.Position - ds
        Main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
    end
end)

UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = false
    end
end)

-- ===== 最小化/关闭 =====
MinBtn.MouseButton1Click:Connect(function()
    isMin = not isMin
    MinBtn.Text = isMin and "➕" or "─"
    ContentContainer.Visible = not isMin
    local targetSize = isMin and UDim2.new(0, 300, 0, 36) or UDim2.new(0, 300, 0, 320)
    TS:Create(Main, TweenInfo.new(0.2), { Size = targetSize }):Play()
    if isMin then
        SL.Text = "⚡ AIHub (已最小化)"
    else
        SL.Text = "⚡ 就绪"
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    SG:Destroy()
end)

-- ===== 启动 =====
log("⚡ AIHub v9 已加载", Theme.Primary)
log("🧠 完整功能版", Theme.Warn)
log("💡 试试: 低重力 / 加速 / 变大", Theme.TextSec)
log("📖 输入 帮助 查看所有功能", Theme.TextSec)
setStatus("⚡ 就绪", Theme.TextSec)

print("⚡ AIHub v9 已加载（完整功能版）")
