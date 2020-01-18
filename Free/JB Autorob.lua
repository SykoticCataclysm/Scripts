-- Gui

local RobGui = Instance.new("ScreenGui")

RobGui.Name = "RobGui"
RobGui.Parent = game:GetService("CoreGui")

local JewOpen = Instance.new("TextLabel")

JewOpen.Name = "JewOpen"
JewOpen.Parent = RobGui
JewOpen.AnchorPoint = Vector2.new(1, 1)
JewOpen.BackgroundColor3 = Color3.new(1, 1, 1)
JewOpen.BackgroundTransparency = 1
JewOpen.BorderSizePixel = 0
JewOpen.Position = UDim2.new(1, -10, 1, 0)
JewOpen.Size = UDim2.new(0, 120, 0, 35)
JewOpen.Font = Enum.Font.SourceSans
JewOpen.Text = "Jewelry Store"
JewOpen.TextColor3 = Color3.new(1, 0, 0)
JewOpen.TextSize = 24
JewOpen.TextStrokeTransparency = 0.5
JewOpen.TextXAlignment = Enum.TextXAlignment.Right

local BankOpen = Instance.new("TextLabel")

BankOpen.Name = "BankOpen"
BankOpen.Parent = RobGui
BankOpen.AnchorPoint = Vector2.new(1, 1)
BankOpen.BackgroundColor3 = Color3.new(1, 1, 1)
BankOpen.BackgroundTransparency = 1
BankOpen.BorderSizePixel = 0
BankOpen.Position = UDim2.new(1, -10, 1, -35)
BankOpen.Size = UDim2.new(0, 50, 0, 35)
BankOpen.Font = Enum.Font.SourceSans
BankOpen.Text = "Bank"
BankOpen.TextColor3 = Color3.new(1, 0, 0)
BankOpen.TextSize = 24
BankOpen.TextStrokeTransparency = 0.5
BankOpen.TextXAlignment = Enum.TextXAlignment.Right

local Airdrop = Instance.new("TextLabel")

Airdrop.Name = "BankOpen"
Airdrop.Parent = RobGui
Airdrop.AnchorPoint = Vector2.new(1, 1)
Airdrop.BackgroundColor3 = Color3.new(1, 1, 1)
Airdrop.BackgroundTransparency = 1
Airdrop.BorderSizePixel = 0
Airdrop.Position = UDim2.new(1, -10, 1, -70)
Airdrop.Size = UDim2.new(0, 50, 0, 35)
Airdrop.Font = Enum.Font.SourceSans
Airdrop.Text = "Airdrops : Being Added..."
Airdrop.TextColor3 = Color3.new(1, 0, 0)
Airdrop.TextSize = 24
Airdrop.TextStrokeTransparency = 0.5
Airdrop.TextXAlignment = Enum.TextXAlignment.Right

-- Setup --

local Plr = game:GetService("Players").LocalPlayer
local Char = Plr.Character
local Root = Char:WaitForChild("HumanoidRootPart")

local Clipped = true
local Robbing = false
_G.AutoRobOn = true

local BankIsOpen = false
local JewIsOpen = false
local Airdrops = {}

Plr.CharacterAdded:Connect(function(char)
	Root = char:WaitForChild("HumanoidRootPart")
	Char = char
end)

for i, v in pairs(workspace:GetChildren()) do
	if v.Name == "Drop" and v:FindFirstChild("Parachute") == nil then
		table.insert(Airdrops, #Airdrops + 1, v:WaitForChild("Briefcase"))
	end
end

function Teleport(Cframe)
	Clipped = false
	local cf0 = (Cframe - Cframe.p) + Root.Position + Vector3.new(0, 4, 0)
	local length = Cframe.p - Root.Position
	workspace.Gravity = 0
	for i = 0, length.magnitude, 3.5 do
		Root.CFrame = cf0 + length.Unit * i
		Root.Velocity, Root.RotVelocity = Vector3.new(), Vector3.new()
		wait()
	end 
	Clipped = true
	workspace.Gravity = 196.2
end

game:GetService("RunService").Stepped:Connect(function()
	if Clipped == false then
		for i, v in pairs(Char:GetChildren()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

-- Auto Rob --

local function NumFromStr(str)
	return tonumber((tostring(str):gsub("%D", "")))
end

local function IsBagFull()
	return Plr.PlayerGui.MainGui.CollectMoney.Visible and NumFromStr(Plr.PlayerGui.MainGui.CollectMoney.Money.Text) + 2 > NumFromStr(Plr.PlayerGui.MainGui.CollectMoney.Maximum.Text)
end

-- Jewelry Store --

function RobJewelry()
	Teleport(CFrame.new(Root.Position.X, 120, Root.Position.Z))
	wait(0.2)
	Teleport(CFrame.new(143.7, 120, 1351.5))
	wait(0.2)
	Teleport(CFrame.new(143.7, 19.1, 1351.5))
	wait(0.2)
	Teleport(CFrame.new(126.3, 19, 1316.9))
	local Jewels = workspace:FindFirstChild("Jewelrys"):GetChildren()[1].Boxes:GetChildren()
	local Collected = 0
	for a, b in pairs(Jewels) do
		if not IsBagFull() and b.Transparency < 0.99 then
			if b.Position.X < 120 and b.Position.Z > 1330 then
				Teleport(CFrame.new(b.Position + b.CFrame.lookVector * 2.5 + Vector3.new(0, 0, -2.5), b.Position))
			elseif b.Position.Z < 1309 and b.Position.Z > 1304 then
				Teleport(CFrame.new(b.Position + b.CFrame.lookVector * 2.5 + Vector3.new(0, 0, 2.5), b.Position))
			else
				Teleport(CFrame.new(b.Position + b.CFrame.lookVector * 2.5, b.Position))
			end
			wait(0.6)
			for c = 1, 4 do
				game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.F, false, game)
				wait(0.6)
			end
			local temp = Collected
			Collected = temp + 1
			wait(0.5)
		end
	end
	Teleport(CFrame.new(154, 18.8, 1270.9))
	wait(0.2)
	Teleport(CFrame.new(141.6, 117.9, 1274.4))
	wait(0.2)
	Teleport(CFrame.new(116.3, 117.9, 1307))
	wait(0.2)
	Teleport(CFrame.new(-229.8, 18.8, 1602.3))
end

-- Bank --

function RobBank()
	Teleport(CFrame.new(Root.Position.X, 120, Root.Position.Z))
	wait(0.2)
	Teleport(CFrame.new(26, 120, 853.5))
	wait(0.2)
	Teleport(CFrame.new(26, 19.4, 853.5))
	local Bank = workspace.Banks:GetChildren()[1].Layout:GetChildren()[1]
	local Door = Bank.Door.Hinge
	if Bank:FindFirstChild("Lasers") then
		for i, v in pairs(Bank.Lasers:GetChildren()) do
			if v.Name == "LaserTrack" then
				v:Destroy()
			end
		end
	end
	wait(1)
	Teleport(Bank.TriggerDoor.CFrame * CFrame.new(0, 0, -2))
	wait(0.5)
	Teleport(Bank.Money.CFrame)
	repeat wait() until IsBagFull() == true
end

-- Controller --

spawn(function()
	while wait() do
		if _G.AutoRobOn == true and Robbing == false then
			if BankIsOpen == true then
				Robbing = true
				RobBank()
				BankIsOpen = false
				BankOpen.BackgroundColor3 = Color3.new(1, 0, 0)
				Robbing = false
			elseif JewIsOpen == true then
				Robbing = true
				RobJewelry()
				JewIsOpen = false
				JewOpen.BackgroundColor3 = Color3.new(1, 0, 0)
				Robbing = false
			elseif (Vector3.new(537.4, 21.6, 1048.8) - Root.Position).magnitude > 10 then
				Teleport(CFrame.new(537.4, 21.6, 1048.8))
			end
		end
	end
end)

-- Detect When Things Open --

local JewSign = workspace:FindFirstChild("Jewelrys"):GetChildren()[1].Extra.Sign.Decal

if JewSign.Transparency > 0.89 then
	JewIsOpen = true
	JewOpen.TextColor3 = Color3.new(0, 1, 0)
end

JewSign:GetPropertyChangedSignal("Transparency"):Connect(function()
	if JewSign.Transparency > 0.89 then
		JewIsOpen = true
		JewOpen.TextColor3 = Color3.new(0, 1, 0)
	else
		JewIsOpen = false
		JewOpen.TextColor3 = Color3.new(1, 0, 0)
	end
end)

local BankSign = workspace:FindFirstChild("Banks"):GetChildren()[1].Extra.Sign.Decal

if BankSign.Transparency > 0.89 then
	BankIsOpen = true
	BankOpen.TextColor3 = Color3.new(0, 1, 0)
end

BankSign:GetPropertyChangedSignal("Transparency"):Connect(function()
	if BankSign.Transparency > 0.89 then
		BankIsOpen = true
		BankOpen.TextColor3 = Color3.new(0, 1, 0)
	else
		BankIsOpen = false
		BankOpen.TextColor3 = Color3.new(1, 0, 0)
	end
end)