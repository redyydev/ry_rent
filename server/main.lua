--
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('ry_rent:pay')
AddEventHandler('ry_rent:pay', function(amount)
	local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
	
  xPlayer.removeMoney(tonumber(amount))
  TriggerClientEvent('esx:showNotification', source, 'You paid ~g~' .. amount .. '~w~$ to rent the vehicle.')
end)

ESX.RegisterServerCallback('ry_rent:check', function(source, cb, amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

  if xPlayer ~= nil then
		if xPlayer.getAccount('money').money >= tonumber(amount) then
			cb(true)
		else
			cb(false)
		end
	end
end)