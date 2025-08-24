local ESX = exports['es_extended']:getSharedObject()

RegisterCommand("pedmenu", function()
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        if not IsEntityDead(PlayerPedId()) then
            ESX.TriggerServerCallback("frp_pedmenu:access", function(status)
                if status then
                    OpenPedMenu()
                else
                    CLNotify("error", "Information", "Du hast keinen Zugriff auf das Ped-Menü")
                end
            end)
        else
            CLNotify("error", "Information", "Du kannst das Ped-Menü nicht öffnen, wenn du tot bist")
        end
    else
        CLNotify("error", "Information", "Du kannst das Ped-Menü nicht im Auto öffnen")
    end
end)

function OpenPedMenu()
    local elements = {
        {label = "Ped wählen", value = "selectped"},
        {label = "Ped zurücksetzen", value = "resetped"},
    }

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "pedmenu", {
        title = "Ped Menu",
        align = "top-left",
        elements = elements
    }, function(data, menu)
        if data.current.value == "selectped" then 
            ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "chooseped", {
                title = "Ped Model Eingeben",
            }, function(data2, menu2)
                if data2.value ~= nil and data2.value ~= "" then
                    if IsModelInCdimage(data2.value) then
                        menu2.close()
                        ESX.TriggerServerCallback("frp_pedmenu:select", function()
                            TriggerEvent("esx:restoreLoadout")
                            CLNotify("info", "Information", "Du hast dein Ped geändert")

                            Citizen.Wait(1000)

                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                if skin then  
                                    TriggerEvent('skinchanger:loadSkin', skin, nil)
                                end
                            end)
                        end, data2.value)
                    else
                        CLNotify("error", "Information", "Dieses Ped existiert nicht")
                    end
                else
                    CLNotify("error", "Information", "Du hast kein Pedmodel eingegeben")
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        elseif data.current.value == "resetped" then
            menu.close()
            ESX.TriggerServerCallback("frp_pedmenu:select", function()
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    if skin then  
                        TriggerEvent('skinchanger:loadSkin', skin, nil)
                        Citizen.Wait(250)
                        TriggerEvent("esx:restoreLoadout")
                        CLNotify("info", "Information", "Du hast dein Ped zurückgesetzt")
                    end
                end)
            end, "mp_m_freemode_01")
        end
    end, function(data, menu)
        menu.close()
    end)
end