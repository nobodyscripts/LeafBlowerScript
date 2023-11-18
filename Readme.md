## Resolution independent scripts v6

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

F4 Gem suitcase farming - Will do prep for you and reset afterwards, keep an eye
on it for a minute incase it has missed anything and is running smoothly.
Removes Bearo from pet team if active, sets default loadout when exited with F4.
No check in place for remaining golden suitcases, if its skipping a bunch of gems
you are out, and can either wait for regen or let it continue to run slower.

F5 72h tower boost loop - Uses (doesn't buy) boosts, swaps areas to raise max
floor. Does equip a tower gear equipment loadout, sets back to default loadout
after exiting with F5.

F6 Borbventure farming - Defaults to farming purple juice, nature gems and white
dices (configure in config.ahk). Set if you own the borb dlc otherwise it will
ignore the first two slots being unfilled. Doesn't scroll so there may be some
pauses. Scrolling will interupt, requires to be at the top of the panel.

F7 Claw machine pumpkin farmer - Tries to identify the pumpkin and use the
hook to grab it, will miss some due to other items and sometimes doesn't grab
things on the first pass.

F8 Green Flame/SoulSeeker farmer - Set how many of each to kill in the config.ahk,
will cycle and use violins to farm that amount as well as resetting SS.

F9 Normal boss farmer - Doesn't select a zone, sit in the area you want to farm
and it'll spam violins when the timers up. If kill numbers look off see settings
below.
F9 (twice) Boss farmer + brew spammer - Opens the first tab of brewing and spams
Artifacts, Equipment, Materials and Card parts (no scrolls). Violin spam rate is
reduced due to the extra actions.
F9 (three times) Boss farm + borbventures
F9 (four times) Boss farm + card opening - Will continue when done opening cards,
can disable this in the config.ahk if concerned about using cards unintentionally
F9 (five times) Toggles off (though you can just F2 early if you prefer, it won't
reset some of your settings)

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
accuracy situations I maximise the window to capture 2560*1369.

All functions have protections to save you in cases of alt tabbing or pop up
windows taking focus, and should cancel in such cases. Functions will try to
setup the area and windows correctly for you so you can stop one and start
another quickly.

Settings you need:
    Set to this                      What might happen without it
    -------------------------------------------------------------
    Windowed mode                    Broken (fullscreen takes you to desktop)

    2560x1440 or less                Alignment issues (untested above but may work)

    100% solid menus                 Setting is tested for and errors without

    Alternative renderer             Will cause missalignment and break scripts
                                     depending on the resolution

    Font size 0/1 (0 default)        May cause missalignment, both should work
                                     0 is my default and will work better in borbv

    Font alternative                 May cause missalignment, untested

    Dark dialog background off       For timer detection in boss scripts

    Alb 90% transparent/off/no tools Boss timer at top of screen can missread
                                     it looks for pure white to see the timer

    Smooth graphics off              Could affect detections, untested

    Notifications off/reduced        May interupt some scripts

    Hotkeys need to either be changed ingame or in script to match

Changes
Handle window resizes between activation more cleanly
Correctly take user to settings if transparency is on
Adjusted and tested for font size 0 and 1, 0 is slightly better for borbventures
F3 If cards gets interupted by notifications it'll close the notifications until done
   Increased default sleep time slightly to make sure each opening is over 1s
F4 Improved L1 slot filling to not partially fill trades
   Made the check for the desert map location dynamic, should get stuck less
   Removed scrolling tooltip which was sometimes hiding the desert leaf
   Improved auto refresh and detailed mode handling
   Added a sleeptimer offset to config.ahk which allows for adjustment if gems are skipped
   Slowed the default sleep timers slightly in the main loop
F6 Improved finished item detection, now a lot quicker and more accurate
   Improved handling of finished item while a cancel button still being monitored
   Increased scan areas for icons to reduce the refresh spam when scrolling
   Fixed rare case where more than 2/4 slots being active would result in refresh spam
F7 Checks for halloween being active at start due to artifact running out
   Reduced scanning area for hook to improve response time
F9 Brew mode properly switches to the general tab
   NEW: Third mode now runs normal boss farm + borbventures
   NEW: Fourth mode now runs normal boss farm + card opening
   Config.ahk has an option to disable this mode so you don't accidentally use cards
   NEW: Fifth press stops
F10 Checks for nature zones being accessible due to artifact running out

TODO
Check for incompatible settings (smooth mode, font size etc)
Button active state checking for GF/SS farming reset before farming starts to
reset kills to known amounts
Mouse blocking during active farming and release during waiting
Coords flexible to font size/font type
Investigate fullscreen (it breaks fullscreen)
Investigate a gui to replace function keys and a proper config
When task requires a specific zone, check that area repeatedly, incase changed (ww on)
Wings farming with SS reset
Buying cards - Change F11 or 12 to card purchasing with greedy amounts
Buying x amount of cards to openall specific amounts
Trade farming for non gems/non suitcase version
F6 Borb check for active refresh button (handle notifications)
   Scroll alignment for borbventures and a 'state memory'
   Fails if a non intended item is in a slot as it cannot 'see' it
   Need a line scan function that finds all blocks of a colour along the line
   Not seeing a gem slot as active causing refresh loop with font 0
F7 Needs to use artifact if need be / get replacement
F9 Option for min amounts of violin usage, rather than as fast as possible
   If on the quark bosses, swap loadouts to a nuclear set while timer isn't active
F10 Needs to use artifact if need be / get replacement

Known issues
F3 Can in cases enable notifications when it wasn't previously enabled
F4 Can in cases enable auto refresh/details mode when it wasn't previously enabled
F6 Free borb/borb token got picked when it shouldn't have, no inventory space locked up process
   Threw spacing off entirely
   Scrolling screws everything up quickly, especially if a mouseup isn't applied
F7 Sometimes grabs scarabs due to the same colour as the stems on pumpkins,
   though it will intentionally grab gems if no pumpkins are found
F9 Albs can register as boss timer (kills due to white on the tools)
