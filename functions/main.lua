function rent_vehicle(model, price, location)
	for k,v in pairs(Config.Locations) do 
		if k == location then
			local spawn_coords = v.spawn_coords
			ESX.TriggerServerCallback('ry_rent:check', function(can)
				if can then
					RequestModel(model) 
					while not HasModelLoaded(model) do
						Citizen.Wait(10)
					end
					if ESX.Game.IsSpawnPointClear(spawn_coords, 5) then
						ESX.Game.SpawnVehicle(model, spawn_coords, spawn_coords.h, function(vehicle)
							SetEntityAsMissionEntity(vehicle, true, true)
							TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
							Options.vehicle.hash = vehicle  
							Options.have_rented = true
							set_blip(false)
						end)
						TriggerServerEvent('ry_rent:pay', price)
						if Config.Options['time'] then
							show_timer()
						end
					else
						Notification(Config.Options['spawnpoint_blocked'])
					end
				end
			end, price)
		end
	end
end

function return_vehicle()
	if IsPedSittingInVehicle(GetPlayerPed(-1), Options.vehicle.hash) then
		delete_vehicle(Options.vehicle.hash)

		Options.vehicle.hash = nil
		Options.have_rented = false

		set_blip(true)
		SendNUIMessage({action = "hide_timer"})
		Notification(Config.Options['return_success'])
	else
		Notification(Config.Options['return_error'])
	end
end

function set_blip(remove)
	if remove then
		RemoveBlip(Options.blips['return'])
		Options.blips['return'] = nil
	else
		for k, v in pairs(Config.Locations) do
			if k == Options.last_location then
				Options.blips['return'] = AddBlipForCoord(v.return_coords.x, v.return_coords.y, v.return_coords.z)
						
				SetBlipSprite (Options.blips['return'], v.blips.return_spot.sprite)
				SetBlipDisplay(Options.blips['return'], 4)
				SetBlipScale  (Options.blips['return'], v.blips.return_spot.scale)
				SetBlipAsShortRange(Options.blips['return'], true)
				SetBlipColour(Options.blips['return'], v.blips.return_spot.color)
			
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentSubstringPlayerName(v.blips.return_spot.name)
				EndTextCommandSetBlipName(Options.blips['return'])
			end
		end
	end
end

function show_timer()
	SendNUIMessage({action = "show_timer", content = { time = Config.Options['time_rent'] }})
	SetNuiFocus(false, false)
end

function finish()
	Notification(Config.Options['time_finished'])
	if IsPedSittingInVehicle(GetPlayerPed(-1), Options.vehicle.hash) then
		SetVehicleEngineHealth(Options.vehicle.hash, -4000)
		SetVehicleEngineOn(Options.vehicle.hash, false, true, true)
		SetVehicleDoorsLocked(Options.vehicle.hash, 2)
		if Config.Options['delete_vehicle'] then
			Citizen.Wait(Config.Options['delete_time'])
			delete_vehicle(Options.vehicle.hash)
		end
	else
		SetVehicleEngineHealth(Options.vehicle.hash, -4000)
		delete_vehicle(Options.vehicle.hash)
	end
	Options.have_rented = false
	set_blip(true)
end

function delete_vehicle(vehicle)
	DeleteVehicle(vehicle)
end

function Notification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function open_ui(location)
	local vehicles = {}

	for k,v in pairs(Config.Vehicles) do 
		table.insert(vehicles, {location = location, id= k,  model = v.model, label = v.label, description = v.description, price = v.price, type = v.type, image = v.image_name})
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


