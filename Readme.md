# Resolution independent scripts v3 build 8

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

    100% solid menus                 All: Setting is tested for and errors without

    Alternative renderer             All: Setting is tested for and errors without

    Font size 0/1 (0 default)        F12: tests this setting and errors
                                     (May cause missalignment, both should work
                                     0 is my default and will work better in borbv)
                                     
    Font alternative                 F12: tests this setting and errors without
                                     (May cause missalignment)

    Dark dialog background off       All/F12: tests this setting and errors without
                                     (Used for boss timer and area travel)

    Alb 90% transparent/off/no tools Boss timer at top of screen can missread
                                     it looks for pure white to see the timer

    Smooth graphics off              All/F12 tests this setting and errors without
                                     (Used for detection of pixels)

    Notifications off/reduced        May interupt some scripts
                                     Checks are in place for the scripts it affects

    Trees off                        F12 tests this setting and errors without
                                     (Used for area travel)

    Hotkeys need to either be changed ingame or in script to match

## Changes

Traveling improved further with a blind attempt and reduced speed, should it fail to
not travel correctly. Blind mode tries once and trusts it succeeded.
Added toggle to disable the new checks and retries on travel and use blind travel
Added check for smooth graphics
Added check for dark dialog background
Logging off by default to avoid filling ssds
F10: Fixed an issue with traveling to The Doomed Tree zone
F12: Fully disabled the settings checks in F12 when configured not to check
Insert: Fixed issues with traveling to quark bosses due to incorrect locations

## TODO

Check for alb
Better check for notifications
Mouse blocking during active farming and release during waiting
Investigate fullscreen (it breaks fullscreen)
Investigate a gui to replace function keys and a proper config
Buying x amount of cards to openall specific amounts
Trade farming for non gems/non suitcase version
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
