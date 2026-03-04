return function(plugin, container)
	-- We require siblings from the 'container' passed by the bootstrapper
	local Datastores = require(container:WaitForChild("Datastores"))
	local UIBuilder  = require(container:WaitForChild("UIBuilder"))
	local Config     = require(container:WaitForChild("Config"))

	-- Toolbar Setup
	local toolbar = plugin:CreateToolbar("Administer Rescue")
	local toggleButton = toolbar:CreateButton("Administer Rescue", "Open Rescue Module", "rbxassetid://116599744136879")
	toggleButton.ClickableWhenViewportHidden = true

	-- Widget Setup
	local widgetInfo = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, false, 350, 250, 300, 200)
	local widget = plugin:CreateDockWidgetPluginGui("AdministerWiperWidget", widgetInfo)
	widget.Title = "Administer Rescue"

	-- Build UI
	local wipeButton, loaderButton = UIBuilder.Create(widget)

	-- Loader Logic
	loaderButton.MouseButton1Click:Connect(function()
		local scriptName = "[Administer] Loader"
		-- Logic to find the config object in the game or attributes
		print("Attempting to create loader...")
		-- (Insert your loader script generation logic here)
	end)

	-- Wiping Logic
	local function wipeStore(name, dataStore)
		print("🧹 Starting wipe for: " .. name)
		local success, pages = pcall(function() return dataStore:ListKeysAsync() end)
		if success then
			while true do
				local items = pages:GetCurrentPage()
				for _, key in ipairs(items) do
					pcall(function() dataStore:RemoveAsync(key.KeyName) end)
				end
				if pages.IsFinished then break end
				pages:AdvanceToNextPageAsync()
			end
			print("✨ Finished: " .. name)
		end
	end

	wipeButton.MouseButton1Click:Connect(function()
		wipeButton.Text = "Wiping..."
		for nickname, storeObject in pairs(Datastores) do
			wipeStore(nickname, storeObject)
		end
		wipeButton.Text = "✅ Data Wiped!"
		task.wait(2)
		wipeButton.Text = "Wipe all Database data"
	end)

	toggleButton.Click:Connect(function() widget.Enabled = not widget.Enabled end)
	widget:GetPropertyChangedSignal("Enabled"):Connect(function() toggleButton:SetActive(widget.Enabled) end)
end