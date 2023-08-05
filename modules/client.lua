local Utils = require('modules.shared')
local drunkAF = false
local drunkCam = 0
local Prop = nil
alcoholCount = 0

local qrc = {}

-- Consumable Effects --
function qrc.ApplyEffects(ITEM)
    if Config.Consumables[ITEM].effects.heal ~= 0 then
        local AddHealth = Config.Consumables[ITEM].effects.heal
        SetEntityHealth(cache.ped, GetEntityHealth(cache.ped) + AddHealth)
    end

    if Config.Consumables[ITEM].effects.stress ~= 0 then
        local ReduceStress = Config.Consumables[ITEM].effects.stress
        TriggerServerEvent('hud:server:RelieveStress', ReduceStress)
    end

    if Config.Consumables[ITEM].effects.armor ~= 0 then
        local AddArmor = Config.Consumables[ITEM].effects.armor
        AddArmourToPed(cache.ped, AddArmor)
    end

    if Config.Consumables[ITEM].type == 'alcohol' then
        alcoholCount = alcoholCount + 1
        if alcoholCount >= Config.Drunk.min and alcoholCount < Config.Drunk.max then
            qrc.Drunk(1)
        elseif alcoholCount >= Config.Drunk.max then
            qrc.Drunk(2)
        end
    end
end

function qrc.SmokingEffects(ITEM)
    if Config.Smokes[ITEM].effects.heal ~= 0 then
        local AddHealth = Config.Smokes[ITEM].effects.heal
        SetEntityHealth(cache.ped, GetEntityHealth(cache.ped) + AddHealth)
    end

    if Config.Smokes[ITEM].effects.stress ~= 0 then
        local ReduceStress = Config.Smokes[ITEM].effects.stress
        TriggerServerEvent('hud:server:RelieveStress', ReduceStress)
    end

    if Config.Smokes[ITEM].effects.armor ~= 0 then
        local AddArmor = Config.Smokes[ITEM].effects.armor
        AddArmourToPed(cache.ped, AddArmor)
    end
end

-- Detach Animation Prop --
function qrc.Detach()
    Wait(100)
    DetachEntity(Prop, true, true)
    DeleteObject(Prop)
end

-- Attach Animation Prop --
function qrc.Attach(model, bone, pX, pY, pZ, rX, rY, rZ)
    lib.requestModel(GetHashKey(model))
    Prop = CreateObject(model, GetEntityCoords(cache.ped), true, false, false)
    AttachEntityToEntity(Prop, cache.ped, GetEntityBoneIndexByName(cache.ped, bone), pX, pY, pZ, rX, rY, rZ, false, true, true, true, 0, true)
end

-- Check if Player has the Reigns of Wagon or Horse --
function qrc.MountCheck()
    local callback = true
    if cache.mount then
        local Horse = Citizen.InvokeNative(0xE7E11B8DCBED1058, cache.ped) -- Get Mount
        local Rider = Citizen.InvokeNative(0xB676EFDA03DADA52, Horse, true) -- Get Rider of Mount
        if Rider == cache.ped then QRCore.Functions.Notify('You can\'t do that while you have the reigns!', 'error') callback = false end
    elseif cache.vehicle then
        local Vehicle = Citizen.InvokeNative(0x9A9112A0FE9A4713, cache.ped) -- Get Vehicle
        local Driver = Citizen.InvokeNative(0x2963B5C1637E8A27, Vehicle) -- Get Driver
        if Driver == cache.ped then QRCore.Functions.Notify('You can\'t do that while you have the reigns!', 'error') callback = false end
    end
    return callback
end

function qrc.IsPedDrunk(PED)
    return Citizen.InvokeNative(0x50F124E6EF188B22, PED)
end

function qrc.SetPedIsDrunk(PED, BOOL)
    return Citizen.InvokeNative(0x95D2D383D5396B8A, PED, BOOL)
end

function qrc.SetPedDrunkness(PED, BOOL, AMOUNT)
    return Citizen.InvokeNative(0x406CCF555B04FAD3, PED, BOOL, AMOUNT)
end

-- Drunk Camera Effects --
function qrc.DrunkCam(VISUALSTRENGTH, SHAKESTRENGTH, CAM)
    ShakeGameplayCam("DRUNK_SHAKE", SHAKESTRENGTH)
    Citizen.InvokeNative(0xFA08722A5EA82DA7, "PlayerDrunk01")
    Citizen.InvokeNative(0xFDB74C9CC54C3F37, VISUALSTRENGTH)
    drunkCam = CAM
end

-- Reset Drunk Effects --
function qrc.ResetDrunk()
    qrc.DrunkCam(0.0, 0.0)
    qrc.SetPedIsDrunk(cache.ped, false)
    qrc.SetPedDrunkness(cache.ped, false, 0.0)
    ClearTimecycleModifier()
    drunkCam = 0
    if drunkAF then drunkAF = false end
end

-- Drunk Effects --
function qrc.Drunk(TYPE)
    if not qrc.IsPedDrunk(cache.ped) then qrc.SetPedIsDrunk(cache.ped, true) end
    if TYPE == 1 and not drunkAF then
        qrc.SetPedDrunkness(cache.ped, true, 0.5)
        if drunkCam ~= 1 then qrc.DrunkCam(1.5, 0.7, 1) end
    elseif TYPE == 2 and not drunkAF then
        drunkAF = true
        qrc.SetPedDrunkness(cache.ped, true, 1.0)
        if drunkCam ~= 2 then qrc.DrunkCam(2.5, 1.3, 2) end
    end
end

return qrc