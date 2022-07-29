function rent_vehicle(model, price, location)
	for k,v in pairs(Config.Locations) do 
		if k == location then
			local spawn_coords = v.spawn_coords
			ESX.TriggerServerCallback('ry_rent:check', function(can)
				if can then
					if ESX.Game.IsSpawnPointClear(spawn_coords, 5) then
						TriggerServerEvent('ry_rent:pay', price)
						ESX.Game.SpawnVehicle(model, spawn_coords, spawn_coords.h, function(vehicle)
							TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)  
						end)
					else
						ESX.ShowNotification(Config.Options['spawnpoint_blocked'])
					end
				else
					ESX.ShowNotification(Config.Options['no_money'])
				end
			end, price)
		end
	end
end

function open_ui(location)

	local vehicles = {}

	for k,v in pairs(Config.Vehicles) do 
		table.insert(vehicles, {location = location,  model = k, label = v.label, description = v.description, price = v.price, type = v.type, image = v.image_name})
	end

	TriggerScreenblurFadeIn(1)
	SendNUIMessage({action = 'open', content = { vehicles = vehicles }})
	SetNuiFocus(true, true)

	InMenu = true
end

function close_ui()
  TriggerScreenblurFadeOut(1000)
	SendNUIMessage({action = "close"})
	SetNuiFocus(false, false)

	InMenu = false
end


























function DrawText3D(x, y, z, text)
	local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId()))

	local distance = GetDistanceBetweenCoords(x, y, z, px, py, pz, false)

	if distance <= 6 then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(true)
		AddTextComponentString(text)
		SetDrawOrigin(x,y,z, 0)
		DrawText(0.0, 0.0)
		local factor = (string.len(text)) / 370
		DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
		ClearDrawOrigin()
	end
end


