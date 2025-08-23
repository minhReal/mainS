local objectsToVoid = {"goodcar", "goodcar2", "bestmovingcar", "bestmovingcar2"}
local voidPosition = Vector3.new(0, -500, 0)

for _, name in ipairs(objectsToVoid) do
    local obj = workspace:FindFirstChild(name)
    if obj and obj:IsA("BasePart") then
        obj.CFrame = CFrame.new(voidPosition)
    end
end
