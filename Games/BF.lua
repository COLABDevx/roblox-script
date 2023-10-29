_.G['ColabX'].Configs = {

}

local function WalkOnWater()
    local WaterBasePlane = workspace.Map["WaterBase-Plane"]

    WaterBasePlane.Size = WaterBasePlane.Size + Vecter3.new(0,13,0)
end

WalkOnWater()