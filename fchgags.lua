--[[ 
  Fikri Cihuy Hub Grow a Garden
  Part 1/6 – Main UI Structure and Tab Navigation
  Language: English
  UI: Mobile Friendly, Black background, Blue outline
--]]

-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Screen GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FikriCihuyHubGrowAGarden"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = PlayerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 650, 0, 430)
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -215)
mainFrame.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
mainFrame.BorderColor3 = Color3.fromRGB(0, 127, 255)
mainFrame.BorderSizePixel = 2
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Parent = screenGui

-- Main Frame Design
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", mainFrame).Color = Color3.fromRGB(0, 127, 255)

-- Title Bar
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleLabel.BorderSizePixel = 0
titleLabel.Text = "Fikri Cihuy Hub - Grow A Garden"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18
titleLabel.Parent = mainFrame

Instance.new("UICorner", titleLabel).CornerRadius = UDim.new(0, 8)

-- Tab Bar
local tabBar = Instance.new("Frame")
tabBar.Name = "TabBar"
tabBar.Size = UDim2.new(1, 0, 0, 45)
tabBar.Position = UDim2.new(0, 0, 0, 40)
tabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
tabBar.BorderSizePixel = 0
tabBar.Parent = mainFrame

-- Tabs
local tabNames = {"Status", "Main", "Event", "Shop", "Teleport", "Credits"}
local tabs = {}
local contentFrames = {}

for i, tabName in ipairs(tabNames) do
    local tabButton = Instance.new("TextButton")
    tabButton.Name = tabName.."Tab"
    tabButton.Size = UDim2.new(0, 100, 0, 30)
    tabButton.Position = UDim2.new(0, 10 + ((i - 1) * 105), 0, 7)
    tabButton.Text = tabName
    tabButton.Font = Enum.Font.GothamBold
    tabButton.TextSize = 14
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tabButton.AutoButtonColor = true
    tabButton.Parent = tabBar

    Instance.new("UICorner", tabButton).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", tabButton).Color = Color3.fromRGB(0, 127, 255)

    tabs[tabName] = tabButton
end

-- Content Frames
for _, tabName in ipairs(tabNames) do
    local content = Instance.new("Frame")
    content.Name = tabName.."Content"
    content.Size = UDim2.new(1, -20, 1, -100)
    content.Position = UDim2.new(0, 10, 0, 90)
    content.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    content.Visible = false
    content.Parent = mainFrame

    Instance.new("UICorner", content).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", content).Color = Color3.fromRGB(0, 127, 255)

    contentFrames[tabName] = content
end

-- Tab Switching Logic
local function showTab(name)
    for tab, frame in pairs(contentFrames) do
        frame.Visible = (tab == name)
    end
end

-- Tab Click Connect
for name, button in pairs(tabs) do
    button.MouseButton1Click:Connect(function()
        showTab(name.."Content")
    end)
end

-- Show Default Tab
showTab("StatusContent")

local statusFrame = contentFrames["Status"]

-- Title
local statusTitle = Instance.new("TextLabel")
statusTitle.Text = "Status Overview"
statusTitle.Size = UDim2.new(1, 0, 0, 30)
statusTitle.Position = UDim2.new(0, 0, 0, 0)
statusTitle.Font = Enum.Font.GothamBold
statusTitle.TextSize = 18
statusTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
statusTitle.BackgroundTransparency = 1
statusTitle.Parent = statusFrame

-- Info Grid Layout
local gridLayout = Instance.new("UIListLayout", statusFrame)
gridLayout.Padding = UDim.new(0, 6)
gridLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Utility Function to Create Status Box
local function createStatusLine(labelText, valueTextFunc)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 35)
	container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	container.BorderColor3 = Color3.fromRGB(0, 127, 255)
	container.Parent = statusFrame
	Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

	local label = Instance.new("TextLabel", container)
	label.Text = labelText
	label.Size = UDim2.new(0.5, 0, 1, 0)
	label.Position = UDim2.new(0, 10, 0, 0)
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.BackgroundTransparency = 1
	label.TextXAlignment = Enum.TextXAlignment.Left

	local value = Instance.new("TextLabel", container)
	value.Name = "Value"
	value.Text = "..."
	value.Size = UDim2.new(0.5, -10, 1, 0)
	value.Position = UDim2.new(0.5, 0, 0, 0)
	value.Font = Enum.Font.Gotham
	value.TextSize = 14
	value.TextColor3 = Color3.fromRGB(200, 255, 200)
	value.BackgroundTransparency = 1
	value.TextXAlignment = Enum.TextXAlignment.Right

	coroutine.wrap(function()
		while true do
			if container.Parent == nil then break end
			value.Text = valueTextFunc()
			wait(1)
		end
	end)()

	return container
end

-- Feature: Playtime
local joinTime = os.time()
createStatusLine("Playtime", function()
	local seconds = os.time() - joinTime
	local minutes = math.floor(seconds / 60)
	return tostring(minutes) .. " min"
end)

-- Feature: Earnings (mock)
local leaderstats = player:FindFirstChild("leaderstats")
createStatusLine("Harvest Earnings", function()
	if leaderstats and leaderstats:FindFirstChild("Cash") then
		return "$" .. tostring(leaderstats.Cash.Value)
	end
	return "$0"
end)

-- Feature: Join Date
createStatusLine("Join Date", function()
	local now = DateTime.now()
	return now:FormatLocalTime("dddd, MMMM D, YYYY", "en-us")
end)

-- Feature: Server Region
createStatusLine("Server Region", function()
	local ip = game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(player)
	return ip or "Unknown"
end)

-- Feature: Player Count
createStatusLine("Players in Server", function()
	return tostring(#Players:GetPlayers()) .. " players"
end)

-- Feature: Avatar Thumbnail
local avatarFrame = Instance.new("ImageLabel")
avatarFrame.Size = UDim2.new(0, 70, 0, 70)
avatarFrame.Position = UDim2.new(0.5, -35, 1, -80)
avatarFrame.BackgroundTransparency = 1
avatarFrame.Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=150&h=150"
avatarFrame.Parent = statusFrame

-- Feature: Weather (example detection)
createStatusLine("Current Weather", function()
	local replicated = game:GetService("ReplicatedStorage")
	local weather = replicated:FindFirstChild("CurrentWeather")
	if weather and weather:IsA("StringValue") then
		return weather.Value
	end
	return "Unknown"
end)

local mainFrameContent = contentFrames["Main"]

-- Grid Layout for Main Actions
local grid = Instance.new("UIGridLayout")
grid.CellSize = UDim2.new(0.45, 0, 0.25, 0)
grid.CellPadding = UDim2.new(0.05, 0, 0.05, 0)
grid.SortOrder = Enum.SortOrder.LayoutOrder
grid.Parent = mainFrameContent

-- Button Creation Utility
local function createMainButton(name, color, parent)
	local button = Instance.new("TextButton")
	button.Name = name.."Button"
	button.Text = name
	button.Font = Enum.Font.GothamBold
	button.TextSize = 16
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.BackgroundColor3 = color or Color3.fromRGB(0, 170, 255)
	button.BorderSizePixel = 0
	button.AutoButtonColor = true
	button.Parent = parent
	Instance.new("UICorner", button)
	return button
end

-- Plant Button (Feature: Collect All Plants)
local plantBtn = createMainButton("Collect Plants", Color3.fromRGB(0, 200, 255), mainFrameContent)
plantBtn.MouseButton1Click:Connect(function()
	local plantFolder = workspace:FindFirstChild("Plants")
	if not plantFolder then return end

	local count = 0
	for _, plant in pairs(plantFolder:GetChildren()) do
		local owner = plant:FindFirstChild("Owner")
		local ready = plant:FindFirstChild("IsReadyToHarvest")
		if owner and ready and ready.Value == true and (owner.Value == player or owner.Value == player.Name) then
			-- Example logic to destroy or harvest
			plant:Destroy()
			count += 1
		end
	end
	warn("Collected "..count.." plants.")
end)

-- Water Button (Feature: Sell Inventory)
local waterBtn = createMainButton("Sell Inventory", Color3.fromRGB(0, 150, 200), mainFrameContent)
waterBtn.MouseButton1Click:Connect(function()
	local inv = player:FindFirstChild("Inventory")
	if not inv or #inv:GetChildren() == 0 then
		warn("Please collect fruits before selling.")
		return
	end

	local sold = 0
	for _, fruit in pairs(inv:GetChildren()) do
		local val = fruit:GetAttribute("SellValue") or 100
		if fruit:IsA("Instance") then
			-- Optional: Add to currency
			-- leaderstats.Cash.Value += val
			fruit:Destroy()
			sold += 1
		end
	end
	print("Sold "..sold.." fruits.")
end)

-- Harvest Button (Feature: Toggle Hide Trees)
local hideTrees = false
local harvestBtn = createMainButton("Toggle Trees", Color3.fromRGB(0, 100, 200), mainFrameContent)
harvestBtn.MouseButton1Click:Connect(function()
	hideTrees = not hideTrees

	local plantFolder = workspace:FindFirstChild("Plants")
	if not plantFolder then return end

	for _, plant in pairs(plantFolder:GetChildren()) do
		local owner = plant:FindFirstChild("Owner")
		if owner and (owner.Value == player or owner.Value == player.Name) then
			for _, part in pairs(plant:GetDescendants()) do
				if part:IsA("BasePart") and (part.Name == "Tree" or part.Name == "Trunk" or part.Name == "Leaves") then
					part.Transparency = hideTrees and 1 or 0
					part.CanCollide = not hideTrees
				end
			end
		end
	end
	print(hideTrees and "Trees hidden" or "Trees shown")
end)

-- Remove Button (Feature: Open Fruit Purchase Menu)
local removeBtn = createMainButton("Open Fruit Buyer", Color3.fromRGB(255, 150, 0), mainFrameContent)
removeBtn.MouseButton1Click:Connect(function()
	local buyTab = contentFrames["Pembelian Buah"]
	showTab("Pembelian BuahContent")
	buyTab.Visible = true
end)

local eventFrame = contentFrames["Event"]

local layout = Instance.new("UIGridLayout")
layout.CellSize = UDim2.new(0.45, 0, 0.25, 0)
layout.CellPadding = UDim2.new(0.05, 0, 0.05, 0)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = eventFrame

-- Utility to Create Event Buttons
local function createEventButton(text, parent)
	local btn = Instance.new("TextButton")
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 15
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn)
	btn.Parent = parent
	return btn
end

-- Button 1: Teleport to Moonit Fruit
local teleportMoonit = createEventButton("Teleport to Moonit", eventFrame)
teleportMoonit.MouseButton1Click:Connect(function()
	local found = false
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and string.find(obj.Name:lower(), "moonit") then
			local owner = obj:FindFirstChild("Owner")
			local isMine = owner and (owner.Value == player or owner.Value == player.Name)
			if isMine then
				player.Character:MoveTo(obj.Position + Vector3.new(0, 3, 0))
				found = true
				break
			end
		end
	end
	if not found then
		warn("Your Moonit fruit is not in your plot.")
	end
end)

-- Button 2: ESP Moonit Fruit (Toggle)
local espActive = false
local moonitESPList = {}

local espMoonitBtn = createEventButton("ESP Moonit OFF", eventFrame)
espMoonitBtn.MouseButton1Click:Connect(function()
	espActive = not espActive
	espMoonitBtn.Text = "ESP Moonit " .. (espActive and "ON" or "OFF")

	-- Clear previous
	for _, v in pairs(moonitESPList) do
		if v:IsA("Highlight") then v:Destroy() end
	end
	table.clear(moonitESPList)

	if espActive then
		for _, obj in pairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") and string.find(obj.Name:lower(), "moonit") then
				local owner = obj:FindFirstChild("Owner")
				local isMine = owner and (owner.Value == player or owner.Value == player.Name)
				if isMine then
					local h = Instance.new("Highlight", obj)
					h.FillColor = Color3.fromRGB(0, 255, 255)
					h.OutlineColor = Color3.fromRGB(255, 255, 255)
					h.FillTransparency = 0.2
					h.OutlineTransparency = 0
					h.Adornee = obj
					table.insert(moonitESPList, h)
				end
			end
		end
	end
end)

-- Button 3: Teleport to Owl Event
local teleportOwlBtn = createEventButton("Teleport to Owl", eventFrame)
teleportOwlBtn.MouseButton1Click:Connect(function()
	local found = false
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and (obj.Name:lower():find("owl") or obj.Name:lower():find("hantu")) then
			player.Character:MoveTo(obj.Position + Vector3.new(0, 3, 0))
			print("Teleported to Owl Event")
			found = true
			break
		end
	end
	if not found then
		warn("Owl Event not found on map.")
	end
end)

-- Button 4: (Future event slot placeholder)
local futureBtn = createEventButton("Coming Soon...", eventFrame)
futureBtn.AutoButtonColor = false
futureBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local shopFrame = contentFrames["Shop"]

local layout = Instance.new("UIGridLayout")
layout.CellSize = UDim2.new(0.45, 0, 0.25, 0)
layout.CellPadding = UDim.new(0.05, 0)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = shopFrame

-- Utility for Shop Button
local function createShopButton(text, parent)
	local btn = Instance.new("TextButton")
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 15
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundColor3 = Color3.fromRGB(255, 204, 0)
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn)
	btn.Parent = parent
	return btn
end

-- Seed Shop UI Frame
local seedShopUI = Instance.new("Frame")
seedShopUI.Name = "SeedShopUI"
seedShopUI.Size = UDim2.new(0, 300, 0, 250)
seedShopUI.Position = UDim2.new(0.5, -150, 0.5, -125)
seedShopUI.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
seedShopUI.Visible = false
seedShopUI.Parent = screenGui
Instance.new("UICorner", seedShopUI)
Instance.new("UIStroke", seedShopUI).Color = Color3.fromRGB(0, 255, 0)

local seedLabel = Instance.new("TextLabel", seedShopUI)
seedLabel.Size = UDim2.new(1, 0, 0, 30)
seedLabel.BackgroundTransparency = 1
seedLabel.Text = "Seed Shop (UI only)"
seedLabel.Font = Enum.Font.GothamBold
seedLabel.TextSize = 16
seedLabel.TextColor3 = Color3.fromRGB(0, 255, 0)

-- Button 1: Open Seed Shop
local openSeedBtn = createShopButton("Open Seed Shop", shopFrame)
openSeedBtn.MouseButton1Click:Connect(function()
	seedShopUI.Visible = not seedShopUI.Visible
end)

-- Owl UI Frame
local owlUI = Instance.new("Frame")
owlUI.Name = "OwlHelperUI"
owlUI.Size = UDim2.new(0, 280, 0, 180)
owlUI.Position = UDim2.new(0.5, -140, 0.5, -90)
owlUI.BackgroundColor3 = Color3.fromRGB(80, 60, 150)
owlUI.Visible = false
owlUI.Parent = screenGui
Instance.new("UICorner", owlUI)
Instance.new("UIStroke", owlUI).Color = Color3.fromRGB(180, 255, 255)

local owlText = Instance.new("TextLabel", owlUI)
owlText.Text = "Mini Owl Helper is here!"
owlText.Size = UDim2.new(1, 0, 0.3, 0)
owlText.BackgroundTransparency = 1
owlText.Font = Enum.Font.Gotham
owlText.TextSize = 16
owlText.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Button 2: Open Owl UI
local owlBtn = createShopButton("Mini Owl Helper", shopFrame)
owlBtn.MouseButton1Click:Connect(function()
	owlUI.Visible = not owlUI.Visible
end)

-- Daily Quest UI
local questUI = Instance.new("Frame")
questUI.Name = "DailyQuestUI"
questUI.Size = UDim2.new(0, 280, 0, 200)
questUI.Position = UDim2.new(0.5, -140, 0.5, -100)
questUI.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
questUI.Visible = false
questUI.Parent = screenGui
Instance.new("UICorner", questUI)
Instance.new("UIStroke", questUI).Color = Color3.fromRGB(255, 170, 0)

local questTitle = Instance.new("TextLabel", questUI)
questTitle.Text = "Daily Quest - Gear Shop"
questTitle.Size = UDim2.new(1, 0, 0, 30)
questTitle.BackgroundTransparency = 1
questTitle.Font = Enum.Font.GothamBold
questTitle.TextSize = 16
questTitle.TextColor3 = Color3.fromRGB(255, 255, 0)

local questText = Instance.new("TextLabel", questUI)
questText.Text = "Harvest 5 fruits and plant 3 seeds."
questText.Size = UDim2.new(1, -20, 0, 80)
questText.Position = UDim2.new(0, 10, 0, 40)
questText.BackgroundTransparency = 1
questText.Font = Enum.Font.Gotham
questText.TextSize = 14
questText.TextColor3 = Color3.fromRGB(255, 255, 255)
questText.TextWrapped = true
questText.TextYAlignment = Enum.TextYAlignment.Top

-- Button 3: Open Daily Quest
local questBtn = createShopButton("Daily Quest", shopFrame)
questBtn.MouseButton1Click:Connect(function()
	questUI.Visible = not questUI.Visible
end)

-- Gear Shop UI
local gearUI = Instance.new("Frame")
gearUI.Name = "GearShopUI"
gearUI.Size = UDim2.new(0, 300, 0, 220)
gearUI.Position = UDim2.new(0.5, -150, 0.5, -110)
gearUI.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
gearUI.Visible = false
gearUI.Parent = screenGui
Instance.new("UICorner", gearUI)
Instance.new("UIStroke", gearUI).Color = Color3.fromRGB(255, 255, 0)

local gearTitle = Instance.new("TextLabel", gearUI)
gearTitle.Text = "Gear Shop UI"
gearTitle.Size = UDim2.new(1, 0, 0, 30)
gearTitle.BackgroundTransparency = 1
gearTitle.Font = Enum.Font.GothamBold
gearTitle.TextSize = 16
gearTitle.TextColor3 = Color3.fromRGB(255, 255, 0)

-- Button 4: Open Gear Shop UI
local gearBtn = createShopButton("Gear Shop", shopFrame)
gearBtn.MouseButton1Click:Connect(function()
	gearUI.Visible = not gearUI.Visible
end)

-- === TELEPORT TAB ===
local teleportFrame = contentFrames["Teleport"]
local teleportLayout = Instance.new("UIGridLayout", teleportFrame)
teleportLayout.CellSize = UDim2.new(0.45, 0, 0.25, 0)
teleportLayout.CellPadding = UDim.new(0.05, 0)
teleportLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function createTeleportButton(text)
	local btn = Instance.new("TextButton")
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 15
	btn.TextColor3 = Color3.fromRGB(0, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn)
	btn.Parent = teleportFrame
	return btn
end

-- Teleport Buttons
local teleportToSeed = createTeleportButton("To Seed Seller")
teleportToSeed.MouseButton1Click:Connect(function()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name:lower():find("seed") and obj.Name:lower():find("npc") then
			player.Character:MoveTo(obj.Position + Vector3.new(0, 3, 0))
			return
		end
	end
	warn("Seed NPC not found.")
end)

local teleportToSell = createTeleportButton("To Sell NPC")
teleportToSell.MouseButton1Click:Connect(function()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name:lower():find("sell") and obj.Name:lower():find("npc") then
			player.Character:MoveTo(obj.Position + Vector3.new(0, 3, 0))
			return
		end
	end
	warn("Sell NPC not found.")
end)

local teleportToGear = createTeleportButton("To Gear Shop")
teleportToGear.MouseButton1Click:Connect(function()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name:lower():find("gear") and obj.Name:lower():find("npc") then
			player.Character:MoveTo(obj.Position + Vector3.new(0, 3, 0))
			return
		end
	end
	warn("Gear NPC not found.")
end)

local teleportToEgg = createTeleportButton("To Egg Seller")
teleportToEgg.MouseButton1Click:Connect(function()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name:lower():find("egg") and obj.Name:lower():find("npc") then
			player.Character:MoveTo(obj.Position + Vector3.new(0, 3, 0))
			return
		end
	end
	warn("Egg NPC not found.")
end)

-- === CREDITS TAB ===
local creditsFrame = contentFrames["Credits"]

local creditsText = Instance.new("TextLabel", creditsFrame)
creditsText.Size = UDim2.new(1, -20, 1, -20)
creditsText.Position = UDim2.new(0, 10, 0, 10)
creditsText.BackgroundTransparency = 1
creditsText.TextColor3 = Color3.fromRGB(255, 255, 255)
creditsText.Font = Enum.Font.Gotham
creditsText.TextSize = 16
creditsText.TextWrapped = true
creditsText.TextYAlignment = Enum.TextYAlignment.Top
creditsText.Text = [[
Script created by:

Developer: Fiks Cihuy
Built by: Fiks Cihuy
Made In: Indonesia

Script Contribution:
Fiks Cihuy (90%)
LPG (10%)

Note: Thank you for using this script!
]]

-- === FRUIT PURCHASE TAB ===
local buyFrame = Instance.new("Frame", screenGui)
buyFrame.Name = "BuyFruitUI"
buyFrame.Size = UDim2.new(0, 320, 0, 200)
buyFrame.Position = UDim2.new(0.5, -160, 0.5, -100)
buyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
buyFrame.Visible = false
Instance.new("UICorner", buyFrame)

local selectedFruit = Instance.new("StringValue", player)
selectedFruit.Name = "SelectedFruit"
selectedFruit.Value = ""

-- Button to open from main tab (already exists, reuse showTab)

-- Choose Fruit Button
local chooseBtn = Instance.new("TextButton", buyFrame)
chooseBtn.Size = UDim2.new(0.45, 0, 0.2, 0)
chooseBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
chooseBtn.Text = "Select Apple"
chooseBtn.Font = Enum.Font.Gotham
chooseBtn.TextSize = 14
chooseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
chooseBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Instance.new("UICorner", chooseBtn)

chooseBtn.MouseButton1Click:Connect(function()
	selectedFruit.Value = "Apple"
	print("Selected: Apple")
end)

-- Buy Fruit Button
local buyBtn = Instance.new("TextButton", buyFrame)
buyBtn.Size = UDim2.new(0.45, 0, 0.2, 0)
buyBtn.Position = UDim2.new(0.5, 0, 0.2, 0)
buyBtn.Text = "Buy"
buyBtn.Font = Enum.Font.Gotham
buyBtn.TextSize = 14
buyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
buyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
Instance.new("UICorner", buyBtn)

buyBtn.MouseButton1Click:Connect(function()
	if selectedFruit.Value == "" then
		warn("Please select a fruit before buying.")
		return
	end

	local stockFolder = game:GetService("ReplicatedStorage"):FindFirstChild("FruitStock")
	if not stockFolder then
		warn("No stock found.")
		return
	end

	local fruitStock = stockFolder:FindFirstChild(selectedFruit.Value)
	if not fruitStock or fruitStock.Value <= 0 then
		warn("Selected fruit is out of stock.")
	else
		fruitStock.Value -= 1
		print("Purchased: " .. selectedFruit.Value)
	end
end)
