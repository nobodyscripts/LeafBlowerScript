#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#Include Config.ahk
#Include Hotkeys.ahk

#Include Lib\Functions.ahk

#Include Lib\Borbventure.ahk
#Include Lib\Cards.ahk
#Include Lib\Claw.ahk
#Include Lib\FarmGFSS.ahk
#Include Lib\FarmNatureBoss.ahk
#Include Lib\FarmNormalBoss.ahk
#Include Lib\GemFarm.ahk
#Include Lib\TowerTimeWarp.ahk

global X, Y, W, H
if WinExist("Leaf Blower Revolution") {
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
}

; ------------------- Readme -------------------
/*
See Readme.md for readme
Run this file to load script
*/

; ------------------- Script Triggers -------------------

*F1:: {
    ; Wildcard shortcut * to allow functions to work while looping with
    ; modifiers held
    ExitApp
}

*F2:: {
    Reload
}

*F3:: { ; Open cards clicker
    global X, Y, W, H
    global HadToHideNotifs
    if WinExist("Leaf Blower Revolution") {
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
    } else {
        reload
    }
    ResetModifierKeys() ; Cleanup incase needed
    Static on3 := False
    If on3 := !on3 {
        fOpenCardLoop()
    } Else {
        if (HadToHideNotifs) {
            fSlowClick(32, 596, 17)
            HadToHideNotifs := false
        }
        ResetModifierKeys() ; Cleanup incase needed
        Reload
    }
}

*F4:: { ; Gem farm using suitcase
    global X, Y, W, H

    if WinExist("Leaf Blower Revolution") {
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
    } else {
        reload
    }
    ResetModifierKeys() ; Cleanup incase needed
    Static on4 := False
    If on4 := !on4 {
        fGemFarmSuitcase()
    } Else {
        EquipDefaultGearLoadout()
        ResetToPriorAutoRefresh()
        ResetToPriorDetailedMode()
        Reload
    }
}

*F5:: { ; Tower 72hr boost loop
    global X, Y, W, H
    if WinExist("Leaf Blower Revolution") {
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
    } else {
        reload
    }
    ResetModifierKeys() ; Cleanup incase needed
    Static on5 := False
    If on5 := !on5 {
        fTimeWarpAndRaiseTower()
    } Else {
        EquipDefaultGearLoadout()
        Reload
    }
}

*F6:: { ; Borb pink juice farm in borbventures
    global X, Y, W, H
    if WinExist("Leaf Blower Revolution") {
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
    } else {
        reload
    }
    ResetModifierKeys() ; Cleanup incase needed
    Static on6 := False
    If on6 := !on6 {
        fBorbVentureJuiceFarm()
    } Else Reload
}

*F7:: { ; Claw pumpkin farm
    global X, Y, W, H
    if WinExist("Leaf Blower Revolution") {
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
    } else {
        reload
    }
    ResetModifierKeys() ; Cleanup incase needed
    Static on7 := False
    If on7 := !on7 {
        fClawFarm()
    } Else Reload
}

*F8:: { ; Green Flame/Soulseeker farm
    global X, Y, W, H
    if WinExist("Leaf Blower Revolution") {
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
    } else {
        reload
    }
    ResetModifierKeys() ; Cleanup incase needed
    Static on8 := False
    If on8 := !on8 {
        fFarmGFSS()
    } Else Reload
}

global on9 := 0

*F9:: { ; Farm normal boss using violins
    global X, Y, W, H
    if WinExist("Leaf Blower Revolution") {
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
    } else {
        reload
    }
    global on9
    global HadToHideNotifsF9
    ResetModifierKeys() ; Cleanup incase needed
    switch on9 {
        case 1:
            on9 := 2 ; Brew and boss mode
            fFarmNormalBossAndBrew()
        case 2:
            on9 := 3 ; Boss mode with borbventures
            ;SetTimer(SpamBrewButtons, 0)
            fNormalBossFarmWithBorbs()
        case 3:
            on9 := 4 ; Boss mode with cards
            if (CardsBossFarmEnabled) {
                fNormalBossFarmWithCards()
            } else {
                on9 := 0 ; Disabled
                ClosePanel()
                Reload
            }
        case 4:
            on9 := 0 ; Disabled
            if (HadToHideNotifsF9) {
                fSlowClick(32, 596, 17)
                HadToHideNotifsF9 := false
            }
            ResetModifierKeys() ; Cleanup incase needed
            ClosePanel()
            Reload
        default:
            on9 := 1 ; Normal boss mode
            fFarmNormalBoss()
    }
}

*F10:: { ; Farm nature boss using violins
    global X, Y, W, H
    if WinExist("Leaf Blower Revolution") {
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
    } else {
        reload
    }
    ResetModifierKeys() ; Cleanup incase needed
    Static on10 := False
    If on10 := !on10 {
        fFarmNatureBoss()
    } Else Reload
}

*F11:: { ; Autoclicker non game specific
    global X, Y, W, H
    if WinExist("Leaf Blower Revolution") {
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
    }
    Static on11 := False
    If on11 := !on11 {
        Loop {
            MouseClick "left", , , , , "D"
            Sleep 16.7
            ; Must be higher than 16.67 which is a single frame of 60fps
            MouseClick "left", , , , , "U"
            Sleep 16.7
        }
    } Else {
        ;if(GetKeyState("MButton"))
        Reload
    }
}

*F12:: {
    global X, Y, W, H
    if WinExist("Leaf Blower Revolution") {
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
    } else {
        reload
    }
    WinMove(, , 1294, 703, "Leaf Blower Revolution")
    ; Changes size of client window for windows 11
    OpenPets()
    Sleep 50
    OpenAreas()
    Sleep 50
    CheckForTransparentPanels()
}