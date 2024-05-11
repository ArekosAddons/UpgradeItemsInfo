std = "lua51"

max_code_line_length = 120
max_string_line_length = false
max_comment_line_length = false

max_cyclomatic_complexity = 15

self = false

ignore = {
    "211/ADDONNAME",
    "211/ns",
    -- "212/event",
    -- "212/...",
}

new_globals = {

}

read_globals = {
    -- Addons
    "LibStub",

    -- WoW Enums
    "Enum.ItemRedundancySlot",
    "Enum.TooltipDataType.Item",
    "Enum.TooltipDataType.Currency",

    -- WoW Objects
    "DEFAULT_CHAT_FRAME",
    "LegendaryItemAlertSystem",
    "LootAlertSystem",
    "LootUpgradeAlertSystem",
    "TooltipDataProcessor",

    -- WoW Frames
    "GameTooltip",
    "ItemRefTooltip",
    "ItemUpgradeFrame",

    -- WoW API
    "CreateFrame",
    "IsAddOnLoaded",
    "IsLoggedIn",

    -- WoW C_API
    "C_EventUtils",
    "C_ItemUpgrade",
    "C_Timer.After",

    -- WoW Lua API
    "hooksecurefunc",
    "securecallfunction",
    "wipe",
}
