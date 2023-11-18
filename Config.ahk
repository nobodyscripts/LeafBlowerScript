#Requires AutoHotkey v2.0

; ------------------- Settings -------------------
; Make sure to reload() (F2) if you change these while running

global EnableLogging := true
; Useful for debugging issues, disable if you don't need it

global HaveBorbDLC := false
; Set this true to fill the first two slots with full teams

global CardsCommonAmount := 25000 ; Amount of Common cards to open per pass
global CardsRareAmount := 25000 ; Amount of Rare cards to open per pass
global CardsLegendaryAmount := 25000 ; Amount of Legendary cards to open per
; pass
global CardsDontOpenCommons := false
global CardsDontOpenRare := false
global CardsDontOpenLegendary := false

global CardsSleepAmount := 860
; Default 860, amount of time to wait between opens, in ms, if lagging
; increase this amount. 860 accounts for the time for clicking as well to be
; over 1s

global CardsBuyEnabled := false ; WARNING: Will allow purchase of cards
; Enables the card purchasing loop on the cards features in F3 and F9
; Ensure the settings are how you want them before enabling as your parts
; will vanish rapidly with no limit. Will buy all cards before opening them,
; set to false if you just want to open cards.

; There is F11 if you just want to quickly buy a tonne of one card type

global CardsBuyStyle := "FocusLegend"
; Possible values:
; "RoundRobin"
; This buys one legendary, then one rare, then one commons then repeats
; "RoundRobin2"
; This buys one common, then one rare, then one legendary then repeats
; "FocusLegend"
; This buys all the legendaries it can first, then rares, then commons.
; "FocusRare"
; This buys all the rares it can first, then commons, then legendaries
; "FocusRare2"
; This buys all the rares it can first, then legendaries, then commons
; "FocusCommon"
; This buys all the commons it can first, then rares, then legendaries

global CardsCommonBuyAmount := 25000 ; Amount to purchase per pass (no limit)
global CardsRareBuyAmount := 25000
global CardsLegBuyAmount := 25000

global CardsDontBuyCommons := false ; Disable the purchase of cards
global CardsDontBuyRare := false
global CardsDontBuyLeg := false

global CardsSleepBuyAmount := 72
; Default 72, amount of time to wait between purchases, can lower down to at
; minimum 17ms or raise if not smoothly purchasing

global CardsPermaLoop := false
; Don't check for the buttons being done, stay in the loop till stopped

global CardsBossFarmEnabled := true
; This disables the card mode on the F9 key rotation

global GFSSFarmUseGrav := true ; Spam Grav while using F8 and boss spawned
global GFSSFarmUseWind := true ; Spam Wind while using F8 and boss spawned
global GFToKillPerCycle := 8 ; How many gf to kill before attempting SS
global SSToKillPerCycle := 1 ; How many ss to kill before resetting

global GemFarmSleepAmount := 101
; Adds 1ms to the timers in gem farm for every 1 added here. 10=10ms slower.
; Increase this if you are skipping gems while you have plenty of suitcases.
; It will skip if you run out of suitcases, so be sure you have some.
; 100-150ms should be very safe for most people, increase/decrease till you
; find your sweet spot

global ClawCheckSizeOffset := 0
; This increases the area that is checked for the claw, if it is not trying to
; pick things up you can increase this value at the potential cost of accuracy.
; Try 5 if needed.

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

global QuarkFarmResetToBoss := 0
; When you die in F9 quark mode, wait 10s to heal then go to this boss
; 0 Disabled (manual travel only)
; 1 Atomic Arbiter
; 2 Cosmic Dragon
; 3 Quantum Artificer
; (You are able to manually swap bosses as required regardless of this setting)

global NavigateTime := 101
; Delay between actions while trying to travel, if experiencing retry loops
; increasing this may help. In ms, default 101

global DisableSettingsChecks := false
; WARNING: This will stop the script checking for badly configured settings, if
; you want to accept the risk, change to true
