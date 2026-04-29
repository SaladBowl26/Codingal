local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN WINDOW
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 450, 0, 300)
main.Position = UDim2.new(0.5, -225, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.Parent = gui

Instance.new("UICorner", main)

-- TITLE BAR
local top = Instance.new("Frame")
top.Size = UDim2.new(1,0,0,40)
top.BackgroundColor3 = Color3.fromRGB(35,35,35)
top.Parent = main

Instance.new("UICorner", top)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,1,0)
title.BackgroundTransparency = 1
title.Text = "⚡ Nexus UI Library"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Parent = top

-- DRAGGING
local dragging, dragInput, startPos, startInput

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        startPos = main.Position
        startInput = input.Position
    end
end)

top.InputEnded:Connect(function()
    dragging = false
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - startInput
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- TAB AREA
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(0, 120, 1, -40)
tabFrame.Position = UDim2.new(0,0,0,40)
tabFrame.BackgroundColor3 = Color3.fromRGB(28,28,28)
tabFrame.Parent = main

-- CONTENT AREA
local content = Instance.new("Frame")
content.Size = UDim2.new(1,-120,1,-40)
content.Position = UDim2.new(0,120,0,40)
content.BackgroundColor3 = Color3.fromRGB(25,25,25)
content.Parent = main

-- FUNCTION: create button
local function createButton(name, callback, y)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,-10,0,40)
    btn.Position = UDim2.new(0,5,0,y)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Parent = content

    btn.MouseButton1Click:Connect(callback)
end

-- TEST BUTTONS
createButton("Hello", function()
    print("Hello clicked")
end, 10)

createButton("Test Key", function()
    print("Key system action here")
end, 60)
