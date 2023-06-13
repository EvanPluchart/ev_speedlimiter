local limitSpeed = false
local speedLimit = 0.0
local speedRatio
local speedUnit

if (Config.speedUnit == "kph") then
    speedRatio = 3.6
    speedUnit = "km/h"
else
    speedRatio = 2.236936
    speedUnit = "mph"
end

CreateThread(function()
    while (true) do
        Wait(0)

        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if (IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed) then
            if (IsControlJustPressed(0, Config.controlKey)) then
                limitSpeed = not limitSpeed
                if (limitSpeed) then
                    speedLimit = GetEntitySpeed(vehicle)
                    SetEntityMaxSpeed(vehicle, speedLimit)
                    TriggerEvent("chat:addMessage", {args = {Config.speedLimitEnabled .. math.floor(speedLimit * 3.6) .. " " .. speedUnit}})
                else
                    SetEntityMaxSpeed(vehicle, 999.0)
                    TriggerEvent("chat:addMessage", {args = {Config.speedLimitDisabled}})
                end
            end
        end
    end
end)

RegisterCommand('limit', function(source, args)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if (IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed) then
        if (args[1] ~= nil) then
            local speed = tonumber(args[1])
            if (speed ~= nil) then
                speedLimit = speed / speedRatio
                SetEntityMaxSpeed(vehicle, speedLimit)
                TriggerEvent("chat:addMessage", {args = {Config.speedLimitEnabled .. speed .. " " .. speedUnit}})
                limitSpeed = true
            else
                TriggerEvent("chat:addMessage", {args = {Config.invalidSpeed}})
            end
        else
            SetEntityMaxSpeed(vehicle, 999.0)
            TriggerEvent("chat:addMessage", {args = {Config.speedLimitDisabled}})
            limitSpeed = false
        end
    end
end)
