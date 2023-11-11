local ADDONNAME, ns = ...

-- [itemID] = maxItemLevel
local ITEM_TOKENS = {
    -- -- 10.1, are now grey items
    -- [204075] = 411, -- Welping fragment
    -- [204193] = 411, -- Welping crest

    -- [204076] = 424, -- Drake fragment
    -- [204195] = 424, -- Drake crest

    -- [204077] = 437, -- Wyrm fragment
    -- [204196] = 437, -- Wyrm crest

    -- [204078] = 447, -- Aspect fragment
    -- [204194] = 447, -- Aspect crest
}

-- [currencyID] = maxItemLevel
ns.CURRENCIES_TOKEN = {
    [2706] = 450, --  Whelpling's Dreaming Crest
    [2707] = 463, --  Drake's Dreaming Crest
    [2708] = 476, --  Wyrm's Dreaming Crest
    [2709] = 489, --  Aspect's Dreaming Crest
    [2715] = 450, --  Whelpling's Dreaming Crest (No Cap)
    [2716] = 463, --  Drake's Dreaming Crest (No Cap)
    [2717] = 476, --  Wyrm's Dreaming Crest (No Cap)
    [2718] = 489, --  Aspect's Dreaming Crest (No Cap)
}

ns.ITEM_TOKENS = ITEM_TOKENS
ns.CURRENCIES_TOKEN = ns.CURRENCIES_TOKEN