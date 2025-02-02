local gameId = game.PlaceId
local scripts = {
    [2882332175] = "https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Script/BDFS_NewUi.lua",
    [537413528] = "https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Script/BABFT.lua"
}

local URL = scripts[gameId]

if URL then
    local success, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    sendnotification({
        Title = success and "Notification" or "Error",
        Text = success and "Script has been loaded successfully!" or "Failed to load script: " .. err,
        Duration = 5
    })
else
    sendnotification({
        Title = "Notification",
        Text = "Script does not support game " .. gameId,
        Duration = 5
    })
end
