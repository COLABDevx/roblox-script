ColabDev = {}
ColabDev.Config = {
    DevMode = {
        Enable = true,
        Source = "https://e4e0-2405-9800-b960-c872-5509-ce32-7bd2-2535.ngrok-free.app"
    }
}


loadstring(game:HttpGet(ColabDev.Config.DevMode.Source.."/Loader.lua"))()ty