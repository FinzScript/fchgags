-- Fikri Cihuy Hub Grow a Garden - Part 1
-- Main GUI Structure, Draggable, Minimize, Centered

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")

-- Root ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "FikriCihuyHubGrowAGarden"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = PlayerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 650, 0, 430)
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -215)
mainFrame.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
mainFrame.BorderColor3 = Color3.fromRGB(0, 127, 255)
mainFrame.BorderSizePixel = 2
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

-- Corners and Outline
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(0, 127, 255)
stroke.Thickness = 2

-- Title Bar
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleLabel.Text = "Fikri Cihuy Hub - Grow A Garden"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextStrokeTransparency = 0.8
titleLabel.Parent = mainFrame
Instance.new("UICorner", titleLabel).CornerRadius = UDim.new(0, 8)

-- Minimize Button
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Text = "-"
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -35, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(0, 127, 255)
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 20
minimizeBtn.Parent = mainFrame
Instance.new("UICorner", minimizeBtn)

-- Tab & Content Setup
local tabNames = {"Status", "Main", "Event", "Shop", "Teleport", "Credits"}
local tabs = {}
local contentFrames = {}

-- Tab Bar
local tabBar = Instance.new("Frame", mainFrame)
tabBar.Name = "TabBar"
tabBar.Size = UDim2.new(1, 0, 0, 45)
tabBar.Position = UDim2.new(0, 0, 0, 40)
tabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

-- Create Tabs
for i, name in ipairs(tabNames) do
	local btn = Instance.new("TextButton")
	btn.Name = name.."Tab"
	btn.Text = name
	btn.Size = UDim2.new(0, 100, 0, 30)
	btn.Position = UDim2.new(0, 10 + (i - 1) * 105, 0, 7)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	btn.Parent = tabBar
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	tabs[name] = btn
end

-- Create Tab Content Frames
for _, name in ipairs(tabNames) do
	local content = Instance.new("Frame")
	content.Name = name.."Content"
	content.Size = UDim2.new(1, -20, 1, -100)
	content.Position = UDim2.new(0, 10, 0, 90)
	content.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	content.Visible = false
	content.Parent = mainFrame
	Instance.new("UICorner", content)
	contentFrames[name] = content
end

-- Tab Switching Logic
local function showTab(name)
	for tab, frame in pairs(contentFrames) do
		frame.Visible = (tab == name)
	end
end

for name, btn in pairs(tabs) do
	btn.MouseButton1Click:Connect(function()
		showTab(name.."Content")
	end)
end

-- Default tab
showTab("StatusContent")

-- Minimize toggle
minimizeBtn.MouseButton1Click:Connect(function()
	local state = not tabBar.Visible
	tabBar.Visible = state
	for _, v in pairs(contentFrames) do
		v.Visible = false
	end
end)

-- === STATUS TAB FEATURES ===
local statusFrame = contentFrames["Status"]

local layout = Instance.new("UIListLayout", statusFrame)
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Utility: Create status info box
local function createStatusInfo(titleText, valueFunc)
	local box = Instance.new("Frame")
	box.Size = UDim2.new(1, 0, 0, 40)
	box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	box.BorderColor3 = Color3.fromRGB(0, 127, 255)
	Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
	box.Parent = statusFrame

	local title = Instance.new("TextLabel", box)
	title.Size = UDim2.new(0.5, -10, 1, 0)
	title.Position = UDim2.new(0, 10, 0, 0)
	title.BackgroundTransparency = 1
	title.Text = titleText
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Font = Enum.Font.Gotham
	title.TextSize = 14
	title.TextXAlignment = Enum.TextXAlignment.Left

	local value = Instance.new("TextLabel", box)
	value.Name = "Value"
	value.Size = UDim2.new(0.5, -10, 1, 0)
	value.Position = UDim2.new(0.5, 0, 0, 0)
	value.BackgroundTransparency = 1
	value.TextColor3 = Color3.fromRGB(150, 255, 150)
	value.Font = Enum.Font.Gotham
	value.TextSize = 14
	value.TextXAlignment = Enum.TextXAlignment.Right

	coroutine.wrap(function()
		while box.Parent do
			pcall(function()
				value.Text = valueFunc()
			end)
			wait(1)
		end
	end)()

	value.Parent = box
end

-- Track playtime
local startTime = os.time()
createStatusInfo("Playtime", function()
	local elapsed = os.time() - startTime
	local min = math.floor(elapsed / 60)
	return min .. " min"
end)

-- Show harvest earnings (mock: use leaderstats if exists)
local leaderstats = player:FindFirstChild("leaderstats")
createStatusInfo("Harvest Earnings", function()
	if leaderstats and leaderstats:FindFirstChild("Cash") then
		return "$" .. tostring(leaderstats.Cash.Value)
	end
	return "$0"
end)

-- Show join date
createStatusInfo("Join Date", function()
	local now = DateTime.now()
	return now:FormatLocalTime("dddd, MMMM D, YYYY", "en-us")
end)

-- Server region (mocked)
createStatusInfo("Server Region", function()
	local ok, result = pcall(function()
		return game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(player)
	end)
	return ok and result or "Unknown"
end)

-- Count players in server
createStatusInfo("Players in Server", function()
	return tostring(#Players:GetPlayers()) .. " players"
end)

-- Show avatar
local avatarImg = Instance.new("ImageLabel", statusFrame)
avatarImg.Size = UDim2.new(0, 70, 0, 70)
avatarImg.BackgroundTransparency = 1
avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id="..player.UserId.."&w=150&h=150"
avatarImg.LayoutOrder = 99

-- Weather detection
createStatusInfo("Current Weather", function()
	local rs = game:GetService("ReplicatedStorage")
	local weather = rs:FindFirstChild("CurrentWeather")
	if weather and weather:IsA("StringValue") then
		return weather.Value
	end
	return "Unknown"
end)

-- === MAIN TAB FEATURES ===
local mainContent = contentFrames["Main"]

local grid = Instance.new("UIGridLayout")
grid.CellSize = UDim2.new(0.45, 0, 0.25, 0)
grid.CellPadding = UDim.new(0.05, 0)
grid.Parent = mainContent

-- Utility button
local function createMainBtn(text)
	local btn = Instance.new("TextButton")
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	Instance.new("UICorner", btn)
	btn.Parent = mainContent
	return btn
end

-- === Button 1: Collect All Plants ===
local collectBtn = createMainBtn("Collect All Plants")
collectBtn.MouseButton1Click:Connect(function()
	local found = 0
	local plants = workspace:FindFirstChild("Plants")
	if not plants then return end
	for _, p in pairs(plants:GetChildren()) do
		local owner = p:FindFirstChild("Owner")
		local ready = p:FindFirstChild("IsReadyToHarvest")
		if owner and ready and ready.Value == true and (owner.Value == player or owner.Value == player.Name) then
			p:Destroy() -- Or fire event to collect
			found += 1
		end
	end
	if found > 0 then
		print("Collected "..found.." plants")
	else
		warn("No plants ready to harvest")
	end
end)

-- === Button 2: Sell Inventory ===
local sellBtn = createMainBtn("Sell All Fruits")
sellBtn.MouseButton1Click:Connect(function()
	local inv = player:FindFirstChild("Inventory")
	if not inv or #inv:GetChildren() == 0 then
		warn("Please collect fruits before selling.")
		return
	end

	local count = 0
	for _, item in pairs(inv:GetChildren()) do
		if item:IsA("Instance") then
			item:Destroy() -- or fire event to sell
			count += 1
		end
	end

	print("Sold "..count.." fruits.")
end)

-- === Button 3: Toggle Tree Visibility ===
local hideTrees = false
local toggleTreeBtn = createMainBtn("Toggle Trees")
toggleTreeBtn.MouseButton1Click:Connect(function()
	hideTrees = not hideTrees
	local plants = workspace:FindFirstChild("Plants")
	if not plants then return end

	for _, p in pairs(plants:GetChildren()) do
		local owner = p:FindFirstChild("Owner")
		if owner and (owner.Value == player or owner.Value == player.Name) then
			for _, part in pairs(p:GetDescendants()) do
				if part:IsA("BasePart") and (part.Name == "Tree" or part.Name == "Trunk" or part.Name == "Leaves") then
					part.Transparency = hideTrees and 1 or 0
					part.CanCollide = not hideTrees
				end
			end
		end
	end

	print(hideTrees and "Trees hidden" or "Trees shown")
end)

-- === Button 4: Open Fruit Purchase UI ===
local openBuyBtn = createMainBtn("Buy Fruits")
openBuyBtn.MouseButton1Click:Connect(function()
	showTab("Pembelian BuahContent")
end)

-- === EVENT TAB FEATURES (EXTENDED) ===
local eventContent = contentFrames["Event"]

local eventGrid = Instance.new("UIGridLayout", eventContent)
eventGrid.CellSize = UDim2.new(0.45, 0, 0.22, 0)
eventGrid.CellPadding = UDim.new(0.05, 0)
eventGrid.SortOrder = Enum.SortOrder.LayoutOrder

-- Utility to create buttons
local function createEventButton(text)
	local btn = Instance.new("TextButton")
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 13
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundColor3 = Color3.fromRGB(30, 60, 120)
	Instance.new("UICorner", btn)
	btn.Parent = eventContent
	return btn
end

-- === 1. Teleport to Moonit Fruit ===
local moonitTPBtn = createEventButton("Teleport to Moonit")
moonitTPBtn.MouseButton1Click:Connect(function()
	local found = false
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name:lower():find("moonit") then
			local owner = obj:FindFirstChild("Owner")
			if owner and (owner.Value == player or owner.Value == player.Name) then
				player.Character:MoveTo(obj.Position + Vector3.new(0, 3, 0))
				found = true
				break
			end
		end
	end
	if not found then warn("Your Moonit fruit is not in your plot.") end
end)

-- === 2. ESP Moonit Fruit (Toggle) ===
local moonitESP = {}
local moonitESPState = false
local moonitESPBtn = createEventButton("ESP Moonit OFF")
moonitESPBtn.MouseButton1Click:Connect(function()
	moonitESPState = not moonitESPState
	moonitESPBtn.Text = "ESP Moonit " .. (moonitESPState and "ON" or "OFF")

	for _, esp in pairs(moonitESP) do if esp:IsA("Highlight") then esp:Destroy() end end
	table.clear(moonitESP)

	if moonitESPState then
		for _, obj in pairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") and obj.Name:lower():find("moonit") then
				local owner = obj:FindFirstChild("Owner")
				if owner and (owner.Value == player or owner.Value == player.Name) then
					local hl = Instance.new("Highlight", obj)
					hl.FillColor = Color3.fromRGB(0, 255, 255)
					hl.OutlineColor = Color3.fromRGB(255, 255, 255)
					hl.Adornee = obj
					table.insert(moonitESP, hl)
				end
			end
		end
	end
end)

-- === 3. Auto Teleport Moonit (Every 10 sec) ===
local autoTP = false
local autoTPBtn = createEventButton("Auto TP Moonit OFF")
autoTPBtn.MouseButton1Click:Connect(function()
	autoTP = not autoTP
	autoTPBtn.Text = "Auto TP Moonit " .. (autoTP and "ON" or "OFF")

	spawn(function()
		while autoTP do
			wait(10)
			for _, obj in pairs(workspace:GetDescendants()) do
				if obj:IsA("BasePart") and obj.Name:lower():find("moonit") then
					local owner = obj:FindFirstChild("Owner")
					if owner and (owner.Value == player or owner.Value == player.Name) then
						player.Character:MoveTo(obj.Position + Vector3.new(0, 3, 0))
						break
					end
				end
			end
		end
	end)
end)

-- === 4. Teleport to Owl Event ===
local owlBtn = createEventButton("Teleport to Owl")
owlBtn.MouseButton1Click:Connect(function()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name:lower():find("owl") then
			player.Character:MoveTo(obj.Position + Vector3.new(0, 3, 0))
			return
		end
	end
	warn("Owl Event not found.")
end)

-- === 5. ESP All Fruits ===
local fruitESPList = {}
local fruitESPState = false
local fruitESPBtn = createEventButton("ESP All Fruits OFF")
fruitESPBtn.MouseButton1Click:Connect(function()
	fruitESPState = not fruitESPState
	fruitESPBtn.Text = "ESP All Fruits " .. (fruitESPState and "ON" or "OFF")

	for _, v in pairs(fruitESPList) do if v:IsA("Highlight") then v:Destroy() end end
	table.clear(fruitESPList)

	if fruitESPState then
		for _, obj in pairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") and obj.Name:lower():find("fruit") then
				local h = Instance.new("Highlight", obj)
				h.FillColor = Color3.fromRGB(255, 150, 0)
				h.OutlineColor = Color3.fromRGB(255, 255, 255)
				h.Adornee = obj
				table.insert(fruitESPList, h)
			end
		end
	end
end)

-- === 6. Event Sound Toggle ===
local soundState = false
local soundBtn = createEventButton("Sound: OFF")
soundBtn.MouseButton1Click:Connect(function()
	soundState = not soundState
	soundBtn.Text = "Sound: " .. (soundState and "ON" or "OFF")
	if soundState then
		local s = Instance.new("Sound", workspace)
		s.SoundId = "rbxassetid://1843521777"
		s.Volume = 1
		s:Play()
	end
end)

-- === 7. Placeholder Buttons (Coming Soon...) ===
for i = 1, 6 do
	local placeholder = createEventButton("Coming Soon: Event "..i)
	placeholder.AutoButtonColor = false
	placeholder.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end

-- === SHOP TAB FEATURES (REBUILT) ===
local shopFrame = contentFrames["Shop"]

-- Layout scroll agar aman di Android jika fitur banyak
local shopScroll = Instance.new("ScrollingFrame", shopFrame)
shopScroll.Size = UDim2.new(1, 0, 1, 0)
shopScroll.CanvasSize = UDim2.new(0, 0, 0, 700)
shopScroll.ScrollBarThickness = 8
shopScroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", shopScroll)
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Utility to create shop buttons
local function createShopButton(text)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
	Instance.new("UICorner", btn)
	btn.Parent = shopScroll
	return btn
end

-- Floating UI Window Maker
local function makeUIWindow(titleText, size, color)
	local frame = Instance.new("Frame", gui)
	frame.Size = size
	frame.Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2)
	frame.BackgroundColor3 = color
	frame.Visible = false
	Instance.new("UICorner", frame)
	Instance.new("UIStroke", frame).Color = Color3.fromRGB(255, 255, 255)

	local title = Instance.new("TextLabel", frame)
	title.Size = UDim2.new(1, -40, 0, 35)
	title.Position = UDim2.new(0, 10, 0, 5)
	title.BackgroundTransparency = 1
	title.Text = titleText
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 16
	title.TextXAlignment = Enum.TextXAlignment.Left

	local close = Instance.new("TextButton", frame)
	close.Size = UDim2.new(0, 30, 0, 30)
	close.Position = UDim2.new(1, -35, 0, 5)
	close.Text = "X"
	close.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
	close.TextColor3 = Color3.fromRGB(255, 255, 255)
	close.Font = Enum.Font.GothamBold
	close.TextSize = 16
	Instance.new("UICorner", close)
	close.MouseButton1Click:Connect(function()
		frame.Visible = false
	end)

	return frame
end

-- 1. Seed Shop UI
local seedUI = makeUIWindow("Seed Shop (UI only)", UDim2.new(0, 350, 0, 220), Color3.fromRGB(40, 40, 40))
createShopButton("Open Seed Shop").MouseButton1Click:Connect(function()
	seedUI.Visible = true
end)

-- 2. Mini Owl Helper
local owlUI = makeUIWindow("Mini Owl Assistant", UDim2.new(0, 320, 0, 180), Color3.fromRGB(60, 60, 100))
createShopButton("Open Mini Owl UI").MouseButton1Click:Connect(function()
	owlUI.Visible = true
end)

-- 3. Daily Quest from Gear NPC
local questUI = makeUIWindow("Daily Quest", UDim2.new(0, 360, 0, 220), Color3.fromRGB(30, 30, 30))
local questText = Instance.new("TextLabel", questUI)
questText.Position = UDim2.new(0, 10, 0, 45)
questText.Size = UDim2.new(1, -20, 0, 150)
questText.Text = "- Harvest 5 fruits\n- Plant 3 seeds\n- Visit 1 owl event"
questText.Font = Enum.Font.Gotham
questText.TextSize = 14
questText.TextWrapped = true
questText.TextColor3 = Color3.fromRGB(255, 255, 255)
questText.TextYAlignment = Enum.TextYAlignment.Top
questText.BackgroundTransparency = 1

createShopButton("Open Daily Quest").MouseButton1Click:Connect(function()
	questUI.Visible = true
end)

-- 4. Gear Shop UI
local gearUI = makeUIWindow("Gear Shop", UDim2.new(0, 360, 0, 200), Color3.fromRGB(50, 50, 50))
local gearText = Instance.new("TextLabel", gearUI)
gearText.Position = UDim2.new(0, 10, 0, 45)
gearText.Size = UDim2.new(1, -20, 0, 140)
gearText.Text = "- Buy shovel\n- Upgrade water can\n- Craft gear"
gearText.Font = Enum.Font.Gotham
gearText.TextSize = 14
gearText.TextWrapped = true
gearText.TextColor3 = Color3.fromRGB(255, 255, 255)
gearText.TextYAlignment = Enum.TextYAlignment.Top
gearText.BackgroundTransparency = 1

createShopButton("Open Gear Shop").MouseButton1Click:Connect(function()
	gearUI.Visible = true
end)

-- === TELEPORT TAB ===
local teleportFrame = contentFrames["Teleport"]

local tpScroll = Instance.new("ScrollingFrame", teleportFrame)
tpScroll.Size = UDim2.new(1, 0, 1, 0)
tpScroll.CanvasSize = UDim2.new(0, 0, 0, 400)
tpScroll.ScrollBarThickness = 8
tpScroll.BackgroundTransparency = 1

local tpLayout = Instance.new("UIListLayout", tpScroll)
tpLayout.Padding = UDim.new(0, 6)
tpLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Teleport Button Utility
local function createTPButton(text)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
	Instance.new("UICorner", btn)
	btn.Parent = tpScroll
	return btn
end

-- Teleport Functions
createTPButton("Teleport to Seed NPC").MouseButton1Click:Connect(function()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name:lower():find("seed") and obj.Name:lower():find("npc") then
			player.Character:MoveTo(obj.Position + Vector3.new(0, 3, 0))
			return
		end
	end
	warn("Seed NPC not found.")
end)

createTPButton("Teleport to Sell NPC").MouseButton1Click:Connect(function()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name:lower():find("sell") then
			player.Character:MoveTo(obj.Position + Vector3.new(0, 3, 0))
			return
		end
	end
	warn("Sell NPC not found.")
end)

createTPButton("Teleport to Gear Shop").MouseButton1Click:Connect(function()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name:lower():find("gear") then
			player.Character:MoveTo(obj.Position + Vector3.new(0, 3, 0))
			return
		end
	end
	warn("Gear Shop not found.")
end)

createTPButton("Teleport to Egg Seller").MouseButton1Click:Connect(function()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name:lower():find("egg") then
			player.Character:MoveTo(obj.Position + Vector3.new(0, 3, 0))
			return
		end
	end
	warn("Egg Seller not found.")
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

Script Name: Fikri Cihuy Hub Grow a Garden
Developer: Fiks Cihuy
Built by: Fiks Cihuy
Made In: Indonesia

Script Contribution:
Fiks Cihuy (90%)
LPG (10%)

Note: Thank you for using this script!
Stay farming and enjoy the garden life!
]]

-- === FRUIT BUYER TAB (Panel Pop-Up) ===
local buyPanel = Instance.new("Frame", gui)
buyPanel.Name = "FruitBuyer"
buyPanel.Size = UDim2.new(0, 350, 0, 250)
buyPanel.Position = UDim2.new(0.5, -175, 0.5, -125)
buyPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
buyPanel.Visible = false
Instance.new("UICorner", buyPanel)
Instance.new("UIStroke", buyPanel).Color = Color3.fromRGB(0, 255, 255)

-- Buy Panel Close
local closeBtn = Instance.new("TextButton", buyPanel)
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
Instance.new("UICorner", closeBtn)
closeBtn.MouseButton1Click:Connect(function()
	buyPanel.Visible = false
end)

-- Title
local title = Instance.new("TextLabel", buyPanel)
title.Size = UDim2.new(1, -40, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "Buy Fruit"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left

-- Fruit selector
local selectedFruit = Instance.new("StringValue", player)
selectedFruit.Name = "SelectedFruit"
selectedFruit.Value = ""

local pickBtn = Instance.new("TextButton", buyPanel)
pickBtn.Text = "Select Apple"
pickBtn.Size = UDim2.new(0.45, 0, 0, 40)
pickBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
pickBtn.BackgroundColor3 = Color3.fromRGB(0, 127, 255)
pickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
pickBtn.Font = Enum.Font.Gotham
pickBtn.TextSize = 14
Instance.new("UICorner", pickBtn)
pickBtn.MouseButton1Click:Connect(function()
	selectedFruit.Value = "Apple"
end)

-- Buy Button
local buyBtn = Instance.new("TextButton", buyPanel)
buyBtn.Text = "Buy"
buyBtn.Size = UDim2.new(0.45, 0, 0, 40)
buyBtn.Position = UDim2.new(0.5, 0, 0.4, 0)
buyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
buyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
buyBtn.Font = Enum.Font.Gotham
buyBtn.TextSize = 14
Instance.new("UICorner", buyBtn)

buyBtn.MouseButton1Click:Connect(function()
	local fruit = selectedFruit.Value
	if fruit == "" then
		warn("Please select a fruit before buying.")
		return
	end
	local stockFolder = game:GetService("ReplicatedStorage"):FindFirstChild("FruitStock")
	if not stockFolder then
		warn("No stock found.")
		return
	end
	local fruitItem = stockFolder:FindFirstChild(fruit)
	if not fruitItem or fruitItem.Value <= 0 then
		warn("Fruit not available in stock.")
	else
		fruitItem.Value -= 1
		print("Purchased:", fruit)
	end
end)

-- Open Buy UI from Main tab (already linked in Part 3)
