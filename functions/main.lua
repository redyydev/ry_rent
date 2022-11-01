function open_ui(location)
	local vehicles = {}

	for k,v in pairs(Config.Locations[location].vehicles) do 
		table.insert(vehicles, {location = location, id= k,  model = v.model, label = v.label, description = v.description, price = v.price, type = v.type, image = v.image_name})
	end

	TriggerScreenblurFadeIn(1)
	SendNUIMessage({action = 'open', content = { vehicles = vehicles }})
	SetNuiFocus(true, true)

	InMenu = true
end

function rentVehicle(model, price, location, r,g,b)
	Options.pricePaid = 0

	for k,v in pairs(Config.Locations) do
		if k == location then
			local spawnCoords = v.spawn_coords
			ESX.TriggerServerCallback('ry_rent:check', function(have_money)
				if have_money then
					RequestModel(model)
					
					while not HasModelLoaded(model) do
						Citizen.Wait(10)
					end
					
					if ESX.Game.IsSpawnPointClear(spawnCoords, 5) then
						TriggerServerEvent('ry_rent:pay', price)
						Options.pricePaid = price

						ESX.Game.SpawnVehicle(model, spawnCoords, spawnCoords.h, function(vehicle)
							SetEntityAsMissionEntity(vehicle, true, true)
							TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)

							SetVehicleCustomPrimaryColour(vehicle, r, g, b)
							SetVehicleCustomSecondaryColour(vehicle, 0, 0, 0)

							Options.vehicle.hash = vehicle  
							Options.have_rented = true
						end)

						changeBlip(false)
						closeUi()
						
						if Config.Options.showTimer then
							showTimer()
						end
					else
						Notification(Config.Options.spawnPointBlocked)
					end

				else
					Notification(Config.Options.donthaveMoney)
				end
			end, price)
		end
	end
end

function returnVehicle(player)
	if IsPedSittingInVehicle(player, Options.vehicle.hash) then
		deleteVehicle(Options.vehicle.hash)

		Options.vehicle.hash = nil
		Options.have_rented = false

		changeBlip(true)
		SendNUIMessage({action = "hide_timer"})

		if Config.Options.refundMoneyWhenDelivered then
			TriggerServerEvent('ry_rent:pay', Options.pricePaid, true)
		end

		Notification(Config.Options.returnSuccess)
	else
		Notification(Config.Options.returnError)
	end
end

function finishRent()
	Notification(Config.Options.rentFinished)

	Options.have_rented = false
	changeBlip(true)

	if IsPedSittingInVehicle(GetPlayerPed(-1), Options.vehicle.hash) then
		SetVehicleEngineHealth(Options.vehicle.hash, -4000)
		SetVehicleEngineOn(Options.vehicle.hash, false, true, true)
		SetVehicleDoorsLocked(Options.vehicle.hash, 2)
		if Config.Options.deleteVehicleWhenFinished then
			Citizen.Wait(Config.Options.deleteTime)
			deleteVehicle(Options.vehicle.hash)
		end
	else
		SetVehicleEngineHealth(Options.vehicle.hash, -4000)
		deleteVehicle(Options.vehicle.hash)
	end
end

function deleteVehicle(vehicle)
	DeleteVehicle(vehicle)
end

function showTimer() 
	SendNUIMessage({action = "show_timer", content = { time = Config.Options.timeRent }})
	SetNuiFocus(false, false)
end

function changeBlip(remove)
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

function Notification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function closeUi()
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


