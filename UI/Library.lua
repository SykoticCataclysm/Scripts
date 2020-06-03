local Library = { Tabs = {} }

local UserInputService = game:GetService("UserInputService")
local Heartbeat = game:GetService("RunService").Heartbeat

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

local function Create(obj, props)
	local Obj = Instance.new(obj)
	for i, v in pairs(props) do
		if i ~= 'Parent' then
			if typeof(v) == 'Instance' then
				v.Parent = Obj
			else
				Obj[i] = v
			end
		end			
	end
	Obj.Parent = props.Parent
	return Obj
end

local function AlphabetiseTable(tab)
	table.sort(tab, function(a, b)
		return a:lower() < b:lower()
	end)
end

local Gui = Create("ScreenGui", {
	Parent = game:GetService("CoreGui"),
	ResetOnSpawn = false
})

Library.Main = Create('ImageLabel', {
    BackgroundColor3 = Color3.new(1, 1, 1),
    BackgroundTransparency = 1,
    Image = "rbxassetid://3570695787",
    ImageColor3 = Color3.new(0.176471, 0.176471, 0.176471),
    Name = "Frame",
    Parent = Gui,
    Position = UDim2.new(0.5, -250, 0.5, -157.5),
    ScaleType = Enum.ScaleType.Slice,
    Size = UDim2.new(0, 500, 0, 315),
    SliceCenter = Rect.new(Vector2.new(100, 100), Vector2.new(100, 100)),
    SliceScale = 0.11999999731779,
    Create('ImageLabel', {
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = Color3.new(0.12549, 0.12549, 0.12549),
        Name = "TitleFrame",
        ScaleType = Enum.ScaleType.Slice,
        Size = UDim2.new(0, 500, 0, 45),
        SliceCenter = Rect.new(Vector2.new(100, 100), Vector2.new(100, 100)),
        SliceScale = 0.11999999731779,
        ZIndex = 2,
        Create('TextLabel', {
            BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 1,
            Font = Enum.Font.Highway,
            Name = "Title",
            Position = UDim2.new(0, 0, 0, 5),
            Size = UDim2.new(0, 500, 0, 35),
            Text = "Title",
            TextColor3 = Color3.new(1, 1, 1),
            TextSize = 24,
            TextStrokeTransparency = 0,
            ZIndex = 2
        })
    }),
    Create('Frame', {
        BackgroundColor3 = Color3.new(0.12549, 0.12549, 0.12549),
        BorderSizePixel = 0,
        Name = "BorderCover",
        Position = UDim2.new(0, 0, 0, 25),
        Size = UDim2.new(0, 500, 0, 20)
    }),
    Create('Frame', {
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1,
        Name = "Buttons",
        Position = UDim2.new(0, 10, 0, 55),
        Size = UDim2.new(0, 160, 0, 250)
    }),
    Create('Frame', {
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1,
        Name = "Frames",
        Position = UDim2.new(0, 175, 0, 55),
        Size = UDim2.new(0, 320, 0, 250)
    })
})

Library.Buttons = Library.Main.Buttons
Library.Frames = Library.Main.Frames
Library.TitleFrame = Library.Main.TitleFrame
Library.Title = Library.TitleFrame.Title

local Dragging = false
local DragStart = nil
local FrameStart = nil

Library.TitleFrame.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = Input.Position
        FrameStart = Library.Main.AbsolutePosition
    end
end)

Library.TitleFrame.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
        local Pos = UDim2.new(0, FrameStart.X + (Input.Position.X - DragStart.X), 0, FrameStart.Y + (Input.Position.Y - DragStart.Y))
        Library.Main:TweenPosition(Pos, "In", "Linear", 0.12, true)
    end
end)

function Library:Tab(name)
	local Tab = {}
	Tab.Btn = Create('TextButton', {
	    AutoButtonColor = false,
	    BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863),
	    BorderColor3 = Color3.new(0.0784314, 0.0784314, 0.0784314),
	    Font = Enum.Font.Highway,
	    Name = name,
		Parent = Library.Buttons,
		Position = UDim2.new(0, 5, 0, 5 + 35 * #Library.Buttons:GetChildren()),
	    Size = UDim2.new(0, 150, 0, 30),
	    Text = name,
	    TextColor3 = Color3.new(1, 1, 1),
	    TextSize = 20,
	    TextStrokeTransparency = 0
	})
	Tab.Btn.MouseButton1Click:Connect(function()
		for i, v in next, Library.Tabs do
			v.Frame.Visible = v.Frame == Tab.Frame
		end
	end)
	Tab.Frame = Create('ScrollingFrame', {
        Active = true,
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
		CanvasSize = UDim2.new(0, 0, 0, 5),
		ClipsDescendants = true,
        Name = name,
		Parent = Library.Frames,
        ScrollBarImageColor3 = Color3.new(0.0392157, 0.0392157, 0.0392157),
        ScrollBarThickness = 5,
        Size = UDim2.new(0, 320, 0, 250),
        Visible = #Library.Tabs == 0
    })
    
    function Tab:Label(name)
        local Label = {}
        Label.Frame = Create('Frame', {
            BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Name = name,
			Parent = Tab.Frame,
            Size = UDim2.new(0, 305, 0, 25),
            Create('TextLabel', {
                AutoButtonColor = false,
                BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255),
                BorderSizePixel = 0,
                Font = Enum.Font.Highway,
                Name = "Label",
                Size = UDim2.new(0, 305, 0, 25),
				Text = name,
                TextColor3 = Color3.new(1, 1, 1),
                TextSize = 16
            })
        })
        Label.Label = Label.Frame.Label
        function Label:Set(name)
            Label.Label.Text = name
        end
        return Label
    end
	
	function Tab:Button(name, func)
		local Button = {}
		local Callback = func or function() end
		Button.Frame = Create('Frame', {
            BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Name = name,
			Parent = Tab.Frame,
            Size = UDim2.new(0, 305, 0, 30),
            Create('TextButton', {
                AutoButtonColor = false,
                BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255),
                BorderColor3 = Color3.new(0.0784314, 0.0784314, 0.0784314),
                Font = Enum.Font.Highway,
                Name = "Button",
                Size = UDim2.new(0, 305, 0, 30),
				Text = name,
                TextColor3 = Color3.new(1, 1, 1),
                TextSize = 18,
                TextStrokeTransparency = 0
            })
        })
		Button.Btn = Button.Frame.Button
		Button.Btn.MouseButton1Click:Connect(Callback)
		function Button:Fire()
			Callback()
		end
		function Button:RepeatFire(times, waittype)
			for i = 1, times do
				Callback()
				if waittype == "Wait" then
					wait()
				end
				if waittype == "Beat" then
					Heartbeat:Wait()
				end
			end
		end
		return Button
	end

	function Tab:Toggle(name, default, func)
		local Toggle = { Enabled = default }
		local Callback = func or function() end
		Toggle.Frame = Create('Frame', {
            BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Name = name,
            Parent = Tab.Frame,
            Position = UDim2.new(0, 5, 0, 40),
            Size = UDim2.new(0, 305, 0, 30),
            Create('TextButton', {
                AutoButtonColor = false,
                BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255),
                BorderColor3 = Color3.new(0.0784314, 0.0784314, 0.0784314),
                Font = Enum.Font.Highway,
                Name = "Button",
                Position = UDim2.new(0, 275, 0, 0),
                Size = UDim2.new(0, 30, 0, 30),
                Text = "",
                TextColor3 = Color3.new(1, 1, 1),
                TextSize = 18,
                TextStrokeTransparency = 0
            }),
            Create('TextLabel', {
                BackgroundColor3 = Color3.new(1, 1, 1),
                BackgroundTransparency = 1,
                Font = Enum.Font.Highway,
                Name = "Label",
                Size = UDim2.new(0, 270, 0, 30),
                Text = name,
                TextColor3 = Color3.new(1, 1, 1),
                TextSize = 18,
                TextStrokeTransparency = 0,
                TextXAlignment = Enum.TextXAlignment.Left
            })
        })
		Toggle.Btn = Toggle.Frame.Button
		Toggle.Btn.MouseButton1Click:Connect(function()
			Toggle.Enabled = not Toggle.Enabled
			Toggle.Btn.BackgroundColor3 = Toggle.Enabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(35, 35, 35)
			Callback(Toggle.Enabled)
		end)
		function Toggle:Switch()
			Toggle.Enabled = not Toggle.Enabled
			Toggle.Btn.BackgroundColor3 = Toggle.Enabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(35, 35, 35)
			Callback(Toggle.Enabled)
		end
		function Toggle:Enable()
			Toggle.Enabled = true
			Toggle.Btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
			Callback(Toggle.Enabled)
		end
		function Toggle:Disable()
			Toggle.Enabled = false
			Toggle.Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			Callback(Toggle.Enabled)
        end
        if default == true then
            Toggle:Enable()
        else
            Toggle:Disable()
        end
		return Toggle
	end
	
	function Tab:Box(name, numonly, default, func)
		local Box = { Value = "" }
		local Callback = func or function() end
		local Default = ""
		if numonly == true then
			if tonumber(default) then
				Default = tonumber(default)
			end
		elseif tostring(default) then
			Default = tostring(default)
		end
		Box.Value = Default
		Box.Frame = Create('Frame', {
            BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Name = name,
            Parent = Tab.Frame,
            Position = UDim2.new(0, 5, 0, 300),
            Size = UDim2.new(0, 305, 0, 30),
            Create('TextLabel', {
                BackgroundColor3 = Color3.new(1, 1, 1),
                BackgroundTransparency = 1,
                Font = Enum.Font.Highway,
                Name = "Label",
                Size = UDim2.new(0, 160, 0, 30),
                Text = name,
                TextColor3 = Color3.new(1, 1, 1),
                TextSize = 18,
                TextStrokeTransparency = 0,
                TextXAlignment = Enum.TextXAlignment.Left
            }),
            Create('TextBox', {
                BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255),
                BorderColor3 = Color3.new(0.0784314, 0.0784314, 0.0784314),
                Font = Enum.Font.SourceSansSemibold,
                Name = "Box",
                Position = UDim2.new(0, 165, 0, 0),
                Size = UDim2.new(0, 140, 0, 30),
                Text = tostring(Box.Value),
                TextColor3 = Color3.new(1, 1, 1),
                TextSize = 16
            })
        })
		Box.Content = Box.Frame.Box
		Box.Content.FocusLost:Connect(function()
			if numonly == true and tonumber(Box.Content.Text) then
				Box.Value = tonumber(Box.Content.Text)
			elseif numonly == false then
				Box.Value = Box.Content.Text
			else
				Box.Content.Text = tostring(Box.Value)
			end
			Callback(Box.Value)
		end)
		function Box:Set(val)
			if numonly == true then
				if tonumber(val) then
					Box.Value = tonumber(val)
				end
			elseif tostring(default) then
				Box.Value = tostring(val)
			end
			Box.Content.Text = tostring(Box.Value)
			Callback(Box.Value)
		end
		function Box:Reset()
			Box:Set(Default)
		end
		Box:Reset()
		return Box
	end
	
	function Tab:Slider(name, min, max, default, func)
		local Slider = { Value = default, Drag = nil }
		local Callback = func or function() end
		local Default = default >= min and default <= max and default or min
		Slider.Frame = Create('Frame', {
            BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Name = name,
			Parent = Tab.Frame,
            Position = UDim2.new(0, 5, 0, 75),
            Size = UDim2.new(0, 305, 0, 30),
            Create('TextLabel', {
                BackgroundColor3 = Color3.new(1, 1, 1),
                BackgroundTransparency = 1,
                Font = Enum.Font.Highway,
                Name = "Label",
                Size = UDim2.new(0, 185, 0, 30),
                Text = name,
                TextColor3 = Color3.new(1, 1, 1),
                TextSize = 18,
                TextStrokeTransparency = 0,
                TextXAlignment = Enum.TextXAlignment.Left
            }),
            Create('TextLabel', {
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471),
                BorderColor3 = Color3.new(0.0784314, 0.0784314, 0.0784314),
                Font = Enum.Font.Highway,
                Name = "Bar",
                Position = UDim2.new(0, 200, 0.5, 0),
                Size = UDim2.new(0, 100, 0, 4),
                Text = "",
                TextColor3 = Color3.new(1, 1, 1),
                TextSize = 18,
                TextStrokeTransparency = 0,
                TextXAlignment = Enum.TextXAlignment.Left,
                Create('TextLabel', {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255),
                    BorderColor3 = Color3.new(0.0784314, 0.0784314, 0.0784314),
                    Font = Enum.Font.Highway,
                    Name = "Dragger",
                    Position = UDim2.new(1, 0, 0.5, 0),
                    Size = UDim2.new(0, 10, 0, 30),
                    Text = "",
                    TextColor3 = Color3.new(1, 1, 1),
                    TextSize = 18,
                    TextStrokeTransparency = 0,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
            }),
            Create('TextLabel', {
                BackgroundColor3 = Color3.new(1, 1, 1),
                BackgroundTransparency = 1,
                Font = Enum.Font.Highway,
                Name = "Value",
                Size = UDim2.new(0, 185, 0, 30),
                Text = tostring(Default),
                TextColor3 = Color3.new(1, 1, 1),
                TextSize = 18,
                TextStrokeTransparency = 0,
                TextXAlignment = Enum.TextXAlignment.Right
            })
        })
		Slider.ValueText = Slider.Frame.Value
		Slider.Bar = Slider.Frame.Bar
		Slider.Dragger = Slider.Bar.Dragger
		Slider.Dragger.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				if Slider.Drag then
					Slider.Drag:Disconnect()
				end
				Slider.Drag = Heartbeat:Connect(function()
					local Percent = (Mouse.X - Slider.Bar.AbsolutePosition.X) / Slider.Bar.AbsoluteSize.X
					Percent = math.clamp(Percent, 0, 1)
					Slider.Dragger.Position = UDim2.new(Percent, 0, 0.5, 0)
					Slider.Value = math.floor(min + ((max - min) * Percent))
					Slider.ValueText.Text = tostring(Slider.Value)
					Callback(Slider.Value)
				end)
			end
		end)
		Slider.Dragger.InputEnded:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 and Slider.Drag then
				Slider.Drag:Disconnect()
			end
		end)
		function Slider:Set(val)
			if val >= min and val <= max then
				local Percent = (val - min) / (max - min)
				Percent = math.clamp(Percent, 0, 1)
				Slider.Dragger.Position = UDim2.new(Percent, 0, 0.5, 0)
				Slider.Value = math.floor(min + ((max - min) * Percent))
				Slider.ValueText.Text = tostring(Slider.Value)
				Callback(Slider.Value)
			end
		end
		function Slider:Reset()
			Slider:Set(Default)
		end
		Slider:Reset()
		return Slider
	end
	
	function Tab:Dropdown(name, list, default, func)
		local Dropdown = { IsOpen = false, Value = "" }
		local Callback = func or function() end
		local Default = table.find(list, default) and default or list[1]
		Dropdown.Value = Default
		Dropdown.Frame = Create('Frame', {
            BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Name = name,
			Parent = Tab.Frame,
            Position = UDim2.new(0, 5, 0, 110),
            Size = UDim2.new(0, 305, 0, 30),
            Create('TextLabel', {
                BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255),
                BorderColor3 = Color3.new(0.0784314, 0.0784314, 0.0784314),
                Font = Enum.Font.Highway,
                Name = "Label",
                Size = UDim2.new(0, 305, 0, 30),
                Text = name,
                TextColor3 = Color3.new(1, 1, 1),
                TextSize = 18,
                TextStrokeTransparency = 0,
                ZIndex = 2
            }),
            Create('TextButton', {
                AutoButtonColor = false,
                BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255),
                BorderColor3 = Color3.new(0.0784314, 0.0784314, 0.0784314),
                Font = Enum.Font.Highway,
                Name = "Open",
                Position = UDim2.new(0, 275, 0, 0),
                Size = UDim2.new(0, 30, 0, 30),
                Text = "V",
                TextColor3 = Color3.new(1, 1, 1),
                TextSize = 18,
                TextStrokeTransparency = 0,
                ZIndex = 2
            }),
            Create('ScrollingFrame', {
                Active = true,
                BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255),
                BorderColor3 = Color3.new(0.0784314, 0.0784314, 0.0784314),
                CanvasSize = UDim2.new(0, 0, 0, 5),
                Name = "Dropdown",
                Position = UDim2.new(0, 10, 0, 25),
                ScrollBarImageColor3 = Color3.new(0.0588235, 0.0588235, 0.0588235),
                ScrollBarThickness = 5,
                Size = UDim2.new(0, 285, 0, 0),
            })
        })
		Dropdown.Scroll = Dropdown.Frame.Dropdown
		Dropdown.Open = Dropdown.Frame.Open
		Dropdown.Open.MouseButton1Click:Connect(function()
			Dropdown.IsOpen = not Dropdown.IsOpen
			Dropdown.Frame.Size = Dropdown.IsOpen and UDim2.new(0, 305, 0, 205) or UDim2.new(0, 305, 0, 30)
			Dropdown.Scroll.Size = Dropdown.IsOpen and UDim2.new(0, 285, 0, 180) or UDim2.new(0, 285, 0, 0)
			Tab.Frame.CanvasSize = UDim2.new(0, 0, 0, 5)
			local Items = Tab.Frame:GetChildren()
			table.sort(Items, function(a, b)
				return a.Position.Y.Offset < b.Position.Y.Offset
			end)
			for i, v in next, Items do
				local Offset = Tab.Frame.CanvasSize.Y.Offset
				v.Position = UDim2.new(0, 5, 0, Offset)
				Tab.Frame.CanvasSize = UDim2.new(0, 0, 0, Offset + v.AbsoluteSize.Y + 5)
			end
		end)
		function Dropdown:Refresh(newlist, newdefault)
			Default = table.find(newlist, newdefault) and newdefault or newlist[1]
			Dropdown.Value = Default
			Dropdown.Scroll:ClearAllChildren()
			Dropdown.Scroll.CanvasSize = UDim2.new(0, 0, 0, 5)
			AlphabetiseTable(newlist)
			for i, v in next, newlist do
				local Btn = Create('TextButton', {
				    AutoButtonColor = false,
				    BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255),
				    BorderColor3 = Color3.new(0.0784314, 0.0784314, 0.0784314),
				    Font = Enum.Font.Highway,
				    Name = v,
					Parent = Dropdown.Scroll,
				    Size = UDim2.new(0, 280, 0, 28),
					Text = v,
				    TextColor3 = Color3.new(1, 1, 1),
				    TextSize = 17
				})
				Btn.MouseButton1Click:Connect(function()
					Dropdown.Value = v
					Callback(Dropdown.Value)
				end)
			end
		end
        Dropdown.Scroll.ChildAdded:Connect(function(child)
			local Offset = Dropdown.Scroll.CanvasSize.Y.Offset
			child.Position = UDim2.new(0, 0, 0, Offset)
			Dropdown.Scroll.CanvasSize = UDim2.new(0, 0, 0, Offset + child.AbsoluteSize.Y)
		end)
		Dropdown:Refresh(list, Default)
		return Dropdown
	end
			
	Tab.Frame.ChildAdded:Connect(function(child)
		local Offset = Tab.Frame.CanvasSize.Y.Offset
		child.Position = UDim2.new(0, 5, 0, Offset)
		Tab.Frame.CanvasSize = UDim2.new(0, 0, 0, Offset + child.AbsoluteSize.Y + 5)
	end)
	
	Library.Tabs[#Library.Tabs + 1] = Tab
	return Tab
end

return Library
