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

-- Server-side admin actions
RegisterNUICallback('adminAction', function(data, cb)
    if ESX.GetPlayerFromId(source).getGroup() == 'admin' then
        if data.action == "kickPlayer" then
            DropPlayer(data.targetId, "You have been kicked by an admin.")
        elseif data.action == "revivePlayer" then
            TriggerClientEvent('esx_ambulancejob:revive', data.targetId)
        end
    else
        print("Player does not have admin rights!")
    end
    cb('ok')
end)
