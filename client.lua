JustTeleported = false
Citizen.CreateThread(function()
    while true do
        local inRange = false
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        for loc,_ in pairs(Config.Teleports) do
            for k, v in pairs(Config.Teleports[loc]) do
                local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                if dist < 5 then
                    inRange = true
                    if not v.hide then
                        DrawMarker(21, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
                    end
                    if dist < 1 then
                        DrawText3D(v.coords.x, v.coords.y, v.coords.z, v.drawText)
                        if IsControlJustReleased(0, 51) then
                            if k == 1 then
                                if v.AllowVehicle then
                                    SetPedCoordsKeepVehicle(ped, Config.Teleports[loc][2].coords.x, Config.Teleports[loc][2].coords.y, Config.Teleports[loc][2].coords.z)
                                else
                                    SetEntityCoords(ped, Config.Teleports[loc][2].coords.x, Config.Teleports[loc][2].coords.y, Config.Teleports[loc][2].coords.z)
                                end

                                if type(Config.Teleports[loc][2].coords) == "vector4" then
                                    SetEntityHeading(ped, Config.Teleports[loc][2].coords.w)
                                end
                            elseif k == 2 then
                                if v.AllowVehicle then
                                    SetPedCoordsKeepVehicle(ped, Config.Teleports[loc][1].coords.x, Config.Teleports[loc][1].coords.y, Config.Teleports[loc][1].coords.z)
                                else
                                    SetEntityCoords(ped, Config.Teleports[loc][1].coords.x, Config.Teleports[loc][1].coords.y, Config.Teleports[loc][1].coords.z)
                                end

                                if type(Config.Teleports[loc][1].coords) == "vector4" then
                                    SetEntityHeading(ped, Config.Teleports[loc][1].coords.w)
                                end
                            end
                            ResetTeleport()
                        end
                    end
                end
            end
        end
        if not inRange then
            Citizen.Wait(1000)
        end
        Citizen.Wait(3)
    end
end)

ResetTeleport = function()
    SetTimeout(1000, function()
        JustTeleported = false
    end)
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.0, 0.45)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
end