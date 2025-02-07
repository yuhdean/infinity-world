local currentHour = 12
local currentMinute = 0
local currentWeather = 'CLEAR'

local permissionsEnabled = true

RegisterCommand('settime', function(source, args)
    if permissionsEnabled and not IsPlayerAceAllowed(source, 'command.settime') then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Permission Denied',
            description = 'You do not have permission to use this command.',
            type = 'error'
        })
        return
    end

    local hour = tonumber(args[1])
    local minute = tonumber(args[2])

    if hour and minute and hour >= 0 and hour < 24 and minute >= 0 and minute < 60 then
        currentHour = hour
        currentMinute = minute
        TriggerClientEvent('48dev-world:setTime', -1, currentHour, currentMinute)
        print(('[48DEV] Time set to %02d:%02d by %s'):format(currentHour, currentMinute, GetPlayerName(source)))
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Time Updated',
            description = ('Time set to %02d:%02d'):format(currentHour, currentMinute),
            type = 'success'
        })
    else
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Invalid Time',
            description = 'Please enter a valid time (0-23 hours, 0-59 minutes).',
            type = 'error'
        })
    end
end, false)

RegisterCommand('setweather', function(source, args)
    if permissionsEnabled and not IsPlayerAceAllowed(source, 'command.setweather') then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Permission Denied',
            description = 'You do not have permission to use this command.',
            type = 'error'
        })
        return
    end

    local weatherType = args[1] and args[1]:upper()
    local validWeatherTypes = {
        CLEAR = true, EXTRASUNNY = true, CLOUDS = true, OVERCAST = true,
        RAIN = true, THUNDER = true, SMOG = true, FOGGY = true,
        XMAS = true, SNOWLIGHT = true, BLIZZARD = true
    }

    if weatherType and validWeatherTypes[weatherType] then
        currentWeather = weatherType
        TriggerClientEvent('48dev-world:setWeather', -1, currentWeather)
        print(('[48DEV] Weather set to %s by %s'):format(currentWeather, GetPlayerName(source)))
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Weather Updated',
            description = ('Weather set to %s'):format(currentWeather),
            type = 'success'
        })
    else
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Invalid Weather',
            description = 'Please enter a valid weather type.',
            type = 'error'
        })
    end
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000)
        TriggerClientEvent('48dev-world:setTime', -1, currentHour, currentMinute)
        TriggerClientEvent('48dev-world:setWeather', -1, currentWeather)
    end
end)

RegisterNetEvent('48dev-world:requestSync')
AddEventHandler('48dev-world:requestSync', function()
    local playerId = source
    TriggerClientEvent('48dev-world:setTime', playerId, currentHour, currentMinute)
    TriggerClientEvent('48dev-world:setWeather', playerId, currentWeather)
end)
