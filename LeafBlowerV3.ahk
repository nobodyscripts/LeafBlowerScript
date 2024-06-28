#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#SingleInstance Force

global ScriptsLogFile := A_ScriptDir "\LeafBlowerV3.Log"
global EnableLogging := true
global IsSecondary := false

#Include Gui\MainGUI.ahk

#Include Lib\ScriptSettings.ahk
#Include Lib\Functions.ahk
#Include Lib\Navigate.ahk
#Include Lib\SettingsCheck.ahk
#Include Lib\Spammers.ahk

#Include Lib\cHotkeysInitGame.ahk
#Include Lib\cHotkeysInitScript.ahk
#Include Lib\GameSettings.ahk
#Include Lib\CheckGameSettings.ahk

#Include Navigate\Header.ahk

#Include Modules\BankDeposit.ahk
#Include Modules\Borbventure.ahk
#Include Modules\Cards.ahk
#Include Modules\CardsBuy.ahk
#Include Modules\Claw.ahk
#Include Modules\CursedCheese.ahk
#Include Modules\FarmGFSS.ahk
#Include Modules\FarmNatureBoss.ahk
#Include Modules\FarmNormalBoss.ahk
#Include Modules\GemFarm.ahk
#Include Modules\NatureHyacinth.ahk
#Include Modules\TowerTimeWarp.ahk
#Include Modules\TowerFarmPassive.ahk
#Include Modules\LeaftonTaxi.ahk
#Include Modules\MineMaintainer.ahk
#Include Modules\SuitcaseSpam.ahk
#Include Modules\QuickPrestige.ahk

SendMode("Input") ; Support for vm
; Can be Input, Event, Play, InputThenPlay if Input doesn't work for you

DetectHiddenWindows(true)
Persistent()  ; Prevent the script from exiting automatically.
OnExit(ExitFunc)

global GameSaveDir := A_AppData "\..\Local\blow_the_leaves_away\"
global ActiveSavePath := GameSaveDir "save.dat"
global ActiveGameSettingsPath := GameSaveDir "options.dat"
global on9 := 0
global HadToHideNotifsF9 := false
global CardsBossFarmEnabled := false
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
RunGui()

; ------------------- Readme -------------------
/*
See Readme.md for readme
Run this file to load script
*/

; ------------------- Script Triggers -------------------

/* Numpad1:: {
    screenx := screeny := windowx := windowy := clientx := clienty := 0
    CoordMode("Mouse", "Screen")
    MouseGetPos(&screenx, &screeny)
    CoordMode("Mouse", "Window")
    MouseGetPos(&windowx, &windowy)
    CoordMode("Mouse", "Client")
    MouseGetPos(&clientx, &clienty)
    Log(
        "Screen:`t" screenx ", " screeny "`n"
        "Window:`t" windowx ", " windowy "`n"
        "Client:`t" clientx ", " clienty "`n"
        "Color:`t#" SubStr(PixelGetColor(screenx, screeny), 3)
    )
} */

/* Numpad2:: {
    testArea := RelSampleArea()
    testArea.SetCoordRel(470, 290, 819, 448)
    results := testArea.OCRArea()
    MsgBox(results.Text)
} */
CreateScriptHotkeys()

CreateScriptHotkeys() {
    Hotkey("*" Scriptkeys.GetHotkey("AutoClicker"), fAutoClicker)
    HotIfWinActive(LBRWindowTitle)
    Hotkey("*" Scriptkeys.GetHotkey("Exit"), fExitApp)
    Hotkey("*" Scriptkeys.GetHotkey("Reload"), fReloadApp)
    Hotkey("*" Scriptkeys.GetHotkey("Cards"), fCardsStart)
    Hotkey("*" Scriptkeys.GetHotkey("GemFarm"), fGemFarmStart)
    Hotkey("*" Scriptkeys.GetHotkey("TowerBoost"), fTowerBoostStart)
    Hotkey("*" Scriptkeys.GetHotkey("Borbv"), fBorbvStart)
    Hotkey("*" Scriptkeys.GetHotkey("Claw"), fClawStart)
    Hotkey("*" Scriptkeys.GetHotkey("GFSS"), fGFSSStart)
    Hotkey("*" Scriptkeys.GetHotkey("BossFarm"), fBossFarmStart)
    Hotkey("*" Scriptkeys.GetHotkey("NatureBoss"), fNatureBossStart)
    Hotkey("*" Scriptkeys.GetHotkey("GameResize"), fGameResize)
    Hotkey("*" Scriptkeys.GetHotkey("MineMaintain"), fMineStart)
    Hotkey("*" Scriptkeys.GetHotkey("HyacinthFarm"), fHyacinthStart)
    Hotkey("*" Scriptkeys.GetHotkey("Bank"), fBankStart)
    Hotkey("*" Scriptkeys.GetHotkey("CursedCheese"), fCursedCheeseStart)
    Hotkey("*" Scriptkeys.GetHotkey("TowerPassive"), fTowerPassiveStart)
    Hotkey("*" Scriptkeys.GetHotkey("Leafton"), fLeaftonStart)
}

fExitApp(*) {
    KillAllSpammers()
    Log("F1: Pressed")
    ; Wildcard shortcut * to allow functions to work while looping with
    ; modifiers held
    ResetModifierKeys() ; Cleanup incase needed
    ResetModifierKeys() ; Twice for good luck
    ExitApp()
}

fReloadApp(*) {
    global HadToHideNotifs, HadToRemoveBearo, GemFarmActive, TowerFarmActive,
        bvAutostartDisabled
    ; Toggle notifs to handle multiple situations where its toggled
    KillAllSpammers()
    if (HadToHideNotifs) {
        Log("F2: Reenabling notifications.")
        Points.Misc.NotifArrow.Click(101)
        HadToHideNotifs := false
    }
    if (bvAutostartDisabled = true) {
        ; TODO move point to Points
        fCustomClick(WinRelPosLargeW(591), WinRelPosLargeH(1100), 34)
    }
    if (GemFarmActive) {
        GemFarmActive := false
        ToolTip(, , , 15)
        if (!IsWindowActive()) {
            cReload()
            return
        }
        Travel.OpenTrades()
        Sleep(34)
        if (HadToRemoveBearo) {
            Log("F2: Equiping default loadout to reapply Bearo")
            GameKeys.EquipDefaultGearLoadout()
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
        GameKeys.EquipDefaultGearLoadout()
        cReload()
        return
    }
    log("F2: Pressed, reloading...")
    sleep(2)
    ResetModifierKeys() ; Cleanup incase needed
    ResetModifierKeys() ; Twice for good luck
    cReload()
}

fCardsStart(*) { ; Open cards clicker
    global HadToHideNotifs
    Static on3 := False
    Log("F3: Pressed")
    InitScriptHotKey()
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
            Points.Misc.NotifArrow.Click(101)
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

fGemFarmStart(*) { ; Gem farm using suitcase
    global HadToRemoveBearo, GemFarmActive
    Static on4 := False
    Log("F4: Pressed")
    InitScriptHotKey()
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
        Travel.OpenTrades()
        Sleep(34)
        if (HadToRemoveBearo) {
            Log("F4: Equiping default loadout to reapply Bearo")
            GameKeys.EquipDefaultGearLoadout()
            HadToRemoveBearo := false
        }
        Log("F4: Resetting auto refresh and detailed mode.")
        ResetToPriorAutoRefresh()
        ResetToPriorDetailedMode()
        cReload()
    }
}

fTowerBoostStart(*) { ; Tower 72hr boost loop
    global TowerFarmActive
    TowerFarmActive := true
    Static on5 := False
    Log("F5: Pressed")
    InitScriptHotKey()
    If on5 := !on5 {
        if (!CheckGameSettingsCorrect()) {
            cReload()
            return
        }
        fTimeWarpAndRaiseTower()
    } Else {
        TowerFarmActive := false
        Log("TowerBoost: Equiping default loadout.")
        GameKeys.EquipDefaultGearLoadout()
        cReload()
    }
}

fBorbvStart(*) { ; Borb pink juice farm in borbventures
    Static on6 := False
    global bvAutostartDisabled
    Log("F6: Pressed")
    InitScriptHotKey()
    If on6 := !on6 {
        if (!CheckGameSettingsCorrect()) {
            cReload()
            return
        }
        fBorbVentureJuiceFarm()
    } Else {
        if (bvAutostartDisabled = true && GotoBorbventuresFirstTab()) {
            ; TODO move point to Points
            fCustomClick(WinRelPosLargeW(591), WinRelPosLargeH(1100), 34)
        }
        ToolTip()
        cReload()
    }
}

fClawStart(*) { ; Claw pumpkin farm
    Static on7 := False
    Log("F7: Pressed")
    InitScriptHotKey()
    If on7 := !on7 {
        if (!CheckGameSettingsCorrect()) {
            cReload()
            return
        }
        fClawFarm()
    } Else cReload()
}

fGFSSStart(*) { ; Green Flame/Soulseeker farm
    Static on8 := False
    Log("F8: Pressed")
    InitScriptHotKey()
    If on8 := !on8 {
        if (!CheckGameSettingsCorrect()) {
            cReload()
            return
        }
        fFarmGFSS()
    } Else reload()
}

fBossFarmStart(GUIMode := -1, *) { ; Farm bosses using violins
    global on9, HadToHideNotifsF9, bvAutostartDisabled
    Log("F9: Pressed")
    InitScriptHotKey()
    Thread('Interrupt', 0)  ; Make all threads always-interruptible.
    if (GUIMode != -1) {
        on9 := GUIMode
    }
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
                    ; TODO move point to Points
                    fCustomClick(WinRelPosLargeW(591), WinRelPosLargeH(1100), 34)
                }
            }
            on9 := 4 ; Boss mode with cards
            if (CardsBossFarmEnabled || GUIMode != -1) {
                Log("F9: Cards and Boss Activated")
                fNormalBossFarmWithCards(on9)
            } else {
                on9 := 0 ; Disabled
                Log("F9: Resetting with cards disabled")
                Travel.ClosePanelIfActive()
                cReload()
                return
            }
        case 4:
            on9 := 0 ; Disabled
            if (HadToHideNotifsF9) {
                Log("F9: Reenabling notifications")
                Points.Misc.NotifArrow.Click(101)
                HadToHideNotifsF9 := false
            }
            Log("F9: Resetting")
            ResetModifierKeys() ; Cleanup incase needed
            Travel.ClosePanelIfActive()
            cReload()
            return
        default:
            on9 := 1 ; Normal boss mode
            if (!CheckGameSettingsCorrect()) {
                cReload()
                return
            }
            Travel.ClosePanelIfActive()
            Log("F9: Boss Farm Activated")
            fFarmNormalBoss(on9)
    }
}

fNatureBossStart(*) { ; Farm nature boss using violins
    Static on10 := False
    Log("F10: Pressed")
    InitScriptHotKey()
    If (on10 := !on10) {
        if (!CheckGameSettingsCorrect()) {
            cReload()
            return
        }
        fFarmNatureBoss()
    } Else reload()
}

fAutoClicker(*) {
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

fGameResize(*) {
    global X, Y, W, H, DisableSettingsChecks
    Log("F12: Pressed")
    if (!InitGameWindow()) {
        return
    }
    If (WinGetMinMax(LBRWindowTitle) != 0) {
        WinRestore(LBRWindowTitle)
    }
    ; Changes size of client window for windows 11
    WinMove(, , 1294, 703, LBRWindowTitle)
    WinWait(LBRWindowTitle)
    InitGameWindow()
    if (W != "1278" || H != "664") {
        Log("Resized window to 1294*703 client size should be 1278*664, found: " W "*" H)
    }
    fCheckGameSettings()
}


fMineStart(*) {
    Static on13 := false
    Log("Insert: Pressed")
    InitScriptHotKey()
    If (on13 := !on13) {
        if (!CheckGameSettingsCorrect()) {
            cReload()
            return
        }
        Log("Insert: Mine Mantainer Activated")
        fMineMaintainer()
    } Else {
        Log("Insert: Resetting")
        cReload()
        return
    }
}

fHyacinthStart(*) {
    ; Farm bosses while farming Hyacinths
    Static on14 := false
    global HyacinthFarmActive
    HyacinthFarmActive := true
    Log("Home: Pressed")
    InitScriptHotKey()
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

fBankStart(*) {
    Static on16 := false
    Log("PgUp: Pressed")
    InitScriptHotKey()
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

fCursedCheeseStart(*) {
    ; Cursed Cheese Farm
    Static on18 := false

    Log("Del: Pressed")
    InitScriptHotKey()
    If (on18 := !on18) {
        if (!CheckGameSettingsCorrect()) {
            cReload()
            return
        }
        Log("Del: Cursed Chees Activated")
        fFarmCheeseBoss()
    } Else {
        ToolTip(, , , 4)
        Log("Del: Resetting")
        cReload()
        return
    }
}

fTowerPassiveStart(*) {
    Static on15 := false

    Log("End: Pressed")
    InitScriptHotKey()
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

fLeaftonStart(*) {
    Static on17 := false
    Log("PgDn: Pressed")
    InitScriptHotKey()
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

ExitFunc(ExitReason, ExitCode) {
    Log("Script exiting. Due to " ExitReason ".")
}