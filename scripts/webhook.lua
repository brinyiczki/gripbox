
MarketplaceService = game:GetService("MarketplaceService") -- Get MS
HTTPService = game:GetService("HttpService") -- get HTTP service (the place you are using it on msut be published and enabled in the game settings


Webhook_URL = "https://webhook.newstargeted.com/api/webhooks/0101/random"     --define the Discord Webhook URL that we want to use to send our message to a Discord channel

-- Copy your Discord Webhook from /api and replace from /api at Webhook_URL since discord blocked requests from roblox




game.Players.PlayerAdded:Connect(function(player)

	local Data = { --Hold data
		["content"] = "", --used to send a message with the embed. We leave it blank in this example.
		["embeds"] = {{
			["title"] = "**Title**" , --Title of the embed you can format it just like at you would do at discord.
			["description"] = player.Name .. "Has joined the game", --we give description as the players name and that he joined the game
			["type"] = "rich", --sets the type of the embed. We set it to "rich".
			["color"] = 4972305,
			["fields"] = { --array of fields to be displayed in the embed, you can add more
				{
					['name'] = "Profile Link: ",
					['value'] = "https://www.roblox.com/users/"..player.UserId.."/profile",  --get the userid of the joined player , to the point of the url so we get a link of the users profile that is clickable
					['inline'] = true  --sets whether the field should be displayed in a single line or multiple 
				}
			}
		}}
	}
	Data = HTTPService:JSONEncode(Data) --We use the HTTPServices JSONEncode method to convert the "Data" table into a JSON string.
	HTTPService:PostAsync(Webhook_URL, Data) --send the "Data" as a post request to the Discord Webhook URL.

end)
