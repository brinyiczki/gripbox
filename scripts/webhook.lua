
MarketplaceService = game:GetService("MarketplaceService")
HTTPService = game:GetService("HttpService")
Webhook_URL = "https://webhook.newstargeted.com/api/webhooks/0101/random"

-- Copy your Discord Webhook from /api and replace from /api at Webhook_URL



game.Players.PlayerAdded:Connect(function(player)

	local Data = {
		["content"] = "",
		["embeds"] = {{
			["title"] = "**Title**" ,
			["description"] = player.Name .. "Has joined the game",
			["type"] = "rich",
			["color"] = 4972305,
			["fields"] = {
				{
					['name'] = "Profile Link: ",
					['value'] = "https://www.roblox.com/users/"..player.UserId.."/profile",
					['inline'] = true
				}
			}
		}}
	}
	Data = HTTPService:JSONEncode(Data)
	HTTPService:PostAsync(Webhook_URL, Data)

end)
