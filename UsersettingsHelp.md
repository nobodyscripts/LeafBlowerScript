
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
high end nuclear fuel set to quickly kill bosses.

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

HyacinthUseFlower: (Default) 1
Select the flower to be used for farming, use slot id or name, possible values:
1 / hyacinth
2 / pansy
3 / hibiscus
4 / rose
5 / poppy
6 / primula
7 / forget-me-not
8 / tulip
9 / camomile
10 / dandelion
11 / aster
12 / daffodil
13 / cornflower
14 / lily of the valley
15 / dames rocket
16 / marigold

HyacinthUseSpheres: (Default) false
Use spheres between planting of flowers to speed up growth, will use all
available spheres to instantly complete flowers. Suggest only using this on
flowers with longer timers and turning off UseNextAvailableFlower to control.

HyacinthUseNextAvailableFlower: (Default) false
Moves up to the next flower type available, will rotate between all 16 types,
use if you want to exaust all available flowers.

HyacinthBanksEnabled: (Default) true
Enables banks maintainer during hyacinth farm mode.

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

BankDepositTime: (Default) 5  
Amount of time to wait between bank maintainer cycles (in minutes), applies to
Leafton mode as well.

LeaftonCraftEnabled: (Default) true  
Enable autoclicker on the stop button in the crafting window during Leafton
mode.

LeaftonSpamsWind: (Default) true  
Enable spamming of wind for increased damage during Leafton mode.

LeaftonBanksEnabled: (Default) true  
Enable auto deposit to banks during Leafton mode, runs based on Bank settings
and BankDepositTime.

LeaftonRunOnceEnable: (Default) false  
Cycles through the floor of Leafton once, then exits, ideal for refreshing max.

TowerPassiveBanksEnabled: (Default) true  
Runs bank maintainer while using passive tower mode.

TowerPassiveCraftEnabled: (Default) true  
Runs crafting autoclicker while using passive tower mode.

MinerEnableVeins: (Default) true  
Enable auto enhance of vein jobs in Coal Vein tab.

MinerEnableVeinRemoval: (Default) false
Auto removes one of the coal bar veins if you have 6 active, letting one refresh
to get non coal bar veins quicker. Use if you prioritize diamonds/fuel and have
all 6 slots.

MinerEnableMineRemoval: (Default) true {inactive}  
Enable auto removal of mine jobs in Mines tab.

MinerMineRemovalTimer: (Default) 5  
Time period in minutes between mine removal using setting above.

MinerEnableTransmute: (Default) true  
Enable auto transmute of all coal bars in Transmute tab.

MinerTransmuteTimer: (Default) 1  
Time period in minutes between Transmute using setting above.

MinerEnableFreeRefuel: (Default) true  
Enable auto collection of the Drills free fuel.

MinerRefuelTimer: (Default) 1  
Time period in minutes between fuel collection using setting above.

MinerEnableSpammer: (Default) true  
Enable the WW spammer used elsewhere to run in the background.

MinerEnableBanks: (Default) true  
Enable the bank maintainer to run using the timeperiod set in BankDepositTime.

MinerEnableVeinUpgrade: (Default) false  
Enable the automatic purchase of the coal vein level upgrade when available.

MinerVeinsRemoveCommon, MinerVeinsRemoveUncommon, MinerVeinsRemoveRare,
MinerVeinsRemoveEpic, MinerVeinsRemoveMythical, MinerVeinsRemoveLegendary:
(Default) false {inactive}  
Remove vein jobs based on quality

Debug: (Default) false  
Extra debug logging and testing modes, not recommended for users due to large
log usage, could cause file size issues.
