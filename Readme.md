## Resolution independent scripts v4

Autohotkey V2 script, install v2 of autohotkey and run the LeafBlowerV3.ahk
file to load. Edit the ahk files with a text editor to configure.

Same key toggles the feature off, if this toggle fails, F1 or F2 to abort.

F1 Closes the script entirely

F2 Reloads the script, deactivating anything that is active but keeping it
loaded

F3 Open card packs - Opens card screen for you. Customize the amount to open
in the config.ahk file, 2500 default. May leave the ctrl/alt/shift keys pressed
when canceling, just press them to update their state if you notice anything
weird.

F4 Gem suitcase farming - Will do prep for you, you can turn off auto refresh
in trades but not required, may not always manage to remove bearo, so watch out
for trades being completed outside the first slot.
Removes Bearo from pet team if active, sets default loadout when exited properly.
No check in place for remaining golden suitcases, if its skipping a bunch of gems
you are out, and can either wait for regen or let it continue to run slower.

F5 72h tower boost loop - Uses (doesn't buy) boosts, swaps areas to raise max
floor. Does equip a tower gear equipment loadout, sets back to default loadout
after exiting with F5.

F6 Borbventure farming - Defaults to farming purple juice, nature gems and
nature spheres and both dices (see BVScanSlotItem()). Variable below to set if
you own the borb dlc otherwise it'll ignore the first two slots being unfilled.
Doesn't scroll so there may be some pauses.

F7 Claw machine pumpkin farmer - Tries to identify the pumpkin and use the
hook to grab it, will miss some due to other items and sometimes doesn't grab
things on the first pass.

F8 Green Flame/SoulSeeker farmer - Set how many of each to kill in the config.ahk,
will cycle and use violins to farm that amount as well as resetting SS.

F9 Normal boss farmer - Doesn't select a zone, sit in the area you want to farm
and it'll spam violins when the timers up.
F9 (twice) Boss farmer + brew spammer - Opens the first tab of brewing and spams
Artifacts, Equipment, Materials and Card parts (no scrolls). Violin spam rate is
reduced due to the extra actions.
F9 (three times) Toggles off

F10 Nature boss farmer - Swaps out to Farm Fields to use violins, uses the
timer in the area screen to check if the timers done, so don't close the panels
while it is running.

F11 A 16.7ms autoclicker - Works outside the game too so be careful

F12 Resizes the window to 1278*664 client area (on windows 11, may need
tweaking if not) This is intended to be optional, but you can use this if things
break for you.

Notes
Sleep times might need adjusting for your pc, so increase them as needed if
things are skipping. Increments of 17 should add another frame (at 60fps).
Ingame Keybinds section below the script triggers can be adjusted either to
what you use, or change them ingame to match.

My window size (1440p snapped to corner) 1278*664 client size is what the
locations are based on, those are adapted to your window size, so set your
window 'client' to this size for changes or if things don't work. For high
accuracy situations I fullscreen to capture 2560*1369.

All functions have protections to save you in cases of alt tabbing or pop up
windows taking focus, and should cancel in such cases. Functions will try to
setup the area and windows correctly for you so you can stop one and start
another quickly.


Settings assumed:
    Windowed mode (fullscreen untested)
    2560x1440 or less (untested above but may work)
    100% solid menus            Tests for setting
    Alternative renderer        <<< Will cause missalignment
    Font size 1                 <<< May cause missalignment
    Font alternative            <<< May cause missalignment
    Dark dialog background off  <<< For timer detection in boss scripts
    Smooth graphics off
    Notifications will interupt cards and trade scripts
    Hotkeys need to either be changed ingame or in script to match

Changes
F3 Checks on cards to stop when done
F3 Slowed timer between card opening to account for the believed 1s delay to
auto transcend (configurable in config.ahk)
F3 Tries to remove notifications covering the buttons when checking

F4 Gems now disables auto refresh and detailed mode if it was on at startup
F4 Also improved speed of trade slot filling, startup and farming
F4 Improved robustness of detection while notifications are on
F4 Can handle L1 being on now though it will only try to fill slots 100 times
F4 Fixed occational getting stuck on wrong zone
F4 Will re-enable auto refresh along with the default loadout, letting you
continue to passive farm when you use F4 to disable

F5 Dynamic alignment for tower farming
F5 Checks on tower to stop when done or misalignment

F6 Improved borbventure finish detection and Improved borbventure speed
F6 Added array config of items to search for (configurable in config.ahk)

F7 Improved travel to pub reliability, accuracy and speed of resetting

F9 has added Brew while spamming violins mode, opens first tab of brewing
and spams the buttons (except scrolls)
F9 Normal boss farm > Second F9 Brew mode > Third F9 stops

Added default loadout on cancel of gems or tower
Improved boss kill detection on normal/gfss/nature
Scripts check for transparency being on, point you to the setting if not
Split files to more easily edit and allow easier config

TODO
Check for incompatible settings (smooth mode, font size etc)
Button active state checking for GF/SS farming reset before farming starts to
reset kills to known amounts
Mouse blocking during active farming and release during waiting
Coords flexible to font size/font type
Investigate fullscreen (it breaks fullscreen)
Investigate a gui to replace function keys and a proper config

F3 Buying cards - Change F11 or 12 to card purchasing with greedy amounts

F6/Borb check for active refresh button (handle notifications)
Scroll alignment for borbventures and a 'state memory'

Normal boss farming with borbventures

F7 Needs checks for halloween being active, use artifact if need be / get replacement

F9 New modes: Borbventure and SS reset while spamming ww and violin
Option for min amounts of violin usage, rather than as fast as possible

F10 Nature boss needs checks for nature being active, use artifact if need be /
get replacement

Known issues
F7 sometimes grabs scarabs due to the same colour as the stems on pumpkins,
though it will intentionally grab gems if no pumpkins are found