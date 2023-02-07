local GUTIL = {} 

local SoundService = game:GetService("SoundService") -- get the SoundService
local Tracks = game:GetService("ReplicatedStorage"):FindFirstChild("YourLocation") --replace it with your sound repo location.(where you have the sounds located that you want to use)
local Sounds = { -- sounds Dictionary
	["YourSound"] = Tracks:FindFirstChild("SoundName"), --add the title of your sound which will be used,  Add your sound name which is inside the track path
	["YourSound2"] = Tracks:FindFirstChild("SoundName2"), --,add the title of your sound which will be used , Add your sound name which is inside the track path 

}

-- This is for if the player dont have circle it creates one for you so the ripple is still useable either way
local function CreateCircle()
	local Label = Instance.new("ImageLabel") -- create the label for the circle
	Label.Name = "Circle" -- set the name of the Label to "Circle"
	Label.Parent = script -- set the parent of the Label to script
	Label.Image = "rbxassetid://266543268" -- set the Image of the Label to the specified asset id
	Label.ImageColor3 = Color3.fromRGB(0,0,0) -- set the Image's color to black
	Label.ImageTransparency = 0.9 -- set the Transparency  of the Label to 0.9
	Label.BackgroundTransparency = 1 -- set the Background transparency of the Label to 1
	Label.Size = UDim2.new(0,0,0,0) -- set the Size of the Label to 0,0
	return Label -- return the Label instance so it can be used by the ripple function
end

-- this function creates a ripple effect on the button when the button is clicked
GUTIL.Ripple = function(Button, X, Y)
	coroutine.resume(coroutine.create(function() -- run the following code as a coroutine
		
		Button.ClipsDescendants = true -- set ClipsDescendants of the Button to true

		local Circle = script:FindFirstChild("Circle") or CreateCircle() -- find the "Circle" below the script or create a new circle if it doesnt exists
		Circle = Circle:Clone() -- clone the Circle

			Circle.Parent = Button -- set the Parent of the Circle to the Button
			local NewX = X - Circle.AbsolutePosition.X -- calculate the new X position of the Circle
			local NewY = Y - Circle.AbsolutePosition.Y -- calculate the new Y position of the Circle
			Circle.Position = UDim2.new(0, NewX, 0, NewY) -- set the Position of the Circle to the new X and Y position
		
		local Size = 0 -- set the size to 0
			-- set the size of the Circle
			if Button.AbsoluteSize.X > Button.AbsoluteSize.Y then
				 Size = Button.AbsoluteSize.X*1.5
			elseif Button.AbsoluteSize.X < Button.AbsoluteSize.Y then
				 Size = Button.AbsoluteSize.Y*1.5
			elseif Button.AbsoluteSize.X == Button.AbsoluteSize.Y then																										Size = Button.AbsoluteSize.X*1.5
			end
		
		local Time = 0.5
			Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, -Size/2, 0.5, -Size/2), "Out", "Quad", Time, false, nil) -- tween the circle 
			for i=1,10 do
				Circle.ImageTransparency = Circle.ImageTransparency + 0.01
				wait(Time/10)
			end
			Circle:Destroy() --destroy the circle after its transparent
			
	end))
end




--This function Requires the player module and makes it avaliable to toggle player controls
GUTIL.SetControls = function(Value: BoolValue)
	local controls = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule):GetControls()
	controls:Enable(Value)
end

--This functions allows to enable or disable each coreUI
GUTIL.SetCoreUI = function(Chat : BoolValue,PlayerList : BoolValue,Backpack : BoolValue)
      if Chat == nil and PlayerList == nil and  Backpack == nil then return warn("Give atleast 1 bool!") end
	local StarterGui = game:GetService("StarterGui")
	
        if Chat then
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat,Chat) -- disable chat
	end

        if PlayerList then
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,PlayerList) -- disable Player List (leaderboard)
        end
	
        if Backpack then
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,Backpack) -- disable Backpack + Hotbar
        end

end

--This functions Tweens the FieldOfView in a specified number to a chosen amount 
GUTIL.SetFov = function(Number : NumberValue,Time : NumberValue)
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



--This functions Tweens the Blur in a specified number to a chosen amount 
GUTIL.SetBlur = function(Number : NumberValue,Time : NumberValue)
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

--This functions Tweens the DOF in a specified number to a chosen amount 
GUTIL.SetDepthField = function(Number : NumberValue,Time : NumberValue)
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


--This functions allows to tween Objects position you can customize it with easing style and so on
--Udim2 table format must be {0,0,0,0} 
GUTIL.Tween = function(Object : ObjectValue,Style : Enum.EasingStyle?,Table : UDim2,Time : NumberValue)

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


GUTIL.SizeTween = function(Object : ObjectValue,Style : Enum.EasingStyle?,Table : UDim2,Time : NumberValue)

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




--Plays a sound from the table you made
--Use the track sound what you gave in a table

GUTIL.PlaySound = function(Name : StringValue)
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



--You can create one module which controls the ability to tween them out (close) or (open) them just by requiring this module
--Or you can use this function to run anything else in the required module of the ui

GUTIL.Prompt = function(Name : StringValue, State : BoolValue)
	local player = game:GetService("Players").LocalPlayer


	if player.PlayerGui:FindFirstChild(Name) then --find if the gui exists
		if player.PlayerGui:FindFirstChild(Name):FindFirstChildWhichIsA("ModuleScript") then --module script exists?
			local module = require(player.PlayerGui:FindFirstChild(Name):FindFirstChildWhichIsA("ModuleScript")) --require the module which was found

			if State == true then -- the bool you gave decides which function runs
				module:TweenIn() -- it was true
			else
				module:TweenOut() -- it was false
			end
		end
	end
end


return GUTIL
