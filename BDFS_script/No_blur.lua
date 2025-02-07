local lighting = game:GetService("Lighting")
local blurEffect = lighting:FindFirstChild("Blur")

local function SendNotification(title, description, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = description,
        Duration = duration
    })
end

if blurEffect then
    if blurEffect.Enabled then
        blurEffect.Enabled = false
        SendNotification("Notification", "Blur is off", 5)
    else
        SendNotification("Notification", "Blur was turned off before", 5)
    end
end
