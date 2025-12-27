local player = game:GetService("Players").LocalPlayer

local blockList = player.PlayerGui.Menu.BlocksFrame.BlockMenu.BlockList
        
 for _, item in ipairs(blockList:GetChildren()) do
            if item:IsA("Frame") then
                item.Visible = true
            end
end
