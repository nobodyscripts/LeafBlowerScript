# LBR Resolution independent scripts v3.1.2-Alpha

Support and news: <https://discord.gg/xu8fXw4CQ8>

Autohotkey V2 script, see Setup Guide below for installation help.

Same key toggles the feature off, if this toggle fails, F1 or F2 to abort.

F1: Closes the script entirely

F2: Reloads the script, deactivating anything that is active but keeping it
loaded

F3: Open/Buy card packs - Opens/buys card screen for you. Customize the amount
to open/buy in the UserSettings.ini file, 25000 default. May leave the
ctrl/alt/shift keys pressed when canceling, just press them to update their
state if you notice anything weird. Doesn't handle the button modifiers, set as
you want before running.

F4: Gem suitcase farming - Will do prep for you and reset afterwards, keep an
eye on it for a minute incase it has missed anything and is running smoothly.
Removes Bearo from pet team if active, sets default loadout when exited with F4.
No check in place for remaining golden suitcases, if its skipping a bunch of
gems you are out, and can either wait for regen or let it continue to run
slower.

F5: 72h tower boost loop - Uses (doesn't buy) boosts, swaps areas to raise max
floor. Does equip a tower gear equipment loadout, sets back to default loadout
after exiting with F5.

F6: Borbventure farming - Defaults to farming purple juice, nature gems and
white dices (configure in UserSettings.ini). Set if you own the borb dlc
otherwise it will ignore the first two slots being unfilled. Doesn't scroll so
there may be some pauses. Scrolling will interupt, requires to be at the top of
the panel. Auto finish can be left on for faster runs, auto start is toggled off
though you will need to wait a cycle for new items, or clear active before
running the script.

F7: Claw machine pumpkin farmer - Tries to identify the pumpkin and use the
hook to grab it, will miss some due to other items and sometimes doesn't grab
things on the first pass. Downgrades to picking gems if no pumpkin found. Auto
start required on.

F8: Green Flame/SoulSeeker farmer - Set how many of each to kill in the
UserSettings.ini, will cycle and use violins to farm that amount as well as
resetting SoulSeeker. Will attempt to reset GF if needed and handle deaths.  
Milestone farm mode (see settings) lets you stop automatic resetting.

F9: Normal boss farmer - Doesn't select a zone, sit in the area you want to farm
and it'll spam violins when the timers up. If kill numbers look off see settings
below. Settings for Wind/Grav/WW and timers available apply to all modes of F9,
attempts to use artifacts smartly, depending which boss zone you are currently
in (updates with WW use). Uses a second script to bypass limitations, so you
will see 2 icons in tray.

F9x2 (twice): Boss farmer + brew spammer - Opens the first tab of brewing and
spams Artifacts, Equipment, Materials and Card parts (no scrolls).  

F9x3 (three times): Boss farm + borbventures

F9x4 (four times): Boss farm + card opening - Will continue when done opening
cards, can disable this in the UserSettings.ini if concerned about using cards
unintentionally

F9x5 (five times): Toggles off (though you can just F2 early if you prefer)

F10: Nature boss farmer - Swaps out to Shadow Cavern to use violins, uses the
timer in the area screen to check if the timers done, so don't close the panels
while it is running.

F11: A 16.7ms autoclicker - Works outside the game too so be careful

F12: Performs settings tests for render type, menu transparency, font size and
font type. Then resizes the window to 1278x664 client area (on windows 11, may
need tweaking if not) This is intended to be optional, but you can use this if
things break for you. And to test if settings are working. Does not currently
test for alb settings, may break if window title bar/borders are different.

Insert: Mine maintainer - Automatic enhance, vein removal (to quickly refresh),
Transmute max coal bars to coal diamonds on timer, free drill fuel collection on
a timer. Bank and WW spammer supported.

Home: Hyacinth farming - Spam grows hyacinths to farm nature gems/exp. Can farm
bosses with WW in the background.

End: Passive Tower Farm - Spams wind and blazing skulls as fast as possible,
resets player to tower if found in home garden. Options for bank and crafting.

PageUp: Bank Maintainer - Every (10m by default) will refill RESS in bank.

PageDown: Leafton mode, auto taxi that waits for energy to refill, while active
will also do crafting, bank, wind for damage. Runonce mode for sweeping floors
to improve max for milestones (suggest bank and crafting off when using).

## Notes

Sleep times might need adjusting for your pc, so increase them as needed if
things are skipping. Increments of 17 should add another frame (at 60fps).
Ingame Keybinds section in Hotkeys.ahk can be adjusted either to what you use,
or change them ingame to match.

My window size (1440p snapped to corner) 1278x664 client size is what the
locations are based on, those are adapted to your window size, so set your
window 'client' to this size for changes or if things don't work. For high
accuracy situations I maximise the window to capture 2560x1369.

All functions have protections to save you in cases of alt tabbing or pop up
windows taking focus, and should cancel in such cases. Functions will try to
setup the area and windows correctly for you so you can stop one and start
another quickly.

## Setup Guide

### 1. Extract Files

Install Autohotkey V2 latest version (must be V2). <https://www.autohotkey.com/>

Download the version of the script you need, either latest build:
<https://github.com/nobodyscripts/LeafBlowerScript/archive/refs/heads/main.zip>
Or from releases page:
<https://github.com/nobodyscripts/LeafBlowerScript/releases>

Extract the zip where you want to keep the files, something like:
Documents/LeafBlowerScript/<files>

### 2. GUI Assisted Config

With the game *not* running run LeafBlowerV3.ahk, then click the "Update game
settings for script use" button. This will automatically apply the required
settings to the game and may resize the game if fullscreen was active. (You can
resize the windowed game freely after this.)

Run the game and continue configuring the script via the gui.

### 2. Manual Config (Alternative)

Open the UserHotkeys.ini file with a text editor (if configs do not exist run
the script and close it), any should do, vscode or even notepad. Match the
hotkeys in this file to the ones you use in game, or change
the ones in game to match the file. (Save the changes if made). Note: The keys
may not visually match ingame in hotkeys but should function when pressed
without modifiers E.G. "\" on US keyboards works but displays as "^"

Open UserSettings.ini with a text editor and configure as you require, if you
need explanations of what settings do you can open UsersettingsHelp.md with a
text editor for help.

Check below for the in game settings required, the script will try to check the
settings are correct for you and will try to warn you if incorrect.

With the game running, run the LeafBlowerV3.ahk file to load the script. Check
the readme.md or main page above for controls.

If you have problems, try using F12 (with logs enabled), it will check your
settings and report back if it finds issues.

### 3. In game setup

The script uses two loadouts (1/3) to change gear/pets for GemFarm and Tower
Boost modes, 1 being a 'Default' set which reapplies Bearo, 3 having a crafted
set for sharded MTF. These must be setup manually to work.

## Hyper-V Setup

See discord server #info channel for details on running in a vm.

## Settings You Need

Hotkeys need to either be changed ingame or in script to match (Hotkeys.ahk)

|   Set game to this                                      |  What might happen without it                                                                                                 |
|---------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------|
|   Windowed mode                                         |  Broken (fullscreen takes you to desktop).                                                                                    |
|                                                         |                                                                                                                               |
|   2560x1440 or less                                     |  Alignment issues (untested above but may work).                                                                              |
|                                                         |                                                                                                                               |
|   100% solid menus                                      |  All: Setting is tested for and errors without.                                                                               |
|                                                         |                                                                                                                               |
|   Alternative renderer                                  |  All: Setting is tested for and errors without.                                                                               |
|                                                         |                                                                                                                               |
|   Font size (0/1) (0 default)                           |  F12: Tests this setting and errors (May cause missalignment, both should work 0 is my default and will work better in borbv).|
|                                                         |                                                                                                                               |
|   Font (Alternative)                                    |  F12: Tests this setting and errors without (May cause missalignment).                                                        |
|                                                         |                                                                                                                               |
|   Dark dialog background (OFF)                          |  All/F12: Setting is tested for and errors if on (Used for boss timer and area travel).                                       |
|                                                         |                                                                                                                               |
|   Alb 90% (OFF/transparent/no tools)                    |  Boss timer at top of screen can missread, it looks for pure white to see the timer. So any setup without pure white is fine. |
|                                                         |                                                                                                                               |
|   Smooth graphics (OFF)                                 |  All/F12 tests this setting and errors if on (Used for detection of pixels).                                                  |
|                                                         |                                                                                                                               |
|   Notifications (OFF/reduced)                           |  May interupt some scripts. Checks are in place for the scripts it affects, so fine to leave on.                              |
|                                                         |                                                                                                                               |
|   Trees (OFF)                                           |  F12: Tests this setting and errors if on (Used for area travel).                                                             |
|                                                         |                                                                                                                               |
|   AFK Mode Lost Focus (OFF/ON)                          |  Checks for and counters situations where this is active. Should be fine to use.                                              |
|                                                         |                                                                                                                               |
|   Display Reward Dialogs (OFF) (Gameplay tab)           |  Checked, will slow down opening.                                                                                             |
|                                                         |                                                                                                                               |
|   Display Blown Away Dialogs (OFF) (Gameplay tab)       |  Shouldn't matter, but might cause travel issues.                                                                             |
|                                                         |                                                                                                                               |
|   Reset Scroll position on prestige (ON) (Gameplay tab) |  Unknown if this breaks scroll resetting. If you have issues traveling it maybe this                                          |
|                                                         |                                                                                                                               |
|   Borbventures auto start                               |  Checked for and toggles off/on.                                                                                              |
|                                                         |                                                                                                                               |
|   Borbventures detailed mode                            |  Checked for and works in either mode, better with details off.                                                               |
|                                                         |                                                                                                                               |
|   Claw auto start                                       |  Currently not detected and required for claw machine, manually toggle it on.                                                 |

## Changes

Check for updates added to gui, will check against the website once per day.
Settings added to General Settings and 3 settings added to ini.

Hotkeys: Added new systems to handle both the hotkeys for ingame and the script.

Hotkeys: Potential fixes for hotkey settings being added to game not working.

GUI: Reflects custom hotkeys.

GUI: Disabled Mine Sphere Count and Modifier if Greedy is enabled to be clear,
the options conflict. Also renamed Amount > Count for clarity.

Insert: Added MinerSphereModifier setting, custom amount to use per click when
greedy mode is turned off. Added to GUI.

Insert: Added MinerEnableTransmuteSdia setting, transmutes max Coal Bars to
Shiny Diamonds. Added to GUI.

Insert: Added MinerEnableTransmuteFuel setting, transmutes max Coal Diamonds to
Fuel. Added to GUI.

Insert: Added MinerEnableTransmuteSphere setting, transmutes max Coal Diamonds
to Spheres. Added to GUI.

Insert: Added MinerEnableTransmuteSdiaToCB setting, transmutes max Shiny
Diamonds to Coal Diamonds. Added to GUI.

Insert: Improved checks for which tab is active to avoid script getting stuck.  

Insert: Adapted background boss spammer into two seperate modes, boss and
Leafton Pit. These options conflict with Leafton taking priority, added setting
MinerEnableLeafton. Boss mode enabled by default.

## TODO

Check settings from options.dat as bootup tests
Cleanup card purchase orders into a more generic func.  
Investigate fullscreen (it breaks fullscreen).  

Trade farming for non gems/non suitcase version.  
Brew + cards rotation mode.  
Halloween + Nature artifact secondary which pauses main functions.  
Adjust window resize based on delta from intended size, for non matching window
   dressing.  

Automated challenges (early game scripts)

F3: Greedy card purchasing
F6: Load dlc purchase state from save file and remove setting.  
F7: Needs to use artifact if need be / get replacement  
F8: Alignment is off, refresh entire function.  
F8: Review ending of gfssnoreset mode.  
F10: Needs to use artifact if need be / get replacement  
PageDown: Leafton needs better setup routine. Travel to zone.  
Insert: Add brewing somehow

## Known issues

If you have menu transparency errors with all settings correct, it is likely your
game colours are not correct, this can be caused by custom colour settings (like
digital vibrancy, hdr or similar).

Some keys don't 'untoggle' properly when the scripts exit due to failures.  
F3: If exited early, may toggle notifications to incorrect state  
F3: Ignores new multipliers, you can manually set them before or during.  
F4: If exited early, may toggle notifications/auto refresh/details to incorrect
   state. Wait till a suitcase has been used to avoid.  
F4: Can sometimes miss bearo, if you see trade start buttons appearing, retry  
F4: Due to nature event pet slot if nature event artifact runs out bearo may not
   reapply after use, to avoid leave a slot free in default loadout  
F4: Will display failures to use suitcases, this is either due to lack of
artifacts or a bad detection.  
F7: Will intentionally grab gems if no pumpkins are found  
F7: Will go for pumpkins that are blocked by other items, its going for the
   highest one  
F9: Albs can register as boss timer (kills due to white on the tools)  
Insert: Mine caves option requires a small area of text to work, so your
experience may vary, if it fails to detect drills being off, then use a higher
resolution. It is dependant on alt font and font size 0 to work.
