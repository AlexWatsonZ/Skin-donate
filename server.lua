
local skins = {
    ['steam:11000013cf91ceb'] = 'a_m_m_fatlatin_01',	-- Alex Watson
	
}; 
---------^^^----Steam-----------------Ped--^^^^----------------------------
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('modelpedspawn')
AddEventHandler('modelpedspawn', function(skin)
    TriggerClientEvent("applyskin", source, skin)
end)

RegisterServerEvent('miladify:turnThePedOff')
AddEventHandler('miladify:turnThePedOff', function(skin)
    local src = source
    TriggerClientEvent("miladify:changeCfixStatus", src)
end)


TriggerEvent('es:addCommand', 'cfix', function(source)
    local steamID = nil
    for k,v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, 5) == "steam" then
            steamID = string.lower(v)
            break
        end
    end
    local skin = nil
    if skins[steamID] ~= nil then
        
            skin = skins[steamID]
            TriggerClientEvent("applyskin", source, skin)
            
    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
    end
end)

TriggerEvent('es:addCommand', 'rchar', function(source)
    TriggerClientEvent("resetchar", source)
end)

RegisterCommand('fstyle', function(source)


    local steamID = nil
    for k,v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, 5) == "steam" then
            steamID = string.lower(v)
            break
        end
    end

    local skin = nil
    if skins[steamID] ~= nil then

        TriggerClientEvent('esx_style:changewalkstyle', source)

    else

        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
    
    end


end)

-- TriggerEvent('es:addCommand', 'am', function(source)
--     local steamID = nil
--     for k,v in ipairs(GetPlayerIdentifiers(source)) do
--         if string.sub(v, 1, 5) == "steam" then
--             steamID = string.lower(v)
--             break
--         end
--     end
--     local skin = nil
--     print('shit1')
--     if skins[steamID] ~= nil then
--         skin = skins[steamID]
--         print('shit2')
--         local xPlayer = ESX.GetPlayerFromId(source)
--             xPlayer. ('bank',1000)
--     end
-- end)