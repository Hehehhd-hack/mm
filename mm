-- Malame Insta Steal | Visual GUI

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("MalameGUI") then
    PlayerGui.MalameGUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MalameGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Main Window
local Window = Instance.new("Frame")
Window.Size = UDim2.fromOffset(240, 145)
Window.Position = UDim2.fromOffset(100, 100)
Window.BackgroundColor3 = Color3.fromRGB(20, 14, 0)
Window.BorderSizePixel = 0
Window.ClipsDescendants = true
Window.ZIndex = 5
Window.Parent = ScreenGui
local wc = Instance.new("UICorner"); wc.CornerRadius = UDim.new(0, 10); wc.Parent = Window
local ws = Instance.new("UIStroke"); ws.Color = Color3.fromRGB(245, 196, 0); ws.Thickness = 2; ws.Parent = Window

-- Particles INSIDE the window (low ZIndex so they sit behind everything)
local particleList = {}
for i = 1, 35 do
    local dot = Instance.new("Frame")
    dot.Size = UDim2.fromOffset(math.random(3, 6), math.random(3, 6))
    dot.Position = UDim2.fromScale(math.random(), math.random())
    dot.BackgroundColor3 = Color3.fromRGB(255, math.random(180, 220), 0)
    dot.BackgroundTransparency = math.random(40, 75) / 100
    dot.BorderSizePixel = 0
    dot.ZIndex = 2  -- behind buttons (ZIndex 6) and title (ZIndex 6)
    dot.Parent = Window
    local dc = Instance.new("UICorner"); dc.CornerRadius = UDim.new(1, 0); dc.Parent = dot
    table.insert(particleList, {
        frame = dot,
        vx = (math.random() - 0.5) * 0.004,
        vy = (math.random() - 0.5) * 0.004,
    })
end

RunService.RenderStepped:Connect(function()
    for _, p in ipairs(particleList) do
        local pos = p.frame.Position
        local nx = pos.X.Scale + p.vx
        local ny = pos.Y.Scale + p.vy
        if nx < 0 then nx = 1 end if nx > 1 then nx = 0 end
        if ny < 0 then ny = 1 end if ny > 1 then ny = 0 end
        p.frame.Position = UDim2.fromScale(nx, ny)
    end
end)

-- Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 34)
TitleBar.BackgroundColor3 = Color3.fromRGB(245, 196, 0)
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 6
TitleBar.Parent = Window
local tc = Instance.new("UICorner"); tc.CornerRadius = UDim.new(0, 9); tc.Parent = TitleBar
local tf = Instance.new("Frame")
tf.Size = UDim2.new(1, 0, 0, 12)
tf.Position = UDim2.new(0, 0, 1, -12)
tf.BackgroundColor3 = Color3.fromRGB(245, 196, 0)
tf.BorderSizePixel = 0
tf.ZIndex = 6
tf.Parent = TitleBar

-- Particles inside title bar too
for i = 1, 15 do
    local dot = Instance.new("Frame")
    dot.Size = UDim2.fromOffset(math.random(2, 5), math.random(2, 5))
    dot.Position = UDim2.fromScale(math.random(), math.random())
    dot.BackgroundColor3 = Color3.fromRGB(20, 14, 0)
    dot.BackgroundTransparency = math.random(50, 80) / 100
    dot.BorderSizePixel = 0
    dot.ZIndex = 6
    dot.Parent = TitleBar
    local dc = Instance.new("UICorner"); dc.CornerRadius = UDim.new(1, 0); dc.Parent = dot
    table.insert(particleList, {
        frame = dot,
        vx = (math.random() - 0.5) * 0.005,
        vy = (math.random() - 0.5) * 0.005,
    })
end

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.fromScale(1, 1)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⭐ Malame Insta Steal ⭐"
TitleLabel.TextColor3 = Color3.fromRGB(20, 14, 0)
TitleLabel.TextSize = 13
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.ZIndex = 8
TitleLabel.Parent = TitleBar

-- Drag logic
local dragging, dragStart, startPos = false, nil, nil
TitleBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = i.Position; startPos = Window.Position
    end
end)
TitleBar.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UserInputService.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - dragStart
        Window.Position = UDim2.fromOffset(startPos.X.Offset + d.X, startPos.Y.Offset + d.Y)
    end
end)

-- Button helper
local function makeButton(text, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -24, 0, 32)
    btn.Position = UDim2.fromOffset(12, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(35, 25, 0)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(245, 196, 0)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamSemibold
    btn.ZIndex = 7
    btn.Parent = Window
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = btn
    local s = Instance.new("UIStroke"); s.Color = Color3.fromRGB(245, 196, 0); s.Thickness = 1; s.Parent = btn
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(245, 196, 0)
        btn.TextColor3 = Color3.fromRGB(20, 14, 0)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(35, 25, 0)
        btn.TextColor3 = Color3.fromRGB(245, 196, 0)
    end)
    return btn
end

local AutoStealBtn = makeButton("Auto steal best", 46)
local ReturnPointBtn = makeButton("Set return point", 86)

-- Set return point: yellow "1" that stays in the world
local returnMarker = nil

ReturnPointBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if returnMarker then returnMarker:Destroy() end

    returnMarker = Instance.new("Part")
    returnMarker.Size = Vector3.new(0.1, 0.1, 0.1)
    returnMarker.Position = hrp.Position
    returnMarker.Anchored = true
    returnMarker.CanCollide = false
    returnMarker.Transparency = 1
    returnMarker.Parent = workspace

    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.fromOffset(40, 40)
    bb.AlwaysOnTop = true
    bb.Parent = returnMarker

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.fromScale(1, 1)
    lbl.BackgroundColor3 = Color3.fromRGB(245, 196, 0)
    lbl.TextColor3 = Color3.fromRGB(20, 14, 0)
    lbl.Text = "1"
    lbl.TextSize = 22
    lbl.Font = Enum.Font.GothamBold
    lbl.Parent = bb
    local lc = Instance.new("UICorner"); lc.CornerRadius = UDim.new(1, 0); lc.Parent = lbl
end)

AutoStealBtn.MouseButton1Click:Connect(function()
    -- your logic here
end)
