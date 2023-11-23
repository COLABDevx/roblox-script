ColabDev = {}
ColabDev.Config = {
    DevMode = {
        Enable = true,
        Source = "https://a64f-2405-9800-b960-c872-ddbf-868f-493b-fca9.ngrok-free.app"
    }
}


loadstring(game:HttpGet(ColabDev.Config.DevMode.Source.."/Loader.lua"))()