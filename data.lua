local ADDONNAME, ns = ...

-- [itemID] = maxItemLevel
local ITEM_TOKENS = {
}

-- [currencyID] = maxItemLevel
ns.CURRENCIES_TOKEN = {
    -- Season 4
    [2806] = 489, -- Whelpling's Awakened Crest
    [2807] = 502, -- Drake's Awakened Crest
    [2809] = 515, -- Wyrm's Awakened Crest
    [2812] = 528, -- Aspect's Awakened Crest
    [2805] = 489, -- Whelpling's Awakened Crest (hidden)
    [2808] = 502, -- Drake's Awakened Crest (hidden)
    [2810] = 515, -- Wyrm's Awakened Crest (hidden)
    [2811] = 528, -- Aspect's Awakened Crest (hidden)
}

ns.ITEM_TOKENS = ITEM_TOKENS
ns.CURRENCIES_TOKEN = ns.CURRENCIES_TOKEN
