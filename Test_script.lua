local gameId = game.PlaceId
local scripts = {
    [2882332175] = "BDFS_NewUi.lua",
    [537413528] = "BABFT.lua"
}

local function load(str)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Script/" .. str))()
end

local scriptName = scripts[gameId]

if scriptName then
    local success, err = pcall(function()
        load(scriptName)
    end)
    
    if not success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Error",
            Text = "script is being updated, wait(),
            Duration = 10,
            Icon = "rbxassetid://16061885051"
        })
    end
else
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Notification",
        Text = "Script does not support game " .. gameId,
        Duration = 10,
        Icon = "rbxassetid://16965361609"
    })
end
