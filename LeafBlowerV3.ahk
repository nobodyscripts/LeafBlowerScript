#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#SingleInstance Force

/**
 * Main script file, run this to activate gui and hotkeys
 */

; Applying these first incase self run functions in includes require them
Global ScriptsLogFile := A_ScriptDir "\LeafBlowerV3.Log"
Global IsSecondary := false

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

Global HadToHideNotifsF9 := false
Global settings := cSettings()

If (!settings.initSettings()) {
    ; If the first load fails, it attempts to write a new config, this retrys
    ; loading after that first failure
    ; Hardcoding 2 attempts because a loop could continuously error
    Sleep(50)
    If (!settings.initSettings()) {
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
    Global HadToHideNotifs, HadToRemoveBearo, GemFarmActive, TowerFarmActive,
        bvAutostartDisabled
    ; Toggle notifs to handle multiple situations where its toggled
    Spammer.KillAllSpammers()
    If (HadToHideNotifs) {
        Out.I("F2: Reenabling notifications.")
        Points.Misc.NotifArrow.Click(101)
        HadToHideNotifs := false
    }
    If (bvAutostartDisabled = true) {
        ; TODO move point to Points
        fCustomClick(Window.RelW(591), Window.RelH(1100), 34)
    }
    If (GemFarmActive) {
        GemFarmActive := false
        ToolTip(, , , 15)
        If (!Window.IsActive()) {
            cReload()
            Return
        }
        Travel.OpenTrades()
        Sleep(34)
        If (HadToRemoveBearo) {
            Out.I("F2: Equiping default loadout to reapply Bearo")
            GameKeys.EquipDefaultGearLoadout()
            HadToRemoveBearo := false
        }
        Out.I("F2: Resetting auto refresh and detailed mode.")
        ResetToPriorAutoRefresh()
        ResetToPriorDetailedMode()
        cReload()
        Return
    }
    If (TowerFarmActive) {
        TowerFarmActive := false
        Out.I("F2: Equiping default loadout.")
        GameKeys.EquipDefaultGearLoadout()
        cReload()
        Return
    }
    Out.I("F2: Pressed, reloading...")
    Sleep(2)
    ResetModifierKeys() ; Cleanup incase needed
    ResetModifierKeys() ; Twice for good luck
    cReload()
}

fCardsStart(*) { ; Open cards clicker
    Global HadToHideNotifs
    Static on3 := false
    Out.I("F3: Pressed")
    InitScriptHotKey()
    Sleep(34)
    ResetModifierKeys() ; Twice for good luck
    Sleep(34)
    If on3 := !on3 {
        If (!Window.AreGameSettingsCorrect()) {
            cReload()
            Return
        }
        fOpenCardLoop()
    } Else {
        If (HadToHideNotifs) {
            Out.I("Cards: Reenabling notifications.")
            Points.Misc.NotifArrow.Click(101)
            HadToHideNotifs := false
        }
        ResetModifierKeys() ; Cleanup incase needed
        Sleep(34)
        ResetModifierKeys() ; Twice for good luck
        Sleep(34)
        cReload()
        Return
    }
    ResetModifierKeys() ; Cleanup incase needed
    Sleep(34)
    ResetModifierKeys() ; Twice for good luck
    Sleep(34)
}

fGemFarmStart(*) { ; Gem farm using suitcase
    Global HadToRemoveBearo, GemFarmActive
    Static on4 := false
    Out.I("F4: Pressed")
    InitScriptHotKey()
    If on4 := !on4 {
        If (!Window.AreGameSettingsCorrect()) {
            cReload()
            Return
        }
        fGemFarmSuitcase()
    } Else {
        GemFarmActive := false
        ToolTip(, , , 15)
        If (!Window.IsActive()) {
            cReload()
            Return
        }
        Travel.OpenTrades()
        Sleep(34)
        If (HadToRemoveBearo) {
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
    Global TowerFarmActive
    TowerFarmActive := true
    Static on5 := false
    Out.I("F5: Pressed")
    InitScriptHotKey()
    If on5 := !on5 {
        If (!Window.AreGameSettingsCorrect()) {
            cReload()
            Return
        }
        fTimeWarpAndRaiseTower()
    } Else {
        TowerFarmActive := false
        Out.I("TowerBoost: Equiping default loadout.")
        GameKeys.EquipDefaultGearLoadout()
        cReload()
    }
}

fBorbvStart(*) { ; Borb pink juice farm in borbventures
    Static on6 := false
    Global bvAutostartDisabled
    Out.I("F6: Pressed")
    InitScriptHotKey()
    If on6 := !on6 {
        If (!Window.AreGameSettingsCorrect()) {
            cReload()
            Return
        }
        fBorbVentureJuiceFarm()
    } Else {
        If (bvAutostartDisabled = true && Travel.GotoBorbVFirstTab()) {
            ; TODO move point to Points
            fCustomClick(Window.RelW(591), Window.RelH(1100), 34)
        }
        ToolTip()
        cReload()
    }
}

fClawStart(*) { ; Claw pumpkin farm
    Static on7 := false
    Out.I("F7: Pressed")
    InitScriptHotKey()
    If on7 := !on7 {
        If (!Window.AreGameSettingsCorrect()) {
            cReload()
            Return
        }
        fClawFarm()
    } Else cReload()
}

fGFSSStart(*) { ; Green Flame/Soulseeker farm
    Static on8 := false
    Out.I("F8: Pressed")
    InitScriptHotKey()
    If on8 := !on8 {
        If (!Window.AreGameSettingsCorrect()) {
            cReload()
            Return
        }
        fFarmGFSS()
    } Else Reload()
}

fBossFarmStart(GUIMode := -1, *) { ; Farm bosses using violins
    Global on9, HadToHideNotifsF9, bvAutostartDisabled
    Out.I("F9: Pressed")
    InitScriptHotKey()
    Thread('Interrupt', 0)  ; Make all threads always-interruptible.
    If (GUIMode != -1 && IsNumber(GUIMode)) {
        on9 := GUIMode
    }
    Switch on9 {
        Case 1:
            on9 := 2 ; Brew and boss mode
            Out.I("F9: Brew and Boss Activated")
            fFarmNormalBossAndBrew(on9)
        Case 2:
            on9 := 3 ; Boss mode with borbventures
            Out.I("F9: Borbventures and Boss Activated")
            fNormalBossFarmWithBorbs(on9)
        Case 3:
            If (bvAutostartDisabled = true) {
                If (!IsBVAutoStartOn()) {
                    ; TODO move point to Points
                    fCustomClick(Window.RelW(591), Window.RelH(1100), 34)
                }
            }
            on9 := 4 ; Boss mode with cards
            If (CardsBossFarmEnabled || GUIMode != -1) {
                Out.I("F9: Cards and Boss Activated")
                fNormalBossFarmWithCards(on9)
            } Else {
                on9 := 0 ; Disabled
                Out.I("F9: Resetting with cards disabled")
                Travel.ClosePanelIfActive()
                cReload()
                Return
            }
        Case 4:
            on9 := 0 ; Disabled
            If (HadToHideNotifsF9) {
                Out.I("F9: Reenabling notifications")
                Points.Misc.NotifArrow.Click(101)
                HadToHideNotifsF9 := false
            }
            Out.I("F9: Resetting")
            ResetModifierKeys() ; Cleanup incase needed
            Travel.ClosePanelIfActive()
            cReload()
            Return
        default:
            on9 := 1 ; Normal boss mode
            If (!Window.AreGameSettingsCorrect()) {
                cReload()
                Return
            }
            Travel.ClosePanelIfActive()
            Out.I("F9: Boss Farm Activated")
            fFarmNormalBoss(on9)
    }
}

fNatureBossStart(*) { ; Farm nature boss using violins
    Static on10 := false
    Out.I("F10: Pressed")
    InitScriptHotKey()
    If (on10 := !on10) {
        If (!Window.AreGameSettingsCorrect()) {
            cReload()
            Return
        }
        fFarmNatureBoss()
    } Else Reload()
}

fAutoClicker(*) {
    Static on11 := false
    Out.I("F11: Pressed")
    ;Window.Exist()
    If (on11 := !on11) {
        While (on11) {
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
    Global DisableSettingsChecks
    Out.I("F12: Pressed")
    If (!Window.Exist()) {
        Return
    }
    If (WinGetMinMax(Window.Title) != 0) {
        WinRestore(Window.Title)
    }
    ; Changes size of client window for windows 11
    WinMove(, , 1294, 703, Window.Title)
    WinWait(Window.Title)
    Window.Exist()
    If (Window.W != "1278" || Window.H != "664") {
        Out.I(
            "Resized window to 1294*703 client size should be 1278*664, found: " Window
            .W "*" Window.H)
    }
    fCheckGameSettings()
}


fMineStart(*) {
    Static on13 := false
    Out.I("Insert: Pressed")
    InitScriptHotKey()
    If (on13 := !on13) {
        If (!Window.AreGameSettingsCorrect()) {
            cReload()
            Return
        }
        Out.I("Insert: Mine Mantainer Activated")
        fMineMaintainer()
    } Else {
        Out.I("Insert: Resetting")
        cReload()
        Return
    }
}

fHyacinthStart(*) {
    ; Farm bosses while farming Hyacinths
    Static on14 := false
    Global HyacinthFarmActive
    HyacinthFarmActive := true
    Out.I("Home: Pressed")
    InitScriptHotKey()
    If (on14 := !on14) {
        If (!Window.AreGameSettingsCorrect()) {
            cReload()
            Return
        }
        Out.I("Home: Hyacinth + Boss Activated")
        fFarmNormalBossAndNatureHyacinth()
    } Else {
        HyacinthFarmActive := false
        Out.I("Home: Resetting")
        cReload()
        Return
    }
}

fBankStart(*) {
    Static on16 := false
    Out.I("PgUp: Pressed")
    InitScriptHotKey()
    If (on16 := !on16) {
        If (!Window.AreGameSettingsCorrect()) {
            cReload()
            Return
        }
        Out.I("PgUp: Bank Maintainer Activated")
        fBankAutoDeposit()
    } Else {
        ToolTip(, , , 4)
        Out.I("PgUp: Resetting")
        cReload()
        Return
    }
}

fCursedCheeseStart(*) {
    ; Cursed Cheese Farm
    Static on18 := false

    Out.I("Del: Pressed")
    InitScriptHotKey()
    If (on18 := !on18) {
        If (!Window.AreGameSettingsCorrect()) {
            cReload()
            Return
        }
        Out.I("Del: Cursed Chees Activated")
        fFarmCheeseBoss()
    } Else {
        ToolTip(, , , 4)
        Out.I("Del: Resetting")
        cReload()
        Return
    }
}

fTowerPassiveStart(*) {
    Static on15 := false

    Out.I("End: Pressed")
    InitScriptHotKey()
    If (on15 := !on15) {
        If (!Window.AreGameSettingsCorrect()) {
            cReload()
            Return
        }
        Out.I("End: Tower Farm Passive Activated")
        fTowerFarm()
    } Else {
        ToolTip(, , , 4)
        Out.I("End: Resetting")
        cReload()
        Return
    }
}

fLeaftonStart(*) {
    Static on17 := false
    Out.I("PgDn: Pressed")
    InitScriptHotKey()
    If (on17 := !on17) {
        If (!Window.AreGameSettingsCorrect()) {
            cReload()
            Return
        }
        Out.I("PgDn: Leafton Autotaxi Activated")
        fLeaftonTaxi()
    } Else {
        ToolTip(, , , 4)
        Out.I("PgDn: Resetting")
        cReload()
        Return
    }
}

ExitFunc(ExitReason, ExitCode) {
    Out.I("Script exiting. Due to " ExitReason ".")
}