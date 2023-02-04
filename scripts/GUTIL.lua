
local GUTIL = {}

local SoundService = game:GetService("SoundService")
local Tracks = game:GetService("ReplicatedStorage"):FindFirstChild("YourLocation")
local Sounds = {
	["YourSound"] = Tracks:FindFirstChild("SoundName"),
	["YourSound2"] = Tracks:FindFirstChild("SoundName2"),

}

local function CreateCircle()
	local Label = Instance.new("ImageLabel")
	Label.Name = "Circle"
	Label.Parent = script
	Label.Image = "rbxassetid://266543268"
	Label.ImageColor3 = Color3.fromRGB(0,0,0)
	Label.ImageTransparency = 0.9
	Label.BackgroundTransparency = 1
	Label.Size = UDim2.new(0,0,0,0)
	return Label
end



UI_Functions.Ripple = function(Button, X, Y)
	coroutine.resume(coroutine.create(function()
		
		Button.ClipsDescendants = true
		
		local Circle = script:FindFirstChild("Circle") or CreateCircle()
		Circle = Circle:Clone()

			Circle.Parent = Button
			local NewX = X - Circle.AbsolutePosition.X
			local NewY = Y - Circle.AbsolutePosition.Y
			Circle.Position = UDim2.new(0, NewX, 0, NewY)
		
		local Size = 0
			if Button.AbsoluteSize.X > Button.AbsoluteSize.Y then
				 Size = Button.AbsoluteSize.X*1.5
			elseif Button.AbsoluteSize.X < Button.AbsoluteSize.Y then
				 Size = Button.AbsoluteSize.Y*1.5
			elseif Button.AbsoluteSize.X == Button.AbsoluteSize.Y then																										Size = Button.AbsoluteSize.X*1.5
			end
		
		local Time = 0.5
			Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, -Size/2, 0.5, -Size/2), "Out", "Quad", Time, false, nil)
			for i=1,10 do
				Circle.ImageTransparency = Circle.ImageTransparency + 0.01
				wait(Time/10)
			end
			Circle:Destroy()
			
	end))
end





UI_Functions.SetControls = function(Value: BoolValue)
	local controls = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule):GetControls()
	controls:Enable(Value)
end


UI_Functions.SetCoreUI = function(Chat : BoolValue,PlayerList : BoolValue,Backpack : BoolValue)
	local StarterGui = game:GetService("StarterGui")
	
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat,Chat)
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,PlayerList)
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,Backpack)


end


UI_Functions.SetFov = function(Number : NumberValue,Time : NumberValue)
	game:GetService("TweenService"):Create(game.Workspace.CurrentCamera, 

	    TweenInfo.new(
		Time, -- Time
		Enum.EasingStyle.Sine, -- EasingStyle
		Enum.EasingDirection.InOut, -- EasingDirection
		0, -- RepeatCount (when less than zero the tween will loop indefinitely)
		false, -- Reverses (tween will reverse once reaching it's goal)
		0), -- DelayTime 
	--//Properties//--
	{FieldOfView = Number}):Play()
end


UI_Functions.SetBlur = function(Number : NumberValue,Time : NumberValue)
	if not game.Lighting:FindFirstChild("Blur") then return warn("No blur found in Lightning") end
	game:GetService("TweenService"):Create(game.Lighting.Blur, 

	    TweenInfo.new(
		Time, -- Time
		Enum.EasingStyle.Sine, -- EasingStyle
		Enum.EasingDirection.InOut, -- EasingDirection
		0, -- RepeatCount (when less than zero the tween will loop indefinitely)
		false, -- Reverses (tween will reverse once reaching it's goal)
		0), -- DelayTime 

	--//Properties//--
	{Size = Number}):Play()
end


UI_Functions.SetDepthField = function(Number : NumberValue,Time : NumberValue)
	if not game.Lighting:FindFirstChild("DepthOfField") then return warn("No DOF found in Lightning") end
	game:GetService("TweenService"):Create(game.Lighting.DepthOfField, 

	    TweenInfo.new(
		Time, -- Time
		Enum.EasingStyle.Sine, -- EasingStyle
		Enum.EasingDirection.InOut, -- EasingDirection
		0, -- RepeatCount (when less than zero the tween will loop indefinitely)
		false, -- Reverses (tween will reverse once reaching it's goal)
		0), -- DelayTime 

	--//Properties//--
	{FarIntensity = Number}):Play()
end


UI_Functions.Tween = function(Object : ObjectValue,Style : Enum.EasingStyle?,Table : UDim2,Time : NumberValue)

	game:GetService("TweenService"):Create(Object, 

        TweenInfo.new(
		Time, -- Time
        Style, -- EasingStyle
		Enum.EasingDirection.InOut, -- EasingDirection
		0, -- RepeatCount (when less than zero the tween will loop indefinitely)
		false, -- Reverses (tween will reverse once reaching it's goal)
		0), -- DelayTime 

	--//Properties//--
	

	{Position = UDim2.new(table.unpack(Table))}):Play()
	wait(Time) --Wait for the Tween to end


end


UI_Functions.SizeTween = function(Object : ObjectValue,Style : Enum.EasingStyle?,Table : UDim2,Time : NumberValue)

	local SizeTween = Object:TweenSize(
		UDim2.new(table.unpack(Table)),  -- endSize (required)
		Enum.EasingDirection.InOut,    -- easingDirection (default Out)
		Style,      -- easingStyle (default Quad)
		Time,                          -- time (default: 1)
		true                       -- should this tween override ones in-progress? (default: false)
		                    -- a function to call when the tween completes (default: nil)
	)


	wait(Time) --Wait for the Tween to end


end





UI_Functions.PlaySound = function(Name : StringValue)
	for SoundName, Track in pairs(Sounds) do --Seperating Sound Name and it's ID from the table

		if SoundName == Name then --Making sure that it will play the requested sound and other sound is not playing.
			local Cloned = Track:Clone()
			Cloned.Parent = SoundService
			Cloned:Play()

			Cloned.Ended:Connect(function() -- When the sound is ended.
				Cloned:Destroy()
			end)
		end
	end
end




UI_Functions.Prompt = function(Name : StringValue, State : BoolValue)
	local player = game:GetService("Players").LocalPlayer


	if player.PlayerGui:FindFirstChild(Name) then
		if player.PlayerGui:FindFirstChild(Name):FindFirstChildWhichIsA("ModuleScript") then
			local module = require(player.PlayerGui:FindFirstChild(Name):FindFirstChildWhichIsA("ModuleScript"))

			if State == true then
				module:TweenIn()
			else
				module:TweenOut()
			end
		end
	end
end



return GUTIL
