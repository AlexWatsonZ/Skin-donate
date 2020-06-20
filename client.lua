local ESX = nil
local pedChanged = false
local frist = true

-- ESX
Citizen.CreateThread(function()

    while ESX == nil do
        TriggerEvent("esx:getSharedObject",function(obj)
                ESX = obj
            end)
            
        Citizen.Wait(0)
        PlayerData = ESX.GetPlayerData()

        if first then
            ESX.SetPlayerData('cfix',0)
            first = false
        end
        
    end
    
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded",function(xPlayer)

    PlayerData = xPlayer
    
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob",function(job)

    PlayerData.job = job
    
end)

RegisterNetEvent("miladify:changeCfixStatus")
AddEventHandler("miladify:changeCfixStatus",function()

    TriggerEvent("resetchar", source)
    ESX.SetPlayerData('cfix',0)
    pedChanged = false
    
end)

RegisterNetEvent('applyskin')
AddEventHandler('applyskin', function(skin)
    local ped = GetPlayerPed(-1)
	local maxhealth = GetEntityMaxHealth(ped)
    local health = GetEntityHealth(ped)

    if health == maxhealth then

        if pedChanged == false then

            if ESX.GetPlayerData()['jailed'] ~= 1 then

                    if ESX.GetPlayerData()['aduty'] ~= 1 then

                    Citizen.CreateThread(function()
                        local model = GetHashKey(skin)
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                            RequestModel(model)
                            Citizen.Wait(0)
                        end
                        SetPlayerModel(PlayerId(), model)
                        SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 2)
                    end)

                    ESX.SetPlayerData('cfix',1)
                    pedChanged = true

            else

                TriggerEvent('chat:addMessage', {
                    color = { 255, 0, 0},
                    multiline = true,
                    args = {"[SYSTEM]", "Shoma dar halat ^2OnDuty ^0nemitavanid az cfix estefade konid!"}
                  })

            end

            else
            
                TriggerEvent('chat:addMessage', {
                    color = { 255, 0, 0},
                    multiline = true,
                    args = {"[SYSTEM]", "Shoma nemitavanid hengami ke jail shodid az cfix estefade konid!"}
                  })
    

            end

        else

            TriggerEvent('chat:addMessage', {
                color = { 255, 0, 0},
                multiline = true,
                args = {"[SYSTEM]", "Shoma nemitavanid hengami ke dar halat PEDe donati khod hastid dobare be hamon PED tabdil shid!"}
              })

        end

    else
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[SYSTEM]", "Shoma nemitavanid hengami ke hp shoma por nist PED khod ra avaz konid!"}
          })
    end

end)

function dump(o)
	if type(o) == 'table' then
	   local s = '{ '
	   for k,v in pairs(o) do
		  if type(k) ~= 'number' then k = '"'..k..'"' end
		  s = s .. '['..k..'] = ' .. dump(v) .. ','
	   end
	   return s .. '} '
	else
	   return tostring(o)
	end
 end

RegisterNetEvent('resetchar')
AddEventHandler('resetchar', function(source)
    local ped = GetPlayerPed(-1)
	local maxhealth = GetEntityMaxHealth(ped)
    local health = GetEntityHealth(ped)
    

    if health == maxhealth then

            if pedChanged then

                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                        local isMale = skin.sex == 0

                        TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                            end)
                        end)

                    end)

                    ESX.SetPlayerData('cfix',0)
                    pedChanged = false
            else

                TriggerEvent('chat:addMessage', {
                    color = { 255, 0, 0},
                    multiline = true,
                    args = {"[SYSTEM]", "Shoma dar halat PEDe donati khod nistid!"}
                  })

            end

        else

            TriggerEvent('chat:addMessage', {
                color = { 255, 0, 0},
                multiline = true,
                args = {"[SYSTEM]", "Shoma nemitavanid hengami ke hp shoma por nist PED khod ra avaz konid!"}
              })

    end

end)

RegisterNetEvent('miladify:resetcharForce')
AddEventHandler('miladify:resetcharForce', function(ChangeClothes)


        if ChangeClothes then
        
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                local isMale = skin.sex == 0

                TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                end)

            end)
            ESX.SetPlayerData('cfix',0)
            pedChanged = false

        else

            ESX.SetPlayerData('cfix',0)
            pedChanged = false

        end     

end)

RegisterNetEvent('changestatus')
AddEventHandler('changestatus', function(source, status)



end)

RegisterNetEvent('esx_style:changewalkstyle')
AddEventHandler('esx_style:changewalkstyle', function(source, lib, anim)

        startAttitude("move_f@heels@c", "move_f@heels@c")

end)

function startAttitude(lib, anim)
	ESX.Streaming.RequestAnimSet(lib, function()
		SetPedMovementClipset(PlayerPedId(), anim, true)
	end)
end