RegisterNUICallback("rent",function(data)
    local model = data.model
    local price = data.price
    local location = data.location
    local r,g,b = data.r, data.g, data.b

    rentVehicle(model, price, location, r, g, b)
end)

RegisterNUICallback("finishRent",function(data)
    finishRent()
end)

RegisterNUICallback("CloseUI",function()
    closeUi()
end)
