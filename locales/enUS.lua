local ADDONNAME = ...
local debug = false -- luacheck: ignore 311/debug
--@debug@
debug = true
--@end-debug@

local L = LibStub("AceLocale-3.0"):NewLocale(ADDONNAME, "enUS", true, debug) -- luacheck: ignore 113/LibStub
if not L then return end

L.UPGRADE_TO_D = "|cnWHITE_FONT_COLOR:Can be upgraded up to|r %d"
L.SLOT_HIGHMARK_SD = "|cnWHITE_FONT_COLOR:%s|r: %d"

-- Slots
L.SLOT_Head = _G.INVTYPE_HEAD
L.SLOT_Neck = _G.INVTYPE_NECK
L.SLOT_Shoulder = _G.INVTYPE_SHOULDER
L.SLOT_Chest = _G.INVTYPE_CHEST
L.SLOT_Waist = _G.INVTYPE_WAIST
L.SLOT_Legs = _G.INVTYPE_LEGS
L.SLOT_Feet = _G.INVTYPE_FEET
L.SLOT_Wrist = _G.INVTYPE_WRIST
L.SLOT_Hand = _G.INVTYPE_HAND
L.SLOT_Finger = _G.INVTYPE_FINGER
L.SLOT_Trinket = _G.INVTYPE_TRINKET
L.SLOT_Cloak = _G.INVTYPE_CLOAK
L.SLOT_Twohand = "Two-Hand weapon"
L.SLOT_MainhandWeapon = "Main-handed weapon"
L.SLOT_OnehandWeapon = "First One-handed Weapon"
L.SLOT_OnehandWeaponSecond = "Second One-handed Weapon"
L.SLOT_Offhand = _G.INVTYPE_WEAPONOFFHAND
