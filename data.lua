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
    -- Midnight: Season 2
    [3442] = 282, -- Adventurer Mistcrest
    [3437] = 282, -- Adventurer Mistcrest (hidden)
    [3443] = 295, -- Veteran Mistcrest
    [3438] = 295, -- Veteran Mistcrest (hidden)
    [3444] = 308, -- Champion Mistcrest
    [3439] = 308, -- Champion Mistcrest (hidden)
    [3445] = 321, -- Hero Mistcrest
    [3440] = 321, -- Hero Mistcrest (hidden)
    [3446] = 334, -- Myth Mistcrest
    [3441] = 334, -- Myth Mistcrest (hidden)
}

--- cost_table => [itemLevel] = <cost to maximum upgrade level for currency>
local adventurer = {
    lowest = 265,
    [265] = 5 * 20,
    [269] = 4 * 20,
    [272] = 3 * 20,
    [275] = 2 * 20,
    [278] = 1 * 20,
    [282] = 0 * 20,
}
local veteran = {
    lowest = 278,
    [278] = 5 * 20,
    [282] = 4 * 20,
    [285] = 3 * 20,
    [288] = 2 * 20,
    [291] = 1 * 20,
    [295] = 0 * 20,
}
local champion = {
    lowest = 291,
    [291] = 5 * 20,
    [295] = 4 * 20,
    [298] = 3 * 20,
    [301] = 2 * 20,
    [304] = 1 * 20,
    [308] = 0 * 20,
}
local hero = {
    lowest = 304,
    [304] = 5 * 20,
    [308] = 4 * 20,
    [311] = 3 * 20,
    [314] = 2 * 20,
    [317] = 1 * 20,
    [321] = 0 * 20,
}
local myth = {
    lowest = 317,
    [317] = 5 * 20,
    [321] = 4 * 20,
    [324] = 3 * 20,
    [327] = 2 * 20,
    [330] = 1 * 20,
    [334] = 0 * 20,
}
-- [currencyID] = cost_table
ns.CURRENCIES_UPGRADE_COSTS = {
    [3442] = adventurer,
    [3437] = adventurer,
    [3443] = veteran,
    [3438] = veteran,
    [3444] = champion,
    [3439] = champion,
    [3445] = hero,
    [3440] = hero,
    [3446] = myth,
    [3441] = myth,
}
