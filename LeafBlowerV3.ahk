#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#SingleInstance Force
#Include Config.ahk
#Include Hotkeys.ahk

#Include Lib\Functions.ahk
#Include Lib\Navigate.ahk
#Include Lib\SettingsCheck.ahk

#Include Lib\Borbventure.ahk
#Include Lib\Cards.ahk
#Include Lib\CardsBuy.ahk
#Include Lib\Claw.ahk
#Include Lib\FarmGFSS.ahk
#Include Lib\FarmNatureBoss.ahk
#Include Lib\FarmNormalBoss.ahk
#Include Lib\FarmQuarkBoss.ahk
#Include Lib\GemFarm.ahk
#Include Lib\TowerTimeWarp.ahk


Log("Script loaded")

global X, Y, W, H
if (WinExist("Leaf Blower Revolution")) {
    WinGetClientPos(&X, &Y, &W, &H, "Leaf Blower Revolution")
}
; ------------------- Readme -------------------
/*
See Readme.md for readme
Run this file to load script
*/

; ------------------- Script Triggers -------------------

#HotIf WinActive("Leaf Blower Revolution")
*F1:: {
    Log("F1: Activated")
    ; Wildcard shortcut * to allow functions to work while looping with
    ; modifiers held
    ResetModifierKeys() ; Cleanup incase needed
    ResetModifierKeys() ; Twice for good luck
    ExitApp()
}
*F2:: {
    IsDarkBackgroundOn()
    log("F2: Activated, reloading...")
    sleep(2)
    ResetModifierKeys() ; Cleanup incase needed
    ResetModifierKeys() ; Twice for good luck
    reload()
}

*F3:: { ; Open cards clicker
    global HadToHideNotifs
    Static on3 := False
    Log("F3: Activated")
    if (!InitGameWindow() && !on3) {
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    Sleep(34)
    ResetModifierKeys() ; Twice for good luck
    Sleep(34)
    If on3 := !on3 {
        if (!CheckGameSettingsCorrect()) {
            reload()
        }
        fOpenCardLoop()
    } Else {
        if (HadToHideNotifs) {
            fSlowClick(32, 596, 17)
            HadToHideNotifs := false
        }
        ResetModifierKeys() ; Cleanup incase needed
        Sleep(34)
        ResetModifierKeys() ; Twice for good luck
        Sleep(34)
        reload()
    }
    ResetModifierKeys() ; Cleanup incase needed
    Sleep(34)
    ResetModifierKeys() ; Twice for good luck
    Sleep(34)
}

*F4:: { ; Gem farm using suitcase
    Static on4 := False
    Log("F4: Activated")
    if (!InitGameWindow() && !on4) {
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    If on4 := !on4 {
        if (!CheckGameSettingsCorrect()) {
            reload()
        }
        fGemFarmSuitcase()
    } Else {
        Log("GemFarm: Equiping default loadout to reapply Bearo")
        EquipDefaultGearLoadout()
        ResetToPriorAutoRefresh()
        ResetToPriorDetailedMode()
        reload()
    }
}

*F5:: { ; Tower 72hr boost loop
    Static on5 := False
    Log("F5: Activated")
    if (!InitGameWindow() && !on5) {
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    If on5 := !on5 {
        if (!CheckGameSettingsCorrect()) {
            reload()
        }
        fTimeWarpAndRaiseTower()
    } Else {
        Log("TowerBoost: Equiping default loadout.")
        EquipDefaultGearLoadout()
        reload()
    }
}

*F6:: { ; Borb pink juice farm in borbventures
    Static on6 := False
    Log("F6: Activated")
    if (!InitGameWindow() && !on6) {
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    If on6 := !on6 {
        if (!CheckGameSettingsCorrect()) {
            reload()
        }
        fBorbVentureJuiceFarm()
    } Else reload()
}

*F7:: { ; Claw pumpkin farm
    Static on7 := False
    Log("F7: Activated")
    if (!InitGameWindow() && !on7) {
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    If on7 := !on7 {
        if (!CheckGameSettingsCorrect()) {
            reload()
        }
        fClawFarm()
    } Else reload()
}

*F8:: { ; Green Flame/Soulseeker farm
    Static on8 := False
    Log("F8: Activated")
    if (!InitGameWindow() && !on8) {
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    If on8 := !on8 {
        if (!CheckGameSettingsCorrect()) {
            reload()
        }
        fFarmGFSS()
    } Else reload()
}

global on9 := 0
global HadToHideNotifsF9 := false

*F9:: { ; Farm bosses using violins
    global on9, HadToHideNotifsF9
    Log("F9: Activated")
    if (!InitGameWindow() && !on9) {
        reload()
        return
    }
    if (!IsWindowActive()) {
        reload() ; Kill if no game
        return
    }
    Thread('Interrupt', 0)  ; Make all threads always-interruptible.
    ResetModifierKeys() ; Cleanup incase needed
    switch on9 {
        case 1:
            on9 := 2 ; Brew and boss mode
            Log("F9: Brew and Boss Activated")
            fFarmNormalBossAndBrew(on9)
        case 2:
            on9 := 3 ; Boss mode with borbventures
            Log("F9: Borbventures and Boss Activated")
            fNormalBossFarmWithBorbs(on9)
        case 3:
            on9 := 4 ; Boss mode with cards
            if (CardsBossFarmEnabled) {
                Log("F9: Cards and Boss Activated")
                fNormalBossFarmWithCards(on9)
            } else {
                on9 := 0 ; Disabled
                Log("F9: Resetting with cards disabled")
                ClosePanel()
                reload()
            }
        case 4:
            on9 := 0 ; Disabled
            if (HadToHideNotifsF9) {
                Log("F9: Reenabling notifications")
                fSlowClick(32, 596, 17)
                HadToHideNotifsF9 := false
            }
            Log("F9: Resetting")
            ResetModifierKeys() ; Cleanup incase needed
            ClosePanel()
            reload()
        default:
            on9 := 1 ; Normal boss mode
            if (!CheckGameSettingsCorrect()) {
                reload()
            }
            ClosePanel()
            Log("F9: Boss Farm Activated")
            fFarmNormalBoss(on9)
    }
}

*F10:: { ; Farm nature boss using violins
    Static on10 := False
    Log("F10: Activated")
    if (!InitGameWindow() && !on10) {
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    If (on10 := !on10) {
        if (!CheckGameSettingsCorrect()) {
            reload()
        }
        fFarmNatureBoss()
    } Else reload()
}

;Allow autoclicker outside game
#HotIf
*F11:: { ; Autoclicker non game specific
    global X, Y, W, H
    Static on11 := False
    Log("F11: Activated")
    if (WinExist("Leaf Blower Revolution")) {
        ; Slightly different as you can use this outside lbr
        WinGetClientPos(&X, &Y, &W, &H, "Leaf Blower Revolution")
    }
    If (on11 := !on11) {
        while (on11) {
            MouseClick("left", , , , , "D")
            Sleep(17)
            ; Must be higher than 16.67 which is a single frame of 60fps
            MouseClick("left", , , , , "U")
            Sleep(17)
        }
    } Else {
        ; Do one click when killing, so that we reset the click state
        MouseClick("left", , , , , "D")
        Sleep(17)
        MouseClick("left", , , , , "U")
        Sleep(17)
        reload()
    }
}

#HotIf WinActive("Leaf Blower Revolution")
*F12:: {
    global X, Y, W, H, DisableSettingsChecks
    Log("F12: Activated")
    if (MakeWindowActive()) {
        WinGetClientPos(&X, &Y, &W, &H, "Leaf Blower Revolution")
    } else {
        return
    }
    ; Changes size of client window for windows 11
    WinMove(, , 1294, 603, "Leaf Blower Revolution")
    WinWait("Leaf Blower Revolution")
    WinGetClientPos(&X, &Y, &W, &H, "Leaf Blower Revolution")
    Sleep(500)
    if (!CheckGameSettingsCorrectVerbose()) {
        ; If it fails checks we need to restore the size we needed and then return
        WinMove(, , 1294, 703, "Leaf Blower Revolution")
        return
    }
    WinMove(, , 1294, 703, "Leaf Blower Revolution")
    WinWait("Leaf Blower Revolution")
    WinGetClientPos(&X, &Y, &W, &H, "Leaf Blower Revolution")
    if (!DisableSettingsChecks) {
        if (IsFontCorrectCheck()) {
            ToolTip(, , , 1)
            ToolTip(, , , 2)
            ToolTip(, , , 3)
            ToolTip(, , , 4)
            ToolTip(, , , 5)
            ToolTip("Correct render mode, transparency, trees, dark background,`n"
                "smooth graphics and font settings found`n"
                "F2 to dismiss", W / 2 - WinRelPosW(150),
                H / 3, 10)
            Log("F12: Correct font settings found")
        } else {
            Log("F12: Incorrect font settings found")
        }
        SetTimer(removeLastCheckTooltip, -3000)
    }
}

; As passing the number of the tooltip is such a pain
removeLastCheckTooltip() {
    ToolTip(, , , 10)
}

*Insert:: {
    ; Farm bosses using violins
    Static on13 := false
    Log("Insert: Activated")
    if (!InitGameWindow() && !on13) {
        reload()
        return
    }
    if (!IsWindowActive()) {
        reload() ; Kill if no game
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    If (on13 := !on13) {
        if (!CheckGameSettingsCorrect()) {
            reload()
        }
        Log("Insert: Quark Boss Activated")
        fFarmNormalBossQuark()
    } Else {
        Log("Insert: Equipped Default Loadout")
        EquipDefaultGearLoadout()
        Log("Insert: Resetting")
        reload()
    }
}