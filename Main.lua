ColabDev = {}
ColabDev.Config = {
    DevMode = {
        Enable = true,
        Source = "https://ce50-2405-9800-b960-c872-c06-83b6-ba3c-11ea.ngrok-free.app"
    }
}


loadstring(game:HttpGet(ColabDev.Config.DevMode.Source.."/Loader.lua"))()