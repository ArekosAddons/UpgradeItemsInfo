local ADDONNAME, ns = ...

local L = LibStub("AceLocale-3.0"):GetLocale(ADDONNAME)

local RedundancySlots = Enum.ItemRedundancySlot

local highMarkCache = {}
local IsCalculatedWeapon, calculateWeaponSet_HighMark do
    local Twohand = RedundancySlots.Twohand
    local Onehand = RedundancySlots.OnehandWeapon
    local Onehand2nd = RedundancySlots.OnehandWeaponSecond
    local Mainhand = RedundancySlots.MainhandWeapon
    local Offhand = RedundancySlots.Offhand

    IsCalculatedWeapon = {
        [Twohand] = true,
        [Onehand] = true,
        [Onehand2nd] = true,
        [Mainhand] = true,
        [Offhand] = true,
    }

    local WeaponSets = {
        Twohand,
        {Onehand, Onehand2nd},
        {Mainhand, Offhand},
    }
    local AllWeapons = {
        Twohand,
        Onehand, Onehand2nd,
        Mainhand, Offhand,
    }

    function calculateWeaponSet_HighMark()
        local weaponHighMark = 0
        for _, data in ipairs(WeaponSets) do
            if type(data) ~= "table" then
                local hm = highMarkCache[data]
                if hm > weaponHighMark then
                    weaponHighMark = hm
                end
            else
                local lowest = math.huge -- lowest
                for _, slotID in ipairs(data) do
                    local hm = highMarkCache[slotID]
                    if hm < lowest then
                        lowest = hm
                    end
                end
                if lowest ~= math.huge and lowest > weaponHighMark then
                    weaponHighMark = lowest
                end
            end
        end

        for _, slotID in ipairs(AllWeapons) do
            local hm = highMarkCache[slotID]
            if hm > 1 and hm < weaponHighMark then
                highMarkCache[slotID] = weaponHighMark
            end
        end
    end
end

local function updateHighMarkCache()
    -- characterHighWatermark, accountHighWatermark = C_ItemUpgrade.GetHighWatermarkForSlot(itemRedundancySlot)
    for _, id  in pairs(RedundancySlots) do
        local high = C_ItemUpgrade.GetHighWatermarkForSlot(id)
        highMarkCache[id] = high
    end

    calculateWeaponSet_HighMark()
end

local SlotIDToName = {}
for slot, id in pairs(RedundancySlots) do
    SlotIDToName[id] = rawget(L, "SLOT_" .. slot) or slot
end

-- Enum.ItemRedundancySlot
local minSlotID = 0
local maxSlotID = 16

local linesCache = {}
local function getLines(maxLevel)
    local lines = linesCache[maxLevel]
    if lines then return lines end
    local AddLine = GameTooltip.AddLine
    local AddDoubleLine = GameTooltip.AddDoubleLine

    lines = {
        {f = AddLine, n = 1, string.format(L.UPGRADE_TO_D, maxLevel)},
    }

    local prevText = nil
    for id = minSlotID, maxSlotID do
        local highMark = highMarkCache[id]
        -- highMark of 1 happens on unused slots
        if highMark > 1 and highMark < maxLevel then
            local name = SlotIDToName[id]
            local text = string.format(L.SLOT_HIGHMARK_SD, name, highMark)
            if prevText then
                lines[#lines + 1] = {f = AddDoubleLine, n = 2, prevText, text}
                prevText = nil
            else
                prevText = text
            end
        end
    end
    if prevText then
        lines[#lines + 1] = {f = AddLine, n = 1, prevText}
    end

    linesCache[maxLevel] = lines
    return lines
end


local function resetCaches()
    updateHighMarkCache()
    wipe(linesCache)
end

local supportedTooltips = {
    [GameTooltip] = true,
    [ItemRefTooltip] = true,
}
local function onLogin()
    updateHighMarkCache()

    local tokens = ns.TOKENS
    local ipairs, unpack = ipairs, unpack -- local upvalues for faster lookup
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
        if not supportedTooltips[tooltip] then return end
        local maxLevel = tokens[data.id]
        if not maxLevel then return end

        local lines = getLines(maxLevel)

        for _, line in ipairs(lines) do
            line.f(tooltip, unpack(line, 1, line.n))
        end
    end)


    local function onHide()
        resetCaches()
    end
    if IsAddOnLoaded("Blizzard_ItemUpgradeUI") then
        ItemUpgradeFrame:HookScript("OnHide", onHide)
    else
        ns.RegisterEvent("ADDON_LOADED", function(_, addonName)
            if addonName == "Blizzard_ItemUpgradeUI" then
                ItemUpgradeFrame:HookScript("OnHide", onHide)
                return true
            end
        end)
    end

    return true
end

if IsLoggedIn() then
    onLogin()
else
    ns.RegisterEvent("PLAYER_LOGIN", function()
        C_Timer.After(0.21, onLogin)
        return true
    end)
end
