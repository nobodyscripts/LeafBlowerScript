#Requires AutoHotkey v2.0

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
#Include HarborGUI.ahk
#Include HyacinthFarmGUI.ahk
#Include LeaftonGUI.ahk
#Include MineGUI.ahk
#Include ScriptHotkeysGUI.ahk
#Include ShadowCrystalGUI.ahk
#Include TowerPassiveGUI.ahk
#Include ULCTestGUI.ahk

Button_Click_Exit(*) {
    fExitApp()
}

Button_Click_Reload(thisGui, info) {
    fReloadApp()
}

Button_Click_TowerBoost(thisGui, info) {
    fTowerBoostStart()
}

Button_Click_NatureBoss(thisGui, info) {
    fNatureBossStart()
}

Button_Click_Resize(thisGui, info) {
    fGameResize()
}

Button_Click_CursedCheese(thisGui, info) {
    fCursedCheeseStart()
}

Button_Click_SuitcaseSpam(thisGui, info) {
    fSuitcaseSpam()
}

Button_Click_PrestigeSpammer(thisGui, info) {
    fPrestigeSpammer()
}

Button_Click_SweepMouse(*) {
    Window.ActiveOrReload()
    Loop {
        MousePattern.SevenHorizontal()
        Sleep(1000)
    }
}

Button_Click_SweepMouseBuyer(*) {
    Window.ActiveOrReload()
    /** @type {cLBRButton} */
    point := Points.ZoneSample
    /** @type {cRect} */
    ButtonCol1 := cRect(1585, 183, 1590, 1148)
    Loop {
        MousePattern.SevenHorizontal()
        upgrades := true
        While (upgrades) {
            clickable := ButtonCol1.PixelSearch(point.Active)
            If (clickable != false) {
                If (cLBRButton(Window.RelW(1789), clickable[2], false).IsButtonActive()) {
                    cLBRButton(Window.RelW(1789), clickable[2], false).ClickOffset(5, 5)
                } Else {
                    cLBRButton(clickable[1], clickable[2], false).ClickOffset(5, 5)
                }
                Sleep(34)
            }
            If (!clickable) {
                upgrades := false
            }
        }
        Sleep(1000)
    }
}

Button_Click_RelicTransmute(*) {
    Shops.Relics.TransMuteResetLoop()
}

RunGui() {
    Updater.Init()
    Updater.Check()
    version := Updater.CurrentVersion.Full

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "LBR NobodyScript " Updater.CurrentVersion.Build)
    MyGui.SetUserFontSettings()

    If (Updater.IsNewRelease) {
        MyGui.AddLink("",
            "New Release Available, <a href=`"https://github.com/nobodyscripts/LeafBlowerScript`">Open Main Page</a> or <a href=`"https://github.com/nobodyscripts/LeafBlowerScript/releases`">Releases</a>"
        )
    }
    If (Updater.IsNewBeta) {
        MyGui.Add("Text", "", "New beta update available.")
        MyGui.Add("Button", "+Background" GuiBGColour "", "Update Script Beta")
        .OnEvent("Click", Updater.UpdateScriptToNewDev)
    }
    ;@region Controls

    MyGui.Add("Text", "section", Scriptkeys.GetHotkey("Exit"))
    MyGui.Add("Button", "+Background" GuiBGColour, "Exit")
    .OnEvent("Click", Button_Click_Exit)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("Reload"))
    MyGui.Add("Button", "+Background" GuiBGColour, "Reload/End")
    .OnEvent("Click", Button_Click_Reload)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("Cards"))
    MyGui.Add("Button", "+Background" GuiBGColour, "Cards Open/Buyer")
    .OnEvent("Click", Button_Click_Cards)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("GemFarm"))
    MyGui.Add("Button", "+Background" GuiBGColour, "Gem Suitcase Farm")
    .OnEvent("Click", Button_Click_GemFarm)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("TowerBoost"))
    MyGui.Add("Button", "+Background" GuiBGColour, "Tower Boost Usage`n(Run)")
    .OnEvent("Click", Button_Click_TowerBoost)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("Borbv"))
    MyGui.Add("Button", "+Background" GuiBGColour, "Borbventure Farm")
    .OnEvent("Click", Button_Click_BorbVenture)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("Claw"))
    MyGui.Add("Button", "+Background" GuiBGColour, "Claw Farm")
    .OnEvent("Click", Button_Click_Claw)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("GFSS"))
    MyGui.Add("Button", "+Background" GuiBGColour, "GFSS Boss Farm")
    .OnEvent("Click", Button_Click_GFSS)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("BossFarm"))
    MyGui.Add("Button", "+Background" GuiBGColour, "Boss Farm Mode")
    .OnEvent("Click", Button_Click_BossFarm)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("NatureBoss"))
    MyGui.Add("Button", "+Background" GuiBGColour, "Nature Boss`n(Run)")
    .OnEvent("Click", Button_Click_NatureBoss)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("AutoClicker") " Autoclicker"
    )

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("GameResize"))
    MyGui.Add("Button", "+Background" GuiBGColour, "Resize Game`n(Run)")
    .OnEvent("Click", Button_Click_Resize)

    ; ----------------------

    MyGui.Add("Text", "ys", Scriptkeys.GetHotkey("MineMaintain"))
    MyGui.Add("Button", "+Background" GuiBGColour, "Mine Maintainer")
    .OnEvent("Click", Button_Click_Mine)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("HyacinthFarm"))
    MyGui.Add("Button", "+Background" GuiBGColour, "Hyacinth Farm")
    .OnEvent("Click", Button_Click_Hyacinth)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("Bank"))
    MyGui.Add("Button", "+Background" GuiBGColour, "Bank Maintainer Mode")
    .OnEvent("Click", Button_Click_Bank)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("CursedCheese"))
    MyGui.Add("Button", "+Background" GuiBGColour, "Cursed Cheese Mode`n(Run)")
    .OnEvent("Click", Button_Click_CursedCheese)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("TowerPassive"))
    MyGui.Add("Button", "+Background" GuiBGColour, "Tower Passive Mode")
    .OnEvent("Click", Button_Click_TowerPassive)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("Leafton"))
    MyGui.Add("Button", "+Background" GuiBGColour, "Leafton Mode")
    .OnEvent("Click", Button_Click_Leafton)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("ShadowCrystal"))
    MyGui.Add("Button", "+Background" GuiBGColour, "Shadow Crystal Fight")
    .OnEvent("Click", Button_Click_ShadowCrystal)

    MyGui.Add("Text", "", "(no keybind)")
    MyGui.Add("Button", "+Background" GuiBGColour, "SuitcaseSpam LE Farm`n(Run)")
    .OnEvent("Click", Button_Click_SuitcaseSpam)

    MyGui.Add("Text", "", "(no keybind)")
    MyGui.Add("Button", "+Background" GuiBGColour, "Gold Prestige Spam`n(Run)")
    .OnEvent("Click", Button_Click_PrestigeSpammer)

    MyGui.Add("Text", "", "(no keybind)")
    MyGui.Add("Button", "+Background" GuiBGColour, "Sweep Leaves")
    .OnEvent("Click", Button_Click_SweepMouse)

    MyGui.Add("Text", "", "(no keybind)")
    MyGui.Add("Button", "+Background" GuiBGColour, "Sweep Leaves with Autobuyer")
    .OnEvent("Click", Button_Click_SweepMouseBuyer)

    ; ----------------------

    MyGui.Add("Text", "ys", "(no keybind)")
    MyGui.Add("Button", "+Background" GuiBGColour, "ULC TEST")
    .OnEvent("Click", Button_Click_ULC)

    MyGui.Add("Text", "", "(no keybind)")
    MyGui.Add("Button", "+Background" GuiBGColour, "Fishing")
    .OnEvent("Click", Button_Click_Fishing)

    MyGui.Add("Text", "", "(no keybind)")
    MyGui.Add("Button", "+Background" GuiBGColour, "Fishing Challenge")
    .OnEvent("Click", Button_Click_FishingChallenge)

    MyGui.Add("Text", "", "(no keybind)")
    MyGui.Add("Button", "+Background" GuiBGColour, "Fishing Tourney")
    .OnEvent("Click", Button_Click_FishingTourney)

    MyGui.Add("Text", "", "(no keybind)")
    MyGui.Add("Button", "+Background" GuiBGColour, "Transmute relic reset loop")
    .OnEvent("Click", Button_Click_RelicTransmute)

    MyGui.Add("Text", "", "(no keybind)")
    MyGui.Add("Button", "+Background" GuiBGColour, "Harbor Manager")
    .OnEvent("Click", Button_Click_Harbor)

    MyGui.Add("Text", "", "")
    MyGui.Add("Button", "+Background" GuiBGColour, "Edit Script Hotkeys")
    .OnEvent("Click", Button_Click_ScriptHotkeys)

    MyGui.Add("Text", "", "")
    MyGui.Add("Button", "+Background" GuiBGColour, "Edit Game Hotkeys")
    .OnEvent("Click", Button_Click_GameHotkeys)

    MyGui.Add("Text", "", "")
    MyGui.Add("Button", "+Background" GuiBGColour, "Update game settings`n"
        "For script use")
    .OnEvent("Click", fGameSettings)

    MyGui.Add("Text", "", "General Settings")
    MyGui.Add("Button", "+Background" GuiBGColour, "Settings")
    .OnEvent("Click", Button_Click_GeneralSettings)

    MyGui.AddText("xs", "")
    MyGui.AddText("xs", "LBR NobodyScript " version)

    ;@endregion

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))
    MyGui.OnEvent("Close", Button_Click_Exit)
}
