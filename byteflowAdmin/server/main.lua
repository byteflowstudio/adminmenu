ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Handle giveCar
RegisterNUICallback('giveCar', function(data, cb)
    local vehicleName = data.vehicleName
    local playerId = data.targetId
    if vehicleName and playerId then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then
            MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
                ['@owner'] = xPlayer.identifier,
                ['@plate'] = 'BYTE'..math.random(1000, 9999),
                ['@vehicle'] = json.encode({model = GetHashKey(vehicleName), plate = 'BYTE'..math.random(1000, 9999)})
            }, function(rowsChanged)
                TriggerClientEvent('esx:showNotification', playerId, "You have received a new vehicle!")
            end)
        end
    end
    cb('ok')
end)

-- Handle giveMoney
RegisterNUICallback('giveMoney', function(data, cb)
    local amount = tonumber(data.amount)
    local playerId = tonumber(data.targetId)
    if amount > 0 and playerId then
        local xTarget = ESX.GetPlayerFromId(playerId)
        if xTarget then
            xTarget.addMoney(amount)
            TriggerClientEvent('esx:showNotification', playerId, "You received $" .. amount)
        end
    end
    cb('ok')
end)
