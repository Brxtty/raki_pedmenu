local ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback("frp_pedmenu:access", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer ~= nil then 
        cb(RAKI.Permissions[xPlayer.identifier])
    end
end)

ESX.RegisterServerCallback("frp_pedmenu:select", function(source, cb, model)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer ~= nil then 
        if RAKI.Permissions[xPlayer.identifier] then 
            local ped = GetPlayerPed(xPlayer.source)

            if ped ~= nil then 
                SetPlayerModel(xPlayer.source, model)          

            

                cb(true)
            end
        end
    end
end)