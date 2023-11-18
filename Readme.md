# Resolution independent scripts v3 build 7

Autohotkey V2 script, install v2 of autohotkey and run the LeafBlowerV3.ahk
file to load. Edit the ahk files with a text editor to configure.

Same key toggles the feature off, if this toggle fails, F1 or F2 to abort.

F1: Closes the script entirely

F2: reloads the script, deactivating anything that is active but keeping it
loaded

F3: Open/Buy card packs - Opens/buys card screen for you. Customize the amount to
open/buy in the config.ahk file, 2500 default. May leave the ctrl/alt/shift keys
pressed when canceling, just press them to update their state if you notice
anything weird.

F4: Gem suitcase farming - Will do prep for you and reset afterwards, keep an eye
on it for a minute incase it has missed anything and is running smoothly.
Removes Bearo from pet team if active, sets default loadout when exited with F4.
No check in place for remaining golden suitcases, if its skipping a bunch of gems
you are out, and can either wait for regen or let it continue to run slower.

F5: 72h tower boost loop - Uses (doesn't buy) boosts, swaps areas to raise max
floor. Does equip a tower gear equipment loadout, sets back to default loadout
after exiting with F5.

F6: Borbventure farming - Defaults to farming purple juice, nature gems and white
dices (configure in config.ahk). Set if you own the borb dlc otherwise it will
ignore the first two slots being unfilled. Doesn't scroll so there may be some
pauses. Scrolling will interupt, requires to be at the top of the panel.

F7: Claw machine pumpkin farmer - Tries to identify the pumpkin and use the
hook to grab it, will miss some due to other items and sometimes doesn't grab
things on the first pass.

F8: Green Flame/SoulSeeker farmer - Set how many of each to kill in the config.ahk,
will cycle and use violins to farm that amount as well as resetting SS.

F9: Normal boss farmer - Doesn't select a zone, sit in the area you want to farm
and it'll spam violins when the timers up. If kill numbers look off see settings
below.
F9x2 (twice): Boss farmer + brew spammer - Opens the first tab of brewing and spams
Artifacts, Equipment, Materials and Card parts (no scrolls). Violin spam rate is
reduced due to the extra actions.
F9x3 (three times): Boss farm + borbventures
F9x4 (four times): Boss farm + card opening - Will continue when done opening cards,
can disable this in the config.ahk if concerned about using cards unintentionally
F9x5 (five times): Toggles off (though you can just F2 early if you prefer, it won't
reset some of your settings)

F10: Nature boss farmer - Swaps out to Farm Fields to use violins, uses the
timer in the area screen to check if the timers done, so don't close the panels
while it is running.

F11: A 16.7ms autoclicker - Works outside the game too so be careful

F12: Performs settings tests for render type, menu transparency, font size and font type.
Then resizes the window to 1278*664 client area (on windows 11, may need
tweaking if not) This is intended to be optional, but you can use this if things
break for you. And to test if settings are working. Does not currently test for
smooth graphics, alb settings or dark dialog background.

Insert: Quark boss farmer - Spams violins when on cd, wind when not, has an
option in config to return to one of the three bosses on death (with 10s wait).
Takes you to the same boss when run. Equips a loadout for nuclear fuel, resets
to default loadout when canceled.

## Notes

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

## Settings you need

    Set to this                      What might happen without it
    -------------------------------------------------------------
    Windowed mode                    Broken (fullscreen takes you to desktop)

    2560x1440 or less                Alignment issues (untested above but may work)

    100% solid menus                 Setting is tested for and errors without

    Alternative renderer             Setting is tested for and errors without

    Font size 0/1 (0 default)        May cause missalignment, both should work
                                     0 is my default and will work better in borbv
                                     F12 tests this setting and errors

    Font alternative                 May cause missalignment
                                     F12 tests this setting and errors

    Dark dialog background off       For timer detection in boss scripts

    Alb 90% transparent/off/no tools Boss timer at top of screen can missread
                                     it looks for pure white to see the timer

    Smooth graphics off              Could affect detections, untested

    Notifications off/reduced        May interupt some scripts

    Hotkeys need to either be changed ingame or in script to match

## Changes

Note: You can leave gravity autouse off with the changes to F8/F9 unless you need it elsewhere.
Adds some further hotkeys to the hotkey.ahk file as a result
Added check for alternative rendering mode being active (if aspect ratio is incorrect)
Added toggle to config.ahk that disables the settings checks if you live dangerously
Added logging to LeafBlowerV3.log, disabled by default
Added passthrough to all keybinds while the game is not focused (renaming files ftw)
All traveling to areas now have checks and redundant attempts, plus skip travel if
   already there (if detection fails, travel manually then activate feature).
Added config for all traveling sleep times, if needed due to it retrying travel
Insert(new key) Added quark boss farming, violin and wind rotation based on boss timer with
   travel and travel on death with a delay to heal.
Insert Added a return to boss when dead option in config.ahk
F3 Added card purchasing, loads of options in config.ahk, disabled by default
F3 Purchasing loops before opening, disable purchasing if you need to just open
F3 Added perma loop option, lets you keep buying and opening as you brew
F3 Added retry to opening cards panel (and on F9)
F3 Added custom purchase priority, this is useful for situations with a large stockpile
F3 Improved the shift/ctrl/alt handling so it gets stuck less
F3 Check for panel being open to prevent a notification close loop
F6 More reliable swapping to the correct tab
F6 Made the flickering tooltip solid
F7 Improved reliability of check for halloween being active
F8 Added spamming of gravity and wind when boss spawned (option in config.ahk)
F8 Slowed the mouseclicks when resetting SS/GF to increase reliability
F9 Reloads when focus lost, to reset which mode is used next
F9 Changed the spamming to a seperate timer, much faster spamming as a result but
   may cause F9 to be ignored occasionally.
F10 Changed the area traveled to for spamming violins for more reliable travel
F11 Reduced the chance of the mouse grabbing things at the end of usage
F12 Added check for incorrect font size and not being set to alternative font this
   is resolution dependant, thus only on F12 for debug.

## TODO

Check for alb
Check for corner buttons colour to check if dark background is on
Check for panel gradiant to check if smooth graphics is on
Better check for notifications
Mouse blocking during active farming and release during waiting
Investigate fullscreen (it breaks fullscreen)
Investigate a gui to replace function keys and a proper config
When task requires a specific zone, check that area repeatedly, incase changed (ww on)
Buying x amount of cards to openall specific amounts
Trade farming for non gems/non suitcase version
Redo the failed to settings system
F6 Borb check for active refresh button (handle notifications)
F6 Scroll alignment for borbventures and a 'state memory'
F6 Check if 2 inactive slots when finding 2 active slots with no dlc
F6 Check for scrollbar tab at top of track (will need to check for scrollbar exist)
F7 Needs to use artifact if need be / get replacement
F9 Option for min amounts of violin usage, rather than as fast as possible
F9 Wings farming with SS reset
F10 Needs to use artifact if need be / get replacement

## Known issues

F3 Can if exited early, enable notifications when it wasn't previously enabled
   If it looks like the buttons are going wild, its because its checking each button
   with its own modifiers to see if each one is available (intended)
   Can still get ctrl/alt/shift stuck on (just press them to unstick)
F4 Can in cases enable auto refresh/details mode when it wasn't previously enabled
   If exited early, will toggle accidentally
F6 Free borb/borb token got picked when it shouldn't have, no inventory space locked up process
   threw spacing off entirely.
   Scrolling screws everything up quickly, especially if a mouseup isn't applied
   Not seeing a gem slot as active, causing refresh loop with font 0
   If there are only 2 borbventure quests, it can see the slots as all filled with no dlc
F7 Will intentionally grab gems if no pumpkins are found
   Will go for pumpkins that are blocked by other items, its going for the highest one
F9 Albs can register as boss timer (kills due to white on the tools)
   When killed the transparent panel check may reoccur but without a panel loaded, so fails
