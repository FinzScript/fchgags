-- Fikri Cihuy Hub Grow a Garden

-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")

-- Screen GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FikriCihuyHubGrowAGarden"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = PlayerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 650, 0, 450)
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -225)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
mainFrame.BorderColor3 = Color3.fromRGB(0, 127, 255)
mainFrame.BorderSizePixel = 2
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = Color3.fromRGB(0, 127, 255)
mainStroke.Thickness = 2

-- Title Bar
local titleBar = Instance.new("TextLabel")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleBar.Text = "Fikri Cihuy Hub - Grow a Garden"
titleBar.Font = Enum.Font.GothamBold
titleBar.TextSize = 18
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBar.Parent = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)

-- Close Button (X)
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
Instance.new("UICorner", closeBtn)

-- MiniBox (for reopening UI)
local miniBox = Instance.new("TextButton", gui)
miniBox.Size = UDim2.new(0, 150, 0, 35)
miniBox.Position = UDim2.new(0.5, -75, 0.85, 0)
miniBox.Text = "Open Fikri Cihuy Hub"
miniBox.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
miniBox.BorderColor3 = Color3.fromRGB(0, 127, 255)
miniBox.BorderSizePixel = 1
miniBox.TextColor3 = Color3.fromRGB(255, 255, 255)
miniBox.Font = Enum.Font.GothamBold
miniBox.TextSize = 13
miniBox.Visible = false
miniBox.Active = true
miniBox.Draggable = true
Instance.new("UICorner", miniBox)
Instance.new("UIStroke", miniBox).Color = Color3.fromRGB(0, 127, 255)

-- Hide/Show logic
closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	miniBox.Visible = true
end)

miniBox.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
	miniBox.Visible = false
end)

-- Tab Bar
local tabNames = {"Status", "Main", "Event", "Shop", "Teleport", "Credits"}
local tabs = {}
local contentFrames = {}

local tabBar = Instance.new("Frame", mainFrame)
tabBar.Name = "TabBar"
tabBar.Size = UDim2.new(1, 0, 0, 45)
tabBar.Position = UDim2.new(0, 0, 0, 40)
tabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

-- Create Tab Buttons
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

-- Create content frames for each tab
for _, name in ipairs(tabNames) do
	local content = Instance.new("Frame")
	content.Name = name.."Content"
	content.Size = UDim2.new(1, -20, 1, -100)
	content.Position = UDim2.new(0, 10, 0, 90)
	content.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	content.Visible = false
	content.Parent = mainFrame

	Instance.new("UICorner", content).CornerRadius = UDim.new(0, 8)

	local padding = Instance.new("UIPadding", content)
	padding.PaddingTop = UDim.new(0, 10)
	padding.PaddingBottom = UDim.new(0, 10)
	padding.PaddingLeft = UDim.new(0, 10)
	padding.PaddingRight = UDim.new(0, 10)

	contentFrames[name] = content
end

-- Function to show selected tab
local function showTab(tabName)
	for name, frame in pairs(contentFrames) do
		frame.Visible = (name == tabName)
	end
end

-- Connect tab buttons
for name, button in pairs(tabs) do
	button.MouseButton1Click:Connect(function()
		showTab(name.."Content")
	end)
end

-- Default tab
showTab("StatusContent")

-- Add indicator bar under tab (optional visual cue)
local indicatorBar = Instance.new("Frame")
indicatorBar.Size = UDim2.new(0, 100, 0, 2)
indicatorBar.Position = UDim2.new(0, 10, 0, 42)
indicatorBar.BackgroundColor3 = Color3.fromRGB(0, 127, 255)
indicatorBar.BorderSizePixel = 0
indicatorBar.Parent = tabBar

-- Animate indicator on tab click
for i, name in ipairs(tabNames) do
	local btn = tabs[name]
	btn.MouseButton1Click:Connect(function()
		indicatorBar:TweenPosition(
			UDim2.new(0, 10 + (i - 1) * 105, 0, 42),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Quad,
			0.2,
			true
		)
	end)
end

-- Scrollable content preparation
for _, frame in pairs(contentFrames) do
	local scroll = Instance.new("ScrollingFrame", frame)
	scroll.Name = "Scroll"
	scroll.Size = UDim2.new(1, 0, 1, 0)
	scroll.CanvasSize = UDim2.new(0, 0, 0, 800)
	scroll.ScrollBarThickness = 8
	scroll.BackgroundTransparency = 1

	local layout = Instance.new("UIListLayout", scroll)
	layout.Padding = UDim.new(0, 6)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
end

-- Test label on Status tab
local statusScroll = contentFrames["Status"]:FindFirstChild("Scroll")
local testLabel = Instance.new("TextLabel", statusScroll)
testLabel.Size = UDim2.new(1, -20, 0, 40)
testLabel.Text = "Welcome to Fikri Cihuy Hub!"
testLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
testLabel.Font = Enum.Font.GothamBold
testLabel.TextSize = 16
testLabel.BackgroundTransparency = 1
testLabel.TextXAlignment = Enum.TextXAlignment.Left

-- === STATUS TAB FEATURES ===
local statusFrame = contentFrames["Status"]:FindFirstChild("Scroll")

-- Utility: Create status info box
local function createStatusInfo(titleText, valueFunc)
	local box = Instance.new("Frame")
	box.Size = UDim2.new(1, -20, 0, 40)
	box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	box.BorderColor3 = Color3.fromRGB(0, 127, 255)
	box.BorderSizePixel = 1
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

	-- Auto-update value every second
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

-- Playtime
local startTime = os.time()
createStatusInfo("Playtime", function()
	local elapsed = os.time() - startTime
	local mins = math.floor(elapsed / 60)
	local secs = elapsed % 60
	return string.format("%02d:%02d", mins, secs)
end)

-- Harvest Earnings (leaderstats)
local leaderstats = player:FindFirstChild("leaderstats")
createStatusInfo("Harvest Earnings", function()
	if leaderstats and leaderstats:FindFirstChild("Cash") then
		return "$" .. tostring(leaderstats.Cash.Value)
	end
	return "$0"
end)

-- Join Date
createStatusInfo("Join Date", function()
	local now = DateTime.now()
	return now:FormatLocalTime("dddd, MMMM D, YYYY", "en-us")
end)

-- Server Region
createStatusInfo("Server Region", function()
	local ok, region = pcall(function()
		return game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(player)
	end)
	return ok and region or "Unknown"
end)

-- Player Count
createStatusInfo("Players in Server", function()
	return tostring(#Players:GetPlayers()) .. " players"
end)

-- Avatar Image
local avatarImage = Instance.new("ImageLabel", statusFrame)
avatarImage.Size = UDim2.new(0, 70, 0, 70)
avatarImage.BackgroundTransparency = 1
avatarImage.Image = "rbxthumb://type=AvatarHeadShot&id="..player.UserId.."&w=150&h=150"

-- Weather
createStatusInfo("Current Weather", function()
	local rs = game:GetService("ReplicatedStorage")
	local weather = rs:FindFirstChild("CurrentWeather")
	if weather and weather:IsA("StringValue") then
		return weather.Value
	end
	return "Unknown"
end)

-- === Simulasi Dropdown Pilih Buah ===
local fruitDropdownFrame = Instance.new("Frame", mainFrameScroll)
fruitDropdownFrame.Size = UDim2.new(1, -20, 0, 140)
fruitDropdownFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
fruitDropdownFrame.BorderColor3 = Color3.fromRGB(0, 127, 255)
fruitDropdownFrame.BorderSizePixel = 1
Instance.new("UICorner", fruitDropdownFrame)

local fruitLabel = Instance.new("TextLabel", fruitDropdownFrame)
fruitLabel.Size = UDim2.new(1, -20, 0, 30)
fruitLabel.Position = UDim2.new(0, 10, 0, 5)
fruitLabel.Text = "Select Fruit to Buy:"
fruitLabel.BackgroundTransparency = 1
fruitLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fruitLabel.Font = Enum.Font.GothamBold
fruitLabel.TextSize = 14
fruitLabel.TextXAlignment = Enum.TextXAlignment.Left

local selectedFruit = Instance.new("StringValue", player)
selectedFruit.Name = "SelectedFruit"
selectedFruit.Value = ""

local fruitDropdown = Instance.new("TextButton", fruitDropdownFrame)
fruitDropdown.Size = UDim2.new(1, -20, 0, 30)
fruitDropdown.Position = UDim2.new(0, 10, 0, 40)
fruitDropdown.BackgroundColor3 = Color3.fromRGB(0, 127, 255)
fruitDropdown.Text = "Choose Fruit"
fruitDropdown.Font = Enum.Font.Gotham
fruitDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
fruitDropdown.TextSize = 14
Instance.new("UICorner", fruitDropdown)

local dropdownList = {"Apple", "Moonit", "Berry", "Grape", "GoldenFruit"}
fruitDropdown.MouseButton1Click:Connect(function()
	fruitDropdown.Text = "Apple"
	selectedFruit.Value = "Apple"
end)

-- Tombol Buy dari buah yang dipilih
local buyFruitBtn = Instance.new("TextButton", fruitDropdownFrame)
buyFruitBtn.Size = UDim2.new(1, -20, 0, 30)
buyFruitBtn.Position = UDim2.new(0, 10, 0, 80)
buyFruitBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
buyFruitBtn.Text = "Buy Selected Fruit"
buyFruitBtn.Font = Enum.Font.Gotham
buyFruitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
buyFruitBtn.TextSize = 14
Instance.new("UICorner", buyFruitBtn)

buyFruitBtn.MouseButton1Click:Connect(function()
	local fruit = selectedFruit.Value
	if fruit == "" then
		warn("Please select a fruit to buy.")
		return
	end

	local stock = game:GetService("ReplicatedStorage"):FindFirstChild("FruitStock")
	if stock then
		local item = stock:FindFirstChild(fruit)
		if item and item.Value > 0 then
			item.Value -= 1
			print("Bought:", fruit)
		else
			warn("Selected fruit is out of stock.")
		end
	else
		warn("No stock folder found.")
	end
end)

-- === Fitur Auto-Replant (simulasi) ===
local autoReplant = false
local replantBtn = createMainButton("Auto-Replant OFF")
replantBtn.MouseButton1Click:Connect(function()
	autoReplant = not autoReplant
	replantBtn.Text = "Auto-Replant " .. (autoReplant and "ON" or "OFF")

	if autoReplant then
		spawn(function()
			while autoReplant do
				wait(5)
				print("Auto-planting seed...")
			end
		end)
	end
end)

-- === Fitur Auto-Water (simulasi) ===
local autoWater = false
local waterBtn = createMainButton("Auto-Water OFF")
waterBtn.MouseButton1Click:Connect(function()
	autoWater = not autoWater
	waterBtn.Text = "Auto-Water " .. (autoWater and "ON" or "OFF")

	if autoWater then
		spawn(function()
			while autoWater do
				wait(7)
				print("Auto-watering plants...")
			end
		end)
	end
end)

-- === Tambahan Dummy Buttons ===
for i = 1, 15 do
	createMainButton("Coming Soon Feature "..i)
end

-- === SHOP TAB FULL FEATURES ===
local shopFrame = contentFrames["Shop"]:FindFirstChild("Scroll")

-- Utility function to create shop buttons
local function createShopButton(text)
	local btn = Instance.new("TextButton")
	btn.Text = text
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	Instance.new("UICorner", btn)
	btn.Parent = shopFrame
	return btn
end

-- Utility to create UI popup panels
local function createUIPopup(name, titleText)
	local frame = Instance.new("Frame", gui)
	frame.Name = name
	frame.Size = UDim2.new(0, 400, 0, 260)
	frame.Position = UDim2.new(0.5, -200, 0.5, -130)
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	frame.Visible = false
	Instance.new("UICorner", frame)
	Instance.new("UIStroke", frame).Color = Color3.fromRGB(255, 255, 255)

	local title = Instance.new("TextLabel", frame)
	title.Text = titleText
	title.Size = UDim2.new(1, -40, 0, 30)
	title.Position = UDim2.new(0, 10, 0, 5)
	title.BackgroundTransparency = 1
	title.Font = Enum.Font.GothamBold
	title.TextSize = 16
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextXAlignment = Enum.TextXAlignment.Left

	local close = Instance.new("TextButton", frame)
	close.Text = "X"
	close.Size = UDim2.new(0, 30, 0, 30)
	close.Position = UDim2.new(1, -35, 0, 5)
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

-- === 1. Seed Shop UI ===
local seedShop = createUIPopup("SeedShopUI", "Seed Shop")
createShopButton("Open Seed Shop").MouseButton1Click:Connect(function()
	seedShop.Visible = true
end)

-- === 2. Mini Owl Helper UI ===
local owlUI = createUIPopup("MiniOwlUI", "Mini Owl Assistant")
createShopButton("Open Mini Owl UI").MouseButton1Click:Connect(function()
	owlUI.Visible = true
end)

-- === 3. Daily Quest UI ===
local dailyQuest = createUIPopup("DailyQuestUI", "Daily Quest")
local questText = Instance.new("TextLabel", dailyQuest)
questText.Position = UDim2.new(0, 10, 0, 50)
questText.Size = UDim2.new(1, -20, 0, 150)
questText.Text = "- Harvest 5 plants\n- Water 3 trees\n- Sell 10 fruits"
questText.TextColor3 = Color3.fromRGB(255, 255, 255)
questText.Font = Enum.Font.Gotham
questText.TextSize = 14
questText.TextWrapped = true
questText.TextYAlignment = Enum.TextYAlignment.Top
questText.BackgroundTransparency = 1

createShopButton("Open Daily Quest").MouseButton1Click:Connect(function()
	dailyQuest.Visible = true
end)

-- === 4. Gear Shop UI ===
local gearUI = createUIPopup("GearShopUI", "Gear Shop")
local gearText = Instance.new("TextLabel", gearUI)
gearText.Position = UDim2.new(0, 10, 0, 50)
gearText.Size = UDim2.new(1, -20, 0, 150)
gearText.Text = "- Shovel\n- Watering Can\n- Speed Shoes"
gearText.TextColor3 = Color3.fromRGB(240, 240, 240)
gearText.Font = Enum.Font.Gotham
gearText.TextSize = 14
gearText.TextWrapped = true
gearText.TextYAlignment = Enum.TextYAlignment.Top
gearText.BackgroundTransparency = 1

createShopButton("Open Gear Shop").MouseButton1Click:Connect(function()
	gearUI.Visible = true
end)
-- === 5. UI CLOSE/REOPEN SYSTEM ===
local miniBox = Instance.new("TextButton", gui)
miniBox.Name = "MiniBox"
miniBox.Size = UDim2.new(0, 140, 0, 35)
miniBox.Position = UDim2.new(0.02, 0, 0.85, 0)
miniBox.Text = "Open FCH Hub"
miniBox.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
miniBox.BorderColor3 = Color3.fromRGB(0, 127, 255)
miniBox.TextColor3 = Color3.fromRGB(255, 255, 255)
miniBox.Font = Enum.Font.GothamBold
miniBox.TextSize = 13
miniBox.Visible = false
miniBox.Active = true
miniBox.Draggable = true
Instance.new("UICorner", miniBox)
Instance.new("UIStroke", miniBox).Color = Color3.fromRGB(0, 127, 255)

-- Tombol Close (X) di UI utama
local closeBtn = mainFrame:FindFirstChild("CloseButton")
if not closeBtn then
	closeBtn = Instance.new("TextButton", mainFrame)
	closeBtn.Name = "CloseButton"
	closeBtn.Size = UDim2.new(0, 30, 0, 30)
	closeBtn.Position = UDim2.new(1, -35, 0, 5)
	closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	closeBtn.Text = "X"
	closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.TextSize = 16
	Instance.new("UICorner", closeBtn)
end

-- Logika Tutup UI Utama
closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	miniBox.Visible = true
end)

-- Logika Tampilkan UI Utama
miniBox.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
	miniBox.Visible = false
end)

-- Styling ulang mainFrame jika dibutuhkan
mainFrame.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
mainFrame.BorderColor3 = Color3.fromRGB(0, 127, 255)
mainFrame.BorderSizePixel = 2

-- Pastikan titlebar ada
local titleBar = mainFrame:FindFirstChild("TitleBar")
if not titleBar then
	titleBar = Instance.new("TextLabel", mainFrame)
	titleBar.Name = "TitleBar"
	titleBar.Size = UDim2.new(1, 0, 0, 40)
	titleBar.Position = UDim2.new(0, 0, 0, 0)
	titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	titleBar.Text = "Fikri Cihuy Hub - Grow a Garden"
	titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleBar.Font = Enum.Font.GothamBold
	titleBar.TextSize = 18
	Instance.new("UICorner", titleBar)
end

-- === TELEPORT TAB: NPC Button System ===
local teleportScroll = contentFrames["Teleport"]:FindFirstChild("Scroll")

local function createTeleportButton(name, keywordList)
	local btn = Instance.new("TextButton", teleportScroll)
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	Instance.new("UICorner", btn)

	btn.MouseButton1Click:Connect(function()
		local found = false
		for _, obj in pairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") then
				for _, key in pairs(keywordList) do
					if obj.Name:lower():find(key:lower()) then
						player.Character:MoveTo(obj.Position + Vector3.new(0, 3, 0))
						found = true
						break
					end
				end
			end
			if found then break end
		end
		if not found then
			warn("NPC location not found: " .. name)
		end
	end)
end

-- Tombol-tombol Teleport
createTeleportButton("Teleport to Seed Seller", {"seed", "seller"})
createTeleportButton("Teleport to Fruit Seller", {"sell", "fruit", "market"})
createTeleportButton("Teleport to Gear Shop", {"gear", "tool"})
createTeleportButton("Teleport to Egg Seller", {"egg", "hatch", "pet"})

-- Spacer & Info Text
for i = 1, 4 do
	local space = Instance.new("TextLabel", teleportScroll)
	space.Size = UDim2.new(1, -20, 0, 20)
	space.BackgroundTransparency = 1
	space.Text = ""
end

local infoText = Instance.new("TextLabel", teleportScroll)
infoText.Size = UDim2.new(1, -20, 0, 40)
infoText.Text = "Click button to instantly teleport to NPC."
infoText.TextColor3 = Color3.fromRGB(200, 200, 200)
infoText.BackgroundTransparency = 1
infoText.Font = Enum.Font.Gotham
infoText.TextSize = 14

-- === CREDITS TAB PANEL ===
local creditsScroll = contentFrames["Credits"]:FindFirstChild("Scroll")

local function createCreditLabel(text, sizeY)
	local label = Instance.new("TextLabel", creditsScroll)
	label.Size = UDim2.new(1, -20, 0, sizeY or 40)
	label.Position = UDim2.new(0, 10, 0, 0)
	label.Text = text
	label.TextWrapped = true
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Top
	return label
end

-- Judul
createCreditLabel("Fikri Cihuy Hub - Grow a Garden", 50)

-- Isi credits
createCreditLabel("Script ini dibuat oleh:", 30)
createCreditLabel("Developer Script : Fiks Cihuy", 30)
createCreditLabel("Dikerjakan oleh : Fiks Cihuy", 30)
createCreditLabel("Made In : Indonesian", 30)

-- Persentase kontribusi
createCreditLabel("Script creation percentage :", 30)
createCreditLabel("Fiks Cihuy (90%)", 30)
createCreditLabel("LPG (10%)", 30)

-- Note
createCreditLabel("Note : Terimakasih telah menggunakan script ini", 40)
createCreditLabel("Semoga membantu kalian para petani Grow a Garden!", 40)
createCreditLabel("Script ini disusun sepenuh hati.", 40)

-- Tambahan padding
for i = 1, 10 do
	createCreditLabel("", 25)
end

-- Placeholder isi credits panjang (tanpa fitur)
for i = 1, 40 do
	createCreditLabel("—", 15)
end
