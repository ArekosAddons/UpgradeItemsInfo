---@type string
local ADDONNAME,
---@class ns
ns = ...

local old_ilvls = select(4, GetBuildInfo()) < 120000

-- [itemID] = maxItemLevel
local ITEM_TOKENS = {
}

-- [currencyID] = maxItemLevel
ns.CURRENCIES_TOKEN = {
    -- The War Within: Season 3
    [3284] = old_ilvls and 678 or 131, -- Weathered Ethereal Crest
    [3285] = old_ilvls and 678 or 131, -- Weathered Ethereal Crest (hidden)
    [3286] = old_ilvls and 691 or 144, -- Carved Ethereal Crest
    [3287] = old_ilvls and 691 or 144, -- Carved Ethereal Crest (hidden)
    [3288] = old_ilvls and 704 or 157, -- Runed Ethereal Crest
    [3289] = old_ilvls and 704 or 157, -- Runed Ethereal Crest (hidden)
    [3290] = old_ilvls and 723+7 or 170, -- Gilded Ethereal Crest
    [3291] = old_ilvls and 723+7 or 170, -- Gilded Ethereal Crest (hidden)
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

ns.ITEM_TOKENS = ITEM_TOKENS
ns.CURRENCIES_TOKEN = ns.CURRENCIES_TOKEN
