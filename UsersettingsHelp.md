
# Settings

Make sure to reload() (F2) if you change these while running

EnableLogging: (Default) false  
true/false, Useful for debugging issues, disable if you don't need it

HaveBorbDLC: (Default) false  
Set this true to fill the first two slots with full teams

CardsCommonAmount: (Default) 25000  
CardsRareAmount: (Default) 25000  
CardsLegendaryAmount: (Default) 25000  
Amount of Common/Rare/Leg cards to open per pass

CardsDontOpenCommons: (Default) false  
CardsDontOpenRare: (Default) false  
CardsDontOpenLegendary: (Default) false  
Disable the opening of cards, so false opens

CardsSleepAmount: (Default) 860  
Amount of time to wait between opens, in ms, if lagging increase this amount.
860 accounts for the time for clicking as well to be over 1s

CardsBuyEnabled: (Default) false  
WARNING: Will allow purchase of cards. Enables the card purchasing loop on the
cards features in F3 and F9. Ensure the settings are how you want them before
enabling as your parts will vanish rapidly with no limit. Will buy all cards
before opening them, set to false if you just want to open cards.
(There is F11 if you just want to quickly buy a lot of one card type)

CardsBuyStyle: (Default) "FocusLegend"  
Possible values:  
"RoundRobin"  
This buys one legendary, then one rare, then one commons then repeats  
"RoundRobin2"  
This buys one common, then one rare, then one legendary then repeats  
"FocusLegend"  
This buys all the legendaries it can first, then rares, then commons.  
"FocusRare"  
This buys all the rares it can first, then commons, then legendaries  
"FocusRare2"  
This buys all the rares it can first, then legendaries, then commons  
"FocusCommon"  
This buys all the commons it can first, then rares, then legendaries  

CardsCommonBuyAmount: (Default) 25000  
CardsRareBuyAmount: (Default) 25000  
CardsLegBuyAmount: (Default) 25000  
Amount to purchase per pass (no limit) 1, 10, 25, 100, 250, 1000, 2500, 25000

CardsDontBuyCommons: (Default) false  
CardsDontBuyRare: (Default) false  
CardsDontBuyLeg: (Default) false  
Disable the purchasing of cards, so false buys

CardsSleepBuyAmount: (Default) 72  
Default 72, amount of time to wait between purchases, can lower down to at
minimum 17ms or raise if not smoothly purchasing

CardsPermaLoop: (Default) false  
Don't check for the buttons being done, stay in the loop till stopped

CardsBossFarmEnabled: (Default) true  
This disables the card mode on the F9 key rotation

GFToKillPerCycle: (Default) 8  
F8 How many gf to kill before attempting SS

SSToKillPerCycle: (Default) 1  
F8 How many ss to kill before resetting

GFSSNoReset: (Default) false  
F8 Disables the reset of kill counts, useful for farming milestones. To use
this setting, set GFToKillPerCycle to as many kills as required
to clear SS 50, set SSToKillPerCycle to 50 and set GFSSNoReset to true.

GemFarmSleepAmount: (Default) 101  
Adds 1ms to the timers in gem farm for every 1 added here. 10=10ms slower.
Increase this if you are skipping gems while you have plenty of suitcases.
It will skip if you run out of suitcases, so be sure you have some.
100-150ms should be very safe for most people, increase/decrease till you
find your sweet spot

ClawCheckSizeOffset: (Default) 0  
This increases the area that is checked for the claw, if it is not trying to
pick things up you can increase this value at the potential cost of accuracy.
Try 5 if needed.

BVItemsArr: (Default) 0x01D814, 0xC9C9C9, 0xF91FF6  
This is the list of colours to check for in borbventures to farm those items.
Add/Remove to this array of colours to include the items you want to farm.
(Space character is required between each colour, no "" around text)  
0xF91FF6 Borb ascention juice (purple default)  
0x70F928 Borb juice (green)  
0x0F2A1D Nature time sphere  
0x55B409 Borb rune (green)  
0x018C9C Magic mulch  
0x01D814 Nature gem  
0xAB5A53 Random item box (all types)  
0x98125F Borb rune (purple)  
0xC1C1C1 Candy  
0x6CD820 Both clovers (uses same colours)  
0x6BEA15 Borb token  
0xCEF587 Free borb token  
0xC9C9C9 Dice Points (white)  
0x0E44BE Power Dice Points (blue)  

BVBlockMythLeg: (Default) true  
Prevents the borbventures farm from starting missions of Mythical or Legendary
quality.

QuarkFarmResetToBoss: (Default) 0  
When you die in F9 quark mode, wait 10s to heal then go to this boss  
0 Disabled (manual travel only)  
1 Atomic Arbiter  
2 Cosmic Dragon  
3 Quantum Artificer  
(You are able to manually swap bosses as required regardless of this setting)

NavigateTime: (Default) 101  
Delay between actions while trying to travel, if experiencing retry loops
increasing this may help. In ms, default 101

DisableZoneChecks: (Default) false  
Disables the background checking to ensure we traveled zone and goes back to
using guesswork and timing. Use this if travel is failing a lot and
NavigateTime isn't giving you stable enough travels to zones. Still uses
NavigateTime for timing, blind travel adds 200ms so you may want to
reduce NavigateTime to between 0-100 to avoid slow travel times.

DisableSettingsChecks: (Default) false  
WARNING: This will stop the script checking for badly configured settings, if
you want to accept the risk, change to true. Disables all handling of
incorrect settings. So if things are not configured correctly they will break.

ArtifactSleepAmount: (Default) 74  
Time between artifact usage, can speed up or slow down to avoid wastage

BossFarmUsesWind: (Default) true  
Add Wind spam to the violin spammer, while boss is spawned, useful with
high end nuclear fuel set to quickly kill bosses/quark.

BossFarmUsesWobblyWings: (Default) false  
Use WW on a split timer so that you can control due to slow time to spawn.
Controls WW usage in secondary script, so functions where secondary script is
used.  
Required true for Hyacinth Boss Farming.

WobblyWingsSleepAmount: (Default) 750  
Timer for WW spam, much lower and you might skip bosses entirely, higher if
you don't instantly kill.

HyacinthUseSlot: (Default) All  
Designate which slot or if all slots should be planted and harvested.
All - Use all fields
1-10 - Use only 1 field matching this number, ordered left to right 1-5 then
second row 6-10.

HyacinthFarmBoss: (Default) true  
Use in combination with BossFarmUsesWobblyWings set to true to allow WW boss farming
in the background while farming Hyacinths.

BankEnableLGDeposit: (Default) true  
Enables the auto deposit of RESS in the Leaf Galaxy bank tab.

BankEnableSNDeposit: (Default) true  
Enables the auto deposit of RESS in the Sacred Nebula bank tab.

BankEnableEBDeposit: (Default) true  
Enables the auto deposit of RESS in the Energy Belt bank tab.

BankEnableFFDeposit: (Default) true  
Enables the auto deposit of RESS in the Fire Fields bank tab.

BankEnableSRDeposit: (Default) true  
Enables the auto deposit of RESS in the Soul Realm bank tab.

BankEnableQADeposit: (Default) true  
Enables the auto deposit of RESS in the Quark Ambit bank tab.

BankRunsSpammer: (Default) true  
Enables the boss farmer background script while using bank maintainer.  

BankCycleTime: (Default) true  
Amount of time to wait between bank maintainer cycles (in seconds)

Debug: (Default) false  
Extra debug logging and testing modes, not recommended for users due to large
log usage, could cause file size issues.
