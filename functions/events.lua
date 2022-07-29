RegisterNUICallback("rent",function(data)
    local model = data.model
    local price = data.price
    local location = data.location

    rent_vehicle(model, price, location)
end)

RegisterNUICallback("CloseUI",function()
    close_ui()
end)
