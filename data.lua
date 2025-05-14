local ADDONNAME = ...
---@class ns
local ns = select(2, ...)

-- [itemID] = maxItemLevel
local ITEM_TOKENS = {
}

-- [currencyID] = maxItemLevel
ns.CURRENCIES_TOKEN = {
    -- The War Within: Season 1
    [2914] = 593, -- Weathered Harbinger Crest
    [2915] = 606, -- Carved Harbinger Crest
    [2916] = 619, -- Runed Harbinger Crest
    [2917] = 639, -- Gilded Harbinger Crest
    [2918] = 593, -- Weathered Harbinger Crest (hidden)
    [2919] = 606, -- Carved Harbinger Crest (hidden)
    [2920] = 619, -- Runed Harbinger Crest (hidden)
    [2921] = 639, -- Gilded Harbinger Crest (hidden)
    -- The War Within: Season 2
    [3107] = 632, -- Weathered Undermine Crest
    [3108] = 645, -- Carved Undermine Crest
    [3109] = 658, -- Runed Undermine Crest
    [3110] = 678+6, -- Gilded Undermine Crest
    [3111] = 632, -- Weathered Undermine Crest (hidden)
    [3112] = 645, -- Carved Undermine Crest (hidden)
    [3113] = 658, -- Runed Undermine Crest (hidden)
    [3114] = 678+6, -- Gilded Undermine Crest (hidden)
}

ns.ITEM_TOKENS = ITEM_TOKENS
ns.CURRENCIES_TOKEN = ns.CURRENCIES_TOKEN
