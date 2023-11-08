ColabDev = {}
ColabDev.Config = {
    DevMode = {
        Enable = true,
        Source = "https://6204-2405-9800-b960-c872-ace2-7966-95b2-7746.ngrok-free.app"
    }
}


loadstring(game:HttpGet(ColabDev.Config.DevMode.Source.."/Loader.lua"))()