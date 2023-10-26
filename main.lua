ColabDev = {}
ColabDev.Config = {
    DevMode = {
        Enable = true,
        Source = {
            Ip = "https://raw.githubusercontent.com/COLABDevx/roblox-script/main",
        },
        LogService = {
            Ip = "http://192.168.1.120:9090",
            Port = 9090,
        }
    },
    Production = {
        Source = "",
        LogService = ""
    }
}


if ColabDev.Config.DevMode.Enable then
    loadstring(game:HttpGet(ColabDev.Config.DevMode.Source.Ip.."/loader.lua"))()
end