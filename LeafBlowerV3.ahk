﻿#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#SingleInstance Force
#Warn All, StdOut

; ------------------- Readme -------------------
/**
 * See Readme.md for readme
 * Run this file to load script, run this to activate gui and hotkeys
 */

; Applying these first incase self run functions in includes require them

/** Using Out instead of Log as thats taken by a func
 * @type {cLog} Global cLog object */
Global Out := cLog(A_ScriptDir "\LeafBlowerV3.Log", true, 3, true)

/** @type {cLBRWindow} */
Global Window := cLBRWindow("Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe", 2560, 1369)

#Include ScriptLib\cSettings.ahk
#Include Lib\ScriptSettingsInit.ahk
#Include ScriptLib\cLogging.ahk
#Include Lib\cLBRWindow.ahk
#Include ScriptLib\cHotkey.ahk
#Include ScriptLib\cGUI.ahk
#Include ScriptLib\Misc.ahk
#Include ScriptLib\cToolTip.ahk
#Include ScriptLib\cUpdateChecker.ahk

#Include Lib\Misc.ahk
#Include Lib\Navigate.ahk
#Include Lib\Spammers.ahk
#Include Lib\cHotkeysInitGame.ahk
#Include Lib\cHotkeysInitScript.ahk
#Include Lib\CheckGameSettings.ahk

#Include Gui\MainGUI.ahk
#Include Modules\Header.ahk

SendMode("Input") ; Support for vm
; Can be Input, Event, Play, InputThenPlay if Input doesn't work for you

DetectHiddenWindows(true)
Persistent() ; Prevent the script from exiting automatically.

Global GameSaveDir := A_AppData "\..\Local\blow_the_leaves_away\"
Global ActiveSavePath := GameSaveDir "save.dat"
Global ActiveGameSettingsPath := GameSaveDir "options.dat"

Updater.ZipDownload := "https://github.com/nobodyscripts/LeafBlowerScript/archive/refs/heads/main.zip"
Updater.ZipFolder := "LeafBlowerScript-main"
Updater.RemoteJson := "https://raw.githubusercontent.com/nobodyscripts/LeafBlowerScript/main/Version.json"
Updater.ScriptName := "LBR NobodyScript"

Scriptkeys.sFilename := A_ScriptDir "\ScriptHotkeys.ini"
Scriptkeys.initHotkeys()
GameKeys.sFilename := A_ScriptDir "\UserHotkeys.ini"
GameKeys.initHotkeys()

Global HadToHideNotifsF9 := false

If (!S.initSettings()) {
    MsgBox(
        "Script failed to load settings, script closing, try restarting.")
    ExitApp()
}

Out.I("Script loaded")
RunGui()
; Setup script hotkeys
CreateScriptHotkeys()

; ------------------- Script Triggers -------------------

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
    Hotkey("*" Scriptkeys.GetHotkey("ShadowCrystal"), fShadowCrystalStart)
}

#HotIf WinActive(Window.Title) and MouseIsOver(Window.Title) and S.Get("Debug")
    ~LButton:: {
        screenx := screeny := windowx := windowy := clientx := clienty := 0
        CoordMode("Mouse", "Screen")
        MouseGetPos(&screenx, &screeny)
        CoordMode("Mouse", "Window")
        MouseGetPos(&windowx, &windowy)
        CoordMode("Mouse", "Client")
        MouseGetPos(&clientx, &clienty)

        Out.D(
            ;"Screen:`t" screenx ", " screeny "`n"
            ;"Window:`t" windowx ", " windowy "`n"
            "Mouse1 click Client: " clientx ", " clienty " Color: #" SubStr(PixelGetColor(clientx, clienty), 3)
            " - pos-1: " clientx - 1 ", " clienty - 1 " Color: #" SubStr(PixelGetColor(clientx - 1, clienty - 1), 3)
            ;"Current zone colour: " Points.ZoneSample.GetColour()
        )
        A_Clipboard := "cLBRButton(" clientx ", " clienty ")"
    }

    ~WheelDown:: {
        Out.D("Wheel down")
    }

    ~WheelUp:: {
        Out.D("Wheel up")
    }

    ~+WheelDown:: {
        Out.D("Wheel down *7")
    }

    ~+WheelUp:: {
        Out.D("Wheel up *7")
    }

    ~*WheelDown:: {
        Out.D("Wheel down *")
    }

    ~*WheelUp:: {
        Out.D("Wheel up *")
    }

    MouseIsOver(WinTitle) {
        MouseGetPos , , &Win
        Return WinExist(WinTitle " ahk_id " Win)
    }
    /* Numpad1:: {
        testArea := RelSampleArea()
        testArea.SetCoordRel(470, 290, 819, 448)
        results := testArea.OCRArea()
        MsgBox(results.Text)
    } */

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
        If (!Window.ActiveOrReload()) {
            Return
        }
        If (HadToHideNotifs) {
            Out.I("F2: Reenabling notifications.")
            Points.Misc.NotifArrow.Click(101)
            HadToHideNotifs := false
        }
        If (bvAutostartDisabled = true) {
            ; TODO move point to Points
            bvAutoStart := cLBRButton(591, 1100)
            bvAutoStart.ClickOffset()
        }
        If (GemFarmActive) {
            GemFarmActive := false
            ToolTip(, , , 15)
            Shops.OpenTrades()
            Sleep(34)
            If (HadToRemoveBearo) {
                Out.I("F2: Equiping default loadout to reapply Bearo")
                GameKeys.EquipDefaultGearLoadout()
                HadToRemoveBearo := false
            }
            Out.I("F2: Resetting auto refresh and detailed mode.")
            ResetToPriorAutoRefresh()
            ResetToPriorDetailedMode()
            Reload()
            Return
        }
        If (TowerFarmActive) {
            TowerFarmActive := false
            Out.I("F2: Equiping default loadout.")
            GameKeys.EquipDefaultGearLoadout()
            Reload()
            Return
        }
        Out.I("F2: Pressed, reloading...")
        Sleep(2)
        ResetModifierKeys() ; Cleanup incase needed
        ResetModifierKeys() ; Twice for good luck
        Reload()
    }

    fCardsStart(*) { ; Open cards clicker
        If (!Window.ActiveOrReload()) {
            Return
        }
        Global HadToHideNotifs
        Static on3 := false
        Out.I("F3: Pressed")
        InitScriptHotKey()
        Sleep(34)
        ResetModifierKeys() ; Twice for good luck
        Sleep(34)
        If on3 := !on3 {
            If (!Window.AreGameSettingsCorrect()) {
                Reload()
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
            Reload()
            Return
        }
        ResetModifierKeys() ; Cleanup incase needed
        Sleep(34)
        ResetModifierKeys() ; Twice for good luck
        Sleep(34)
    }

    fGemFarmStart(*) { ; Gem farm using suitcase
        If (!Window.ActiveOrReload()) {
            Return
        }
        Global HadToRemoveBearo, GemFarmActive
        Static on4 := false
        Out.I("F4: Pressed")
        InitScriptHotKey()
        If on4 := !on4 {
            If (!Window.AreGameSettingsCorrect()) {
                Reload()
                Return
            }
            fGemFarmSuitcase()
        } Else {
            GemFarmActive := false
            ToolTip(, , , 15)
            If (!Window.IsActive()) {
                Reload()
                Return
            }
            Shops.OpenTrades()
            Sleep(34)
            If (HadToRemoveBearo) {
                Out.I("F4: Equiping default loadout to reapply Bearo")
                GameKeys.EquipDefaultGearLoadout()
                HadToRemoveBearo := false
            }
            Out.I("F4: Resetting auto refresh and detailed mode.")
            ResetToPriorAutoRefresh()
            ResetToPriorDetailedMode()
            Reload()
        }
    }

    fTowerBoostStart(*) { ; Tower 72hr boost loop
        If (!Window.ActiveOrReload()) {
            Return
        }
        Global TowerFarmActive
        TowerFarmActive := true
        Static on5 := false
        Out.I("F5: Pressed")
        InitScriptHotKey()
        If on5 := !on5 {
            If (!Window.AreGameSettingsCorrect()) {
                Reload()
                Return
            }
            fTimeWarpAndRaiseTower()
        } Else {
            TowerFarmActive := false
            Out.I("TowerBoost: Equiping default loadout.")
            GameKeys.EquipDefaultGearLoadout()
            Reload()
        }
    }

    fBorbvStart(*) { ; Borb pink juice farm in borbventures
        If (!Window.ActiveOrReload()) {
            Return
        }
        Static on6 := false
        Global bvAutostartDisabled
        Out.I("F6: Pressed")
        InitScriptHotKey()
        If on6 := !on6 {
            If (!Window.AreGameSettingsCorrect()) {
                Reload()
                Return
            }
            fBorbVentureJuiceFarm()
        } Else {
            If (bvAutostartDisabled = true && Shops.GotoBorbVFirstTab()) {
                ; TODO move point to Points
                fCustomClick(Window.RelW(591), Window.RelH(1100), 34)
            }
            ToolTip()
            Reload()
        }
    }

    fClawStart(*) { ; Claw pumpkin farm
        Window.StartOrReload()
        Out.I("F7: Pressed")
        InitScriptHotKey()
        If (!Window.AreGameSettingsCorrect()) {
            Reload()
            Return
        }
        fClawFarm()
    }

    fGFSSStart(*) { ; Green Flame/Soulseeker farm
        Window.StartOrReload()
        Out.I("F8: Pressed")
        InitScriptHotKey()
        If (!Window.AreGameSettingsCorrect()) {
            Reload()
            Return
        }
        fFarmGFSS()
    }

    fBossFarmStart(GUIMode := -1, *) { ; Farm bosses using violins
        Window.ActiveOrReload()
        CardsBossFarmEnabled := S.Get("CardsBossFarmEnabled")
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
                Reload()
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
            Reload()
            Return
        default:
            on9 := 1 ; Normal boss mode
            If (!Window.AreGameSettingsCorrect()) {
                Reload()
                Return
            }
            Travel.ClosePanelIfActive()
            Out.I("F9: Boss Farm Activated")
            fFarmNormalBoss(on9)
        }
    }

    fNatureBossStart(*) { ; Farm nature boss using violins
        Window.StartOrReload()
        Out.I("F10: Pressed")
        InitScriptHotKey()
        If (!Window.AreGameSettingsCorrect()) {
            Reload()
            Return
        }
        fFarmNatureBoss()
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
            Reload()
        }
    }

    fGameResize(*) {
        Out.I("F12: Pressed")
        Window.ActiveOrReload()
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
        Window.StartOrReload()
        Static on13 := false
        Out.I("Insert: Pressed")
        InitScriptHotKey()
        If (!Window.AreGameSettingsCorrect()) {
            Reload()
            Return
        }
        Out.I("Insert: Mine Mantainer Activated")
        fMineMaintainer()
    }

    fHyacinthStart(*) {
        Window.StartOrReload()
        ; Farm bosses while farming Hyacinths
        Out.I("Home: Pressed")
        InitScriptHotKey()
        If (!Window.AreGameSettingsCorrect()) {
            Reload()
            Return
        }
        Out.I("Home: Hyacinth + Boss Activated")
        fFarmNormalBossAndNatureHyacinth()
    }

    fBankStart(*) {
        Window.StartOrReload()
        Out.I("PgUp: Pressed")
        InitScriptHotKey()
        If (!Window.AreGameSettingsCorrect()) {
            Reload()
            Return
        }
        Out.I("PgUp: Bank Maintainer Activated")
        fBankAutoDeposit()
    }

    fCursedCheeseStart(*) {
        Window.StartOrReload()
        ; Cursed Cheese Farm
        Out.I("Del: Pressed")
        InitScriptHotKey()
        If (!Window.AreGameSettingsCorrect()) {
            Reload()
            Return
        }
        Out.I("Del: Cursed Chees Activated")
        fFarmCheeseBoss()
    }

    fTowerPassiveStart(*) {
        Window.StartOrReload()
        Out.I("End: Pressed")
        InitScriptHotKey()
        If (!Window.AreGameSettingsCorrect()) {
            Reload()
            Return
        }
        Out.I("End: Tower Farm Passive Activated")
        fTowerFarm()
    }

    fLeaftonStart(*) {
        Window.StartOrReload()
        Out.I("PgDn: Pressed")
        InitScriptHotKey()
        If (!Window.AreGameSettingsCorrect()) {
            Reload()
            Return
        }
        Out.I("PgDn: Leafton Autotaxi Activated")
        fLeaftonTaxi()
    }

    fShadowCrystalStart(*) {
        Window.StartOrReload()
        Out.I("Numpad9: Pressed")
        InitScriptHotKey()
        If (!Window.Exist()) {
            Return
        }
        Out.I("Numpad9: Shadow Crystal Fight Activated")
        fShadowCrystalFight()
    }
