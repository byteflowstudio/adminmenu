ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local isMenuOpen = false

-- Register the /byteflow command
RegisterCommand('byteflow', function()
    if not isMenuOpen then
        OpenByteflowMenu()
    end
end, false)

-- Keybind to open the admin menu
RegisterKeyMapping('open_admin_menu', 'Open Admin Menu', 'keyboard', 'F7')

RegisterCommand('open_admin_menu', function()
    OpenAdminMenu()
end, false)

-- Function to open the main menu
function OpenByteflowMenu()
    isMenuOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openMenu",
        type = "mainMenu"
    })
end

-- Function to open the admin menu
function OpenAdminMenu()
    isMenuOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openMenu",
        type = "adminMenu"
    })
end

-- Close the menu
RegisterNUICallback('closeMenu', function(data, cb)
    isMenuOpen = false
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Handle vehicle spawning
RegisterNUICallback('spawnVehicle', function(data, cb)
    local model = data.vehicleName
    if model then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local heading = GetEntityHeading(playerPed)

        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end

        local vehicle = CreateVehicle(model, coords.x + 2.0, coords.y, coords.z, heading, true, false)
        SetPedIntoVehicle(playerPed, vehicle, -1)
        SetModelAsNoLongerNeeded(model)
    end
    cb('ok')
end)
