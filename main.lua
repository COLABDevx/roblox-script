ColabDev = {}
ColabDev.Config = {
    DevMode = {
        Enable = false,
        Source = "https://raw.githubusercontent.com/COLABDevx/roblox-script/main"
    }
}


loadstring(game:HttpGet(ColabDev.Config.DevMode.Source.."/Loader.lua"))()