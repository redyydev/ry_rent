local rentalVehicles = {}

function openMenu(lastLocation)
	cache.lastLocation = lastLocation
	
	rentalVehicles = {}
	for k,v in pairs(RY.Locations[cache.lastLocation].vehiclesConfig) do
		table.insert(rentalVehicles, {
			vehicleID = k,
			vehicleModel = v.vehicleModel,
			vehicleLabel = v.vehicleLabel,
			vehicleDescription = v.vehicleDescription,
			vehicleRentalPrice = v.vehicleRentalPrice,
			vehicleType = v.vehicleType,
			vehicleImageName = v.vehicleImageName,
		})
	end

	TriggerScreenblurFadeIn(1)
	SendNUIMessage({action = 'openMenu', data = { rentalVehicles = rentalVehicles, maxPerformance = RY.Options.priceMaxPerformance }})
	SetNuiFocus(true, true)

	InMenu = true
end

function rentVehicle(vehicleID, vehicleRentalPrice, vehicleColor, vehicleMaxPerformance)
    TriggerServerEvent('ry-vehiclerental:checkMoney', vehicleRentalPrice)

	Citizen.Wait(100)

	local spawnCoords = nil
	local vehicleModel = nil
	
	for k,v in pairs(RY.Locations) do
		if k == cache.lastLocation then
			spawnCoords = v.vehicleSpawnCoords
			vehicleModel = v.vehiclesConfig[vehicleID].vehicleModel
		end
	end

	RequestModel(vehicleModel)
	
	while not HasModelLoaded(vehicleModel) do
		Citizen.Wait(10)
	end

	if cache.haveMoney then
		if RY.Options.FrameWork == 'esx' then
			Framework.Game.SpawnVehicle(vehicleModel, spawnCoords, spawnCoords.h, function(vehicle)
				SetEntityAsMissionEntity(vehicle, true, true)
				TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)

				SetVehicleCustomPrimaryColour(vehicle, vehicleColor.r, vehicleColor.g, vehicleColor.b)
				SetVehicleCustomSecondaryColour(vehicle, 0, 0, 0)

				if vehicleMaxPerformance == 'on' then
					PerformanceUpgradeVehicle(vehicle)
				end

				cache.vehicleRented = vehicle
			end)
		elseif RY.Options.FrameWork == 'qb' then
			Framework.Functions.SpawnVehicle(vehicleModel, function(vehicle)
				SetEntityAsMissionEntity(vehicle, true, true)
				TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)

				SetVehicleCustomPrimaryColour(vehicle, vehicleColor.r, vehicleColor.g, vehicleColor.b)
				SetVehicleCustomSecondaryColour(vehicle, 0, 0, 0)

				if vehicleMaxPerformance == 'on' then
					PerformanceUpgradeVehicle(vehicle)
				end

				cache.vehicleRented = vehicle
			end, spawnCoords, true)
		end
		TriggerServerEvent('ry-vehiclerental:removeMoney', vehicleRentalPrice)
		
		cache.haveRented = true
		cache.pricePaid = vehicleRentalPrice
		
		closeMenu()
		returnBlip(false)
		if RY.Options.enableRentTimer then
			showTimer()
		end
	else
		notification(RY.Messages.noMoney)
	end
end

function returnVehicle(player)
	if IsPedSittingInVehicle(player, cache.vehicleRented) then
		DeleteVehicle(cache.vehicleRented)
		
		cache.haveRented = false
		cache.vehicleRented = nil

		if RY.Options.refundMoneyWhenDelivered then
			local refundMessage = RY.Messages.refund
			refundMessage = string.gsub(refundMessage, "%%payment%%", cache.pricePaid)

			TriggerServerEvent('ry-vehiclerental:giveMoney', cache.pricePaid)
			notification(refundMessage)
		end

		returnBlip(true)
		if RY.Options.enableRentTimer then
			disableTimer()
		end
		notification(RY.Messages.returnSuccess)
	else
		notification(RY.Messages.returnError)
	end
end

function finishRent()
	notification(RY.Messages.rentFinished)
	
	if RY.Options.enableRentTimer then
		disableTimer()
	end
	returnBlip(true)

	cache.haveRented = false

	if IsPedSittingInVehicle(PlayerPedId(), cache.vehicleRented) then
		SetVehicleEngineHealth(cache.vehicleRented, -4000)
		SetVehicleEngineOn(cache.vehicleRented, false, true, true)
		SetVehicleDoorsLocked(cache.vehicleRented, 2)

		if RY.Options.deleteVehicleWhenFinished then
			Citizen.Wait(RY.Options.deleteTime)

			local latestVehicle = cache.vehicleRented
			DeleteVehicle(latestVehicle)
		end
	else
		SetVehicleEngineHealth(cache.vehicleRented, -4000)
		DeleteVehicle(cache.vehicleRented)
	end
	cache.vehicleRented = nil
end

function returnBlip(remove)
	if remove then
		RemoveBlip(cache.blips['return'])
		cache.blips['return'] = nil
	else
		for k, v in pairs(RY.Locations) do
			if k == cache.lastLocation then
				cache.blips['return'] = AddBlipForCoord(v.returnVehicleCoords.x, v.returnVehicleCoords.y, v.returnVehicleCoords.z)
						
				SetBlipSprite (cache.blips['return'], v.blipsConfig.blipReturnMenu.blipSprite)
				SetBlipDisplay(cache.blips['return'], 4)
				SetBlipScale  (cache.blips['return'], v.blipsConfig.blipReturnMenu.blipScale)
				SetBlipAsShortRange(cache.blips['return'], true)
				SetBlipColour(cache.blips['return'], v.blipsConfig.blipReturnMenu.blipColor)
			
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentSubstringPlayerName(v.blipsConfig.blipReturnMenu.blipName)
				EndTextCommandSetBlipName(cache.blips['return'])
			end
		end
	end
end

function showTimer()
	SetNuiFocus(false, false)
	SendNUIMessage({action = "showTimer", data = { time = RY.Options.rentTime }})
end

function disableTimer()
	SendNUIMessage({action = "hideTimer"})
end

local performanceModIndices = {11,12,13,16}
function PerformanceUpgradeVehicle(vehicle, customWheels)
    customWheels = customWheels or false
    local max
    if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        for _, modType in ipairs(performanceModIndices) do
            max = GetNumVehicleMods(vehicle, modType) - 1
            SetVehicleMod(vehicle, modType, max, customWheels)
        end
        ToggleVehicleMod(vehicle, 18, true) -- Turbo
    end
end

function notification(msg, type)
    if RY.Options.FrameWork == 'esx' then
        Framework.ShowNotification(msg) -- Default ESX notification
    elseif RY.Options.FrameWork == 'qb' then
        Framework.Functions.Notify(msg) -- Default QB notification
    end

    --[[ TriggerEvent('mythic_notify:client:SendAlert', {							example mythic notification
    	type = type,
    	text = msg,
    	length = 7500
     })]]--
end

function closeMenu()
	TriggerScreenblurFadeOut(1000)
	SendNUIMessage({action = "closeMenu"})
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
