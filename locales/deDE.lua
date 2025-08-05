local ADDONNAME = ...





local L = LibStub("AceLocale-3.0"):NewLocale(ADDONNAME, "deDE") -- luacheck: ignore 113/LibStub
if not L then return end

L.UPGRADE_TO_D = "|cnWHITE_FONT_COLOR:Erlaubt die Aufwertung auf|r %d"
-- L.SLOT_HIGHMARK_SD = "|cnWHITE_FONT_COLOR:%s|r: %d"

-- Slots
-- L.SLOT_Head = INVTYPE_HEAD
-- L.SLOT_Neck = INVTYPE_NECK
-- L.SLOT_Shoulder = INVTYPE_SHOULDER
-- L.SLOT_Chest = INVTYPE_CHEST
-- L.SLOT_Waist = INVTYPE_WAIST
-- L.SLOT_Legs = INVTYPE_LEGS
-- L.SLOT_Feet = INVTYPE_FEET
-- L.SLOT_Wrist = INVTYPE_WRIST
-- L.SLOT_Hand = INVTYPE_HAND
-- L.SLOT_Finger = INVTYPE_FINGER
-- L.SLOT_Trinket = INVTYPE_TRINKET
-- L.SLOT_Cloak = INVTYPE_CLOAK
L.SLOT_Twohand = "Zweihändige Waffe"
L.SLOT_MainhandWeapon = "Waffenhand Waffe"
L.SLOT_OnehandWeapon = "Erste Einhandwaffen"
L.SLOT_OnehandWeaponSecond = "Zweite Einhandwaffen"
L.SLOT_Offhand = "Nebenhand"
