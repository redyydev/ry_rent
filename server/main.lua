framework = nil

if RY.Options.FrameWork == 'esx' then
    framework = exports['es_extended']:getSharedObject()   
elseif RY.Options.FrameWork == 'qb' then
    framework = exports['qb-core']:GetCoreObject()
end

RegisterNetEvent('ry-vehiclerental:checkMoney', function(amount)
    local _source = source
    local xPlayer = nil
    local playerMoney = 0

    if RY.Options.FrameWork == 'esx' then
        xPlayer = framework.GetPlayerFromId(_source)
        playerMoney = xPlayer.getAccount("money").money

        if xPlayer ~= nil then
            if tonumber(playerMoney) >= amount then
                TriggerClientEvent('ry-vehiclerental:sendhaveMoney', _source, true)
            else
                TriggerClientEvent('ry-vehiclerental:sendhaveMoney', _source, false)
            end
        end
    elseif RY.Options.FrameWork == 'qb' then
        xPlayer = framework.Functions.GetPlayer(_source)
        playerMoney = xPlayer.PlayerData.money["cash"]

        if xPlayer ~= nil then
            if tonumber(playerMoney) >= amount then
                TriggerClientEvent('ry-vehiclerental:sendhaveMoney', _source, true)
            else
                TriggerClientEvent('ry-vehiclerental:sendhaveMoney', _source, false)
            end
        end
    end
end)

RegisterNetEvent('ry-vehiclerental:removeMoney', function(total)
    local _source = source
    local xPlayer = nil
    local playerMoney = 0

    if RY.Options.FrameWork == 'esx' then
        xPlayer = framework.GetPlayerFromId(_source)
        
        if xPlayer ~= nil then
            xPlayer.removeMoney(tonumber(total))
        end
    elseif RY.Options.FrameWork == 'qb' then
        xPlayer = framework.Functions.GetPlayer(_source)
        
        if xPlayer ~= nil then
            xPlayer.Functions.RemoveMoney("cash", tonumber(total))
        end
    end
end)

RegisterServerEvent("ry-vehiclerental:giveMoney")
AddEventHandler("ry-vehiclerental:giveMoney", function(amount)
    local _source = source
    local xPlayer = nil

    if RY.Options.FrameWork == 'esx' then
        xPlayer = framework.GetPlayerFromId(_source)
        xPlayer.addMoney(tonumber(amount))
    elseif RY.Options.FrameWork == 'qb' then
        xPlayer = framework.Functions.GetPlayer(_source)
        xPlayer.Functions.AddMoney("cash", tonumber(total))
    end
end)

