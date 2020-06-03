local Notification = {}

local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("NotificationGui") then
    Notification.Gui = CoreGui.NotificationGui
else
    Notification.Gui = Instance.new("ScreenGui", CoreGui)
    Notification.Gui.Name = "NotificationGui"
end

local function GetPosition(frame)
    local Height = 0
    for i, v in next, Notification.Gui:GetChildren() do
        Height = Height + v.AbsoluteSize.Y + 10
    end
    Height = (-Height) + frame.AbsoluteSize.Y
    return UDim2.new(1, -10, 1, Height)
end

function Notification:Send(title, text)
    local Height = 16 * #string.split(text, "\n")

    local Notif = Instance.new("Frame", Notification.Gui)
    Notif.AnchorPoint = Vector2.new(1, 1)
    Notif.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Notif.BorderSizePixel = 0

    local Title = Instance.new("TextLabel", Notif)
    Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Title.BorderSizePixel = 0
    Title.Font = Enum.Font.Highway
    Title.Size = UDim2.new(0, 200, 0, 30)
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20
    Title.TextStrokeTransparency = 0

    local Text = Instance.new("TextLabel", Notif)
    Text.BackgroundTransparency = 1
    Text.Font = Enum.Font.Highway
    Text.Position = UDim2.new(0, 0, 0, 35)
    Text.Text = text
    Text.TextColor3 = Color3.fromRGB(220, 220, 220)
    Text.TextSize = 16
    Text.TextWrapped = true

    Text.Size = UDim2.new(0, 200, 0, Height)
    Notif.Size = UDim2.new(0, 200, 0, 40 + Height)
    Notif.Position = GetPosition(Notif)

    wait(5)

    Notif:Destroy()
end

return Notification
