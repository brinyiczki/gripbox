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
	if Chat == nil and PlayerList == nil and  Backpack == nil then return warn("Give atleast 3 bool!") end
	local StarterGui = game:GetService("StarterGui")


		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat,Chat) -- disable chat
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,PlayerList) -- disable Player List (leaderboard)
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,Backpack) -- disable Backpack + Hotbar

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




--This functions Tweens the FieldOfView in a specified number to a chosen amount 
GUTIL.SetFov = function(Number : NumberValue,Time : NumberValue)
	game:GetService("TweenService"):Create(game.Workspace.CurrentCamera, 

	 TweenInfo.new(
		Time or 1, -- Time
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
		Time or 1, -- Time
		Enum.EasingStyle.Sine, -- EasingStyle
		Enum.EasingDirection.InOut, -- EasingDirection
		0, -- RepeatCount (when less than zero the tween will loop indefinitely)
		false, -- Reverses (tween will reverse once reaching it's goal)
		0), -- DelayTime 

	--//Properties//--
	{Size = Number or 0}):Play()
end

--This functions Tweens the DOF in a specified number to a chosen amount 
GUTIL.SetDepthField = function(Number : NumberValue,Time : NumberValue)
	if not game.Lighting:FindFirstChild("DepthOfField") then return warn("No DOF found in Lightning") end
	game:GetService("TweenService"):Create(game.Lighting.DepthOfField, 

	 TweenInfo.new(
		Time or 1, -- Time
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
GUTIL.Tween = function(Ingredient : GuiObject ,Table : UDim2 ,Time : number ,Style : Enum.EasingStyle)
	
	if not Ingredient then warn("No Ingredient to tween") return end
	if not table then warn("No Table to process") return end
	
	game:GetService("TweenService"):Create(Ingredient,

	 TweenInfo.new(
		Time or 0.5, -- Time
		Style or Enum.EasingStyle.Back, -- EasingStyle
		Enum.EasingDirection.Out, -- EasingDirection
		0, -- RepeatCount (when less than zero the tween will loop indefinitely)
		false, -- Reverses (tween will reverse once reaching it's goal)
		0), -- DelayTime 

	--//Properties//--


	{Position = Table}):Play()
end


GUTIL.SizeTween = function(Ingredient : GuiObject ,Table : UDim2 ,AddUp : number ,Time : number ,Style : Enum.EasingStyle)

	if not Ingredient then warn("No Ingredient to Size Tween") return end
	
	
	local SizeTween = Ingredient:TweenSize(
		AddUp and UDim2.new(0,AddUp,0,AddUp) + Table or Table ,  -- endSize (required)
		Enum.EasingDirection.Out,    -- easingDirection (default Out)
		Style or Enum.EasingStyle.Back,      -- easingStyle (default Quad)
		Time or 0.5,                          -- time (default: 1)
		true                       -- should this tween override ones in-progress? (default: false)
		-- a function to call when the tween completes (default: nil)
	)
end


--You can create one module which controls the ability to tween them out (close) or (open) them just by requiring this module
--Or you can use this function to run anything else in the required module of the ui

GUTIL.Prompt = function(Hay : string, Needle : string , State : boolean)
	local player = game:GetService("Players").LocalPlayer
if not Hay then warn("No GUI name given") return end
	

	if player.PlayerGui:FindFirstChild(Hay) then --find if the gui exists
		if player.PlayerGui:FindFirstChild(Hay):FindFirstChildWhichIsA("ModuleScript") then --module script exists?
			local module = require(player.PlayerGui:FindFirstChild(Hay):FindFirstChildWhichIsA("ModuleScript")) --require the module which was found

			if State == true or nil then -- the bool you gave decides which function runs
				module:Open(Needle or "null") -- it was true
			else
				module:Close(Needle or "null") -- it was false
			end
		end
	end
end


return GUTIL
