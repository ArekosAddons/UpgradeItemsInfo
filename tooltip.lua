---@type string
local ADDONNAME,
---@class ns
ns = ...

local math = math
local string = string

local C_AddOns = C_AddOns
local C_ItemUpgrade = C_ItemUpgrade
local C_Timer = C_Timer


local L = LibStub("AceLocale-3.0"):GetLocale(ADDONNAME)

local RedundancySlots = Enum.ItemRedundancySlot

local highMarkCache = {}
local IsCalculatedWeaponSlot, calculateWeaponSet_HighMark do
    local Twohand = RedundancySlots.Twohand
    local Onehand = RedundancySlots.OnehandWeapon
    local Onehand2nd = RedundancySlots.OnehandWeaponSecond
    local Mainhand = RedundancySlots.MainhandWeapon
    local Offhand = RedundancySlots.Offhand

    IsCalculatedWeaponSlot = {
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
    for _, id  in pairs(RedundancySlots) do
        local high = C_ItemUpgrade.GetHighWatermarkForSlot(id)
        highMarkCache[id] = high or 0
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

    local unpack = unpack -- local upvalues for faster lookup
    local function add_info(tooltip, maxLevel)
        local lines = getLines(maxLevel)

        for i = 1, #lines do
            local line = lines[i]
            line.f(tooltip, unpack(line, 1, line.n))
        end
    end

    local item_tokens = ns.ITEM_TOKENS
    if next(item_tokens) ~= nil then
        TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
            if not supportedTooltips[tooltip] then return end
            local maxLevel = item_tokens[data.id]
            if not maxLevel then return end

            add_info(tooltip, maxLevel)
        end)
    end

    local currencies_token = ns.CURRENCIES_TOKEN
    if next(currencies_token) ~= nil then
        TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Currency, function(tooltip, data)
            if not supportedTooltips[tooltip] then return end
            local maxLevel = currencies_token[data.id]
            if not maxLevel then return end

            add_info(tooltip, maxLevel)
        end)
    end


    local isUpgradeHooked = false
    local function hook_upgrade()
        if isUpgradeHooked then return end
        isUpgradeHooked = true

        hooksecurefunc(ItemUpgradeFrame, "OnConfirm", function()
            local delay = ItemUpgradeFrame.numUpgradeLevels or 1
            C_Timer.After(delay, resetCaches)
        end)
    end
    if C_AddOns.IsAddOnLoaded("Blizzard_ItemUpgradeUI") then
        hook_upgrade()
    else
        ns.RegisterEvent("ADDON_LOADED", function(_, addonName)
            if addonName == "Blizzard_ItemUpgradeUI" then
                hook_upgrade()
                return true
            end
        end)
    end

    local function onLoot(itemLink)
        if not itemLink then return end

        local redundancySlotID = C_ItemUpgrade.GetHighWatermarkSlotForItem(itemLink)
        if redundancySlotID >= 0 then -- invalid items are -1
            -- local highMark = C_ItemUpgrade.GetHighWatermarkForItem(itemLink)
            local highMark = C_ItemUpgrade.GetHighWatermarkForSlot(redundancySlotID)

            local currentHighMark = highMarkCache[redundancySlotID]
            if currentHighMark ~= highMark then
                highMarkCache[redundancySlotID] = highMark
                wipe(linesCache)

                if IsCalculatedWeaponSlot[redundancySlotID] then
                    if highMark > currentHighMark then
                        calculateWeaponSet_HighMark()
                    else
                        -- HighMark rest to smaller value, need to clear all weapons values
                        updateHighMarkCache()
                    end
                end
            end
        end
    end

    local function LootWonAlertFrame_SetUp_Hook(self, itemLink, _, _, _, _, isCurrency)
        if isCurrency then return end

        onLoot(self.hyperlink or itemLink)
    end

    hooksecurefunc("LootWonAlertFrame_SetUp", LootWonAlertFrame_SetUp_Hook)
    hooksecurefunc(LootAlertSystem, "setUpFunction", LootWonAlertFrame_SetUp_Hook)


    local function Simple_SetUp_Hook(self, itemLink)
        onLoot(self.hyperlink or itemLink)
    end

    hooksecurefunc("LootUpgradeFrame_SetUp", Simple_SetUp_Hook)
    hooksecurefunc(LootUpgradeAlertSystem, "setUpFunction", Simple_SetUp_Hook)

    hooksecurefunc("LegendaryItemAlertFrame_SetUp", Simple_SetUp_Hook)
    hooksecurefunc(LegendaryItemAlertSystem, "setUpFunction", Simple_SetUp_Hook)

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
