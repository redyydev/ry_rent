Framework = nil
inMenu = false
sleepWait = true
cache = {
    lastLocation = nil,
    haveMoney = false,
    haveRented = false,
    pricePaid = 0,
    vehicleRented = nil,
    blips = {}
}

if RY.Options.FrameWork == 'esx' then
    Framework = exports['es_extended']:getSharedObject()   
elseif RY.Options.FrameWork == 'qb' then
    Framework = exports['qb-core']:GetCoreObject()
end

if not RY.Options.oxTarget.enable then
    Citizen.CreateThread(function()
        while true do 
            Citizen.Wait(1)
            sleepWait = true
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
    
            if not InMenu then
                for k,v in pairs(RY.Locations) do
                    local distanceBetwennPlayerAndMenu = #(playerCoords - v.menuCoords)        
                    local distanceBetwennPlayerAndReturnMenu = #(playerCoords - v.returnVehicleCoords)      

                    if distanceBetwennPlayerAndMenu < 1 then
                        sleepWait = false
                        if cache.haveRented then
                            DrawText3D(v.menuCoords.x, v.menuCoords.y, v.menuCoords.z + 0.25, RY.Messages.alreadyRented)                        
                        else
                            DrawText3D(v.menuCoords.x, v.menuCoords.y, v.menuCoords.z + 0.25, v.markersConfig.markerMenu.markerText)                        
                            if IsControlJustReleased(0, v.markersConfig.markerMenu.useKey) then
                                openMenu(k)
                            end
                        end
                    end
    
                    if  distanceBetwennPlayerAndMenu <= 15 then
                        sleepWait = false
                        DrawMarker(v.markersConfig.markerMenu.markerType, v.menuCoords.x, v.menuCoords.y, v.menuCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.markersConfig.markerMenu.markerSize.x, v.markersConfig.markerMenu.markerSize.y, v.markersConfig.markerMenu.markerSize.z, v.markersConfig.markerMenu.markerColor.r, v.markersConfig.markerMenu.markerColor.g, v.markersConfig.markerMenu.markerColor.b, 50, false, true, 2, false, nil, nil, false)
                    end

                    if cache.haveRented and not RY.Options.oxTarget.enable then
                        if distanceBetwennPlayerAndReturnMenu < 3 then
                            sleepWait = false
                            DrawText3D(v.returnVehicleCoords.x, v.returnVehicleCoords.y, v.returnVehicleCoords.z + 0.25, v.markersConfig.markerReturnMenu.markerText)
                            if IsControlJustReleased(0, v.markersConfig.markerReturnMenu.useKey) then
                                returnVehicle(playerPed)
                            end
                        end
    
                        if distanceBetwennPlayerAndReturnMenu < 15 then
                            sleepWait = false
                            DrawMarker(v.markersConfig.markerReturnMenu.markerType, v.returnVehicleCoords.x, v.returnVehicleCoords.y, v.returnVehicleCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.markersConfig.markerReturnMenu.markerSize.x, v.markersConfig.markerReturnMenu.markerSize.y, v.markersConfig.markerReturnMenu.markerSize.z, v.markersConfig.markerReturnMenu.markerColor.r, v.markersConfig.markerReturnMenu.markerColor.g, v.markersConfig.markerReturnMenu.markerColor.b, 50, false, true, 2, false, nil, nil, false)
                        end
                    end
                end
            end
            if sleepWait then
                Citizen.Wait(150)
            end
        end 
    end)
end

for k, v in pairs(RY.Locations) do
    if RY.Options.oxTarget.enable then
        exports.ox_target:addBoxZone({
            coords = vector3(v.menuCoords.x, v.menuCoords.y, v.menuCoords.z),
            size = vector3(3,3,3),
            rotation = 45,
            debug = false,
            options = {
                {
                    name = 'rent' .. k,
                    event = 'ry-vehiclerental:openMenu',
                    args = { location = k },
                    icon = RY.Options.oxTarget.icons.menu,
                    label = RY.Options.oxTarget.labels.menu
                }
            }
        })
        exports.ox_target:addBoxZone({
            coords = vector3(v.returnVehicleCoords.x, v.returnVehicleCoords.y, v.returnVehicleCoords.z),
            size = vector3(3,3,3),
            rotation = 45,
            debug = false,
            options = {
                {
                    name = 'rent-return' .. k,
                    event = 'ry-vehiclerental:returnVehicle',
                    icon = RY.Options.oxTarget.icons.menu,
                    label = RY.Options.oxTarget.labels.returnMenu
                }
            }
        })
    end

	rent = AddBlipForCoord(v.menuCoords.x, v.menuCoords.y, v.menuCoords.z)
	SetBlipSprite (rent, v.blipsConfig.blipMenu.blipSprite)
	SetBlipDisplay(rent, 4)
	SetBlipScale  (rent, v.blipsConfig.blipMenu.blipScale)
	SetBlipAsShortRange(rent, true)
	SetBlipColour(rent, v.blipsConfig.blipMenu.blipColor)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName(v.blipsConfig.blipMenu.blipName)
	EndTextCommandSetBlipName(rent)
end
