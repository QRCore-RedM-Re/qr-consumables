-- Shared Modules --

local Utils = {}

-- Debug Print --
function Utils.Debug(type, debugTxt)
    if debugTxt == nil then debugTxt = '' end
    if Config.Debug then
        print("QR Debug | "..type.." | "..debugTxt)
    end
end

return Utils