-- Remove Item --
lib.callback.register('qr-consumables:server:RemoveItem', function(source, item)
    local src = source
    local Player = QRCore.Functions.GetPlayer(src)
    local callback = false
    if not Player then return callback end
    if Player.Functions.GetItemByName(item) ~= nil then
        if Player.Functions.RemoveItem(item, 1) then
            TriggerClientEvent("inventory:client:ItemBox", src, QRCore.Shared.GetItem(item), "remove")
            callback = true
        end
    end
    return callback
end)

-- Useable Items --
for q, r in pairs(Config.Consumables) do
    QRCore.Functions.CreateUseableItem(q, function(source, item)
        local src = source
        local Player = QRCore.Functions.GetPlayer(src)
        if not Player then return end
        if Player.Functions.GetItemByName(item.name) ~= nil then
            TriggerClientEvent('qr-consumables:client:UseItem', src, item.name)
        end
    end)
end

for q, r in pairs(Config.Smokes) do
    QRCore.Functions.CreateUseableItem(q, function(source, item)
        local src = source
        local Player = QRCore.Functions.GetPlayer(src)
        if not Player then return end
        if Player.Functions.GetItemByName(item.name) ~= nil then
            TriggerClientEvent('qr-consumables:client:Smoke', src, item.name)
        end
    end)
end