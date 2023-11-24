# LBR Resolution independent scripts V3.0.11

Autohotkey V2 script, install V2 of autohotkey and run the LeafBlowerV3.ahk
file to load. Edit the ahk files with a text editor to configure.

Same key toggles the feature off, if this toggle fails, F1 or F2 to abort.

F1: Closes the script entirely

F2: Reloads the script, deactivating anything that is active but keeping it
loaded

F3: Open/Buy card packs - Opens/buys card screen for you. Customize the amount
to open/buy in the UserSettings.ini file, 2500 default. May leave the
ctrl/alt/shift keys pressed when canceling, just press them to update their
state if you notice anything weird.

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
the panel.

F7: Claw machine pumpkin farmer - Tries to identify the pumpkin and use the
hook to grab it, will miss some due to other items and sometimes doesn't grab
things on the first pass.

F8: Green Flame/SoulSeeker farmer - Set how many of each to kill in the
UserSettings.ini, will cycle and use violins to farm that amount as well as
resetting SoulSeeker.

F9: Normal boss farmer - Doesn't select a zone, sit in the area you want to farm
and it'll spam violins when the timers up. If kill numbers look off see settings
below.  
F9x2 (twice): Boss farmer + brew spammer - Opens the first tab of brewing and
spams Artifacts, Equipment, Materials and Card parts (no scrolls). Violin spam
rate is reduced due to the extra actions.  
F9x3 (three times): Boss farm + borbventures  
F9x4 (four times): Boss farm + card opening - Will continue when done opening
cards, can disable this in the UserSettings.ini if concerned about using cards
unintentionally  
F9x5 (five times): Toggles off (though you can just F2 early if you prefer)

F10: Nature boss farmer - Swaps out to Farm Fields to use violins, uses the
timer in the area screen to check if the timers done, so don't close the panels
while it is running.

F11: A 16.7ms autoclicker - Works outside the game too so be careful

F12: Performs settings tests for render type, menu transparency, font size and
font type. Then resizes the window to 1278x664 client area (on windows 11, may
need tweaking if not) This is intended to be optional, but you can use this if
things break for you. And to test if settings are working. Does not currently
test for smooth graphics, alb settings or dark dialog background.

Insert: Quark boss farmer - Spams violins when on cd, wind when not, has an
option in config to return to one of the three bosses on death (with 10s wait).
Takes you to the same boss when run. Equips a loadout for nuclear fuel, resets
to default loadout when canceled.

Home: WW mode - Set the bosses you would like to farm and then this script will
keep the SS reset screen loaded while you farm and reset when it can. Will abort
when you die, so is not very useful, prefer F8 for GF/SS and F9 for WW

## Notes

Sleep times might need adjusting for your pc, so increase them as needed if
things are skipping. Increments of 17 should add another frame (at 60fps).
Ingame Keybinds section below the script triggers can be adjusted either to
what you use, or change them ingame to match.

My window size (1440p snapped to corner) 1278x664 client size is what the
locations are based on, those are adapted to your window size, so set your
window 'client' to this size for changes or if things don't work. For high
accuracy situations I maximise the window to capture 2560x1369.

All functions have protections to save you in cases of alt tabbing or pop up
windows taking focus, and should cancel in such cases. Functions will try to
setup the area and windows correctly for you so you can stop one and start
another quickly.

## Settings you need

Hotkeys need to either be changed ingame or in script to match

|   Set to this                                           |  What might happen without it                                                                                                 |
|---------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------|
|   Windowed mode                                         |  Broken (fullscreen takes you to desktop)                                                                                     |
|                                                         |                                                                                                                               |
|   2560x1440 or less                                     |  Alignment issues (untested above but may work)                                                                               |
|                                                         |                                                                                                                               |
|   100% solid menus                                      |  All: Setting is tested for and errors without                                                                                |
|                                                         |                                                                                                                               |
|   Alternative renderer                                  |  All: Setting is tested for and errors without                                                                                |
|                                                         |                                                                                                                               |
|   Font size (0/1) (0 default)                           |  F12: Tests this setting and errors (May cause missalignment, both should work 0 is my default and will work better in borbv) |
|                                                         |                                                                                                                               |
|   Font (Alternative)                                    |  F12: Tests this setting and errors without (May cause missalignment)                                                         |
|                                                         |                                                                                                                               |
|   Dark dialog background (OFF)                          |  All/F12: Setting is tested for and errors if on (Used for boss timer and area travel)                                        |
|                                                         |                                                                                                                               |
|   Alb 90% (OFF/transparent/no tools)                    |  Boss timer at top of screen can missread, it looks for pure white to see the timer. So any setup without pure white is fine. |
|                                                         |                                                                                                                               |
|   Smooth graphics (OFF)                                 |  All/F12 tests this setting and errors if on (Used for detection of pixels)                                                   |
|                                                         |                                                                                                                               |
|   Notifications (OFF/reduced)                           |  May interupt some scripts. Checks are in place for the scripts it affects, so fine to leave on.                              |
|                                                         |                                                                                                                               |
|   Trees (OFF)                                           |  F12: Tests this setting and errors if on (Used for area travel)                                                              |
|                                                         |                                                                                                                               |
|   AFK (AUTO/OFF)                                        |  Checks for and counters situations where this is active. Should be fine to use.                                              |
|                                                         |                                                                                                                               |
|   Display Reward Dialogs (OFF) (Gameplay tab)           |  Checked, will slow down opening                                                                                              |
|                                                         |                                                                                                                               |
|   Display Blown Away Dialogs (OFF) (Gameplay tab)       |  Shouldn't matter, but might cause travel issues                                                                              |
|                                                         |                                                                                                                               |
|   Reset Scroll position on prestige (ON) (Gameplay tab) |  Unknown if this breaks scroll resetting. If you have issues traveling it maybe this                                          |
|                                                         |                                                                                                                               |
|   Borbventures auto start                               |  Checked for and toggles off/on.                                                                                              |
|                                                         |                                                                                                                               |
|   Borbventures detailed mode                            |  Checked for and works in either mode, better with details off.                                                               |
|                                                         |                                                                                                                               |
|   Claw auto start                                       |  Currently not detected and required for claw machine, manually toggle it on.                                                 |

## Changes

## TODO

Devoption: Window check, keybinds and active checks designed around dev.
   F12 Test mode, edit save file to incorrect settings and test each
   mode detects, verbose debug on pixel checks.  
Cleanup card purchase orders into a more generic func.  
Break up monolithic funcs to logical parts.  
Check for alb.  
Investigate fullscreen (it breaks fullscreen).  
Investigate a gui to replace function keys.  
Move keybinds to UserSettings.ini.  
Trade farming for non gems/non suitcase version.  
Brew + cards rotation mode.  
Halloween + Nature artifact secondary which pauses main functions.  
Adjust window resize based on delta from intended size, for non matching window
   dressing.

F3: Handle new multipliers, decreasing amounts, priorities. Will probably need
to read save file, get caps, work out how much to open to avoid breaking auto
transcend limits, then ocr the buttons and openall the right amount.  
F6: If item is not a valid target cancel borbv  
F6: If white pixels in area next to normal text display, cancel borbv as
   inventory is blocked  
F6: Autostart check for both font sizes
F7: Autoplay check  
F7: Needs to use artifact if need be / get replacement  
F8: Move violin to secondary, spam during non boss timer after farming starts  
F10: Needs to use artifact if need be / get replacement  

## Known issues

Some keys don't 'untoggle' properly when the scripts exit due to failures.  
F3: If exited early, may toggle notifications to incorrect state  
F3: If it looks like the buttons are going wild, its because its checking each
   button with its own modifiers to see if each one is available (intended)  
F3: Can still get ctrl/alt/shift stuck on (just press them to unstick)  
F3: Ignores new multipliers, you can manually set them before or during.  
F4: If exited early, may toggle notifications/auto refresh/details to incorrect
   state.  
F4: Can sometimes miss bearo, if you see trade start buttons appearing, retry  
F4: Due to nature event pet slot if nature event artifact runs out bearo may not
   reapply after use  
F6: Incorrect items can be started if manually refreshed while it scans  
F7: Will intentionally grab gems if no pumpkins are found  
F7: Will go for pumpkins that are blocked by other items, its going for the
   highest one  
F9: Albs can register as boss timer (kills due to white on the tools)  
F9: When killed the transparent panel check may reoccur but without a panel
   loaded, so fails  
Home: WW being unpredictable you will occationally go to SS or GF when unable to
   defeat boss and be sent to Home Garden, script will then exit. Use F8/F9.
