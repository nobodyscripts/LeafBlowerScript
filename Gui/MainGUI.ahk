#Requires AutoHotkey v2.0

#Include ..\Lib\CheckForUpdates.ahk

#Include GeneralSettingsGUI.ahk

#Include BankGUI.ahk
#Include BorbVenturesGUI.ahk
#Include BossFarmGUI.ahk
#Include CardsGUI.ahk
#Include ClawGUI.ahk
#Include FishingGUI.ahk
#Include FishingChallengeGUI.ahk
#Include FishingTourneyGUI.ahk
#Include GameHotkeysGUI.ahk
#Include GemFarmGUI.ahk
#Include GFSSFarmGUI.ahk
#Include HyacinthFarmGUI.ahk
#Include LeaftonGUI.ahk
#Include MineGUI.ahk
#Include ScriptHotkeysGUI.ahk
#Include ShadowCrystalGUI.ahk
#Include TowerPassiveGUI.ahk

#Include ULCTestGUI.ahk
#Include ..\Modules\Fishing.ahk

Button_Click_Exit(*) {
    fExitApp()
}

Button_Click_Reload(thisGui, info) {
    fReloadApp()
}

Button_Click_TowerBoost(thisGui, info) {
    Window.Activate()
    fTowerBoostStart()
}

Button_Click_NatureBoss(thisGui, info) {
    Window.Activate()
    fNatureBossStart()
}

Button_Click_Resize(thisGui, info) {
    Window.Activate()
    fGameResize()
}

Button_Click_CursedCheese(thisGui, info) {
    Window.Activate()
    fCursedCheeseStart()
}

Button_Click_SuitcaseSpam(thisGui, info) {
    Window.Activate()
    fSuitcaseSpam()
}

Button_Click_PrestigeSpammer(thisGui, info) {
    Window.Activate()
    fPrestigeSpammer()
}

RunGui() {
    Global Updater
    Updater.Init()
    Updater.Check()
    version := Updater.CurrentVersion.Full
    If (!Debug) {
        /** @type {GUI} */
        MyGui := Gui(, "LBR NobodyScript " Updater.CurrentVersion.Build)
    } Else {
        /** @type {GUI} */
        MyGui := Gui(, "LBR TEST " Updater.CurrentVersion.Build)
    }
    If (Updater.IsNewRelease) {
        MyGui.AddLink("ccfcfcf",
            "New Release Available, <a href=`"https://github.com/nobodyscripts/LeafBlowerScript`">Open Main Page</a> or <a href=`"https://github.com/nobodyscripts/LeafBlowerScript/releases`">Releases</a>"
        )
    }
    If (Updater.IsNewBeta) {
        MyGui.AddLink("ccfcfcf",
            "New Update Available, <a href=`"https://github.com/nobodyscripts/LeafBlowerScript'>Open Main Page</a> or <a href=`"https://github.com/nobodyscripts/LeafBlowerScript/archive/refs/heads/main.zip`">Direct Download</a>"
        )
    }
    ;MyGui.Opt("-SysMenu")
    MyGui.BackColor := "0c0018"

    MyGui.Add("Text", "ccfcfcf section", Scriptkeys.GetHotkey("Exit"))
    MyBtn := MyGui.Add("Button", "Default w80", "Exit")
    MyBtn.OnEvent("Click", Button_Click_Exit)

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("Reload"))
    MyBtn := MyGui.Add("Button", "Default w80", "Reload/End")
    MyBtn.OnEvent("Click", Button_Click_Reload)

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("Cards"))
    MyBtn := MyGui.Add("Button", "Default w120", "Cards Open/Buyer")
    MyBtn.OnEvent("Click", Button_Click_Cards)

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("GemFarm"))
    MyBtn := MyGui.Add("Button", "Default w120", "Gem Suitcase Farm")
    MyBtn.OnEvent("Click", Button_Click_GemFarm)

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("TowerBoost"))
    MyBtn := MyGui.Add("Button", "Default w120", "Tower Boost Usage`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_TowerBoost)

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("Borbv"))
    MyBtn := MyGui.Add("Button", "Default w120", "Borbventure Farm")
    MyBtn.OnEvent("Click", Button_Click_BorbVenture)

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("Claw"))
    MyBtn := MyGui.Add("Button", "Default w120", "Claw Farm")
    MyBtn.OnEvent("Click", Button_Click_Claw)

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("GFSS"))
    MyBtn := MyGui.Add("Button", "Default w120", "GFSS Boss Farm")
    MyBtn.OnEvent("Click", Button_Click_GFSS)

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("BossFarm"))
    MyBtn := MyGui.Add("Button", "Default w120", "Boss Farm Mode")
    MyBtn.OnEvent("Click", Button_Click_BossFarm)

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("NatureBoss"))
    MyBtn := MyGui.Add("Button", "Default w120", "Nature Boss`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_NatureBoss)

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("AutoClicker") " Autoclicker"
    )

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("GameResize"))
    MyBtn := MyGui.Add("Button", "Default w120", "Resize Game`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_Resize)

    ; ----------------------

    MyGui.Add("Text", "ys ccfcfcf", Scriptkeys.GetHotkey("MineMaintain"))
    MyBtn := MyGui.Add("Button", "Default w120", "Mine Maintainer")
    MyBtn.OnEvent("Click", Button_Click_Mine)

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("HyacinthFarm"))
    MyBtn := MyGui.Add("Button", "Default w120", "Hyacinth Farm")
    MyBtn.OnEvent("Click", Button_Click_Hyacinth)

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("Bank"))
    MyBtn := MyGui.Add("Button", "Default w120", "Bank Maintainer Mode")
    MyBtn.OnEvent("Click", Button_Click_Bank)

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("CursedCheese"))
    MyBtn := MyGui.Add("Button", "Default w120", "Cursed Cheese Mode`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_CursedCheese)

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("TowerPassive"))
    MyBtn := MyGui.Add("Button", "Default w120", "Tower Passive Mode")
    MyBtn.OnEvent("Click", Button_Click_TowerPassive)

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("Leafton"))
    MyBtn := MyGui.Add("Button", "Default w120", "Leafton Mode")
    MyBtn.OnEvent("Click", Button_Click_Leafton)

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("ShadowCrystal"))
    MyBtn := MyGui.Add("Button", "Default w120", "Shadow Crystal Fight")
    MyBtn.OnEvent("Click", Button_Click_ShadowCrystal)

    MyGui.Add("Text", "ccfcfcf", "(no keybind)")
    MyBtn := MyGui.Add("Button", "Default w120", "SuitcaseSpam LE Farm`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_SuitcaseSpam)

    MyGui.Add("Text", "ccfcfcf", "(no keybind)")
    MyBtn := MyGui.Add("Button", "Default w120", "Gold Prestige Spam`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_PrestigeSpammer)

    ; ----------------------

    MyGui.Add("Text", "ys ccfcfcf", "(no keybind)")
    MyBtn := MyGui.Add("Button", "Default w120", "ULC TEST")
    MyBtn.OnEvent("Click", Button_Click_ULC)

    MyGui.Add("Text", "ccfcfcf", "(no keybind)")
    MyBtn := MyGui.Add("Button", "Default w120", "Fishing")
    MyBtn.OnEvent("Click", Button_Click_Fishing)

    MyGui.Add("Text", "ccfcfcf", "(no keybind)")
    MyBtn := MyGui.Add("Button", "Default w120", "Fishing Challenge")
    MyBtn.OnEvent("Click", Button_Click_FishingChallenge)

    MyGui.Add("Text", "ccfcfcf", "(no keybind)")
    MyBtn := MyGui.Add("Button", "Default w120", "Fishing Tourney")
    MyBtn.OnEvent("Click", Button_Click_FishingTourney)

    MyGui.Add("Text", "ccfcfcf", "")
    MyBtn := MyGui.Add("Button", "Default w120", "Edit Script Hotkeys")
    MyBtn.OnEvent("Click", Button_Click_ScriptHotkeys)

    MyGui.Add("Text", "ccfcfcf", "")
    MyBtn := MyGui.Add("Button", "Default w120", "Edit Game Hotkeys")
    MyBtn.OnEvent("Click", Button_Click_GameHotkeys)

    MyGui.Add("Text", "ccfcfcf", "")
    MyBtn := MyGui.Add("Button", "Default w120", "Update game settings`n"
        "For script use")
    MyBtn.OnEvent("Click", fGameSettings)

    MyGui.Add("Text", "ccfcfcf", "General Settings")
    MyBtn := MyGui.Add("Button", "Default w120", "Settings")
    MyBtn.OnEvent("Click", Button_Click_GeneralSettings)

    MyGui.AddText("ccfcfcf xs", "")
    MyGui.AddText("ccfcfcf xs", "LBR NobodyScript " version)

    ShowGUIPosition(MyGui)
    MyGui.OnEvent("Close", Button_Click_Exit)
    MyGui.OnEvent("Size", SaveGUIPositionOnResize)
    OnMessage(0x0003, SaveGUIPositionOnMove)
}

ShowGUIPosition(thisGUI) {
    SplitTitle := StrSplit(thisGUI.Title, " ")
    Title := thisGUI.Title
    If (SplitTitle[1] = "LBR") {
        Title := SplitTitle[1] " " SplitTitle[2]
    }
    Try {
        arr := Settings.IniToVar(Title, "GUIPosition")
    } Catch Error As OutputVar {
        If (OutputVar.Message = "The requested key, section or file was not found.") {
            Out.I("No window position stored for " Title)
            thisGUI.Show()
            Return
        }
        Out.E(OutputVar)
        Return
    }
    coords := StrSplit(arr, ",", " ")
    guiX := coords[1]
    guiY := coords[2]
    If (coords.Length > 2) {
        guiW := coords[3]
        guiH := coords[4]
        thisGUI.Show("x" guiX " y" guiY " w" guiW " h" guiH)
    } Else {
        thisGUI.Show("x" guiX " y" guiY)
    }
}

ResetGUIPosition(thisGUI) {
    SplitTitle := StrSplit(thisGUI.Title, " ")
    Title := thisGUI.Title
    If (SplitTitle[1] = "LBR") {
        Title := SplitTitle[1] " " SplitTitle[2]
    }
    Try {
        arr := Settings.IniToVar(Title, "GUIPosition")
    } Catch Error As OutputVar {
        If (OutputVar.Message = "The requested key, section or file was not found.") {
            Out.I("No window position stored for " Title)
            Return
        }
        Out.E(OutputVar)
        Return
    }
    coords := StrSplit(arr, ",", " ")
    guiX := coords[1]
    guiY := coords[2]
    If (coords.Length > 2) {
        guiW := coords[3]
        guiH := coords[4]
        WinMove(guiX, guiY, guiW, guiH, thisGUI.Title)
    } Else {
        WinMove(guiX, guiY, , , thisGUI.Title)
    }
}

StorePos(thisGUI, resize := false) {
    Static StorePosLock := false

    If (Type(thisGUI) = "Gui" && !StorePosLock) {
        StorePosLock := true
        WinGetPos(&guiX, &guiY, &guiW, &guiH, thisGUI.Title)
        Sleep(500)
        Global Settings
        If (WinExist(thisGUI.Title)) {
            WinGetPos(&guiX, &guiY, &guiW, &guiH, thisGUI.Title)
        }
        SplitTitle := StrSplit(thisGUI.Title, " ")
        Title := thisGUI.Title
        If (SplitTitle[1] = "LBR") {
            Title := SplitTitle[1] " " SplitTitle[2]
        }
        ;Out.I("Written window pos " thisGUI.Title " X" guiX " Y" guiY)
        If (!resize) {
            Settings.WriteToIni(Title, guiX "," guiY, "GUIPosition")
        } Else {
            Settings.WriteToIni(Title, guiX "," guiY "," guiW "," guiH, "GUIPosition")
        }
        StorePosLock := false
    }
}

SaveGUIPositionOnMove(Wparam, Lparam, Msg, Hwnd) {
    ;Out.D("onmessage " Wparam " " Lparam " " Msg " " Hwnd)
    thisGUI := GuiFromHwnd(Hwnd)
    SetTimer(StorePos.Bind(thisGUI), -500)
}

SaveGUIPositionOnResize(thisGUI, MinMax, Width, Height) {
    SetTimer(StorePos.Bind(thisGUI, true), -500)
}
