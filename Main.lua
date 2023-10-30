ColabDev = {}
ColabDev.Config = {
    DevMode = {
        Enable = true,
        Source = "https://ef61-2405-9800-b960-c872-400-885e-53b6-4fa1.ngrok-free.app/"
    }
}


loadstring(game:HttpGet(ColabDev.Config.DevMode.Source.."/Loader.lua"))()ty