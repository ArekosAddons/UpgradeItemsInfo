---@type string
local ADDONNAME,
---@class ns
ns = ...


-- [currencyID] = maxItemLevel
ns.CURRENCIES_TOKEN = {
    -- Midnight: Season 1
    [3383] = 237, -- Adventurer Dawncrest
    [3391] = 237, -- Adventurer Dawncrest (hidden)
    [3341] = 250, -- Veteran Dawncrest
    [3342] = 250, -- Veteran Dawncrest (hidden)
    [3343] = 263, -- Champion Dawncrest
    [3344] = 263, -- Champion Dawncrest (hidden)
    [3345] = 276, -- Hero Dawncrest
    [3346] = 276, -- Hero Dawncrest (hidden)
    [3347] = 289, -- Myth Dawncrest
    [3348] = 289, -- Myth Dawncrest (hidden)
}

--- cost_table => [itemLevel] = <cost to maximum upgrade level for currency>
local adventurer = {
    lowest = 220,
    [220] = 5 * 20,
    [224] = 4 * 20,
    [227] = 3 * 20,
    [230] = 2 * 20,
    [233] = 1 * 20,
    [237] = 0 * 20,
}
local veteran = {
    lowest = 233,
    [233] = 5 * 20,
    [237] = 4 * 20,
    [240] = 3 * 20,
    [243] = 2 * 20,
    [246] = 1 * 20,
    [250] = 0 * 20,
}
local champion = {
    lowest = 246,
    [246] = 5 * 20,
    [250] = 4 * 20,
    [253] = 3 * 20,
    [256] = 2 * 20,
    [259] = 1 * 20,
    [263] = 0 * 20,
}
local hero = {
    lowest = 259,
    [259] = 5 * 20,
    [263] = 4 * 20,
    [266] = 3 * 20,
    [269] = 2 * 20,
    [272] = 1 * 20,
    [276] = 0 * 20,
}
local myth = {
    lowest = 272,
    [272] = 5 * 20,
    [276] = 4 * 20,
    [279] = 3 * 20,
    [282] = 2 * 20,
    [285] = 1 * 20,
    [289] = 0 * 20,
}
-- [currencyID] = cost_table
ns.CURRENCIES_UPGRADE_COSTS = {
    [3383] = adventurer,
    [3391] = adventurer,
    [3341] = veteran,
    [3342] = veteran,
    [3343] = champion,
    [3344] = champion,
    [3345] = hero,
    [3346] = hero,
    [3347] = myth,
    [3348] = myth,
}
