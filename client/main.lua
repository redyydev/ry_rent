--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- SCRIPT BY REDYY#0449
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

ESX = nil
PlayerData = nil
InMenu = false

Options = {
    vehicle = {
        hash = 0,
    },
    last_location = '',
    have_rented = false,
    blips = {}
}

Citizen.CreateThread(function()
    Wait(100)
	while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Citizen.Wait(0) end
    while ESX.GetPlayerData().job == nil do Wait(0) end
    ESX.PlayerData = ESX.GetPlayerData()
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

Citizen.CreateThread(function()
    Wait(1000)
    while PlayerData == nil do Wait(10) end
    while true do 
        Citizen.Wait(1)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
        for k,v in pairs(Config.Locations) do
            if not InMenu then
                local distance = #(coords - v.coords)
                local return_distance = #(coords - v.return_coords) 

                    if distance < 1 then
                        DrawText3D(v.coords.x, v.coords.y, v.coords.z + 0.25, v.markers.spawn.text)
                        if IsControlJustReleased(0, v.markers.spawn.key) then
                            Options.last_location = k
                            open_ui(k)
                        end
                    end

                    if distance <= 15 then
                        DrawMarker(v.markers.spawn.type, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.markers.spawn.size.x, v.markers.spawn.size.y, v.markers.spawn.size.z, v.markers.spawn.color.r, v.markers.spawn.color.g, v.markers.spawn.color.b, 50, false, true, 2, false, nil, nil, false)
                    end

                    if Options.have_rented then
                        if return_distance < 3 then
                            DrawText3D(v.return_coords.x, v.return_coords.y, v.return_coords.z + 0.25, v.markers.return_spot.text)
                            if IsControlJustReleased(0, v.markers.return_spot.key) then
                                return_vehicle()
                            end
                        end
                        if return_distance <= 15 then
                            DrawMarker(v.markers.return_spot.type, v.return_coords.x, v.return_coords.y, v.return_coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.markers.return_spot.size.x, v.markers.return_spot.size.y, v.markers.return_spot.size.z, v.markers.return_spot.color.r, v.markers.return_spot.color.g, v.markers.return_spot.color.b, 50, false, true, 2, false, nil, nil, false)
                        end
                    end
            end
        end
    end
end)

Citizen.CreateThread(function()
	for k, v in pairs(Config.Locations) do
		rent = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
  
		SetBlipSprite (rent, v.blips.spawn.sprite)
		SetBlipDisplay(rent, 4)
		SetBlipScale  (rent, 0.65)
		SetBlipAsShortRange(rent, true)
		SetBlipColour(rent, v.blips.spawn.color)
  
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName(v.blips.spawn.name)
		EndTextCommandSetBlipName(rent)
	end
end)

