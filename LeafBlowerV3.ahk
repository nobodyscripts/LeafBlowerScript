﻿#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#SingleInstance Force
#Include Hotkeys.ahk

#Include Lib\ScriptSettings.ahk
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
#Include Lib\FarmWWBoss.ahk
#Include Lib\GemFarm.ahk
#Include Lib\TowerTimeWarp.ahk

DetectHiddenWindows(true)
Persistent()  ; Prevent the script from exiting automatically.
OnExit(ExitFunc)

global ScriptsLogFile := A_ScriptDir "\LeafBlowerV3.Log"
global Debug := false
global on9 := 0
global HadToHideNotifsF9 := false
global LBRWindowTitle := "Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe"
global X, Y, W, H
global settings := cSettings()

if (!settings.initSettings()) {
    ; If the first load fails, it attempts to write a new config, this retrys
    ; loading after that first failure
    ; Hardcoding 2 attempts because a loop could continuously error
    Sleep(50)
    if (!settings.initSettings()) {
        MsgBox("Script failed to load settings, script closing, try restarting.")
        ExitApp()
    }
}
X := Y := W := H := 0
if (WinExist(LBRWindowTitle)) {
    WinGetClientPos(&X, &Y, &W, &H, LBRWindowTitle)
}
Log("Script loaded")


; ------------------- Readme -------------------
/*
See Readme.md for readme
Run this file to load script
*/

; ------------------- Script Triggers -------------------

#HotIf WinActive(LBRWindowTitle)
*F1:: {
    KillSpammer()
    KillWWSpammer()
    Log("F1: Pressed")
    ; Wildcard shortcut * to allow functions to work while looping with
    ; modifiers held
    ResetModifierKeys() ; Cleanup incase needed
    ResetModifierKeys() ; Twice for good luck
    ExitApp()
}
*F2:: {
    global HadToHideNotifs, HadToRemoveBearo, GemFarmActive, TowerFarmActive,
        QuarkFarmActive
    ; Toggle notifs to handle multiple situations where its toggled
    KillSpammer()
    KillWWSpammer()
    if (HadToHideNotifs) {
        Log("F2: Reenabling notifications.")
        fSlowClick(32, 596, 101)
        HadToHideNotifs := false
    }
    if (GemFarmActive) {
        GemFarmActive := false
        ToolTip(, , , 15)
        if (!IsWindowActive()) {
            reload()
            return
        }
        if (!IsPanelActive()) {
            OpenTrades()
        }
        Sleep(34)
        if (HadToRemoveBearo) {
            Log("F2: Equiping default loadout to reapply Bearo")
            EquipDefaultGearLoadout()
            HadToRemoveBearo := false
        }
        Log("F2: Resetting auto refresh and detailed mode.")
        ResetToPriorAutoRefresh()
        ResetToPriorDetailedMode()
        reload()
        return
    }
    if (TowerFarmActive) {
        TowerFarmActive := false
        Log("F2: Equiping default loadout.")
        EquipDefaultGearLoadout()
        reload()
        return
    }
    if (QuarkFarmActive) {
        QuarkFarmActive := false
        Log("F2: Equipped Default Loadout")
        EquipDefaultGearLoadout()
        reload()
        return
    }
    log("F2: Pressed, reloading...")
    sleep(2)
    ResetModifierKeys() ; Cleanup incase needed
    ResetModifierKeys() ; Twice for good luck
    reload()
}

*F3:: { ; Open cards clicker
    global HadToHideNotifs
    Static on3 := False
    Log("F3: Pressed")
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
            return
        }
        fOpenCardLoop()
    } Else {
        if (HadToHideNotifs) {
            Log("Cards: Reenabling notifications.")
            fSlowClick(32, 596, 101)
            HadToHideNotifs := false
        }
        ResetModifierKeys() ; Cleanup incase needed
        Sleep(34)
        ResetModifierKeys() ; Twice for good luck
        Sleep(34)
        reload()
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    Sleep(34)
    ResetModifierKeys() ; Twice for good luck
    Sleep(34)
}

*F4:: { ; Gem farm using suitcase
    global HadToRemoveBearo, GemFarmActive
    Static on4 := False
    Log("F4: Pressed")
    if (!InitGameWindow() && !on4) {
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    If on4 := !on4 {
        if (!CheckGameSettingsCorrect()) {
            reload()
            return
        }
        fGemFarmSuitcase()
    } Else {
        GemFarmActive := false
        ToolTip(, , , 15)
        if (!IsWindowActive()) {
            reload()
            return
        }
        if (!IsPanelActive()) {
            OpenTrades()
        }
        Sleep(34)
        if (HadToRemoveBearo) {
            Log("F4: Equiping default loadout to reapply Bearo")
            EquipDefaultGearLoadout()
            HadToRemoveBearo := false
        }
        Log("F4: Resetting auto refresh and detailed mode.")
        ResetToPriorAutoRefresh()
        ResetToPriorDetailedMode()
        reload()
    }
}

*F5:: { ; Tower 72hr boost loop
    global TowerFarmActive
    TowerFarmActive := true
    Static on5 := False
    Log("F5: Pressed")
    if (!InitGameWindow() && !on5) {
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    If on5 := !on5 {
        if (!CheckGameSettingsCorrect()) {
            reload()
            return
        }
        fTimeWarpAndRaiseTower()
    } Else {
        TowerFarmActive := false
        Log("TowerBoost: Equiping default loadout.")
        EquipDefaultGearLoadout()
        reload()
    }
}

*F6:: { ; Borb pink juice farm in borbventures
    Static on6 := False
    Log("F6: Pressed")
    if (!InitGameWindow() && !on6) {
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    If on6 := !on6 {
        if (!CheckGameSettingsCorrect()) {
            reload()
            return
        }
        fBorbVentureJuiceFarm()
    } Else reload()
}

*F7:: { ; Claw pumpkin farm
    Static on7 := False
    Log("F7: Pressed")
    if (!InitGameWindow() && !on7) {
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    If on7 := !on7 {
        if (!CheckGameSettingsCorrect()) {
            reload()
            return
        }
        fClawFarm()
    } Else reload()
}

*F8:: { ; Green Flame/Soulseeker farm
    Static on8 := False
    Log("F8: Pressed")
    if (!InitGameWindow() && !on8) {
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    If on8 := !on8 {
        if (!CheckGameSettingsCorrect()) {
            reload()
            return
        }
        fFarmGFSS()
    } Else reload()
}


*F9:: { ; Farm bosses using violins
    global on9, HadToHideNotifsF9
    Log("F9: Pressed")
    if (!InitGameWindow() && !on9) {
        reload()
        return
    }
    if (!IsWindowActive()) {
        reload() ; Kill if no game
        return
    }
    KillSpammer()
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
                return
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
            return
        default:
            on9 := 1 ; Normal boss mode
            if (!CheckGameSettingsCorrect()) {
                reload()
                return
            }
            ClosePanel()
            Log("F9: Boss Farm Activated")
            fFarmNormalBoss(on9)
    }
}

*F10:: { ; Farm nature boss using violins
    Static on10 := False
    Log("F10: Pressed")
    if (!InitGameWindow() && !on10) {
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    If (on10 := !on10) {
        if (!CheckGameSettingsCorrect()) {
            reload()
            return
        }
        fFarmNatureBoss()
    } Else reload()
}

;Allow autoclicker outside game
#HotIf
*F11:: { ; Autoclicker non game specific
    Static on11 := False
    Log("F11: Pressed")
    ;InitGameWindow()
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

#HotIf WinActive(LBRWindowTitle)
*F12:: {
    global X, Y, W, H, DisableSettingsChecks
    Log("F12: Pressed")
    if (!InitGameWindow()) {
        return
    }
    If (WinGetMinMax(LBRWindowTitle) != 0) {
        WinRestore(LBRWindowTitle)
    }
    ; Changes size of client window for windows 11
    WinMove(, , 1294, 603, LBRWindowTitle)
    WinWait(LBRWindowTitle)
    InitGameWindow()
    if (W != "1278" || H != "564") {
        Log("Resized window to 1294*603 client size should be 1278*564, found: " W "*" H)
    }
    Sleep(500)
    if (!CheckGameSettingsCorrectVerbose()) {
        ; If it fails checks we need to restore the size we needed and then
        ; return
        WinMove(, , 1294, 703, LBRWindowTitle)
        InitGameWindow()
        if (W != "1278" || H != "664") {
            Log("Resized window to 1294*703 client size should be 1278*664, found: " W "*" H)
        }
        return
    }
    WinMove(, , 1294, 703, LBRWindowTitle)
    WinWait(LBRWindowTitle)
    InitGameWindow()
    if (W != "1278" || H != "664") {
        Log("Resized window to 1294*703 client size should be 1278*664, found: " W "*" H)
    }
    if (!DisableSettingsChecks) {
        if (IsFontCorrectCheck()) {
            ToolTip(, , , 1)
            ToolTip(, , , 2)
            ToolTip(, , , 3)
            ToolTip(, , , 4)
            ToolTip(, , , 5)
            ToolTip("Correct render mode, transparency, trees, dark "
                "background,`nsmooth graphics and font settings found`nF2 to "
                "dismiss",
                W / 2 - WinRelPosW(150),
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

/**
 * Toggle the Quark Boss farm mode
 * @param ThisHotkey Insert
 * @returns {void} 
 */
*Insert:: {
    ; Farm bosses using violins
    Static on13 := false
    global QuarkFarmActive
    QuarkFarmActive := true
    Log("Insert: Pressed")
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
            return
        }
        Log("Insert: Quark Boss Activated")
        fFarmNormalBossQuark()
    } Else {
        QuarkFarmActive := false
        Log("Insert: Equipped Default Loadout")
        EquipDefaultGearLoadout()
        Log("Insert: Resetting")
        reload()
        return
    }
}

/**
 * Toggle the Wobbly Wings + GFSS farm mode
 * @param ThisHotkey Home
 * @returns {void} 
 */
*Home:: {
    ; Farm bosses using violins
    Static on14 := false
    global WWFarmActive
    WWFarmActive := true
    Log("Home: Pressed")
    KillWWSpammer()
    if (!InitGameWindow() && !on14) {
        reload()
        return
    }
    if (!IsWindowActive()) {
        reload() ; Kill if no game
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    If (on14 := !on14) {
        if (!CheckGameSettingsCorrect()) {
            reload()
            return
        }
        Log("Home: WW Boss Activated")
        fFarmWWBoss()
    } Else {
        WWFarmActive := false
        KillWWSpammer()
        Log("Home: Resetting")
        reload()
        return
    }
}

ExitFunc(ExitReason, ExitCode) {
    Log("Script exiting. Due to " ExitReason ".")
}