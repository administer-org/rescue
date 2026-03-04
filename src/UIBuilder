local TweenService = game:GetService("TweenService")
local UIBuilder = {}

local TWEEN_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

function UIBuilder.Create(parentWidget)
	local mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(1, 0, 1, 0)
	mainFrame.BackgroundTransparency = 0
	mainFrame.Parent = parentWidget

	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 32, 60)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 5))
	})
	gradient.Rotation = 45
	gradient.Parent = mainFrame

	local padding = Instance.new("UIPadding")
	padding.PaddingTop = UDim.new(0, 15)
	padding.PaddingBottom = UDim.new(0, 15)
	padding.PaddingLeft = UDim.new(0, 15)
	padding.PaddingRight = UDim.new(0, 15)
	padding.Parent = mainFrame

	local header = Instance.new("Frame")
	header.Size = UDim2.new(1, 0, 0, 40)
	header.BackgroundTransparency = 1
	header.Parent = mainFrame

	local title = Instance.new("TextLabel")
	title.Text = "ADMINISTER RESCUE"
	title.Size = UDim2.new(1, 0, 0.6, 0)
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Font = Enum.Font.GothamBlack
	title.TextSize = 16
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.BackgroundTransparency = 1
	title.Parent = header

	local subtitle = Instance.new("TextLabel")
	subtitle.Text = "v2.0 • DATABASE MANAGEMENT"
	subtitle.Size = UDim2.new(1, 0, 0.4, 0)
	subtitle.Position = UDim2.new(0, 0, 0.6, 0)
	subtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
	subtitle.Font = Enum.Font.GothamMedium
	subtitle.TextSize = 10
	subtitle.TextXAlignment = Enum.TextXAlignment.Left
	subtitle.BackgroundTransparency = 1
	subtitle.Parent = header

	local buttonContainer = Instance.new("Frame")
	buttonContainer.Size = UDim2.new(1, 0, 1, -50)
	buttonContainer.Position = UDim2.new(0, 0, 0, 50)
	buttonContainer.BackgroundTransparency = 1
	buttonContainer.Parent = mainFrame

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 12)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.Parent = buttonContainer

	local function createBtn(text, accentColor)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, 0, 0, 48)
		btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		btn.AutoButtonColor = false
		btn.Text = text
		btn.TextColor3 = Color3.fromRGB(230, 230, 230)
		btn.Font = Enum.Font.GothamBold
		btn.TextSize = 13
		btn.Parent = buttonContainer

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 6)
		corner.Parent = btn

		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 1
		stroke.Color = accentColor
		stroke.Transparency = 0.6
		stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		stroke.Parent = btn

		btn.MouseEnter:Connect(function()
			TweenService:Create(btn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			TweenService:Create(stroke, TWEEN_INFO, {Transparency = 0, Thickness = 1.5}):Play()
		end)

		btn.MouseLeave:Connect(function()
			TweenService:Create(btn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
			TweenService:Create(stroke, TWEEN_INFO, {Transparency = 0.6, Thickness = 1}):Play()
		end)

		btn.MouseButton1Down:Connect(function()
			btn.Size = UDim2.new(0.98, 0, 0, 46)
			task.wait(0.1)
			btn.Size = UDim2.new(1, 0, 0, 48)
		end)

		return btn
	end

	local loaderButton = createBtn("GENERATE GITHUB LOADER", Color3.fromRGB(0, 140, 255))
	local wipeButton = createBtn("WIPE DATABASE INSTANCES", Color3.fromRGB(255, 60, 60))

	return wipeButton, loaderButton
end

return UIBuilder