RegisterNetEvent('ry-vehiclerental:openMenu',function(data)
    local lastLocation = data.args.location

    if cache.haveRented then
        notification(RY.Messages.alreadyRented)
    else
        openMenu(lastLocation)
    end
end)

RegisterNetEvent('ry-vehiclerental:returnVehicle',function(data)
    local playerPed = PlayerPedId()
    returnVehicle(playerPed)
end)

RegisterNetEvent('ry-vehiclerental:sendhaveMoney',function(haveMoney)
    cache.haveMoney = haveMoney
end)

RegisterNUICallback("finishRent",function()
    finishRent()
end)

RegisterNUICallback("rentVehicle",function(data)
    rentVehicle(data.vehicleID, data.vehicleRentalPrice, data.vehicleColor, data.vehicleMaxPerformance)
end)

RegisterNUICallback("CloseMenu",function()
    closeMenu()
end)