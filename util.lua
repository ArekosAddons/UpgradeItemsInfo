local ADDONNAME = ...
---@class ns
local ns = select(2, ...)

do -- Event handling
    local frame = CreateFrame("frame")
    local events = setmetatable({}, {
        __index = function(t, k)
            local v = {}
            t[k] = v
            return v
        end
    })

    if C_EventUtils then
        local C_EventUtils = C_EventUtils

        function ns.RegisterEvent(event, callback)
            local callbacks = events[event]

            if next(callbacks) == nil and C_EventUtils.IsEventValid(event) then
                callbacks[callback] = true
                frame:RegisterEvent(event)
            else
                callbacks[callback] = true
            end
        end
    else
        function ns.RegisterEvent(_event, _callback)
            error("Not Implemented")
        end
    end

    local function callCallbacks(self, event, ...)
        local securecallfunction = securecallfunction
        local callbacks = events[event]

        for callback in pairs(callbacks) do
            local clear = securecallfunction(callback, event, ...)

            if clear then
                callbacks[callback] = nil
            end
        end

        if self and next(callbacks) == nil then
            self:UnregisterEvent(event)
        end
    end

    function ns.FireEvent(event, ...)
        callCallbacks(nil, event, ...)
    end

    frame:SetScript("OnEvent", callCallbacks)
end

do -- Print
    local TAG = "[|cFFFFFFFF" .. ADDONNAME .. "|r]"

    function ns.Printf(fmt, ...)
        DEFAULT_CHAT_FRAME:AddMessage(TAG .. string.format(fmt, ...))
    end

    --@debug@
    local debugPrint = true
    --@end-debug@
    --[===[@non-debug@
    local debugPrint = false
    --@end-non-debug@]===]

    if debugPrint then
        function ns.DebugPrint(...)
            print(TAG, ...)
        end
    else
        function ns.DebugPrint() end
    end
end
