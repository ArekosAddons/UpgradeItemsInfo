---@type string
local ADDONNAME,
---@class ns
ns = ...

local math = math
local string = string

local C_AddOns = C_AddOns
local C_ItemUpgrade = C_ItemUpgrade
local C_Timer = C_Timer


---@type LOCALE
local L = LibStub("AceLocale-3.0"):GetLocale(ADDONNAME)

local RedundancySlots = Enum.ItemRedundancySlot

---@type table<Enum.ItemRedundancySlot, number>
local highMarkCache = {}

---@alias CurrencyID number
---@type table<Enum.ItemRedundancySlot, table<CurrencyID, number>>
local currency_cost_for_slot = {} do
    local upgrade_costs = ns.CURRENCIES_UPGRADE_COSTS

    for _, slot in pairs(RedundancySlots) do
        currency_cost_for_slot[slot] = setmetatable({}, {
            __index = function(t, currrencyID)
                local value = 0

                local data = upgrade_costs[currrencyID]
                if data then
                    local level = highMarkCache[slot]
                    local cost = data[level]

                    if cost then
                        value = cost
                    elseif level < data.lowest then
                        value = data[data.lowest]
                    end
                end

                t[currrencyID] = value
                return value
            end
        })
    end
end

local currency_cost_for_currency do
    local minimumCostSlot = 0
    local maximumCostSlot = RedundancySlots.Twohand

    local FingerSlot = RedundancySlots.Finger
    local TrinketSlot = RedundancySlots.Trinket

    ---@type table<CurrencyID, number>
    currency_cost_for_currency = setmetatable({}, {
        __index = function(t, currrencyID)
            local value = 0

            for slot = minimumCostSlot, maximumCostSlot do
                value = value + currency_cost_for_slot[slot][currrencyID]
            end

            value = value + currency_cost_for_slot[FingerSlot][currrencyID]
            value = value + currency_cost_for_slot[TrinketSlot][currrencyID]

            t[currrencyID] = value
            return value
        end,
    })
end

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
        for i = 1, #WeaponSets do
            local data = WeaponSets[i]

            if type(data) ~= "table" then
                local hm = highMarkCache[data]
                if hm > weaponHighMark then
                    weaponHighMark = hm
                end
            else
                local lowest = math.huge
                for j = 1, #data do
                    local slot = data[j]

                    local hm = highMarkCache[slot]
                    if hm < lowest then
                        lowest = hm
                    end
                end
                if lowest ~= math.huge and lowest > weaponHighMark then
                    weaponHighMark = lowest
                end
            end
        end

        for i = 1, #AllWeapons do
            local slot = AllWeapons[i]

            local hm = highMarkCache[slot]
            if hm > 1 and hm < weaponHighMark then
                highMarkCache[slot] = weaponHighMark
            end
        end
    end
end

local function updateHighMarkCache()
    for _, slot  in pairs(RedundancySlots) do
        local high = C_ItemUpgrade.GetHighWatermarkForSlot(slot)
        highMarkCache[slot] = high or 0

        wipe(currency_cost_for_slot[slot])
    end

    wipe(currency_cost_for_currency)

    calculateWeaponSet_HighMark()
end

---@type table<Enum.ItemRedundancySlot, string>
local SlotIDToName = {}
for slot, id in pairs(RedundancySlots) do
    SlotIDToName[id] = rawget(L, "SLOT_" .. slot) or slot
end

-- Enum.ItemRedundancySlot
local minSlotID = 0
local maxSlotID = 16
local currencies_token = ns.CURRENCIES_TOKEN

local linesCache = {}

---@alias TooltipAddline fun(tooltip: GameTooltip, text: string, r: number?, g: number?, b: number?, warp: boolean?)
---@alias TooltipAddDoubleLine fun(tooltip: GameTooltip, left: string, right: string?, lr: number?, lg: number?, lb: number?, rr: number?, rg: number?, rb: number?)

---@param currrencyID CurrencyID
---@return {f: TooltipAddline|TooltipAddDoubleLine, n: number, [number]: string}[]|nil
local function getLines(currrencyID)
    local lines = linesCache[currrencyID]
    if lines then return lines end
    local maxLevel = currencies_token[currrencyID]
    if not maxLevel then return nil end

    local AddLine = GameTooltip.AddLine
    local AddDoubleLine = GameTooltip.AddDoubleLine

    local header
    local full_cost = currency_cost_for_currency[currrencyID]
    if full_cost > 0 then
        header = string.format(L.UPGRADE_TO_WITH_COST_DD, maxLevel, full_cost)
    else
        header = string.format(L.UPGRADE_TO_D, maxLevel)
    end
    lines = {
        {f = AddLine, n = 5, header, nil, nil, nil, true },
    }

    ---@type string?
    local prevText = nil
    for slot = minSlotID, maxSlotID do
        local highMark = highMarkCache[slot]

        -- highMark of 1 happens on unused slots
        if highMark > 1 and highMark < maxLevel then
            local cost = currency_cost_for_slot[slot][currrencyID]
            local name = SlotIDToName[slot]

            local text
            if cost > 0 then
                text = string.format(L.SLOT_HIGHMARK_WITH_COST_SDD, name, highMark, cost)
            else
                text = string.format(L.SLOT_HIGHMARK_SD, name, highMark)
            end

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

    if next(currencies_token) ~= nil then
        TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Currency, function(tooltip, data)
            if not supportedTooltips[tooltip] then return end

            local lines = getLines(data.id)
            if lines then
                for i = 1, #lines do
                    local line = lines[i]

                    line.f(tooltip, unpack(line, 1, line.n))
                end
            end
        end)
    end


    local isUpgradeHooked = false
    local function hook_upgrade()
        if isUpgradeHooked then return end
        isUpgradeHooked = true

        hooksecurefunc(ItemUpgradeFrame, "OnConfirm", function()
            local delay = ItemUpgradeFrame.numUpgradeLevels or 1
            C_Timer.After(delay * 1.5, resetCaches)
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

                        wipe(currency_cost_for_slot[redundancySlotID])
                        wipe(currency_cost_for_currency)
                    else
                        -- HighMark rest to smaller value, need to clear all weapons values
                        updateHighMarkCache()
                    end
                else
                    wipe(currency_cost_for_slot[redundancySlotID])
                    wipe(currency_cost_for_currency)
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
