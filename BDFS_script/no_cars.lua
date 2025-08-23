local objectsToVoid = {"goodcar", "goodcar2", "bestmovingcar", "bestmovingcar2"}

local voidPosition = Vector3.new(0, -500, 0)

local voidRunning = true

local function sendToVoid()
    for _, objectName in ipairs(objectsToVoid) do
        local object = workspace:FindFirstChild(objectName)
        if object and object:IsA("BasePart") then
      
            object.CFrame = CFrame.new(voidPosition)
        end
    end
end

spawn(function()
    while true do
        if voidRunning then
            sendToVoid()
        end
        wait(0.1)
    end
end)
