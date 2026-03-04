return function(plugin, container, toggleButton)
	local Datastores = require(container:WaitForChild("Datastores"))
	local UIBuilder  = require(container:WaitForChild("UIBuilder"))
	local Config     = require(container:WaitForChild("Config"))
	
	local ServerScriptService = game:GetService("ServerScriptService")
	local MAX_RETRIES = 3

	local widgetInfo = DockWidgetPluginGuiInfo.new(
		Enum.InitialDockState.Float, 
		false, 
		false, 
		350, 250, 
		300, 200
	)
	local widget = plugin:CreateDockWidgetPluginGui("AdministerWiperWidget", widgetInfo)
	widget.Title = "Administer Rescue"

	local wipeButton, loaderButton = UIBuilder.Create(widget)

	loaderButton.MouseButton1Click:Connect(function()
		local scriptName = "[Administer] Loader"
		local packageId = Config.PackageId or 0

		if ServerScriptService:FindFirstChild(scriptName) then
			loaderButton.Text = "⚠️ Loader already exists!"
			task.wait(2)
			loaderButton.Text = "Create Asset Loader Script"
			return
		end

		local newScript = Instance.new("Script")
		newScript.Name = scriptName
		newScript.Source = [[
local InsertService = game:GetService("InsertService")
local assetId = ]] .. tostring(packageId) .. [[

local success, model = pcall(function()
	return InsertService:LoadAsset(assetId)
end)

if success and model then
	model.Parent = script
	print("✅ Administer Rescue: Asset loaded successfully.")
else
	warn("❌ Administer Rescue: Failed to load asset: " .. tostring(model))
end
		]]
		newScript.Parent = ServerScriptService
		
		loaderButton.Text = "✅ Loader Created!"
		task.wait(2)
		loaderButton.Text = "Create Asset Loader Script"
	end)

	local function wipeStore(name, dataStore)
		print("Starting wipe for: " .. name)
		local success, pages
		local attempt = 0

		repeat
			attempt += 1
			success, pages = pcall(function() return dataStore:ListKeysAsync() end)
			if not success then task.wait(1) end
		until success or attempt >= MAX_RETRIES

		if success then
			while true do
				local items = pages:GetCurrentPage()
				for _, key in ipairs(items) do
					pcall(function() dataStore:RemoveAsync(key.KeyName) end)
				end
				if pages.IsFinished then break end
				local nextSuccess = pcall(function() pages:AdvanceToNextPageAsync() end)
				if not nextSuccess then break end
			end
			print("Finished: " .. name)
		else
			warn("Error accessing " .. name .. " after " .. MAX_RETRIES .. " retries.")
		end
	end

	wipeButton.MouseButton1Click:Connect(function()
		wipeButton.Text = "Wiping..."
		wipeButton.Interactable = false
		
		task.spawn(function()
			for nickname, storeObject in pairs(Datastores) do
				wipeStore(nickname, storeObject)
			end
			wipeButton.Text = "✅ Data Wiped!"
			task.wait(2)
			wipeButton.Text = "Wipe all Database data"
			wipeButton.Interactable = true
		end)
	end)

	widget.Enabled = true
	toggleButton:SetActive(true)

	toggleButton.Click:Connect(function()
		widget.Enabled = not widget.Enabled
	end)

	widget:GetPropertyChangedSignal("Enabled"):Connect(function()
		toggleButton:SetActive(widget.Enabled)
	end)
end
