#Requires AutoHotkey v2.0

global HaveBorbDLC := false
; Set this true to fill the first two slots with full teams

global CardsCommonAmount := 2500 ; Amount of Common cards to open per pass
global CardsRareAmount := 2500 ; Amount of Rare cards to open per pass
global CardsLegendaryAmount := 2500 ; Amount of Legendary cards to open per pass
global CardsSleepAmount := 950
; Default 950, amount of time to wait between opens, in ms, if lagging 
; increase this amount. 950 accounts for the time for clicking as well to be 
; over 1s
global CardsDontOpenCommons := false
global CardsDontOpenRare := false
global CardsDontOpenLegendary := false

global GFToKillPerCycle := 8 ; How many gf to kill before attempting SS
global SSToKillPerCycle := 1 ; How many ss to kill before resetting


; This is the list of colours to check for in borbventures to farm those items.
; Add/Remove to this array of colours to include the items you want to farm.

global BVItemsArr := ["0x01D814", "0xC9C9C9", "0xF91FF6"]
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
