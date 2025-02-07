RegisterNetEvent('48dev-world:setTime')
AddEventHandler('48dev-world:setTime', function(hour, minute)
    NetworkOverrideClockTime(hour, minute, 0)
end)

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('48dev-world:requestSync')
end)
