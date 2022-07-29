--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- SCRIPT BY REDYY#0449
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
PlayerData = nil
InMenu = false

Citizen.CreateThread(function()
    Wait(100)
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
                if distance < 1 then
                    DrawText3D(v.coords.x, v.coords.y, v.coords.z + 0.2, v.marker.text)
                    if IsControlJustReleased(0, v.marker.key) then
                        open_ui(k)
                    end
                end
                if distance <= 15 then
                    DrawMarker(v.marker.type, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.marker.size.x, v.marker.size.y, v.marker.size.z, v.marker.color.r, v.marker.color.g, v.marker.color.b, 100, false, true, 2, false, nil, nil, false)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
	for k, v in pairs(Config.Locations) do
		rent = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
  
		SetBlipSprite (rent, v.blip.sprite)
		SetBlipDisplay(rent, 4)
		SetBlipScale  (rent, 0.65)
		SetBlipAsShortRange(rent, true)
		SetBlipColour(rent, v.blip.color)
  
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName(v.blip.name)
		EndTextCommandSetBlipName(rent)
	end
end)

