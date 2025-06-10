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
        MyBtn := MyGui.Add("Button", "+Background" GuiBGColour "", "Update Script Beta")
        MyBtn.OnEvent("Click", Updater.UpdateScriptToNewDev)
    }
    ;@region Controls

    MyGui.Add("Text", "section", Scriptkeys.GetHotkey("Exit"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Exit")
    MyBtn.OnEvent("Click", Button_Click_Exit)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("Reload"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Reload/End")
    MyBtn.OnEvent("Click", Button_Click_Reload)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("Cards"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Cards Open/Buyer")
    MyBtn.OnEvent("Click", Button_Click_Cards)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("GemFarm"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Gem Suitcase Farm")
    MyBtn.OnEvent("Click", Button_Click_GemFarm)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("TowerBoost"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Tower Boost Usage`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_TowerBoost)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("Borbv"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Borbventure Farm")
    MyBtn.OnEvent("Click", Button_Click_BorbVenture)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("Claw"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Claw Farm")
    MyBtn.OnEvent("Click", Button_Click_Claw)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("GFSS"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "GFSS Boss Farm")
    MyBtn.OnEvent("Click", Button_Click_GFSS)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("BossFarm"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Boss Farm Mode")
    MyBtn.OnEvent("Click", Button_Click_BossFarm)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("NatureBoss"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Nature Boss`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_NatureBoss)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("AutoClicker") " Autoclicker"
    )

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("GameResize"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Resize Game`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_Resize)

    ; ----------------------

    MyGui.Add("Text", "ys", Scriptkeys.GetHotkey("MineMaintain"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Mine Maintainer")
    MyBtn.OnEvent("Click", Button_Click_Mine)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("HyacinthFarm"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Hyacinth Farm")
    MyBtn.OnEvent("Click", Button_Click_Hyacinth)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("Bank"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Bank Maintainer Mode")
    MyBtn.OnEvent("Click", Button_Click_Bank)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("CursedCheese"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Cursed Cheese Mode`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_CursedCheese)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("TowerPassive"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Tower Passive Mode")
    MyBtn.OnEvent("Click", Button_Click_TowerPassive)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("Leafton"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Leafton Mode")
    MyBtn.OnEvent("Click", Button_Click_Leafton)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("ShadowCrystal"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Shadow Crystal Fight")
    MyBtn.OnEvent("Click", Button_Click_ShadowCrystal)

    MyGui.Add("Text", "", "(no keybind)")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "SuitcaseSpam LE Farm`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_SuitcaseSpam)

    MyGui.Add("Text", "", "(no keybind)")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Gold Prestige Spam`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_PrestigeSpammer)

    ; ----------------------

    MyGui.Add("Text", "ys", "(no keybind)")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "ULC TEST")
    MyBtn.OnEvent("Click", Button_Click_ULC)

    MyGui.Add("Text", "", "(no keybind)")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Fishing")
    MyBtn.OnEvent("Click", Button_Click_Fishing)

    MyGui.Add("Text", "", "(no keybind)")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Fishing Challenge")
    MyBtn.OnEvent("Click", Button_Click_FishingChallenge)

    MyGui.Add("Text", "", "(no keybind)")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Fishing Tourney")
    MyBtn.OnEvent("Click", Button_Click_FishingTourney)

    MyGui.Add("Text", "", "")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Edit Script Hotkeys")
    MyBtn.OnEvent("Click", Button_Click_ScriptHotkeys)

    MyGui.Add("Text", "", "")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Edit Game Hotkeys")
    MyBtn.OnEvent("Click", Button_Click_GameHotkeys)

    MyGui.Add("Text", "", "")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Update game settings`n"
        "For script use")
    MyBtn.OnEvent("Click", fGameSettings)

    MyGui.Add("Text", "", "General Settings")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Settings")
    MyBtn.OnEvent("Click", Button_Click_GeneralSettings)

    MyGui.AddText("xs", "")
    MyGui.AddText("xs", "LBR NobodyScript " version)

    ;@endregion

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))
}
