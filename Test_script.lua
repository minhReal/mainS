local function typeText(object, text, delay)
    for i = 1, #text do
        object.Text = text:sub(1, i)
        task.wait(delay)
    end
end

local function clearText(object, delay)
    for i = #object.Text, 1, -1 do
        object.Text = object.Text:sub(1, i - 1)
        task.wait(delay)
    end
end

local msg = Instance.new("Hint", workspace)
msg.Text = ""

local function displayMessages(messages)
    for _, message in ipairs(messages) do
        typeText(msg, message, 0.05)
        task.wait(2.5)
        clearText(msg, 0.05)
    end
    msg:Destroy()
end

local gameId = game.PlaceId

if gameId == 2882332175 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Script/BDFS_NewUi.lua"))()
    coroutine.wrap(displayMessages)({"Thanks for using my script", "Enjoy!"})
elseif gameId == 537413528 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/minhReal/mainS/refs/heads/main/Script/BABFT.lua"))()
    coroutine.wrap(displayMessages)({"Thanks for using my script", "Enjoy!"})
else
    msg.Text = "Script does not support this game"
    task.wait(2)
    msg:Destroy()
end
