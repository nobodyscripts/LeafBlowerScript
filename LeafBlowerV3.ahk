#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#SingleInstance Force
#Include Hotkeys.ahk

#Include Lib\ScriptSettings.ahk
#Include Lib\Functions.ahk
#Include Lib\Navigate.ahk
#Include Lib\SettingsCheck.ahk

#Include Lib\BankDeposit.ahk
#Include Lib\Borbventure.ahk
#Include Lib\Cards.ahk
#Include Lib\CardsBuy.ahk
#Include Lib\Claw.ahk
#Include Lib\FarmGFSS.ahk
#Include Lib\FarmNatureBoss.ahk
#Include Lib\FarmNormalBoss.ahk
#Include Lib\FarmQuarkBoss.ahk
#Include Lib\GemFarm.ahk
#Include Lib\NatureHyacinth.ahk
#Include Lib\TowerTimeWarp.ahk
#Include Lib\TowerFarmPassive.ahk
#Include Lib\LeaftonTaxi.ahk

DetectHiddenWindows(true)
Persistent()  ; Prevent the script from exiting automatically.
OnExit(ExitFunc)

global ScriptsLogFile := A_ScriptDir "\LeafBlowerV3.Log"
global on9 := 0
global HadToHideNotifsF9 := false
global CardsBossFarmEnabled := false
global DisableSettingsChecks := false
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
    if (IsSpammerActive()) {
        KillSpammer()
    }
    if (IsWindSpammerActive()) {
        KillWindSpammer()
    }
    if (IsTowerPassiveSpammerActive()) {
        KillTowerPassiveSpammer()
    }
    Log("F1: Pressed")
    ; Wildcard shortcut * to allow functions to work while looping with
    ; modifiers held
    ResetModifierKeys() ; Cleanup incase needed
    ResetModifierKeys() ; Twice for good luck
    ExitApp()
}
*F2:: {
    global HadToHideNotifs, HadToRemoveBearo, GemFarmActive, TowerFarmActive,
        QuarkFarmActive, bvAutostartDisabled
    ; Toggle notifs to handle multiple situations where its toggled
    if (IsSpammerActive()) {
        KillSpammer()
    }
    if (IsWindSpammerActive()) {
        KillWindSpammer()
    }
    if (IsTowerPassiveSpammerActive()) {
        KillTowerPassiveSpammer()
    }
    if (HadToHideNotifs) {
        Log("F2: Reenabling notifications.")
        fSlowClick(32, 596, 101)
        HadToHideNotifs := false
    }
    if (bvAutostartDisabled = true) {
        fCustomClick(WinRelPosLargeW(591), WinRelPosLargeH(1100), 34)
    }
    if (GemFarmActive) {
        GemFarmActive := false
        ToolTip(, , , 15)
        if (!IsWindowActive()) {
            cReload()
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
        cReload()
        return
    }
    if (TowerFarmActive) {
        TowerFarmActive := false
        Log("F2: Equiping default loadout.")
        EquipDefaultGearLoadout()
        cReload()
        return
    }
    if (QuarkFarmActive) {
        QuarkFarmActive := false
        Log("F2: Equipped Default Loadout")
        EquipDefaultGearLoadout()
        cReload()
        return
    }
    log("F2: Pressed, reloading...")
    sleep(2)
    ResetModifierKeys() ; Cleanup incase needed
    ResetModifierKeys() ; Twice for good luck
    cReload()
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
            cReload()
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
        cReload()
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
            cReload()
            return
        }
        fGemFarmSuitcase()
    } Else {
        GemFarmActive := false
        ToolTip(, , , 15)
        if (!IsWindowActive()) {
            cReload()
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
        cReload()
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
            cReload()
            return
        }
        fTimeWarpAndRaiseTower()
    } Else {
        TowerFarmActive := false
        Log("TowerBoost: Equiping default loadout.")
        EquipDefaultGearLoadout()
        cReload()
    }
}

*F6:: { ; Borb pink juice farm in borbventures
    Static on6 := False
    global bvAutostartDisabled
    Log("F6: Pressed")
    if (!InitGameWindow() && !on6) {
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    If on6 := !on6 {
        if (!CheckGameSettingsCorrect()) {
            cReload()
            return
        }
        fBorbVentureJuiceFarm()
    } Else {
        if (bvAutostartDisabled = true && GotoBorbventuresFirstTab()) {
            fCustomClick(WinRelPosLargeW(591), WinRelPosLargeH(1100), 34)
        }
        ToolTip()
        cReload()
    }
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
            cReload()
            return
        }
        fClawFarm()
    } Else cReload()
}

*F8:: { ; Green Flame/Soulseeker farm
    Static on8 := False
    Log("F8: Pressed")
    if (IsSpammerActive()) {
        KillSpammer()
    }
    if (IsWindSpammerActive()) {
        KillWindSpammer()
    }
    if (IsTowerPassiveSpammerActive()) {
        KillTowerPassiveSpammer()
    }
    if (!InitGameWindow() && !on8) {
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    If on8 := !on8 {
        if (!CheckGameSettingsCorrect()) {
            cReload()
            return
        }
        fFarmGFSS()
    } Else reload()
}


*F9:: { ; Farm bosses using violins
    global on9, HadToHideNotifsF9, bvAutostartDisabled
    Log("F9: Pressed")
    if (!InitGameWindow() && !on9) {
        cReload()
        return
    }
    if (!IsWindowActive()) {
        cReload() ; Kill if no game
        return
    }
    if (IsSpammerActive()) {
        KillSpammer()
    }
    if (IsWindSpammerActive()) {
        KillWindSpammer()
    }
    if (IsTowerPassiveSpammerActive()) {
        KillTowerPassiveSpammer()
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
            if (bvAutostartDisabled = true) {
                if (!IsBVAutoStartOn()) {
                    fCustomClick(WinRelPosLargeW(591), WinRelPosLargeH(1100), 34)
                }
            }
            on9 := 4 ; Boss mode with cards
            if (CardsBossFarmEnabled) {
                Log("F9: Cards and Boss Activated")
                fNormalBossFarmWithCards(on9)
            } else {
                on9 := 0 ; Disabled
                Log("F9: Resetting with cards disabled")
                if (IsPanelActive()) {
                    ClosePanel()
                }
                cReload()
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
            if (IsPanelActive()) {
                ClosePanel()
            }
            cReload()
            return
        default:
            on9 := 1 ; Normal boss mode
            if (!CheckGameSettingsCorrect()) {
                cReload()
                return
            }
            if (IsPanelActive()) {
                ClosePanel()
            }
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
            cReload()
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
        cReload()
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
        cReload()
        return
    }
    if (!IsWindowActive()) {
        cReload() ; Kill if no game
        return
    }
    ResetModifierKeys() ; Cleanup incase needed
    If (on13 := !on13) {
        if (!CheckGameSettingsCorrect()) {
            cReload()
            return
        }
        Log("Insert: Quark Boss Activated")
        fFarmNormalBossQuark()
    } Else {
        QuarkFarmActive := false
        Log("Insert: Equipped Default Loadout")
        EquipDefaultGearLoadout()
        Log("Insert: Resetting")
        cReload()
        return
    }
}

*Home:: {
    ; Farm bosses while farming Hyacinths
    Static on14 := false
    global HyacinthFarmActive
    HyacinthFarmActive := true
    Log("Home: Pressed")
    if (!InitGameWindow() && !on14) {
        cReload()
        return
    }
    if (!IsWindowActive()) {
        cReload() ; Kill if no game
        return
    }
    if (IsSpammerActive()) {
        KillSpammer()
    }
    if (IsWindSpammerActive()) {
        KillWindSpammer()
    }
    if (IsTowerPassiveSpammerActive()) {
        KillTowerPassiveSpammer()
    }
    ResetModifierKeys() ; Cleanup incase needed
    If (on14 := !on14) {
        if (!CheckGameSettingsCorrect()) {
            cReload()
            return
        }
        Log("Home: Hyacinth + Boss Activated")
        fFarmNormalBossAndNatureHyacinth()
    } Else {
        HyacinthFarmActive := false
        Log("Home: Resetting")
        cReload()
        return
    }
}

*End:: {
    ; Tower farm passive
    Static on15 := false

    Log("End: Pressed")
    if (!InitGameWindow() && !on15) {
        cReload()
        return
    }
    if (!IsWindowActive()) {
        cReload() ; Kill if no game
        return
    }
    if (IsSpammerActive()) {
        KillSpammer()
    }
    if (IsWindSpammerActive()) {
        KillWindSpammer()
    }
    if (IsTowerPassiveSpammerActive()) {
        KillTowerPassiveSpammer()
    }
    ResetModifierKeys() ; Cleanup incase needed
    If (on15 := !on15) {
        if (!CheckGameSettingsCorrect()) {
            cReload()
            return
        }
        Log("End: Tower Farm Passive Activated")
        fTowerFarm()
    } Else {
        ToolTip(, , , 4)
        Log("End: Resetting")
        cReload()
        return
    }
}

*PgUp:: {
    ; Bank maintainer
    Static on16 := false

    Log("PgUp: Pressed")
    if (!InitGameWindow() && !on16) {
        cReload()
        return
    }
    if (!IsWindowActive()) {
        cReload() ; Kill if no game
        return
    }
    if (IsSpammerActive()) {
        KillSpammer()
    }
    if (IsWindSpammerActive()) {
        KillWindSpammer()
    }
    if (IsTowerPassiveSpammerActive()) {
        KillTowerPassiveSpammer()
    }
    ResetModifierKeys() ; Cleanup incase needed
    If (on16 := !on16) {
        if (!CheckGameSettingsCorrect()) {
            cReload()
            return
        }
        Log("PgUp: Bank Maintainer Activated")
        fBankAutoDeposit()
    } Else {
        ToolTip(, , , 4)
        Log("PgUp: Resetting")
        cReload()
        return
    }
}


*PgDn:: {
    ; Leafton Autotaxi
    Static on17 := false

    Log("PgDn: Pressed")
    if (!InitGameWindow() && !on17) {
        cReload()
        return
    }
    if (!IsWindowActive()) {
        cReload() ; Kill if no game
        return
    }
    if (IsSpammerActive()) {
        KillSpammer()
    }
    if (IsWindSpammerActive()) {
        KillWindSpammer()
    }
    if (IsTowerPassiveSpammerActive()) {
        KillTowerPassiveSpammer()
    }
    ResetModifierKeys() ; Cleanup incase needed
    If (on17 := !on17) {
        if (!CheckGameSettingsCorrect()) {
            cReload()
            return
        }
        Log("PgDn: Leafton Autotaxi Activated")
        fLeaftonTaxi()
    } Else {
        ToolTip(, , , 4)
        Log("PgDn: Resetting")
        cReload()
        return
    }
}

/* *Del:: {
    OpenAreasPanel()
    Sleep(1000)
    ResetAreaScroll()
    Sleep(1000)
    ScrollAmountDown(10)
    Sleep(1000)
    ScrollAmountUp(10)
    Sleep(1000)
    OpenEventsAreasPanel()
    Sleep(1000)
    OpenQuarkPanel()
    Sleep(1000)
    GoToHomeGarden()
    Sleep(1000)
    GoToGF()
    Sleep(1000)
    GoToSS()
    Sleep(1000)
    GoToShadowCavern()
    Sleep(1000)
    GotoResetSS()
    Sleep(1000)
    ResetSS()
    Sleep(1000)
    ResetGF()
    Sleep(1000)
    GoToNatureBoss()
    Sleep(1000)
    GoToFarmField()
    Sleep(1000)
    GoToDesert()
    Sleep(1000)
    GoToAstralOasis()
    Sleep(1000)
    GoToDimentionalTapestry()
    Sleep(1000)
    GoToPlankScope()
    Sleep(1000)
    GotoCardsFirstTab()
} */

ExitFunc(ExitReason, ExitCode) {
    Log("Script exiting. Due to " ExitReason ".")
}