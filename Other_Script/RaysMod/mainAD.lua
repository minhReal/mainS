--// DOUBLE WHITELIST CHECK
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

-- Link whitelist (2 file khác nhau)
local whitelistLinks = {
    "https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Other_Script/RaysMod/whitelist_1.lua",
    "https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Other_Script/RaysMod/whitelist_2.lua"
}

local whitelist1, whitelist2

-- Tải whitelist 1
local success1, result1 = pcall(function()
    return loadstring(game:HttpGet(whitelistLinks[1]))()
end)
if success1 and type(result1) == "table" then
    whitelist1 = result1
end

-- Tải whitelist 2
local success2, result2 = pcall(function()
    return loadstring(game:HttpGet(whitelistLinks[2]))()
end)
if success2 and type(result2) == "table" then
    whitelist2 = result2
end

-- Nếu 1 trong 2 file fail → dừng script
if not whitelist1 or not whitelist2 then
    StarterGui:SetCore("SendNotification", {
        Title = "❗ERROR❗",
        Text = "Whitelist file missing or invalid!",
        Icon = "rbxassetid://12077529452",
        Duration = 10
    })
    return
end

-- Hàm kiểm tra whitelist (chỉ cần có trong 1 file là pass)
local function isWhitelisted(name)
    for _, v in ipairs(whitelist1) do
        if v == name then return true end
    end
    for _, v in ipairs(whitelist2) do
        if v == name then return true end
    end
    return false
end

-- Nếu player không có trong whitelist → dừng
if not isWhitelisted(player.Name) then
    StarterGui:SetCore("SendNotification", {
        Title = "❗WARNING❗",
        Text = "You are not in the whitelist!",
        Icon = "rbxassetid://12077529452",
        Duration = 10
    })
    return
end

-- Nếu pass → load GUI script chính
loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Other_Script/RaysMod/Admin_GUI.lua"))()
