#Requires AutoHotkey v2.0

; ------------------- Settings -------------------
; Make sure to reload (F2) if you change these while running

global HaveBorbDLC := false
; Set this true to fill the first two slots with full teams

global CardsCommonAmount := 2500 ; Amount of Common cards to open per pass
global CardsRareAmount := 2500 ; Amount of Rare cards to open per pass
global CardsLegendaryAmount := 2500 ; Amount of Legendary cards to open per pass
global CardsSleepAmount := 970
; Default 970, amount of time to wait between opens, in ms, if lagging 
; increase this amount. 970 accounts for the time for clicking as well to be 
; over 1s
global CardsDontOpenCommons := false
global CardsDontOpenRare := false
global CardsDontOpenLegendary := false

global CardsBossFarmEnabled := true

global GFToKillPerCycle := 8 ; How many gf to kill before attempting SS
global SSToKillPerCycle := 1 ; How many ss to kill before resetting

global GemFarmSleepAmount := 100 
; Adds 1ms to the timers in gem farm for every 1 added here.
; Increase this if you are skipping gems while you have plenty of suitcases.
; It will skip if you run out of suitcases, so be sure you have some.
; 100-150ms should be very safe for most people, increase/decrease till you
; find your sweet spot


global ClawCheckSizeOffset := 0
; This increases the area that is checked for the claw, if it is not trying to
; pick things up you can increase this value at the potential cost of accuracy.
; Try 5-10 if needed.

global BVItemsArr := ["0x01D814", "0xC9C9C9", "0xF91FF6"]
; This is the list of colours to check for in borbventures to farm those items.
; Add/Remove to this array of colours to include the items you want to farm.
; "0xF91FF6" Borb ascention juice (purple default)
; "0x70F928" Borb juice (green)
; "0x0F2A1D" Nature time sphere
; "0x55B409" Borb rune (green)
; "0x018C9C" Magic mulch
; "0x01D814" Nature gem
; "0xAB5A53" Random item box (all types)
; "0x98125F" Borb rune (purple)
; "0xC1C1C1" Candy
; "0x6CD820" Both clovers (uses same colours)
; "0x6BEA15" Borb token
; "0xCEF587" Free borb token
; "0xC9C9C9" Dice Points (white)
; "0x0E44BE" Power Dice Points (blue)
