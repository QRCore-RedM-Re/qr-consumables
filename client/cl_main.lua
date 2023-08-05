local qrc = require('modules.client')
local Utils = require('modules.shared')

local Player = QRCore.Functions.GetPlayerData()
local isUsing = false

-- Use Consumable --
RegisterNetEvent('qr-consumables:client:UseItem', function(item)
    if not qrc.MountCheck() then return end
    if isUsing then return end
    local emoteInfo = Config.Emotes[Config.Consumables[item].emote].Options
    local pX, pY, pZ, rX, rY, rZ = table.unpack(emoteInfo.Placement)
    local Emote = Config.Emotes[Config.Consumables[item].emote]
    local fillType = ''
    local task = ''

    if Config.Consumables[item].type == 'food' then
        task = 'Eating a '..QRCore.Shared.GetItem(item).label
        fillType = 'hunger'
    else
        task = 'Drinking a '..QRCore.Shared.GetItem(item).label
        fillType = 'thirst'
    end

    lib.requestAnimDict(Emote.Dict)
    SetCurrentPedWeapon(cache.ped, GetHashKey("weapon_unarmed"))
    qrc.Attach(emoteInfo.Prop, emoteInfo.Bone, pX, pY, pZ, rX, rY, rZ) -- Attach Prop

    isUsing = true
    TaskPlayAnim(cache.ped, Emote.Dict, Emote.Anim, 5.0, 5.0, (Config.Consumables[item].length * 1000), 1, false, false, false)
    QRCore.Functions.Progressbar('consumable', task, (Config.Consumables[item].length * 1000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    }, {
        -- animDict = Emote.Dict,
        -- anim = Emote.Anim,
    }, {}, {}, function()
        isUsing = false
        local remove = lib.callback.await('qr-consumables:server:RemoveItem', false, item)
        ClearPedTasks(cache.ped)
        qrc.Detach()
        if remove then
            qrc.ApplyEffects(item)
            TriggerServerEvent("QRCore:Server:SetMetaData", fillType, Player.metadata[fillType] + Config.Consumables[item].fill)
        end
    end, function()
        isUsing = false
        ClearPedTasks(cache.ped)
        qrc.Detach()
    end)
end)

RegisterNetEvent('qr-consumables:client:Smoke', function(item)
    if not qrc.MountCheck() then return end
    if isUsing then return end
    local emoteInfo = Config.Emotes[Config.Smokes[item].emote].Options
    local Emote = Config.Emotes[Config.Smokes[item].emote]
    local pX, pY, pZ, rX, rY, rZ = table.unpack(emoteInfo.Placement)

    lib.requestAnimDict(Emote.Dict)
    SetCurrentPedWeapon(cache.ped, GetHashKey("weapon_unarmed"))
    qrc.Attach(emoteInfo.Prop, emoteInfo.Bone, pX, pY, pZ, rX, rY, rZ) -- Attach Prop

    isUsing = true
    TaskPlayAnim(cache.ped, Emote.Dict, Emote.Anim, 5.0, 5.0, (Config.Smokes[item].length * 1000), 1, false, false, false)
    QRCore.Functions.Progressbar('consumable', 'Smoking a '..QRCore.Shared.GetItem(item).label, (Config.Smokes[item].length * 1000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    }, {
        -- animDict = Emote.Dict,
        -- anim = Emote.Anim,
    }, {}, {}, function()
        isUsing = false
        local remove = lib.callback.await('qr-consumables:server:RemoveItem', false, item)
        ClearPedTasks(cache.ped)
        qrc.Detach()
        if remove then qrc.SmokingEffects(item) end
    end, function()
        isUsing = false
        ClearPedTasks(cache.ped)
        qrc.Detach()
    end)
end)

-- Reduce Alcohol Count --
CreateThread(function()
    while true do
        Wait(1000)
        if alcoholCount > 0 then
            Wait(Config.ReduceAlcoholCount * 1000)
            alcoholCount = alcoholCount -1
            if alcoholCount <= 0 then
                if qrc.IsPedDrunk(cache.ped) then
                    qrc.ResetDrunk()
                end
            end
        end
    end
end)

-- Stuck Prop Command --
if Config.StuckPropCommand.enable then
    RegisterCommand(Config.StuckPropCommand.command, function()
        for k, v in pairs(GetGamePool('CObject')) do
            if IsEntityAttachedToEntity(cache.ped, v) then
                SetEntityAsMissionEntity(v, true, true)
                DeleteObject(v)
                DeleteEntity(v)
            end
        end
    end)
end

-- Player Stuff --
AddEventHandler('onResourceStart', function(resource) if resource == GetCurrentResourceName() then Player = QRCore.Functions.GetPlayerData() end end)
AddEventHandler('onResourceStop', function(resource) if resource == GetCurrentResourceName() then Player = {} end end)
RegisterNetEvent('QRCore:Client:OnPlayerLoaded', function() Player = QRCore.Functions.GetPlayerData() end)
RegisterNetEvent('QRCore:Client:OnPlayerUnload', function() Player = {} end)