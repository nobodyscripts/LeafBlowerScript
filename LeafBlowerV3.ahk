#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#SingleInstance Force

/**
 * Main script file, run this to activate gui and hotkeys
 */

; Applying these first incase self run functions in includes require them
global ScriptsLogFile := A_ScriptDir "\LeafBlowerV3.Log"
global IsSecondary := false

#Include Lib\hGlobals.ahk

#Include Gui\MainGUI.ahk

#Include Lib\ScriptSettings.ahk
#Include Lib\Functions.ahk
#Include Lib\Navigate.ahk
#Include Lib\cGameWindow.ahk
#Include Lib\Spammers.ahk
#Include Lib\cHotkeysInitGame.ahk
#Include Lib\cHotkeysInitScript.ahk
#Include Lib\GameSettings.ahk
#Include Lib\CheckGameSettings.ahk
#Include Lib\hModules.ahk

SendMode("Input") ; Support for vm
; Can be Input, Event, Play, InputThenPlay if Input doesn't work for you

DetectHiddenWindows(true)
Persistent()  ; Prevent the script from exiting automatically.
OnExit(ExitFunc)

global HadToHideNotifsF9 := false
global settings := cSettings()

if (!settings.initSettings()) {
    ; If the first load fails, it attempts to write a new config, this retrys
    ; loading after that first failure
    ; Hardcoding 2 attempts because a loop could continuously error
    Sleep(50)
    if (!settings.initSettings()) {
        MsgBox(
            "Script failed to load settings, script closing, try restarting.")
        ExitApp()
    }
}
Out.I("Script loaded")
RunGui()
; Setup script hotkeys
CreateScriptHotkeys()

; ------------------- Readme -------------------
/*
See Readme.md for readme
Run this file to load script
*/

; ------------------- Script Triggers -------------------

/*
Numpad1:: {
    screenx := screeny := windowx := windowy := clientx := clienty := 0
    CoordMode("Mouse", "Screen")
    MouseGetPos(&screenx, &screeny)
    CoordMode("Mouse", "Window")
    MouseGetPos(&windowx, &windowy)
    CoordMode("Mouse", "Client")
    MouseGetPos(&clientx, &clienty)
    Out.I(
        "Screen:`t" screenx ", " screeny "`n"
        "Window:`t" windowx ", " windowy "`n"
        "Client:`t" clientx ", " clienty "`n"
        "Color:`t#" SubStr(PixelGetColor(screenx, screeny), 3)
    )
}
Numpad2:: {
    testArea := RelSampleArea()
    testArea.SetCoordRel(470, 290, 819, 448)
    results := testArea.OCRArea()
    MsgBox(results.Text)
}
Numpad0:: {
    Out.I(Points.Misc.ZoneSample.GetColour())
}*/

CreateScriptHotkeys() {
    Hotkey("*" Scriptkeys.GetHotkey("AutoClicker"), fAutoClicker)
    HotIfWinActive(Window.Title)
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
    Spammer.KillAllSpammers()
    Out.I("F1: Pressed")
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
    Spammer.KillAllSpammers()
    if (HadToHideNotifs) {
        Out.I("F2: Reenabling notifications.")
        Points.Misc.NotifArrow.Click(101)
        HadToHideNotifs := false
    }
    if (bvAutostartDisabled = true) {
        ; TODO move point to Points
        fCustomClick(Window.RelW(591), Window.RelH(1100), 34)
    }
    if (GemFarmActive) {
        GemFarmActive := false
        ToolTip(, , , 15)
        if (!Window.IsActive()) {
            cReload()
            return
        }
        Travel.OpenTrades()
        Sleep(34)
        if (HadToRemoveBearo) {
            Out.I("F2: Equiping default loadout to reapply Bearo")
            GameKeys.EquipDefaultGearLoadout()
            HadToRemoveBearo := false
        }
        Out.I("F2: Resetting auto refresh and detailed mode.")
        ResetToPriorAutoRefresh()
        ResetToPriorDetailedMode()
        cReload()
        return
    }
    if (TowerFarmActive) {
        TowerFarmActive := false
        Out.I("F2: Equiping default loadout.")
        GameKeys.EquipDefaultGearLoadout()
        cReload()
        return
    }
    Out.I("F2: Pressed, reloading...")
    Sleep(2)
    ResetModifierKeys() ; Cleanup incase needed
    ResetModifierKeys() ; Twice for good luck
    cReload()
}

fCardsStart(*) { ; Open cards clicker
    global HadToHideNotifs
    static on3 := false
    Out.I("F3: Pressed")
    InitScriptHotKey()
    Sleep(34)
    ResetModifierKeys() ; Twice for good luck
    Sleep(34)
    if on3 := !on3 {
        if (!Window.AreGameSettingsCorrect()) {
            cReload()
            return
        }
        fOpenCardLoop()
    } else {
        if (HadToHideNotifs) {
            Out.I("Cards: Reenabling notifications.")
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
    static on4 := false
    Out.I("F4: Pressed")
    InitScriptHotKey()
    if on4 := !on4 {
        if (!Window.AreGameSettingsCorrect()) {
            cReload()
            return
        }
        fGemFarmSuitcase()
    } else {
        GemFarmActive := false
        ToolTip(, , , 15)
        if (!Window.IsActive()) {
            cReload()
            return
        }
        Travel.OpenTrades()
        Sleep(34)
        if (HadToRemoveBearo) {
            Out.I("F4: Equiping default loadout to reapply Bearo")
            GameKeys.EquipDefaultGearLoadout()
            HadToRemoveBearo := false
        }
        Out.I("F4: Resetting auto refresh and detailed mode.")
        ResetToPriorAutoRefresh()
        ResetToPriorDetailedMode()
        cReload()
    }
}

fTowerBoostStart(*) { ; Tower 72hr boost loop
    global TowerFarmActive
    TowerFarmActive := true
    static on5 := false
    Out.I("F5: Pressed")
    InitScriptHotKey()
    if on5 := !on5 {
        if (!Window.AreGameSettingsCorrect()) {
            cReload()
            return
        }
        fTimeWarpAndRaiseTower()
    } else {
        TowerFarmActive := false
        Out.I("TowerBoost: Equiping default loadout.")
        GameKeys.EquipDefaultGearLoadout()
        cReload()
    }
}

fBorbvStart(*) { ; Borb pink juice farm in borbventures
    static on6 := false
    global bvAutostartDisabled
    Out.I("F6: Pressed")
    InitScriptHotKey()
    if on6 := !on6 {
        if (!Window.AreGameSettingsCorrect()) {
            cReload()
            return
        }
        fBorbVentureJuiceFarm()
    } else {
        if (bvAutostartDisabled = true && Travel.GotoBorbVFirstTab()) {
            ; TODO move point to Points
            fCustomClick(Window.RelW(591), Window.RelH(1100), 34)
        }
        ToolTip()
        cReload()
    }
}

fClawStart(*) { ; Claw pumpkin farm
    static on7 := false
    Out.I("F7: Pressed")
    InitScriptHotKey()
    if on7 := !on7 {
        if (!Window.AreGameSettingsCorrect()) {
            cReload()
            return
        }
        fClawFarm()
    } else cReload()
}

fGFSSStart(*) { ; Green Flame/Soulseeker farm
    static on8 := false
    Out.I("F8: Pressed")
    InitScriptHotKey()
    if on8 := !on8 {
        if (!Window.AreGameSettingsCorrect()) {
            cReload()
            return
        }
        fFarmGFSS()
    } else Reload()
}

fBossFarmStart(GUIMode := -1, *) { ; Farm bosses using violins
    global on9, HadToHideNotifsF9, bvAutostartDisabled
    Out.I("F9: Pressed")
    InitScriptHotKey()
    Thread('Interrupt', 0)  ; Make all threads always-interruptible.
    if (GUIMode != -1 && IsNumber(GUIMode)) {
        on9 := GUIMode
    }
    switch on9 {
        case 1:
            on9 := 2 ; Brew and boss mode
            Out.I("F9: Brew and Boss Activated")
            fFarmNormalBossAndBrew(on9)
        case 2:
            on9 := 3 ; Boss mode with borbventures
            Out.I("F9: Borbventures and Boss Activated")
            fNormalBossFarmWithBorbs(on9)
        case 3:
            if (bvAutostartDisabled = true) {
                if (!IsBVAutoStartOn()) {
                    ; TODO move point to Points
                    fCustomClick(Window.RelW(591), Window.RelH(1100), 34)
                }
            }
            on9 := 4 ; Boss mode with cards
            if (CardsBossFarmEnabled || GUIMode != -1) {
                Out.I("F9: Cards and Boss Activated")
                fNormalBossFarmWithCards(on9)
            } else {
                on9 := 0 ; Disabled
                Out.I("F9: Resetting with cards disabled")
                Travel.ClosePanelIfActive()
                cReload()
                return
            }
        case 4:
            on9 := 0 ; Disabled
            if (HadToHideNotifsF9) {
                Out.I("F9: Reenabling notifications")
                Points.Misc.NotifArrow.Click(101)
                HadToHideNotifsF9 := false
            }
            Out.I("F9: Resetting")
            ResetModifierKeys() ; Cleanup incase needed
            Travel.ClosePanelIfActive()
            cReload()
            return
        default:
            on9 := 1 ; Normal boss mode
            if (!Window.AreGameSettingsCorrect()) {
                cReload()
                return
            }
            Travel.ClosePanelIfActive()
            Out.I("F9: Boss Farm Activated")
            fFarmNormalBoss(on9)
    }
}

fNatureBossStart(*) { ; Farm nature boss using violins
    static on10 := false
    Out.I("F10: Pressed")
    InitScriptHotKey()
    if (on10 := !on10) {
        if (!Window.AreGameSettingsCorrect()) {
            cReload()
            return
        }
        fFarmNatureBoss()
    } else Reload()
}

fAutoClicker(*) {
    static on11 := false
    Out.I("F11: Pressed")
    ;Window.Exist()
    if (on11 := !on11) {
        while (on11) {
            MouseClick("left", , , , , "D")
            Sleep(17)
            ; Must be higher than 16.67 which is a single frame of 60fps
            MouseClick("left", , , , , "U")
            Sleep(17)
        }
    } else {
        ; Do one click when killing, so that we reset the click state
        MouseClick("left", , , , , "D")
        Sleep(17)
        MouseClick("left", , , , , "U")
        Sleep(17)
        cReload()
    }
}

fGameResize(*) {
    global DisableSettingsChecks
    Out.I("F12: Pressed")
    if (!Window.Exist()) {
        return
    }
    if (WinGetMinMax(Window.Title) != 0) {
        WinRestore(Window.Title)
    }
    ; Changes size of client window for windows 11
    WinMove(, , 1294, 703, Window.Title)
    WinWait(Window.Title)
    Window.Exist()
    if (Window.W != "1278" || Window.H != "664") {
        Out.I(
            "Resized window to 1294*703 client size should be 1278*664, found: " Window
            .W "*" Window.H)
    }
    fCheckGameSettings()
}

fMineStart(*) {
    static on13 := false
    Out.I("Insert: Pressed")
    InitScriptHotKey()
    if (on13 := !on13) {
        if (!Window.AreGameSettingsCorrect()) {
            cReload()
            return
        }
        Out.I("Insert: Mine Mantainer Activated")
        fMineMaintainer()
    } else {
        Out.I("Insert: Resetting")
        cReload()
        return
    }
}

fHyacinthStart(*) {
    ; Farm bosses while farming Hyacinths
    static on14 := false
    global HyacinthFarmActive
    HyacinthFarmActive := true
    Out.I("Home: Pressed")
    InitScriptHotKey()
    if (on14 := !on14) {
        if (!Window.AreGameSettingsCorrect()) {
            cReload()
            return
        }
        Out.I("Home: Hyacinth + Boss Activated")
        fFarmNormalBossAndNatureHyacinth()
    } else {
        HyacinthFarmActive := false
        Out.I("Home: Resetting")
        cReload()
        return
    }
}

fBankStart(*) {
    static on16 := false
    Out.I("PgUp: Pressed")
    InitScriptHotKey()
    if (on16 := !on16) {
        if (!Window.AreGameSettingsCorrect()) {
            cReload()
            return
        }
        Out.I("PgUp: Bank Maintainer Activated")
        fBankAutoDeposit()
    } else {
        ToolTip(, , , 4)
        Out.I("PgUp: Resetting")
        cReload()
        return
    }
}

fCursedCheeseStart(*) {
    ; Cursed Cheese Farm
    static on18 := false

    Out.I("Del: Pressed")
    InitScriptHotKey()
    if (on18 := !on18) {
        if (!Window.AreGameSettingsCorrect()) {
            cReload()
            return
        }
        Out.I("Del: Cursed Chees Activated")
        fFarmCheeseBoss()
    } else {
        ToolTip(, , , 4)
        Out.I("Del: Resetting")
        cReload()
        return
    }
}

fTowerPassiveStart(*) {
    static on15 := false

    Out.I("End: Pressed")
    InitScriptHotKey()
    if (on15 := !on15) {
        if (!Window.AreGameSettingsCorrect()) {
            cReload()
            return
        }
        Out.I("End: Tower Farm Passive Activated")
        fTowerFarm()
    } else {
        ToolTip(, , , 4)
        Out.I("End: Resetting")
        cReload()
        return
    }
}

fLeaftonStart(*) {
    static on17 := false
    Out.I("PgDn: Pressed")
    InitScriptHotKey()
    if (on17 := !on17) {
        if (!Window.AreGameSettingsCorrect()) {
            cReload()
            return
        }
        Out.I("PgDn: Leafton Autotaxi Activated")
        fLeaftonTaxi()
    } else {
        ToolTip(, , , 4)
        Out.I("PgDn: Resetting")
        cReload()
        return
    }
}

ExitFunc(ExitReason, ExitCode) {
    Out.I("Script exiting. Due to " ExitReason ".")
}
