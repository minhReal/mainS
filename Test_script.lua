local gameId = game.PlaceId

if gameId == 2882332175 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Script/BDFS_NewUi.lua"))()
elseif gameId == 537413528 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Script/BABFT.lua"))()
else
    sendnotification({
        Title = "Thông báo",
        Text = "Script does not support game " .. gameId,
        Duration = 5
    })
end
