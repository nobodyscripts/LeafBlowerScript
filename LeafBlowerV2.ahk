#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 4

; ------------------- Readme -------------------
/*
Same key toggles the feature off, if this toggle fails, F1 or F2 to abort.

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

F1 Closes the script entirely

F2 Reloads the script, deactivating anything that is active but keeping it
loaded

F3 Open card packs - Opens card screen for you. Customize the amount to open
with the variables below the readme. May leave the ctrl/alt/shift keys pressed
when canceling, just press them to update their state if you notice anything
weird.

F4 Gem suitcase farming - Will do prep for you, you can turn off auto refresh
in trades but not required, may not always manage to remove bearo, so watch out
for trades being completed outside the first slot.
Removes Bearo from pet team if active, so manually reset your loadout after. No
check in place for remaining golden suitcases, if its skipping a bunch of gems
you are out and can either wait for regen or let it continue to run slower.
Does double checks for gem being present at the cost of speed, if you don't mind
inaccuracy you can remove the extra checks.

F5 72h tower boost loop - Uses (doesn't buy) boosts, swaps areas to raise max
floor. Does equip a tower gear equipment loadout, so you will need to swap back
afterwards

F6 Borbventure farming - Defaults to farming purple juice, nature gems and
nature spheres and both dices (see BVScanSlotItem()). Variable below to set if you own the
borb dlc otherwise it'll ignore the first two slots being unfilled. Doesn't
 scroll so there may be some pauses.

F7 Claw machine pumpkin farmer - Tries to identify the pumpkin and use the
hook to grab it, will miss some due to other items and sometimes doesn't grab
things on the first pass.

F8 Green Flame/SoulSeeker farmer - Set how many of each to kill in the variables
below, will cycle and use violins to farm that amount as well as resetting SS.

F9 Normal boss farmer - Doesn't select a zone, sit in the area you want to farm and it'll spam violins when the timers up.

F10 Nature boss farmer - Swaps out to Farm Fields to use violins, uses the timer in the area screen to check if the timers done, so don't close the panels
while it is running.

F11 A 16.7ms autoclicker - Works outside the game too so be careful

F12 Resizes the window to 1278*664 client area (on windows 11, may need
tweaking if not) This is intended to be optional, but you can use this if things
break for you.

Settings assumed, Alternative renderer, 100% solid menus, notifications may
cause conflicts with things like bearo detection on F4 so i have most of those
off. I do leave notifications on but disable all of them so i can see gem
trades but not required.
*/
global X, Y, W, H
if WinExist("Leaf Blower Revolution") {
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
}

global HaveBorbDLC := false
; Set this to fill the first two slots with full teams

global CardOpeningUseShift := false ; Set cards opening to 2500 (default)
global CardOpeningUseCtrl := true
global CardOpeningUseAlt := true
global CardOpeningMode := 3 ; 1 for Common, 2 for rare, 3 for legendary
global GFToKillPerCycle := 8 ; How many gf to kill before attempting SS
global SSToKillPerCycle := 2 ; How many ss to kill before resetting

; ------------------- Script Triggers -------------------

*F1:: {
    ;Wildcard shortcut * to allow functions to work while looping with
    ; modifiers held
    ExitApp
}

*F2:: {
    Reload
}

*F3:: { ; Open cards clicker
    ResetModifierKeys() ; Cleanup incase needed
    Static on1 := False
    If on1 := !on1 {
        fOpenCardLoop()
    } Else {
        ResetModifierKeys() ; Cleanup incase needed
        Reload
    }
}

*F4:: { ; Gem farm using suitcase
    ResetModifierKeys() ; Cleanup incase needed
    Static on2 := False
    If on2 := !on2 {
        fGemFarmSuitcase()
    } Else Reload
}

*F5:: { ; Tower 72hr boost loop
    ResetModifierKeys() ; Cleanup incase needed
    Static on3 := False
    If on3 := !on3 {
        fTimeWarpAndRaiseTower()
    } Else Reload
}

*F6:: { ; Borb pink juice farm in borbventures
    ResetModifierKeys() ; Cleanup incase needed
    Static on5 := False
    If on5 := !on5 {
        fBorbVentureJuiceFarm()
    } Else Reload
}

*F7:: { ; Claw pumpkin farm
    ResetModifierKeys() ; Cleanup incase needed
    Static on6 := False
    If on6 := !on6 {
        fClawFarm()
    } Else Reload
}

*F8:: { ; Green Flame/Soulseeker farm
    ResetModifierKeys() ; Cleanup incase needed
    Static on7 := False
    If on7 := !on7 {
        fFarmGFSS()
    } Else Reload
}

*F9:: { ; Farm normal boss using violins
    ResetModifierKeys() ; Cleanup incase needed
    Static on8 := False
    If on8 := !on8 {
        fFarmNormalBoss()
    } Else Reload
}

*F10:: { ; Farm nature boss using violins
    ResetModifierKeys() ; Cleanup incase needed
    Static on8 := False
    If on8 := !on8 {
        fFarmNatureBoss()
    } Else Reload
}

*F11:: { ; Autoclicker non game specific
    Static on4 := False
    If on4 := !on4 {
        Loop {
            MouseClick "left", , , , , "D"
            Sleep 16.7
            ; Must be higher than 16.67 which is a single frame of 60fps
            MouseClick "left", , , , , "U"
            Sleep 16.7
        }
    } Else Reload
}

*F12:: {
    WinMove(, , 1294, 703, "Leaf Blower Revolution")
    ; Changes size of client window for windows 11
}

; ------------------- Keybinds -------------------

; Customise these to match your keybinds or change to these ingame

OpenAreas() {
    ControlSend "{v}", , "Leaf Blower Revolution"
}

OpenGemShop() {
    ControlSend "{.}", , "Leaf Blower Revolution" ; Period/full stop
}

OpenTrades() {
    ControlSend "{y}", , "Leaf Blower Revolution"
}

OpenPets() {
    ControlSend "{k}", , "Leaf Blower Revolution"
}

OpenBorbVentures() {
    ControlSend "{j}", , "Leaf Blower Revolution"
}

OpenCards() {
    ControlSend "{i}", , "Leaf Blower Revolution"
}

OpenAlchemy() {
    ControlSend "{o}", , "Leaf Blower Revolution" ; Letter O
}

TriggerSuitcase() {
    ControlSend "{,}", , "Leaf Blower Revolution"
}

TriggerViolin() {
    ControlSend "{/}", , "Leaf Blower Revolution"
}

RefreshTrades() {
    ControlSend "{Space}", , "Leaf Blower Revolution"
}

EquipTowerGearLoadout() {
    ControlSend "{Numpad3}", , "Leaf Blower Revolution"
}

ClosePanel() {
    ControlSend "{Esc}", , "Leaf Blower Revolution"
}
/* These are not currently used so you can ignore the keybinds below


OpenTools() {
    ControlSend "{1}", , "Leaf Blower Revolution" ; Inactive
}
TriggerWind() {
    ControlSend "{[}", , "Leaf Blower Revolution" ; Inactive
}

TriggerGravity() {
    ControlSend "{]}", , "Leaf Blower Revolution" ; Inactive
}

TriggerWobblyWings() {
    ControlSend "{#}", , "Leaf Blower Revolution" ; Inactive
}

EquipBrewGearLoadout() {
    ControlSend "{Numpad1}", , "Leaf Blower Revolution" ; Inactive
}

EquipDamageGearLoadout() {
    ControlSend "{Numpad2}", , "Leaf Blower Revolution" ; Inactive
}

EquipBlowingGearLoadout() {
    ControlSend "{Numpad4}", , "Leaf Blower Revolution" ; Inactive
}

EquipSwordGearLoadout() {
    ControlSend "{Numpad5}", , "Leaf Blower Revolution" ; Inactive
}

EquipPyramidGearLoadout() {
    ControlSend "{Numpad6}", , "Leaf Blower Revolution" ; Inactive
}

EquipSevenGearLoadout() {
    ControlSend "{Numpad7}", , "Leaf Blower Revolution" ; Inactive
}

EquipEightGearLoadout() {
    ControlSend "{Numpad8}", , "Leaf Blower Revolution" ; Inactive
}
*/

; ------------------- Functions -------------------

; Convert positions from 1278*664 client resolution to current resolution
WinRelPosW(PosW)
{
    return PosW / 1278 * W
}

WinRelPosH(PosH)
{
    return PosH / 664 * H
}

; Convert positions from 2560*1396 client resolution to current resolution to
; allow higher accuracy
WinRelPosLargeW(PosW2)
{
    return PosW2 / 2560 * W
}

WinRelPosLargeH(PosH2)
{
    return PosH2 / 1369 * H
}

; Default clicking function, uses relative locations
fSlowClick(x, y, delay := 34)
{
    MouseClick "left", WinRelPosW(x), WinRelPosH(y), , , "D"
    Sleep delay ; Must be higher than 16.67 which is a single frame of 60fps,
    ; set to slightly higher than 2 frames for safety
    ; If clicking isn't reliable increase this sleep value
    MouseClick "left", WinRelPosW(x), WinRelPosH(y), , , "U"
}

; Custom clicking function, swap the above to this if you want static coords
; that are more easily changed
fCustomClick(x, y, delay := 34)
{
    MouseClick "left", x, y, , , "D"
    Sleep delay
    /* Must be higher than 16.67 which is a single frame of 60fps,
    set to slightly higher than 2 frames for safety
    If clicking isn't reliable increase this sleep value */
    MouseClick "left", x, y, , , "U"
}

ResetModifierKeys() {
    ; Cleanup incase still held, lbr/ahk like to get stuck with them held and
    ; getkeystate shows them not down
    ;if GetKeyState("Control")
    ControlSend "{Control up}", , "Leaf Blower Revolution"
    ;if GetKeyState("Alt")
    ControlSend "{Alt up}", , "Leaf Blower Revolution"
    ;if GetKeyState("Shift")
    ControlSend "{Shift up}", , "Leaf Blower Revolution"
}

; ------------------- Main actions -------------------

fOpenCardLoop()
{
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check

    OpenPets()
    ; Opens or closes another screen so that when areas is opened it doesn't
    ; close
    Sleep 50
    OpenCards()
    Sleep 50
    fSlowClick(202, 574)
    ; Open leaf galaxy tab incase wrong tab and to reset scroll

    loop {
        ; Check if lost focus, close or crash and break if so
        if !WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution") {
                break
        }
        WinActivate("Leaf Blower Revolution")
        ; Use the window found by WinExist.
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
        ; Update window size

        if CardOpeningUseCtrl = true {
            ControlSend "{Control down}", , "Leaf Blower Revolution"
        }
        if CardOpeningUseAlt = true {
            ControlSend "{Alt down}", , "Leaf Blower Revolution"
        }
        if CardOpeningUseShift = true {
            ControlSend "{Shift down}", , "Leaf Blower Revolution"
        }
        if CardOpeningMode = 1 {
            fSlowClick 315, 400 ; Common pack open
        }
        if CardOpeningMode = 2 {
            fSlowClick 597, 400 ; Rare pack open
        }
        if CardOpeningMode = 3 {
            fSlowClick 880, 400 ; Legendary pack open
        }
        Sleep 100
        ResetModifierKeys() ; Cleanup ctrl+shift+alt modifiers
    }
    ResetModifierKeys() ; Cleanup incase of broken loop
}

fTimeWarpAndRaiseTower() {
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    OpenPets()
    ; Opens or closes another screen so that when areas is opened it doesn't
    ; close
    Sleep 50
    OpenAreas()
    Sleep 50
    fSlowClick(317, 574)
    ; Open leaf galaxy tab incase wrong tab and to reset scroll
    Sleep 100
    MouseMove(WinRelPosW(875), WinRelPosH(313)) ; Move mouse for scrolling

    ResetAreaScroll()
    ; Move the screen up to reset the scroll incase its been changed outside
    ; the script

    AreaScrollAmount(16) ; Scroll down for the zones

    EquipTowerGearLoadout() ; Equip Tower set

    Loop {
        ; Check if: lost focus, close or crash and break if so
        if !WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution") {
                break
        }
        WinActivate("Leaf Blower Revolution")
        ; Use the window found by WinExist.
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
        ; Update window size

        ; These next three clicks are unstable, the scrolling isn't accurate
        ; Use window spy to correct, if your pc doesn't match these, as
        ; detailed at the top
        fSlowClick(875, 313) ; Open leafsing harbor to allow max level reset
        Sleep 100
        fSlowClick(1046, 419) ; Max Tower level
        Sleep 100
        fSlowClick(875, 388) ; Select Tower area
        Sleep 100
        OpenGemShop()
        Sleep 150
        fSlowClick(904, 571) ; Navigate to Time Travel tab
        Sleep 100
        fSlowClick(894, 312) ; Click 72h warp
        Sleep 100
        OpenAreas() ; Doing this last as we open this to scroll to start
        Sleep 150
    }

}

fGemFarmSuitcase() {
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    OpenPets()
    ; Opens or closes another screen so that when areas is opened it doesn't
    ; close
    Sleep 150
    OpenAreas()
    Sleep 150
    fSlowClick(317, 574)
    ; Open leaf galaxy tab incase wrong tab and to reset scroll
    Sleep 150
    MouseMove(WinRelPosW(875), WinRelPosH(313)) ; Move mouse for scrolling
    ResetAreaScroll()
    ; Move the screen up to reset the scroll incase its been changed outside
    ; the script
    AreaScrollAmount(22) ; Scroll down for the zones
    fSlowClick(875, 298) ; Set zone to golden suitcase territory

    OpenPets()
    Sleep 150
    RemoveBearo() ; Removes bearo from your pet team if its active
    Sleep 200

    OpenTrades()
    Sleep 150
    ResetTradeScroll()
    FillTradeSlots() ; Leaves the first slot free to use suitcase on

    Loop {
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
        ; Update window size

        if !WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution") {
                break ; Kill the loop if the window closes
        }
        try {
            ; PixelSearch resolution independant function based on higher
            ; resolution to increase accuracy, using lower res resulted in
            ; drift when scaled up.
            colour := PixelGetColor(WinRelPosLargeW(1252), WinRelPosLargeH(397))
            If (colour = "0xFF0044") {
                Sleep 71
                colour := PixelGetColor(WinRelPosLargeW(1252),
                    WinRelPosLargeH(397))
                If (colour = "0xFF0044") {
                    ; Double check to try and avoid false usage
                    TriggerSuitcase()
                    Sleep 71
                }
            }
        } catch as exc {
            MsgBox "Could not conduct the search due to the following error:`n" exc.Message
        }
        RefreshTrades()
        Sleep 71
    }
}

ResetTradeScroll() {
    loopcount1 := 6
    ToolTip("Resetting scroll position, will take a moment", W / 2 - 120, H / 2)
    while loopcount1 > 0 {
        if !WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution") {
                break ; Kill the loop if the window closes
        }
        ControlClick(, "Leaf Blower Revolution", , "WheelUp")
        Sleep 102
        loopcount1 := loopcount1 - 1
    }
    SetTimer(ToolTip, -1)
}

RemoveBearo() {
    OutX := 0
    OutY := 0
    try {
        X1 := WinRelPosLargeW(675)
        Y1 := 1070 / 1369 * H
        X2 := WinRelPosLargeW(1494)
        Y2 := 1138 / 1369 * H
        found := PixelSearch(&OutX, &OutY, X1, Y1, X2, Y2, "0x64747A", 0)
        If (found and OutX != 0) {
            ToolTip("Bearo found and removed", OutX, OutY)
            SetTimer(Tooltip, -100)
            Sleep 72
            fCustomClick(OutX, OutY)
        }

    } catch as exc {
        MsgBox "Could not conduct the search due to the following error:`n" exc.Message
        return
    }
}

FillTradeSlots() {
    i := 24
    ToolTip("Filling trade slots", W / 2 - 70, H / 2)
    While i > 0 {
        fSlowClick(1040, 230)
        Sleep 50
        RefreshTrades()
        Sleep 50
        i := i - 1
    }
    SetTimer(ToolTip, -1)
}

fBorbVentureJuiceFarm() {

    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    OpenPets() ; Opens or closes another screen so that when areas is opened it
    ; doesn't close
    Sleep 100
    OpenBorbVentures() ; Open BV
    Sleep 100
    fSlowClick(211, 573) ; Select tab
    loop {

        if (!WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution")) {
                break ; Kill if no game
        }

        ; Check first four slots for item
        Slot1Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(431),
            WinRelPosLargeW(1353), WinRelPosLargeH(490))
        Slot2Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(620),
            WinRelPosLargeW(1353), WinRelPosLargeH(675))
        Slot3Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(811),
            WinRelPosLargeW(1353), WinRelPosLargeH(866))
        Slot4Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(1028),
            WinRelPosLargeW(1353), WinRelPosLargeH(1076))

        ;Charslot 1 is at X 1600
        ;Charslot 2 is at X 1717
        ;Start/Finish is at X 1911
        ;Cancel is at X 2120
        ;BorbJuice first detect point is at X 1326
        SlotsYArray := [Slot1Y, Slot2Y, Slot3Y, Slot4Y]

        activeSlots := 0
        for SlotY in SlotsYArray {
            if (SlotY != 0 && BVIsSlotActive(SlotY)) {
                ; If slots cancel button exists, assume active. This lets us
                ; pause refreshing until something new happens to avoid wastage
                activeSlots := activeSlots + 1
            }
        }

        for SlotY in SlotsYArray {
            while (BVIsSlotFinished(SlotY)) {
                if (SlotY != 0 && BVIsSlotFinished(SlotY) &&
                    WinActive("Leaf Blower Revolution")) {
                        ; If slots finished, its Y is used to align click and spam
                        Sleep 100
                        fCustomClick(WinRelPosLargeW(1911), SlotY, 100)
                        Sleep 100
                }
            }
        }

        ; Scan again but reverse order so that we can start them bottom to top
        ; Accounts for changes since 'finishing'

        Slot1Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(431), WinRelPosLargeW(1353), WinRelPosLargeH(490))
        Slot2Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(620), WinRelPosLargeW(1353), WinRelPosLargeH(675))
        Slot3Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(811), WinRelPosLargeW(1353), WinRelPosLargeH(866))
        Slot4Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(1028), WinRelPosLargeW(1353), WinRelPosLargeH(1076))

        SlotsYArray := [Slot4Y, Slot3Y, Slot2Y, Slot1Y]

        for SlotY in SlotsYArray {
            if (SlotY != 0 && BVIsSlotStartInactive(SlotY) &&
                WinActive("Leaf Blower Revolution")) {
                    ; Don't try to start more if we're full even if another is
                    ; detected
                    if ((!HaveBorbDLC and activeSlots != 2) ||
                        (HaveBorbDLC and activeSlots != 4)) {
                            ; If slots inactive, its ready to start,
                            ; use its y to align clicks
                            Sleep 100
                            fCustomClick(WinRelPosLargeW(1600), SlotY, 100)
                            ; Click team slot 1
                            Sleep 100
                            fCustomClick(WinRelPosLargeW(1717), SlotY, 100)
                            ; Click team slot 2
                            Sleep 100
                            fCustomClick(WinRelPosLargeW(1911), SlotY, 100)
                            ; Click Start
                            Sleep 100
                    }
            }
        }
        if (activeSlots >= 1) {
            ToolTip("Found " . activeSlots . " active slots", W / 2, H / 2, 1)
            SetTimer(ToolTip, -750)
        }
        if (!HaveBorbDLC and activeSlots != 2) {
            ; If we have not filled all available slots refresh
            RefreshTrades()
        }
        if (HaveBorbDLC and activeSlots != 4) {
            RefreshTrades()
        }
    }
}

BVScanSlotItem(X1, Y1, X2, Y2) {
    try {
        ; This is the check for the borbjuice pink colour, if you want to scan
        ; for something else. Change this colour to something unique to that
        ; type, or add more checks if you want several.

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


        found := PixelSearch(&OutX, &OutY, X1, Y1, X2, Y2, "0x01D814", 0)
        ; Nature gem
        If (found and OutX != 0) {
            return OutY ; Found item row
        }
        ;found := PixelSearch(&OutX, &OutY, X1, Y1, X2, Y2, "0x0F2A1D", 0)
        ; Nature time sphere
        ;If (found and OutX != 0) {
        ;    return OutY ; Found item row
        ;}
        found := PixelSearch(&OutX, &OutY, X1, Y1, X2, Y2, "0x0E44BE", 0)
        ; Power Dice Points (blue)
        If (found and OutX != 0) {
            return OutY ; Found item row
        }
        found := PixelSearch(&OutX, &OutY, X1, Y1, X2, Y2, "0xC9C9C9", 0)
        ; Dice Points (white)
        If (found and OutX != 0) {
            return OutY ; Found item row
        }
        found := PixelSearch(&OutX, &OutY, X1, Y1, X2, Y2, "0xF91FF6", 0)
        ; Borb ascention juice (purple default)
        If (found and OutX != 0) {
            return OutY ; Found item row
        }
    } catch as exc {
        MsgBox "Could not conduct the search due to the following error:`n" exc.Message
    }
    return 0
}

BVIsSlotFinished(Y) {
    ;Start/Finish is at X 1911
    try {
        colour := PixelGetColor(WinRelPosLargeW(1911), Y)
        If (colour = "0xFFF1D2") {
            ;ToolTip("Slot found Finished button", WinRelPosLargeW(1911), Y, 1)
            ;SetTimer(ToolTip, -500)
            return true
        }
    } catch as exc {
        MsgBox "Could not conduct the search due to the following error:`n" exc.Message
    }
    return false
}

BVIsSlotStartInactive(Y) {
    ; Start/finish left side, blank background X 1864
    try {
        If (PixelGetColor(WinRelPosLargeW(1864), Y) = "0xC8BDA5") {
            ; Check point to the left of the button to make sure its blank
            ;ToolTip("Slot found Inactive button", WinRelPosLargeW(1864), Y, 1)
            ;SetTimer(ToolTip, -500)
            return true
        }
    } catch as exc {
        MsgBox "Could not conduct the search due to the following error:`n" exc.Message
    }
    return false
}

BVIsSlotActive(Y) {
    ; Position less important as just checking if not background X2120
    try {
        targetColour := PixelGetColor(WinRelPosLargeW(2120), Y)
        If (targetColour != "0x97714A") {
            ; Check cancel button for non background colour
            return true
        }
    } catch as exc {
        MsgBox "Could not conduct the search due to the following error:`n" exc.Message
    }
    return false
}

fClawFarm() {
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    OpenPets() ; Opens or closes another screen so that when areas
    ; is opened it doesn't close
    Sleep 50
    OpenAreas() ; Open areas
    Sleep 100
    fSlowClick(315, 574) ; Click the right tab just incase
    Sleep 100
    ResetAreaScroll() ; Reset incase
    Sleep 100
    AreaScrollAmount(43) ; Scroll down
    Sleep 100
    fSlowClick(877, 359) ; Open pub area
    Sleep 100
    fSlowClick(50, 252) ; Close the area screen
    Sleep 50
    fSlowClick(276, 252) ; Open claw machine
    Sleep 50
    RefreshTrades()
    Sleep 150
    loop {

        if (!WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution")) {
                return ; Kill early if no game
        }
        PumpkinX := ClawGetPumpkinLocation()
        HookX := ClawGetHookLocation()
        if (PumpkinX = 0) {
            Sleep 150
            RefreshTrades()
            Sleep 150
        }

        if (PumpkinX + WinRelPosLargeW(15) >= HookX && PumpkinX -
            WinRelPosLargeW(15) <= HookX) {
                RefreshTrades()
                ToolTip("Trying to catch HookX " . HookX . " PumpX " . PumpkinX,
                    PumpkinX - WinRelPosLargeW(15),
                    WinRelPosLargeH(970), 5)
                SetTimer(ToolTip, -200)
        }
        Sleep 8.35
    }

}

ClawGetPumpkinLocation() {
    try {
        ; Pumpkin stem colour 0x6CD820
        ; 406 672 top left pickup area 1440 res
        ; 2070 920 bottom right  pickup area
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(406), WinRelPosLargeH(672),
            WinRelPosLargeW(2070), WinRelPosLargeH(970), "0x6CD820", 0)
        ; Pumpkin stem pixel search
        If (found and OutX != 0) {
            return OutX ; Found colour
        }
    } catch as exc {
        MsgBox "Could not conduct the search due to the following error:`n" exc.Message
    }
    return 0
}

ClawGetHookLocation() {
    ;Hook colour 0x8B9BB4
    ;296 346 top left Hook area 1440
    ;2042 400 bottom right Hook area 1440
    try {
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(296), WinRelPosLargeH(346),
            WinRelPosLargeW(2042), WinRelPosLargeH(400), "0x8B9BB4", 0)
        ; Hook pixel search
        If (found and OutX != 0) {
            return OutX ; Found colour
        }
    } catch as exc {
        MsgBox "Could not conduct the search due to the following error:`n" exc.Message
    }
    return 0
}

fFarmGFSS() {

    ResettingGF := false
    loop {
        if (!WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution")) {
                break ; Kill early if no game
        }
        GFKills := 0
        SSKills := 0
        IsInGF := true
        IsInSS := false
        GoToGF()
        sleep 100
        TimerLastCheckStatus := IsBossTimerActive()

        while (SSToKillPerCycle != SSKills) {
            if (!WinExist("Leaf Blower Revolution") ||
                !WinActive("Leaf Blower Revolution")) {
                    break ; Kill early if no game
            }
            while (GFToKillPerCycle != GFKills) {
                if (!WinExist("Leaf Blower Revolution") ||
                    !WinActive("Leaf Blower Revolution")) {
                        break ; Kill early if no game
                }
                if (!IsInGF) {
                    GoToGF()
                    IsInGF := true
                    IsInSS := false
                }
                TimerCurrentState := IsBossTimerActive()
                ; if state of timer has changed and is now off, we killed
                if (TimerLastCheckStatus != TimerCurrentState &&
                    !TimerCurrentState) {
                        GFKills := GFKills + 1
                }
                ; if we just started and there is a timer or looped and theres
                ; still a timer, we need to use a violin
                if (IsBossTimerActive()) {
                    TriggerViolin()
                    sleep 71
                }
                ; If boss killed us at gf assume we're weak and reset gf
                ; If user set gf kills too high it'll hit this
                if (IsAreaResetToGarden()) {
                    ToolTip("Killed by boss, resetting", W / 2, H / 2 + 400, 6)
                    SetTimer(ToolTip, -200)
                    ResetGF()
                    ResettingGF := true
                    break
                }
                ToolTip(" GF Kills " . GFKills . " SS Kills " . SSKills,
                    W / 2, H / 2 + 300, 1)
                SetTimer(ToolTip, -200)
                TimerLastCheckStatus := TimerCurrentState
            }
            if (!IsInSS) {
                GoToSS()
                IsInSS := true
                IsInGF := false
            }
            TimerCurrentState := IsBossTimerActive()
            ; if state of timer has changed and is now off, we killed
            if (TimerLastCheckStatus != TimerCurrentState &&
                !TimerCurrentState) {
                    SSKills := SSKills + 1
                    GFKills := 0
            }
            ; if we just started and there is a timer or looped and theres
            ; still a timer, we need to use a violin
            if (IsBossTimerActive()) {
                TriggerViolin()
                sleep 71
            }
            ; if boss killed us exit this loop, then let the master loop
            ; reset
            if (IsAreaResetToGarden() && !ResettingGF) {
                ToolTip("Killed by boss, resetting", W / 2, H / 2 + 400, 6)
                SetTimer(ToolTip, -200)
                break
            }
            ToolTip(" GF Kills " . GFKills . " SS Kills " . SSKills,
                W / 2, H / 2 + 300, 1)
            SetTimer(ToolTip, -200)
            TimerLastCheckStatus := TimerCurrentState

        }
        ; if we're done looping or got killed reset ss
        if (!ResettingGF) {
            ResetSS()
        }
        ResettingGF := false
    }
}

GoToGF() {
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    OpenPets() ; Opens or closes another screen so that when areas
    ; is opened it doesn't close
    Sleep 150
    OpenAreas() ; Open areas
    Sleep 150
    fSlowClick(317, 574, 100)
    ; Open leaf galaxy tab incase wrong tab and to reset scroll
    Sleep 150
    fSlowClick(686, 574, 100)
    ; Open Fire Fields tab
    Sleep 200
    fSlowClick(877, 411, 100)
    ; Open Flame Brazier (GF zone)
}

GoToSS() {
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    OpenPets() ; Opens or closes another screen so that when areas
    ; is opened it doesn't close
    Sleep 150
    OpenAreas() ; Open areas
    Sleep 150
    fSlowClick(317, 574, 100)
    ; Open leaf galaxy tab incase wrong tab and to reset scroll
    Sleep 150
    fSlowClick(686, 574, 100)
    ; Open Fire Fields tab
    Sleep 200
    fSlowClick(877, 516, 100)
    ; Open Flame Universe (SS zone)
}

ResetSS() {
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    OpenPets() ; Opens or closes another screen so that when areas
    ; is opened it doesn't close
    Sleep 150
    OpenAreas() ; Open areas
    Sleep 150
    fSlowClick(317, 574)
    ; Open leaf galaxy tab incase wrong tab and to reset scroll
    Sleep 150
    fSlowClick(686, 574)
    ; Open Fire Fields tab
    Sleep 150
    fSlowClick(880, 159)
    ; Go to shadow cavern
    Sleep 150
    ClosePanel()
    ; Close the panel to see borb
    Sleep 150
    fSlowClick(880, 180)
    ; Go to Borbiana Jones screen
    Sleep 150
    fSlowClick(517, 245)
    ; Reset SpectralSeeker
}

ResetGF() {
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    OpenPets() ; Opens or closes another screen so that when areas
    ; is opened it doesn't close
    Sleep 150
    OpenAreas() ; Open areas
    Sleep 150
    fSlowClick(317, 574)
    ; Open leaf galaxy tab incase wrong tab and to reset scroll
    Sleep 150
    fSlowClick(686, 574)
    ; Open Fire Fields tab
    Sleep 150
    fSlowClick(880, 159)
    ; Go to shadow cavern
    Sleep 150
    ClosePanel()
    ; Go to shadow cavern
    Sleep 150
    fSlowClick(880, 180)
    ; Go to Borbiana Jones screen
    Sleep 150
    fSlowClick(280, 245)
    ; Reset Green Flame
}

IsBossTimerActive() {
    ; if white is in this area, timer active (hopefully no zones have white bg
    ; and text is pure white)
    ; 1240 5
    ; 1280 40
    try {
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(1240), WinRelPosLargeH(5),
            WinRelPosLargeW(1280), WinRelPosLargeH(40), "0xFFFFFF", 0)
        ; Timer pixel search
        If (found and OutX != 0) {
            return true ; Found colour
        }
    } catch as exc {
        MsgBox "Could not conduct the search due to the following error:`n" exc.Message
    }
    return false
}

IsAreaResetToGarden() {
    try {
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(1240), WinRelPosLargeH(5),
            WinRelPosLargeW(1280), WinRelPosLargeH(40), "0x4A9754", 0)
        ; Timer pixel search
        If (found and OutX != 0) {
            return true ; Found colour
        }
    } catch as exc {
        MsgBox "Could not conduct the search due to the following error:`n" exc.Message
    }
    return false
}

fFarmNormalBoss() {
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    Killcount := 0
    TimerLastCheckStatus := IsBossTimerActive()
    loop {
        if (!WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution")) {
                break ; Kill early if no game
        }
        TimerCurrentState := IsBossTimerActive()
        ; if state of timer has changed and is now off, we killed
        if (TimerLastCheckStatus != TimerCurrentState &&
            !TimerCurrentState) {
                Killcount := Killcount + 1
        }
        ; if we just started and there is a timer or looped and theres
        ; still a timer, we need to use a violin
        if (IsBossTimerActive()) {
            TriggerViolin()
            sleep 71
        }
        ; If boss killed us at gf assume we're weak and reset gf
        ; If user set gf kills too high it'll hit this
        if (IsAreaResetToGarden()) {
            ToolTip("Killed by boss, exiting", W / 2, H / 2 + WinRelPosLargeH(50), 6)
            Sleep 30000
            break
        }
        ToolTip("Kills: " . Killcount,
            W / 2, H / 2 +  + WinRelPosLargeH(20), 1)
        SetTimer(ToolTip, -200)
        TimerLastCheckStatus := TimerCurrentState
    }
}

fFarmNatureBoss() {
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    ; Check zone is available

    GoToNatureBoss()
    sleep 100
    ClosePanel()
    sleep 100
    Killcount := 0
    LastAliveState := IsNatureBossAlive()

    IsInFF := false
    loop {
        if (!WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution")) {
                break ; Kill early if no game
        }
        CurrentAliveState := IsNatureBossAlive()

        ; if state of timer has changed and is now off, we killed
        if (LastAliveState != CurrentAliveState &&
            !CurrentAliveState) {
                Killcount := Killcount + 1
        }
        ; if we just started and there is a timer or looped and theres
        ; still a timer, we need to use a violin
        if (!CurrentAliveState && IsBossTimerActive()) {
            if (!IsInFF) {
                ToolTip("Going to ff", W / 2, H / 2, 2)
                SetTimer(ToolTip, -250)
                GoToFarmField()
                IsInFF := true
            }
            loop {
                if (!WinExist("Leaf Blower Revolution") ||
                    !WinActive("Leaf Blower Revolution")) {
                        break ; Kill early if no game
                }
                if (IsNatureBossTimerActive()) {
                    ToolTip("Using violins", W / 2, H / 2, 4)
                    SetTimer(ToolTip, -250)
                    TriggerViolin()
                    sleep 71
                } else {
                    ToolTip("Returning to boss", W / 2, H / 2, 2)
                    SetTimer(ToolTip, -250)
                    ; Timers reset send user back
                    GoToNatureBoss()
                    IsInFF := false
                    sleep 100
                    ClosePanel()
                    sleep 1000
                    ; boss doesn't appear instantly so we need a manual delay
                    break
                }
            }
        }
        ; If boss killed us not much we can do, on user to address
        if (IsAreaResetToGarden()) {
            ToolTip("Killed by boss, exiting", W / 2, H / 2, 1)
            SetTimer(ToolTip, -3000)
            Sleep 3000
            break
        }
        ToolTip("Kills: " . Killcount, W / 2, H / 2 + WinRelPosLargeH(50), 10)
        SetTimer(ToolTip, -200)
        LastAliveState := CurrentAliveState
    }
}

IsNatureBossAlive() {
    ;2ce8f5
    ; 852 250 (1440)
    try {
        found := PixelGetColor(WinRelPosLargeW(852), WinRelPosLargeH(250))
        ; Timer pixel search
        If (found = "0x2CE8F5") {
            return true ; Found colour
        }
        if (IsNatureBossTimerActive()) {
            return false
        }
    } catch as exc {
        MsgBox "Could not conduct the search due to the following error:`n" exc.Message
    }
    return false
}

IsNatureBossTimerActive() {
    ; if white is in this area, timer active
    ; ONLY WORKS ON THE AREA SCREEN IN THE EVENT TAB

    ; 1883 1004
    ; 2189 1033
    try {
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(1883), WinRelPosLargeH(1004),
            WinRelPosLargeW(2189), WinRelPosLargeH(1033), "0xFFFFFF", 0)
        ; Timer pixel search
        If (found and OutX != 0) {
            return true ; Found colour
        }
    } catch as exc {
        MsgBox "Could not conduct the search due to the following error:`n" exc.Message
    }
    return false
}

GoToNatureBoss() {
    OpenEventsAreasPanel()
    fSlowClick(875, 470) ; Open nature boss area
}

GoToFarmField() {
    OpenEventsAreasPanel()
    fSlowClick(875, 260) ; Open farm field
}

OpenEventsAreasPanel() {
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    OpenPets() ; Opens or closes another screen so that when areas
    ; is opened it doesn't close
    Sleep 150
    OpenAreas() ; Open areas
    Sleep 150
    fSlowClick(1049, 572) ; Click the event tab
    Sleep 150
    ControlClick(, "Leaf Blower Revolution", , "WheelUp") ; Align the page
    Sleep 150
}

ResetAreaScroll() {
    fSlowClick(200, 574) ; Click Favourites
    Sleep 50
    fSlowClick(315, 574) ; Click Back to default page to reset the scroll
    Sleep 50
}

AreaScrollAmount(amount := 1) {
    ToolTip("Scrolling to position, will take a moment", W / 2 - 100, H / 2)
    while amount > 0 {
        if !WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution") {
                break ; Kill the loop if the window closes
        }
        ControlClick(, "Leaf Blower Revolution", , "WheelDown")
        Sleep 102
        amount := amount - 1
    }
    SetTimer(ToolTip, -1)
}