
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

local MuseumOpen = Instance.new("TextLabel")

MuseumOpen.Name = "MuseumOpen"
MuseumOpen.Parent = RobGui
MuseumOpen.AnchorPoint = Vector2.new(1, 1)
MuseumOpen.BackgroundColor3 = Color3.new(1, 1, 1)
MuseumOpen.BackgroundTransparency = 1
MuseumOpen.BorderSizePixel = 0
MuseumOpen.Position = UDim2.new(1, -10, 1, -70)
MuseumOpen.Size = UDim2.new(0, 50, 0, 35)
MuseumOpen.Font = Enum.Font.SourceSans
MuseumOpen.Text = "Museum"
MuseumOpen.TextColor3 = Color3.new(1, 0, 0)
MuseumOpen.TextSize = 24
MuseumOpen.TextStrokeTransparency = 0.5
MuseumOpen.TextXAlignment = Enum.TextXAlignment.Right

local Airdrop = Instance.new("TextLabel")

Airdrop.Name = "AirdropLanded"
Airdrop.Parent = RobGui
Airdrop.AnchorPoint = Vector2.new(1, 1)
Airdrop.BackgroundColor3 = Color3.new(1, 1, 1)
Airdrop.BackgroundTransparency = 1
Airdrop.BorderSizePixel = 0
Airdrop.Position = UDim2.new(1, -10, 1, -105)
Airdrop.Size = UDim2.new(0, 50, 0, 35)
Airdrop.Font = Enum.Font.SourceSans
Airdrop.Text = "Airdrop(s)"
Airdrop.TextColor3 = Color3.new(1, 0, 0)
Airdrop.TextSize = 24
Airdrop.TextStrokeTransparency = 0.5
Airdrop.TextXAlignment = Enum.TextXAlignment.Right
	
-- Setup --

local VIM = game:GetService("VirtualInputManager")

local Plr = game:GetService("Players").LocalPlayer
local Char = Plr.Character
local Root = Char:WaitForChild("HumanoidRootPart")
local Hum = Char:FindFirstChildOfClass("Humanoid")

local Clipped = true
local Robbing = false
local RobType = ""
local Abort = false
local Teleporting = false
_G.AutoRobOn = true

local BankIsOpen = false
local JewIsOpen = false
local MuseumIsOpen = false
local Airdrops = {}

for i, v in ipairs(workspace.Buildings:GetChildren()) do
	if (v.Position - Vector3.new(560.544556, 25.0398712, 1159.97266)).magnitude < 5 then
		v.CanCollide = false
	end
end

for i, v in ipairs(workspace:GetChildren()) do
	if v.Name == "Drop" and v:FindFirstChild("Briefcase") then
		repeat wait() until v:FindFirstChild("Parachute") == nil
		table.insert(Airdrops, #Airdrops + 1, v)
		Airdrop.TextColor3 = Color3.new(0, 1, 0)
	end
end

workspace.ChildAdded:Connect(function(child)
	if child.Name == "Drop" then
		repeat wait() until child:FindFirstChild("Parachute") == nil and child:FindFirstChild("Briefcase")
		table.insert(Airdrops, #Airdrops + 1, child)
		Airdrop.TextColor3 = Color3.new(0, 1, 0)
	end
end)

workspace.ChildRemoved:Connect(function(child)
	if child.Name == "Drop" then
		for i, v in pairs(Airdrops) do
			if v == child then
				table.remove(Airdrops, i)
			end
		end
		if #Airdrops == 0 then
			Airdrop.TextColor3 = Color3.new(1, 0, 0)
		end
	end
end)

Plr.CharacterAdded:Connect(function(char)
	Root = char:WaitForChild("HumanoidRootPart")
	Hum = char:FindFirstChildOfClass("Humanoid")
	Char = char
	_G.AutoRobOn = false
	wait()
	_G.AutoRobOn = true
end)

function CloseTP(Cframe)
	Teleporting = true
	Clipped = false
	local cf0 = (Cframe - Cframe.p) + Root.Position + Vector3.new(0,4,0)
	local length = Cframe.p - Root.Position
	workspace.Gravity = 0
	for i = 0, length.magnitude, 3 do
		Root.CFrame = cf0 + length.Unit * i
		Root.Velocity, Root.RotVelocity = Vector3.new(), Vector3.new()
		wait()
	end 
	Clipped = true
	workspace.Gravity = 196.2
	Teleporting = false
end

function FarTP(Cframe)
	Teleporting = true
	wait(1)
	local Car = nil
	for i, v in pairs(workspace.Vehicles:GetChildren()) do
		if v.Name == "Camaro" and v:FindFirstChild("Seat") and v.Seat:FindFirstChild("Player") and v.Seat.Player.Value == false then
			Car = v.Model.Body
			Car.CFrame = Root.CFrame * CFrame.new(-5, 0, -2)
			wait(0.5)
			repeat
				VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
				wait(0.25)
				VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
				wait(0.25)
			until Hum:GetState() == Enum.HumanoidStateType.Seated or Plr.PlayerGui.MainGui.SimpleMessage.Visible == true
			if Plr.PlayerGui.MainGui.SimpleMessage.Visible == true then
				Car = nil
				v:Destroy()
			end
		end
		wait(1)
	end
	if Car ~= nil then
		wait(1)
		Car.CFrame = Cframe
		wait(1)
		repeat
			VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
			wait()
			VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
		until Hum:GetState() ~= Enum.HumanoidStateType.Seated
		wait(1)
		Car.Parent.Parent:Destroy()
	else
		CloseTP(Cframe)
	end
	Teleporting = false
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

function NumFromStr(str)
	return tonumber((tostring(str):gsub("%D", "")))
end

local CollectMoney = Plr.PlayerGui.MainGui.CollectMoney

function IsBagFull()
	return CollectMoney.Visible and NumFromStr(CollectMoney.Money.Text) + 2 > NumFromStr(CollectMoney.Maximum.Text)
end

local MuseumBag = Plr.PlayerGui.MainGui.MuseumBag.TextLabel

function MuseumBagFull()
	local Strings = string.split(MuseumBag.Text, " ")
	return Strings[1] == Strings[3]
end

-- Jewelry Store --

function RobJewelry()
	RobType = "Jewelry"
	FarTP(CFrame.new(143.7, 19.1, 1351.5))
	wait(1)
	CloseTP(CFrame.new(126.3, 19, 1316.9))
	local Jewels = workspace:FindFirstChild("Jewelrys"):GetChildren()[1].Boxes:GetChildren()
	local Collected = 0
	for a, b in pairs(Jewels) do
		repeat wait() until Abort == false
		if not IsBagFull() and b.Transparency < 0.99 and JewIsOpen == true then
			if b.Position.X < 120 and b.Position.Z > 1330 then
				CloseTP(CFrame.new(b.Position + b.CFrame.lookVector * 2.5 + Vector3.new(0, 0, -2.5), b.Position))
			elseif b.Position.Z < 1309 and b.Position.Z > 1304 then
				CloseTP(CFrame.new(b.Position + b.CFrame.lookVector * 2.5 + Vector3.new(0, 0, 2.5), b.Position))
			else
				CloseTP(CFrame.new(b.Position + b.CFrame.lookVector * 2.5, b.Position))
			end
			wait(0.6)
			for c = 1, 4 do
				VIM:SendKeyEvent(true, Enum.KeyCode.F, false, game)
				wait(0.6)
				repeat wait() until Abort == false
			end
			local temp = Collected
			Collected = temp + 1
			wait(0.5)
		end
	end
	FarTP(CFrame.new(116.3, 117.9, 1307))
	wait(0.2)
	FarTP(CFrame.new(-229.8, 20, 1602.3))
end

-- Bank --

function RobBank()
	RobType = "Bank"
	FarTP(CFrame.new(12.1, 19.1, 790.6))
	wait(1)
	CloseTP(CFrame.new(25.7, 19.4, 854.3))
	local Bank = workspace.Banks:GetChildren()[1].Layout:GetChildren()[1]
	local Door = Bank.Door.Hinge
	if Bank:FindFirstChild("Lasers") then
		for i, v in pairs(Bank.Lasers:GetChildren()) do
			v:Destroy()
		end
	end
	wait(1)
	CloseTP(Bank.TriggerDoor.CFrame * CFrame.new(0, 0, -2))
	wait(0.5)
	CloseTP(Bank.Money.CFrame)
	repeat wait() until IsBagFull() == true or Abort == true or BankIsOpen == false
end

-- Museum --

function RobMuseum()
	RobType = "Museum"
	FarTP(CFrame.new(1085.8, 143.8, 1201.7))
	local Museum = workspace:FindFirstChild("Museum")
	for i, v in ipairs(Museum.CaseLasers:GetChildren()) do
		v:Destroy()
	end
	for i, v in ipairs(Museum.Dino:GetChildren()) do
		if v.Transparency < 0.99 and MuseumBagFull() == false and MuseumIsOpen == true then
			repeat 
				CloseTP(CFrame.new(v.Position.X, v.Position.Y + 2, v.Position.Z))
				wait(0.5)
				VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
				wait(2)
				VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
			until v.Transparency > 0.99 or MuseumIsOpen == false or Abort == true
		end
	end
	CloseTP(CFrame.new(1085.8, 143.8, 1201.7))
	if string.split(MuseumBag.Text, " ")[1] ~= "0" then
		FarTP(CFrame.new(1638.9, 51.1, -1799.1))
		wait(0.25)
		CloseTP(CFrame.new(1638.9, 51.1, -1799.1))
	end
end

-- Airdrop --

function RobAirdrop()
	RobType = "Airdrop"
	local Drop = nil
	local Dist = 999999
	for i, v in pairs(Airdrops) do
		if 	(v.Briefcase.Position - Root.Position).magnitude < Dist then
			Dist = (v.Briefcase.Position - Root.Position).magnitude
			Drop = v
		end
	end
	if Drop ~= nil then
		local Loc = Drop.Briefcase.CFrame
		FarTP(Loc)
		repeat
			CloseTP(Loc)
			wait(0.5)
			VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
			wait(7)
			VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
		until Drop == nil or Drop.Parent == nil or Abort == true
	end
end

-- Controller --

spawn(function()
	while wait() do
		if _G.AutoRobOn == true then
			if Robbing == false then
				if BankIsOpen == true then
					Robbing = true
					RobBank()
					BankIsOpen = false
					BankOpen.TextColor3 = Color3.new(1, 0, 0)
					Robbing = false
				elseif JewIsOpen == true then
					Robbing = true
					RobJewelry()
					JewIsOpen = false
					JewOpen.TextColor3 = Color3.new(1, 0, 0)
					Robbing = false
				elseif MuseumIsOpen == true then
					Robbing = true
					RobMuseum()
					MuseumIsOpen = false
					MuseumOpen.TextColor3 = Color3.new(1, 0, 0)
					Robbing = false
				elseif #Airdrops > 0 then
					Robbing = true
					RobAirdrop()
					Robbing = false
				elseif (Vector3.new(554.5, 20, 1117.4) - Root.Position).magnitude > 15 then
					FarTP(CFrame.new(554.5, 20, 1117.4), 3.5)
				end
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

local MuseumGap = workspace:FindFirstChild("Museum").Roof.Hole.Part

if MuseumGap.Transparency > 0.99 then
	MuseumIsOpen = true
	MuseumOpen.TextColor3 = Color3.new(0, 1, 0)
end

MuseumGap:GetPropertyChangedSignal("Transparency"):Connect(function()
	if MuseumGap.Transparency > 0.99 then
		MuseumIsOpen = true
		MuseumOpen.TextColor3 = Color3.new(0, 1, 0)
	else
		MuseumIsOpen = false
		MuseumOpen.TextColor3 = Color3.new(1, 0, 0)
	end
end)

-- Anti AFK --

Plr.Idled:connect(function()
	game:GetService("VirtualUser"):CaptureController()
	game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

-- Cop Detection --

spawn(function()
	while wait() do
		if Teleporting == false and Robbing == true and RobType == "Bank" then
			for i, v in ipairs(game:GetService("Teams").Police:GetPlayers()) do
				if v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") then
					if (v.Character.HumanoidRootPart.Position - Root.Position).magnitude < 15 then
						Abort = true
						FarTP(CFrame.new(554.5, 20, 1117.4))
						Abort = false
					end
				end
			end
		end
	end	
end)
