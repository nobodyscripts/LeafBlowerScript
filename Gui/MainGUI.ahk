#Requires AutoHotkey v2.0

#Include GeneralSettingsGUI.ahk

#Include BankGUI.ahk
#Include BorbVenturesGUI.ahk
#Include BossFarmGUI.ahk
#Include CardsGUI.ahk
#Include ClawGUI.ahk
#Include GameHotkeysGUI.ahk
#Include GemFarmGUI.ahk
#Include GFSSFarmGUI.ahk
#Include HyacinthFarmGUI.ahk
#Include LeaftonGUI.ahk
#Include MineGUI.ahk
#Include ScriptHotkeysGUI.ahk
#Include TowerPassiveGUI.ahk

Button_Click_Exit(*) {
    fExitApp()
}

Button_Click_Reload(thisGui, info) {
    fReloadApp()
}

Button_Click_TowerBoost(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fTowerBoostStart()
}

Button_Click_NatureBoss(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fNatureBossStart()
}

Button_Click_Resize(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fGameResize()
}

Button_Click_CursedCheese(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fCursedCheeseStart()
}

Button_Click_SuitcaseSpam(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fSuitcaseSpam()
}

Button_Click_PrestigeSpammer(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fPrestigeSpammer()
}


RunGui() {
    if (!Debug) {
        MyGui := Gui(, "LBR NobodyScript")
    } else {
        MyGui := Gui(, "LBR TEST")
    }
    ;MyGui.Opt("-SysMenu")
    MyGui.BackColor := "0c0018"

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("Exit"))
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

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("AutoClicker") " Autoclicker")

    MyGui.Add("Text", "ccfcfcf", Scriptkeys.GetHotkey("GameResize"))
    MyBtn := MyGui.Add("Button", "Default w120", "Resize Game`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_Resize)

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

    MyGui.Add("Text", "ccfcfcf", "Test (no keybind)")
    MyBtn := MyGui.Add("Button", "Default w120", "SuitcaseSpam Test`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_SuitcaseSpam)

    MyGui.Add("Text", "ccfcfcf", "Test (no keybind)")
    MyBtn := MyGui.Add("Button", "Default w120", "Gold Prestige Spam`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_PrestigeSpammer)

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

    MyGui.Show()

    MyGui.OnEvent("Close", Button_Click_Exit)
}