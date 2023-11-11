local ADDONNAME, ns = ...

local WELPING_MAX_LEVEL = 411
local DRAKE_MAX_LEVEL = 424
local WYRM_MAX_LEVEL = 437
local ASPECT_MAX_LEVEL = 447
-- [itemID] = maxItemLevel
local ITEM_TOKENS = {

    [204075] = WELPING_MAX_LEVEL, -- fragment
    [204193] = WELPING_MAX_LEVEL, -- crest

    [204076] = DRAKE_MAX_LEVEL, -- fragment
    [204195] = DRAKE_MAX_LEVEL, -- crest

    [204077] = WYRM_MAX_LEVEL, -- fragment
    [204196] = WYRM_MAX_LEVEL, -- crest
}

    [204078] = ASPECT_MAX_LEVEL, -- fragment
    [204194] = ASPECT_MAX_LEVEL, -- crest
-- [currencyID] = maxItemLevel
ns.CURRENCIES_TOKEN = {
}

ns.ITEM_TOKENS = ITEM_TOKENS
ns.CURRENCIES_TOKEN = ns.CURRENCIES_TOKEN
