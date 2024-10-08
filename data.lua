local ADDONNAME, ns = ...

-- [itemID] = maxItemLevel
local ITEM_TOKENS = {
}

-- [currencyID] = maxItemLevel
ns.CURRENCIES_TOKEN = {
    -- Dragonflight: Season 4
    [2806] = 489, -- Whelpling's Awakened Crest
    [2807] = 502, -- Drake's Awakened Crest
    [2809] = 515, -- Wyrm's Awakened Crest
    [2812] = 528, -- Aspect's Awakened Crest
    [2805] = 489, -- Whelpling's Awakened Crest (hidden)
    [2808] = 502, -- Drake's Awakened Crest (hidden)
    [2810] = 515, -- Wyrm's Awakened Crest (hidden)
    [2811] = 528, -- Aspect's Awakened Crest (hidden)
    -- War Within: Season 1
    [2914] = 593, -- Weathered Harbinger Crest
    [2915] = 606, -- Carved Harbinger Crest
    [2916] = 619, -- Runed Harbinger Crest
    [2917] = 639, -- Gilded Harbinger Crest
    [2918] = 593, -- Weathered Harbinger Crest (hidden)
    [2919] = 606, -- Carved Harbinger Crest (hidden)
    [2920] = 619, -- Runed Harbinger Crest (hidden)
    [2921] = 639, -- Gilded Harbinger Crest (hidden)
}

ns.ITEM_TOKENS = ITEM_TOKENS
ns.CURRENCIES_TOKEN = ns.CURRENCIES_TOKEN
