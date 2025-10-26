-- loader.lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/TonRepo/TonCheat/main/core/ui.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TonRepo/TonCheat/main/core/http.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TonRepo/TonCheat/main/core/config.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TonRepo/TonCheat/main/core/modules.lua"))()

-- Lancer le cheat
getgenv().Cheat = {}
Cheat.Name = "Ton Cheat"
Cheat.Version = "1.0"
Cheat.Game = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

-- Démarrer
loadstring(game:HttpGet("https://raw.githubusercontent.com/TonRepo/TonCheat/main/main.lua"))()
