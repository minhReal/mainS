local gui = Instance.new("ScreenGui")
gui.Name = "Gui"
gui.Parent = game.CoreGui


local ma = Instance.new("Frame")
ma.Size = UDim2.new(0.01, 0, 0.024, 0)
ma.Position = UDim2.new(0.495, 0, 0.4221, 0)
ma.BackgroundColor3 = Color3.new(1, 1, 1)
ma.BorderColor3 = Color3.new(0, 0, 0)
ma.BorderSizePixel = 0
ma.Active = true
ma.BackgroundTransparency = 0.3
ma.Draggable = false
ma.Parent = gui


local m = Instance.new("UICorner")
m.CornerRadius = UDim.new(50, 50)
m.Parent = ma
