local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

-- 🔗 YOUR SERVER URL (replace this)
local API = "http://YOUR-SERVER/roblox/check?key="

-- =========================
-- UI
-- =========================
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 200)
frame.Position = UDim2.new(0.5, -175, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Parent = gui

local box = Instance.new("TextBox")
box.PlaceholderText = "Enter Key"
box.Size = UDim2.new(1, -20, 0, 40)
box.Position = UDim2.new(0, 10, 0, 30)
box.Parent = frame

local button = Instance.new("TextButton")
button.Text = "Verify Key"
button.Size = UDim2.new(1, -20, 0, 40)
button.Position = UDim2.new(0, 10, 0, 90)
button.Parent = frame

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, -20, 0, 40)
label.Position = UDim2.new(0, 10, 0, 140)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(255,255,255)
label.Text = ""
label.Parent = frame

-- =========================
-- KEY CHECK FUNCTION
-- =========================
local function checkKey(key)
    local success, response = pcall(function()
        return HttpService:GetAsync(API .. key)
    end)

    if not success then
        return false, "Server Error"
    end

    local data = HttpService:JSONDecode(response)

    return data.valid, data.type
end

-- =========================
-- BUTTON CLICK
-- =========================
button.MouseButton1Click:Connect(function()
    local key = box.Text

    if key == "" then
        label.Text = "Enter a key"
        return
    end

    local valid, typeKey = checkKey(key)

    if valid then
        label.Text = "ACCESS GRANTED: " .. tostring(typeKey)
        print("Player allowed:", player.Name)
    else
        label.Text = "INVALID KEY"
    end
end)
