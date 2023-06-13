local limitSpeed = false
local speedLimit = 0.0
local controlKey = 38

CreateThread(function()
    while (true) do
        Wait(0)

        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if (IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed) then
            if (IsControlJustPressed(0, controlKey)) then
                limitSpeed = not limitSpeed
                if (limitSpeed) then
                    speedLimit = GetEntitySpeed(vehicle)
                    SetEntityMaxSpeed(vehicle, speedLimit)
                    TriggerEvent("chat:addMessage", {args = {"^1[Limitateur de vitesse]^7 Limitation de vitesse activée à " .. math.floor(speedLimit * 3.6) .. " km/h"}})
                else
                    SetEntityMaxSpeed(vehicle, 999.0)
                    TriggerEvent("chat:addMessage", {args = {"^1[Limitateur de vitesse]^7 Limitation de vitesse désactivée"}})
                end
            end
        end
    end
end)