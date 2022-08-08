RegisterServerEvent("ry_rent:pay");
AddEventHandler("ry_rent:pay", function(amount)
	local _source = source;
	local xPlayer = ESX.GetPlayerFromId(_source);
	local Money = (xPlayer.getAccount("money")).money;
	if Money >= amount then
		xPlayer.removeMoney(tonumber(amount));
		TriggerClientEvent("esx:showNotification", source, "You paid ~g~" .. amount .. "~w~$ to rent the vehicle.");
	end;
end);

ESX.RegisterServerCallback("ry_rent:check", function(source, cb, amount)
	local _source = source;
	local xPlayer = ESX.GetPlayerFromId(_source);
	local Money = (xPlayer.getAccount("money")).money;
	if xPlayer ~= nil then
		if Money >= amount then
			cb(true);
		else
			cb(false);
			TriggerClientEvent("esx:showNotification", source, Config.Options.no_money);
		end;
	end;
end);
