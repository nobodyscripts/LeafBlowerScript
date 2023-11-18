#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 4

; ------------------- Readme -------------------
/*
Same key toggles the feature off, if this toggle fails, F1 or F2 to abort.

Sleep times might need adjusting for your pc, so increase them as needed if things are skipping.
Increments of 17 should add another frame (at 60fps).
Ingame Keybinds section below the script triggers can be adjusted either to what you use, or
change them ingame to match.

My window size (1440p snapped to corner) 1278*664 client size is what the locations are based on
those are adapted to your window size, so set your window 'client' to this size for changes or if
things don't work. The image search used for gems and scrolling used for tower may have issues at 
other resolutions so use F12 and reload the script if you have trouble.

F1 Closes the script entirely

F2 Reloads the script, deactivating anything that is active but keeping it loaded

F3 Open packs, open the card packs screen, customize the amount to open in the function below

F4 Gem suitcase farming - Fill up your trades with active/completed trades except for one slot,
   sit in the desert zone for more suitcases, remove bearo from your team, turn off auto refresh
   and hit F4 to farm
   Untested at 4k resolutions for accuracy

F5 (Unstable) 72h tower boost loop - Uses (doesn't buy) boosts, swaps levels to raise max floor
   Does equip a tower gear equipment loadout, so you will need to swap back afterwards

F6 A 16.7ms autoclicker - should work outside the game too so be careful

F12 Resizes the window to 1278*664 client area (on windows 11, may need tweaking if not)
    This is intended to be optional, but you can avoid remaking bitmaps and coords if things
    break for you.
*/
global X, Y, W, H
WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

; ------------------- Script Triggers -------------------

*F1:: { ;Wildcard shortcut * to allow functions to work while looping with modifiers held
    ResetModifierKeys() ; Cleanup incase needed
    ExitApp
}

*F2:: {
    ResetModifierKeys() ; Cleanup incase needed
    Reload
}

*F3:: { ; Open cards clicker
    ResetModifierKeys() ; Cleanup incase needed
    Static on := False
    If on := !on {
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

*F5:: { ; Gem farm using suitcase
    ResetModifierKeys() ; Cleanup incase needed
    Static on2 := False
    If on2 := !on2 {
        fTimeWarpAndRaiseTower()
    } Else Reload
}

*F6:: { ; Autoclicker non game specific
    Static on2 := False
    If on2 := !on2 {
        Loop {
            MouseClick "left", , , , , "D"
            Sleep 16.7 ; Must be higher than 16.67 which is a single frame of 60fps,
            MouseClick "left", , , , , "U"
            Sleep 16.7
        }
    } Else Reload
}

*F12:: {
    WinMove(,, 1294, 703, "Leaf Blower Revolution") ; Should size to windows 11 borders
}

; ------------------- Keybinds -------------------

; Customise these to match your keybinds or change to these ingame

OpenAreas() {
    ControlSend "{v}", , "Leaf Blower Revolution"
}

OpenGemShop() {
    ControlSend "{.}", , "Leaf Blower Revolution" ; Period/full stop
}

TriggerSuitcase() {
    ControlSend "{,}", , "Leaf Blower Revolution"
}

RefreshTrades() {
    ControlSend "{Space}", , "Leaf Blower Revolution"
}

EquipTowerGearLoadout() {
    ControlSend("{Numpad3}", , "Leaf Blower Revolution") ; Used
}

/* These are not currently used so you can ignore the keybinds below
OpenTools() {
    ControlSend "{1}", , "Leaf Blower Revolution" ; Inactive, You can ignore the inactive ones
}

ClosePanel() {
    ControlSend "{Esc}", , "Leaf Blower Revolution" ; Inactive
}

TriggerWind() {
    ControlSend "{[}", , "Leaf Blower Revolution" ; Inactive
}

TriggerViolin() {
    ControlSend "{#}", , "Leaf Blower Revolution" ; Inactive
}

TriggerGravity() {
    ControlSend "{]}", , "Leaf Blower Revolution" ; Inactive
}

TriggerWobblyWings() {
    ControlSend "{#}", , "Leaf Blower Revolution" ; Inactive
}

EquipBrewGearLoadout() {
    ControlSend("{Numpad1}", , "Leaf Blower Revolution") ; Inactive
}

EquipDamageGearLoadout() {
    ControlSend("{Numpad2}", , "Leaf Blower Revolution") ; Inactive
}

EquipBlowingGearLoadout() {
    ControlSend("{Numpad4}", , "Leaf Blower Revolution") ; Inactive
}

EquipSwordGearLoadout() {
    ControlSend("{Numpad5}", , "Leaf Blower Revolution") ; Inactive
}

EquipPyramidGearLoadout() {
    ControlSend("{Numpad6}", , "Leaf Blower Revolution") ; Inactive
}

EquipSevenGearLoadout() {
    ControlSend("{Numpad7}", , "Leaf Blower Revolution") ; Inactive
}

EquipEightGearLoadout() {
    ControlSend("{Numpad8}", , "Leaf Blower Revolution") ; Inactive
}
*/

; ------------------- Functions -------------------

; Convert positions from 1278*664 resolution to current resolution
WinRelPosH(PosH)
{
    return PosH / 664 * H
}

WinRelPosW(PosW)
{
    return PosW / 1278 * W
}

; Default clicking function, uses relative locations
fSlowClick(x, y)
{
    MouseClick "left", WinRelPosW(x), WinRelPosH(y), , , "D"
    Sleep 34 ; Must be higher than 16.67 which is a single frame of 60fps,
             ; set to slightly higher than 2 frames for safety
             ; If clicking isn't reliable increase this sleep value
    MouseClick "left", WinRelPosW(x), WinRelPosH(y), , , "U"
}

; Custom clicking function, swap the above to this if you want static coords
; that are more easily changed
fCustomClick(x, y) 
{
    MouseClick "left", x, y, , , "D"
    Sleep 34 
    /* Must be higher than 16.67 which is a single frame of 60fps,
       set to slightly higher than 2 frames for safety
       If clicking isn't reliable increase this sleep value */
    MouseClick "left", x, y, , , "U"
}

ResetModifierKeys() {
    ; Cleanup incase still held
    if GetKeyState("Control")
        ControlSend "{Control up}", , "Leaf Blower Revolution"
    if GetKeyState("Alt")
        ControlSend "{Alt up}", , "Leaf Blower Revolution"
    if GetKeyState("Shift")
        ControlSend "{Shift up}", , "Leaf Blower Revolution"
}

; ------------------- Main actions -------------------

fOpenCardLoop()
{
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check

    loop {
        ; Check if lost focus, close or crash and break if so
        if !WinExist("Leaf Blower Revolution") or !WinActive("Leaf Blower Revolution") {
            break
        }
        WinActivate("Leaf Blower Revolution") ; Use the window found by WinExist.
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution" ; Update window size

        ControlSend "{Control down}", , "Leaf Blower Revolution"
        ControlSend "{Alt down}", , "Leaf Blower Revolution" ; Add ctrl/alt/shift as required for amount
        ;ControlSend "{Shift down}",, "Leaf Blower Revolution" ; Commented out, remove the semi colon at the start for 25000
        fSlowClick 315, 400 ; Common pack open
        Sleep 60
        fSlowClick 597, 400 ; Rare pack open
        Sleep 60
        fSlowClick 880, 400 ; Legendary pack open
        ResetModifierKeys() ; Cleanup ctrl+shift+alt modifiers
        Sleep 200
    }
    ResetModifierKeys() ; Cleanup incase of broken loop
}

; TODO: Work out how to control the scrolling or use pixel detection to adjust for the inaccuracies
; without being resolution dependant
fTimeWarpAndRaiseTower() {
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    OpenAreas()
    Sleep 100
    fSlowClick(317, 574) ; Open leaf galaxy tab incase wrong tab and to reset scroll
    Sleep 100
    MouseMove(W / 2, H / 2) ; Move mouse for scrolling
    loopcount1 := 50
    while loopcount1 > 0 {
        ControlClick(, "Leaf Blower Revolution", , "WheelUp")
        Sleep 51
        ; Reset area view scroll to top
        loopcount1 := loopcount1 - 1
    }
    loopcount2 := 17
    while loopcount2 > 0 {
        ControlClick(, "Leaf Blower Revolution", , "WheelDown")
        Sleep 51
        ; Scroll down to the tower, game stores this so only need to loop once
        loopcount2 := loopcount2 - 1
    }
    EquipTowerGearLoadout() ; Equip Tower set

    Loop {
        ; Check if: lost focus, close or crash and break if so
        if !WinExist("Leaf Blower Revolution") or !WinActive("Leaf Blower Revolution") {
            break
        }
        WinActivate("Leaf Blower Revolution") ; Use the window found by WinExist.
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution" ; Update window size

        ; These next three clicks are unstable, the scrolling isn't accurate
        ; Use window spy to correct, if your pc doesn't match these, as detailed at the top
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

; TODO: Automate setup, work out why refresh works while not focused but suitcase doesn't so alt tab is possible
; Also find a way to resolution independantly scan for the gems
fGemFarmSuitcase() {
    ;Open area menu (V)
    ;Set zone to golden suitcase territory
    ;Open trades
    ;loop
    ;Refresh trades (space)
    ;If slot 2 isn't active or collect
    ;Start every inactive trade viewable except first > loop
    Loop {
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution" ; Update window size
        ;OutputVarX := 0
        ;OutputVarY := 0
        ;X1 := Round(WinRelPosW(602)) ; First slot icon, top left
        ;Y1 := Round(WinRelPosH(176))
        ;X2 := Round(WinRelPosW(640)) ; First slot icon, bottom right
        ;Y2 := Round(WinRelPosH(203))
        if !WinExist("Leaf Blower Revolution") or !WinActive("Leaf Blower Revolution") {
            break ; Kill the loop if the window closes
        }
        try {
            ; PixelSearch resolution independant function based on higher resolution to increase accuracy, using lower res resulted
            ; in drift when scaled up. 4k might be ok? Cannot test
            colour := PixelGetColor(1252 / 2560 * W, 397 / 1369 * H)
            If (colour = "0xFF0044") {
                TriggerSuitcase()
                Sleep 50
            }
            ;If (ImageSearch(&OutputVarX, &OutputVarY, X1, Y1, X2, Y2, "Gem.bmp")) {
                ;ToolTip("Gem Found", W/2, H/2+80, 3)
                ;TriggerSuitcase()
                ;Sleep 500
            ;}
            RefreshTrades()
        } catch as exc {
            MsgBox "Could not conduct the search due to the following error:`n" exc.Message
        }
        Sleep 50
    }
}

; Plans for future
fBorbVentureJuiceFarm() {
    ;Open BV
    ;Select tab
    ;Check first four slots
    ;for each found
    ;If not active
    ;click team slot 1
    ;click team slot 2
    ;click start
    ;If active and finished
    ;click finish
    ;wait a short time to not lag with infinite looping
    ;Refresh list
}

fGemsFarmNormal() {
    ;If game isn't running exit
    ;If game running focus
    ;winH = Get window height
    ;winW = Get window width

    ;While in trading window
    ;stop if safety check fails
    ;Check if in trading window
    ;Scan trading and find all gems, cancel, start and boost buttons
    ;plot to rows and totals

    ;For each row that has no gem and a cancel, click cancel
    ;For each row that has gem and boost or start, click start button > boost
    ;fSlowClick(1039, 194)
    ;fSlowClick(805, 194)
    ;If any row has collect button, click collect all
    ;If rows are not full of active gems, or collect all has been clicked:
    ;refresh
    ;pause for a few hundred ms to avoid infinite looping
    ;loop

    ;Safety check
    ;does window exist
    ;is window focused
    ;is window resized
    ;is abort held
    ;is error
}

fFarmNatureBoss() {
    ;SetZone Nature boss
    ;Spam wind and gravity until timer
    ;SetZone Violin spawn
    ;Use 25+10+1 Violins to spawn boss
    ;loop if timer gone, else trickle use till timer
}

fClawFarm() {
    ;Search for the orange pumpkin
    ;Keep checking for claw vertically above
}

fFarmSS() {

}

fFarmGF() {

}

ResetSS() {

}
