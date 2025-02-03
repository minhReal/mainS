-- I made this script first so that maybe I can make another game script using the script --
local marketplaceService = game:GetService("MarketplaceService")
local gameInfo = marketplaceService:GetProductInfo(gameId)
local gameId = game.PlaceId

local scripts = {
    [2882332175] = "BDFS_NewUi.lua",
    [537413528] = "BABFT.lua"
}

local function load(str)
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Script/" .. str))()
end

local scriptName = scripts[gameId]

if scriptName then
    local success, err = pcall(function()
        load(scriptName)
    end)
    
    if not success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Error",
            Text = "The script may be having an error, can you report this error on YT to let me know.",
            Duration = 10,
            Icon = "rbxassetid://16061885051"
        })
        setclipboard("https://www.youtube.com/@Hydro_genN")
    end
else
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Notification",
        Text = "Script does not support game: " .. gameInfo.Name,
        Duration = 10,
        Icon = "rbxassetid://16965361609"
    })
end
