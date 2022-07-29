RegisterServerEvent('ry_rent:pay')
AddEventHandler('ry_rent:pay', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local Money = xPlayer.getAccount('money').money

    if Money >= amount then 
        xPlayer.removeMoney(tonumber(amount))
        TriggerClientEvent('esx:showNotification', source, 'You paid ~g~' .. amount .. '~w~$ to rent the vehicle.')
    else
        TriggerClientEvent('esx:showNotification', source, 'You dont have enough Money to rent a vehicle.')
    end
end)

ESX.RegisterServerCallback('ry_rent:check', function(source, cb, amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

  if xPlayer ~= nil then
		if xPlayer.getMoney() >= tonumber(amount) then
			cb(true)
		else
			cb(false)
		end
	end
end)