local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local API = "http://localhost:3000/check?key="

-- UI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

local box = Instance.new("TextBox", gui)
box.PlaceholderText = "Enter Key"
box.Size = UDim2.new(0,200,0,40)
box.Position = UDim2.new(0.5,-100,0.5,-20)

local button = Instance.new("TextButton", gui)
button.Text = "Check Key"
button.Size = UDim2.new(0,200,0,40)
button.Position = UDim2.new(0.5,-100,0.5,30)

local label = Instance.new("TextLabel", gui)
label.Size = UDim2.new(0,200,0,40)
label.Position = UDim2.new(0.5,-100,0.5,80)
label.BackgroundTransparency = 1

local function checkKey(key)
    local res = HttpService:GetAsync(API .. key)
    return HttpService:JSONDecode(res)
end

button.MouseButton1Click:Connect(function()
    local data = checkKey(box.Text)

    if data.valid then
        label.Text = "ACCESS GRANTED: " .. data.type
    else
        label.Text = "INVALID KEY"
    end
end)
