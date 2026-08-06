-- =============================================
-- Delta 手机端 AI脚本生成器 (缩小版)
-- 尺寸紧凑，适合小屏手机
-- =============================================

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local isMobile = UserInputService.TouchEnabled

-- =============================================
-- 创建主界面 (缩小版)
-- =============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AIAssistantGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 420)  -- 缩小
MainFrame.Position = UDim2.new(0.5, -160, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

local Blur = Instance.new("Frame")
Blur.Size = UDim2.new(1, 0, 1, 0)
Blur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Blur.BackgroundTransparency = 0.3
Blur.BorderSizePixel = 0
Blur.ZIndex = 0
Blur.Parent = MainFrame
local BlurCorner = Instance.new("UICorner")
BlurCorner.CornerRadius = UDim.new(0, 12)
BlurCorner.Parent = Blur

-- =============================================
-- 标题栏 (缩小)
-- =============================================
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
TitleBar.BackgroundTransparency = 0.1
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0.6, 0, 1, 0)
TitleLabel.Position = UDim2.new(0.05, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🤖 AI"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 32, 0, 32)
MinimizeButton.Position = UDim2.new(1, -72, 0, 4)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
MinimizeButton.BackgroundTransparency = 0.2
MinimizeButton.Text = "➖"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 18
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Parent = TitleBar
local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = MinimizeButton

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 32, 0, 32)
CloseButton.Position = UDim2.new(1, -36, 0, 4)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BackgroundTransparency = 0.15
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TitleBar
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

-- =============================================
-- 输入框 (缩小)
-- =============================================
local InputFrame = Instance.new("Frame")
InputFrame.Size = UDim2.new(1, -14, 0, 42)
InputFrame.Position = UDim2.new(0, 7, 0, 50)
InputFrame.BackgroundTransparency = 1
InputFrame.Parent = MainFrame

local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(0.62, -5, 1, 0)
InputBox.Position = UDim2.new(0, 0, 0, 0)
InputBox.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.PlaceholderText = "指令..."
InputBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 190)
InputBox.TextSize = 15
InputBox.Font = Enum.Font.SourceSans
InputBox.ClearTextOnFocus = false
InputBox.BorderSizePixel = 0
InputBox.Parent = InputFrame
local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = InputBox

local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Size = UDim2.new(0.36, 0, 1, 0)
ExecuteButton.Position = UDim2.new(0.64, 5, 0, 0)
ExecuteButton.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
ExecuteButton.Text = "执行"
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.TextSize = 15
ExecuteButton.Font = Enum.Font.SourceSansBold
ExecuteButton.BorderSizePixel = 0
ExecuteButton.Parent = InputFrame
local ExecCorner = Instance.new("UICorner")
ExecCorner.CornerRadius = UDim.new(0, 8)
ExecCorner.Parent = ExecuteButton

-- =============================================
-- 快捷按钮 (缩小，两行，6个)
-- =============================================
local QuickFrame = Instance.new("Frame")
QuickFrame.Size = UDim2.new(1, -14, 0, 70)
QuickFrame.Position = UDim2.new(0, 7, 0, 102)
QuickFrame.BackgroundTransparency = 1
QuickFrame.Parent = MainFrame

local function createQuickButton(text, posX, posY, width, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(width or 0.31, 0, 0.42, 0)
    btn.Position = UDim2.new(posX, 0, posY, 0)
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 100)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansBold
    btn.BorderSizePixel = 0
    btn.Parent = QuickFrame
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    return btn
end

local btnJump = createQuickButton("🦘跳", 0, 0, 0.31, Color3.fromRGB(70, 130, 220))
local btnMove = createQuickButton("🚶走", 0.345, 0, 0.31, Color3.fromRGB(70, 190, 130))
local btnBack = createQuickButton("🔙退", 0.69, 0, 0.31, Color3.fromRGB(220, 130, 70))

local btnColor = createQuickButton("🎨色", 0, 0.58, 0.31, Color3.fromRGB(200, 130, 70))
local btnPart = createQuickButton("🧱块", 0.345, 0.58, 0.31, Color3.fromRGB(180, 70, 220))
local btnInfo = createQuickButton("📊信", 0.69, 0.58, 0.31, Color3.fromRGB(70, 200, 200))

-- =============================================
-- 额外按钮 (帮助+清空，缩小)
-- =============================================
local ExtraFrame = Instance.new("Frame")
ExtraFrame.Size = UDim2.new(1, -14, 0, 30)
ExtraFrame.Position = UDim2.new(0, 7, 0, 182)
ExtraFrame.BackgroundTransparency = 1
ExtraFrame.Parent = MainFrame

local btnHelp = createQuickButton("❓帮助", 0, 0, 0.48, Color3.fromRGB(80, 80, 130))
btnHelp.Parent = ExtraFrame
btnHelp.Size = UDim2.new(0.48, 0, 1, 0)
btnHelp.TextSize = 13

local btnClear = createQuickButton("🧹清空", 0.52, 0, 0.48, Color3.fromRGB(200, 80, 80))
btnClear.Parent = ExtraFrame
btnClear.Size = UDim2.new(0.48, 0, 1, 0)
btnClear.TextSize = 13

-- =============================================
-- 日志区域 (缩小)
-- =============================================
local LogFrame = Instance.new("Frame")
LogFrame.Size = UDim2.new(1, -14, 0, 140)
LogFrame.Position = UDim2.new(0, 7, 0, 222)
LogFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
LogFrame.BackgroundTransparency = 0.2
LogFrame.BorderSizePixel = 0
LogFrame.Parent = MainFrame
local LogCorner = Instance.new("UICorner")
LogCorner.CornerRadius = UDim.new(0, 8)
LogCorner.Parent = LogFrame

local LogLabel = Instance.new("TextLabel")
LogLabel.Size = UDim2.new(1, -8, 0, 18)
LogLabel.Position = UDim2.new(0, 4, 0, 4)
LogLabel.BackgroundTransparency = 1
LogLabel.Text = "📋 日志"
LogLabel.TextColor3 = Color3.fromRGB(150, 150, 210)
LogLabel.TextSize = 12
LogLabel.TextXAlignment = Enum.TextXAlignment.Left
LogLabel.Font = Enum.Font.SourceSans
LogLabel.Parent = LogFrame

local LogBox = Instance.new("ScrollingFrame")
LogBox.Size = UDim2.new(1, -8, 1, -28)
LogBox.Position = UDim2.new(0, 4, 0, 24)
LogBox.BackgroundTransparency = 1
LogBox.BorderSizePixel = 0
LogBox.ScrollBarThickness = 3
LogBox.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 160)
LogBox.Parent = LogFrame

local LogList = Instance.new("UIListLayout")
LogList.Padding = UDim.new(0, 2)
LogList.SortOrder = Enum.SortOrder.LayoutOrder
LogList.Parent = LogBox

-- =============================================
-- 状态栏 (缩小)
-- =============================================
local StatusBar = Instance.new("Frame")
StatusBar.Size = UDim2.new(1, 0, 0, 28)
StatusBar.Position = UDim2.new(0, 0, 1, -28)
StatusBar.BackgroundColor3 = Color3.fromRGB(30, 30, 55)
StatusBar.BackgroundTransparency = 0.2
StatusBar.BorderSizePixel = 0
StatusBar.Parent = MainFrame
local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 12)
StatusCorner.Parent = StatusBar

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -8, 1, 0)
StatusLabel.Position = UDim2.new(0, 4, 0, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "✅ 就绪"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 210)
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.Parent = StatusBar

-- =============================================
-- 最小化状态
-- =============================================
local isMinimized = false
local minimizedSize = UDim2.new(0, 320, 0, 40)
local expandedSize = UDim2.new(0, 320, 0, 420)

-- =============================================
-- 日志函数
-- =============================================
local function addLog(message, color)
    color = color or Color3.fromRGB(200, 200, 255)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 18)
    label.BackgroundTransparency = 1
    label.Text = message
    label.TextColor3 = color
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.SourceSans
    label.Parent = LogBox
    task.wait(0.05)
    LogBox.CanvasPosition = Vector2.new(0, LogBox.CanvasSize.Y.Offset)
    local children = LogBox:GetChildren()
    for i = 1, #children - 40 do
        if children[i]:IsA("TextLabel") then
            children[i]:Destroy()
        end
    end
end

local function setStatus(text, isError)
    local color = isError and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(150, 150, 210)
    StatusLabel.Text = text
    StatusLabel.TextColor3 = color
end

-- =============================================
-- AI引擎
-- =============================================
local function generateCode(instruction)
    instruction = string.lower(instruction)
    if string.find(instruction, "跳") then
        return "local plr=game.Players.LocalPlayer;local char=plr.Character or plr.CharacterAdded:Wait();local hum=char:WaitForChild('Humanoid');hum:ChangeState(Enum.HumanoidStateType.Jumping)"
    end
    if string.find(instruction, "前进") or string.find(instruction, "走") then
        return "local plr=game.Players.LocalPlayer;local char=plr.Character or plr.CharacterAdded:Wait();local root=char:FindFirstChild('HumanoidRootPart');local hum=char:FindFirstChild('Humanoid');if root and hum then hum:MoveTo(root.Position + root.CFrame.LookVector * 15) end"
    end
    if string.find(instruction, "后退") or string.find(instruction, "退") then
        return "local plr=game.Players.LocalPlayer;local char=plr.Character or plr.CharacterAdded:Wait();local root=char:FindFirstChild('HumanoidRootPart');local hum=char:FindFirstChild('Humanoid');if root and hum then hum:MoveTo(root.Position - root.CFrame.LookVector * 15) end"
    end
    if string.find(instruction, "颜色") or string.find(instruction, "色") or string.find(instruction, "变色") then
        return "local plr=game.Players.LocalPlayer;local char=plr.Character or plr.CharacterAdded:Wait();for _,part in ipairs(char:GetDescendants()) do if part:IsA('BasePart') and part.Name~='HumanoidRootPart' then part.Color=Color3.fromHSV(math.random(),1,1) end end"
    end
    if string.find(instruction, "生成") or string.find(instruction, "块") or string.find(instruction, "零件") then
        return "local plr=game.Players.LocalPlayer;local char=plr.Character or plr.CharacterAdded:Wait();local root=char:FindFirstChild('HumanoidRootPart');if root then local part=Instance.new('Part');part.Size=Vector3.new(2,2,2);part.Position=root.Position+Vector3.new(0,5,0);part.Anchored=true;part.BrickColor=BrickColor.Random();part.Material=Enum.Material.Neon;part.Parent=workspace;task.delay(5,function() part:Destroy() end) end"
    end
    if string.find(instruction, "信息") or string.find(instruction, "状态") then
        return "local plr=game.Players.LocalPlayer;local char=plr.Character;local info='玩家: '..plr.Name;if char then local root=char:FindFirstChild('HumanoidRootPart');if root then info=info..' | 位置:'..tostring(root.Position) end;local hum=char:FindFirstChild('Humanoid');if hum then info=info..' | 血量:'..string.format('%.0f',hum.Health)..'/'..hum.MaxHealth end else info=info..' | 未加载' end;print(info)"
    end
    if string.find(instruction, "清空") or string.find(instruction, "clear") then
        return "for _,c in ipairs(workspace:GetChildren()) do if c:IsA('Part') and c.Anchored and c.Parent~=game then c:Destroy() end end"
    end
    if string.find(instruction, "帮助") or string.find(instruction, "help") then
        return "print('=== AI指令 === 跳 走 退 色 块 信息 清空 帮助')"
    end
    return instruction
end

-- =============================================
-- 执行函数
-- =============================================
local function executeInstruction(instruction)
    if not instruction or instruction == "" then
        setStatus("⚠️ 输入指令", true)
        return
    end
    setStatus("⏳ 生成中...")
    addLog("> " .. instruction, Color3.fromRGB(255, 255, 150))
    local code = generateCode(instruction)
    addLog("📝 " .. string.sub(code, 1, 40) .. (string.len(code) > 40 and "..." or ""), Color3.fromRGB(150, 200, 255))
    local success, err = pcall(function()
        local func = loadstring(code)
        if func then func() setStatus("✅ 成功") addLog("✅ 成功", Color3.fromRGB(100, 255, 150)) else error("编译失败") end
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

btnJump.MouseButton1Click:Connect(function() executeInstruction("跳") end)
btnMove.MouseButton1Click:Connect(function() executeInstruction("走") end)
btnBack.MouseButton1Click:Connect(function() executeInstruction("退") end)
btnColor.MouseButton1Click:Connect(function() executeInstruction("色") end)
btnPart.MouseButton1Click:Connect(function() executeInstruction("块") end)
btnInfo.MouseButton1Click:Connect(function() executeInstruction("信息") end)
btnHelp.MouseButton1Click:Connect(function() executeInstruction("帮助") end)
btnClear.MouseButton1Click:Connect(function() executeInstruction("清空") end)

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
addLog("🤖 AI已加载", Color3.fromRGB(100, 200, 255))
addLog("📱 缩小版", Color3.fromRGB(150, 150, 200))
setStatus("✅ 就绪")

print("🤖 AI生成器已加载 (缩小版)")
