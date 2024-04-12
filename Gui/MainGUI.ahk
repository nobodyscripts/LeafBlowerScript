#Requires AutoHotkey v2.0

Button_Click_Exit(thisGui, info) {
    fExitApp()
}

Button_Click_Reload(thisGui, info) {
    fReloadApp()
}

Button_Click_Cards(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fCardsStart()

}

Button_Click_GemFarm(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fGemFarmStart()
}

Button_Click_TowerBoost(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fTowerBoostStart()
}

Button_Click_BorbVenture(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fBorbvStart()
}

Button_Click_Claw(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fClawStart()
}

Button_Click_GFSS(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fGFSSStart()
}

Button_Click_BossFarm(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fBossFarmStart()
}

Button_Click_NatureBoss(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fNatureBossStart()
}

Button_Click_Resize(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fGameResize()
}


Button_Click_Hyacinth(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fHyacinthStart()
}

Button_Click_TowerPassive(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fTowerPassiveStart()
}

Button_Click_Bank(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fBankStart()
}

Button_Click_Leafton(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fLeaftonStart()
}

Button_Click_CursedCheese(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fCursedCheeseStart()
}
/*
Button_Click_Hyacinth(thisGui, info) {
    WinActivate(LBRWindowTitle)
    fHyacinthStart()
} */

RunGui() {
    MyGui := Gui(, "LBR NobodyScript")
    MyGui.Opt("-SysMenu")
    MyGui.BackColor := "0c0018"


    MyGui.Add("Text", "ccfcfcf", "F1")
    MyBtn := MyGui.Add("Button", "Default w80", "Exit")
    MyBtn.OnEvent("Click", Button_Click_Exit)

    MyGui.Add("Text", "ccfcfcf", "F2")
    MyBtn := MyGui.Add("Button", "Default w80", "Reload")
    MyBtn.OnEvent("Click", Button_Click_Reload)

    MyGui.Add("Text", "ccfcfcf", "F3")
    MyBtn := MyGui.Add("Button", "Default w120", "Cards Open/Buyer")
    MyBtn.OnEvent("Click", Button_Click_Cards)

    MyGui.Add("Text", "ccfcfcf", "F4")
    MyBtn := MyGui.Add("Button", "Default w120", "Gem Suitcase Farm")
    MyBtn.OnEvent("Click", Button_Click_GemFarm)

    MyGui.Add("Text", "ccfcfcf", "F5")
    MyBtn := MyGui.Add("Button", "Default w120", "Tower Boost Usage")
    MyBtn.OnEvent("Click", Button_Click_TowerBoost)

    MyGui.Add("Text", "ccfcfcf", "F6")
    MyBtn := MyGui.Add("Button", "Default w120", "Borbventure Farm")
    MyBtn.OnEvent("Click", Button_Click_BorbVenture)

    MyGui.Add("Text", "ccfcfcf", "F7")
    MyBtn := MyGui.Add("Button", "Default w120", "Claw Farm")
    MyBtn.OnEvent("Click", Button_Click_Claw)

    MyGui.Add("Text", "ccfcfcf", "F8")
    MyBtn := MyGui.Add("Button", "Default w120", "GFSS Boss Farm")
    MyBtn.OnEvent("Click", Button_Click_GFSS)

    MyGui.Add("Text", "ccfcfcf", "F9")
    MyBtn := MyGui.Add("Button", "Default w120", "Boss Farm Mode")
    MyBtn.OnEvent("Click", Button_Click_BossFarm)

    MyGui.Add("Text", "ccfcfcf", "F10")
    MyBtn := MyGui.Add("Button", "Default w120", "Nature Boss")
    MyBtn.OnEvent("Click", Button_Click_NatureBoss)

    MyGui.Add("Text", "ccfcfcf", "F11 Autoclicker")

    MyGui.Add("Text", "ccfcfcf", "F12")
    MyBtn := MyGui.Add("Button", "Default w120", "Resize Game")
    MyBtn.OnEvent("Click", Button_Click_Resize)

    MyGui.Add("Text", "ys ccfcfcf", "Insert")
    MyBtn := MyGui.Add("Button", "Default w120", "Mine Maintainer")
    MyBtn.OnEvent("Click", Button_Click_Mine)

    MyGui.Add("Text", "ccfcfcf", "Home")
    MyBtn := MyGui.Add("Button", "Default w120", "Hyacinth Farm")
    MyBtn.OnEvent("Click", Button_Click_Hyacinth)

    MyGui.Add("Text", "ccfcfcf", "PageUp")
    MyBtn := MyGui.Add("Button", "Default w120", "Bank Maintainer Mode")
    MyBtn.OnEvent("Click", Button_Click_Bank)

    MyGui.Add("Text", "ccfcfcf", "Del")
    MyBtn := MyGui.Add("Button", "Default w120", "Cursed Cheese Mode")
    MyBtn.OnEvent("Click", Button_Click_CursedCheese)

    MyGui.Add("Text", "ccfcfcf", "End")
    MyBtn := MyGui.Add("Button", "Default w120", "Tower Passive Mode")
    MyBtn.OnEvent("Click", Button_Click_TowerPassive)

    MyGui.Add("Text", "ccfcfcf", "PageDown")
    MyBtn := MyGui.Add("Button", "Default w120", "Leafton Mode")
    MyBtn.OnEvent("Click", Button_Click_Leafton)

    MyGui.Add("Text", "ccfcfcf", "General Settings")
    MyBtn := MyGui.Add("Button", "Default w120", "Settings")
    MyBtn.OnEvent("Click", Button_Click_GeneralSettings)


    MyGui.Show()
}
/*
Button_Click_Mine(thisGui, info) {
    optionsGUI := Gui(, "Mine Maintainer Settings")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunMine)
    optionsGUI.Add("Button", "default yp", "Apply").OnEvent("Click", ProcessMineSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click", CloseMineSettings)
    ;settingsGUI.OnEvent("Close", ProcessMineSettings)

    optionsGUI.Show("w300")

    ProcessMineSettings(*) {

        values := optionsGUI.Submit()
        Log("Event Items: Logging " values.Logging " NavigateTime " values.NavigateTime
            "`nDisableZoneChecks " values.DisableZoneChecks " DisableSettingsChecks " values.DisableSettingsChecks)
        settings.SaveCurrentSettings()
    }

    RunMine(*) {
        WinActivate(LBRWindowTitle)
        fMineStart()
    }

    CloseMineSettings(*) {
        optionsGUI.Hide()
    }
} */

Button_Click_Mine(thisGui, info) {
    /**
     * MinerSphereTimer=1
     */
    global Settings, MinerEnableVeins, MinerEnableTransmute, MinerEnableFreeRefuel,
        MinerEnableBanks, MinerEnableSpammer, MinerTransmuteTimer, MinerRefuelTimer,
        MinerEnableVeinUpgrade, MinerEnableVeinRemoval, MinerEnableSphereUse,
        MinerSphereDelay, MinerSphereAmount, MinerSphereTimer

    optionsGUI := Gui(, "Mine Maintainer Settings")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    if (MinerEnableVeins = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableVeins ccfcfcf checked", "Enable Coal Veins")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableVeins ccfcfcf", "Enable Coal Veins")
    }

    if (MinerEnableTransmute = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmute ccfcfcf checked", "Enable Bar Transmute")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmute ccfcfcf", "Enable Bar Transmute")
    }

    if (MinerEnableFreeRefuel = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableFreeRefuel ccfcfcf checked", "Enable Fuel Collection")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableFreeRefuel ccfcfcf", "Enable Fuel Collection")
    }

    if (MinerEnableBanks = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableBanks ccfcfcf checked", "Enable Banks")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableBanks ccfcfcf", "Enable Banks")
    }

    if (MinerEnableSpammer = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableSpammer ccfcfcf checked", "Enable Boss Spammer")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableSpammer ccfcfcf", "Enable Boss Spammer")
    }

    optionsGUI.Add("Text", "ccfcfcf", "Auto Bars Transmute Timer (s)")
    optionsGUI.AddEdit()
    If (IsInteger(MinerTransmuteTimer) && MinerTransmuteTimer > 0) {
        optionsGUI.Add("UpDown", "vMinerTransmuteTimer Range1-9999",
            MinerTransmuteTimer)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerTransmuteTimer Range1-9999",
                settings.defaultNobodySettings.MinerTransmuteTimer)
        } else {
            optionsGUI.Add("UpDown", "vMinerTransmuteTimer Range1-9999",
                settings.defaultSettings.MinerTransmuteTimer)
        }
    }

    optionsGUI.Add("Text", "ccfcfcf", "Fuel Collection Timer (m)")
    optionsGUI.AddEdit()
    If (IsInteger(MinerRefuelTimer) && MinerRefuelTimer > 0) {
        optionsGUI.Add("UpDown", "vMinerRefuelTimer Range1-9999",
            MinerRefuelTimer)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerRefuelTimer Range1-9999",
                settings.defaultNobodySettings.MinerRefuelTimer)
        } else {
            optionsGUI.Add("UpDown", "vMinerRefuelTimer Range1-9999",
                settings.defaultSettings.MinerRefuelTimer)
        }
    }

    if (MinerEnableVeinUpgrade = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableVeinUpgrade ccfcfcf checked", "Enable Vein Level Upgrader")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableVeinUpgrade ccfcfcf", "Enable Vein Level Upgrader")
    }

    if (MinerEnableVeinRemoval = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableVeinRemoval ccfcfcf checked", "Enable Removal of 6th Vein")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableVeinRemoval ccfcfcf", "Enable Removal of 6th Vein")
    }

    if (MinerEnableSphereUse = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableSphereUse ccfcfcf checked", "Enable Drill Sphere Use")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableSphereUse ccfcfcf", "Enable Drill Sphere Use")
    }

    optionsGUI.Add("Text", "ccfcfcf", "Drill Sphere Use Delay (ms)")
    optionsGUI.AddEdit()
    If (IsInteger(MinerSphereDelay) && MinerSphereDelay > 0) {
        optionsGUI.Add("UpDown", "vMinerSphereDelay Range1-9999",
            MinerSphereDelay)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerSphereDelay Range1-9999",
                settings.defaultNobodySettings.MinerSphereDelay)
        } else {
            optionsGUI.Add("UpDown", "vMinerSphereDelay Range1-9999",
                settings.defaultSettings.MinerSphereDelay)
        }
    }

    optionsGUI.Add("Text", "ccfcfcf", "Drill Sphere Amount, 0 (infinite)")
    optionsGUI.AddEdit()
    If (IsInteger(MinerSphereAmount) && MinerSphereAmount > 0) {
        optionsGUI.Add("UpDown", "vMinerSphereAmount Range0-99999",
        MinerSphereAmount)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerSphereAmount Range0-99999",
                settings.defaultNobodySettings.MinerSphereAmount)
        } else {
            optionsGUI.Add("UpDown", "vMinerSphereAmount Range0-99999",
                settings.defaultSettings.MinerSphereAmount)
        }
    }
    
    optionsGUI.Add("Text", "ccfcfcf", "Drill Sphere Cycle Timer (m)")
    optionsGUI.AddEdit()
    If (IsInteger(MinerSphereTimer) && MinerSphereTimer > 0) {
        optionsGUI.Add("UpDown", "vMinerSphereTimer Range1-9999",
        MinerSphereTimer)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerSphereTimer Range1-9999",
                settings.defaultNobodySettings.MinerSphereTimer)
        } else {
            optionsGUI.Add("UpDown", "vMinerSphereTimer Range1-9999",
                settings.defaultSettings.MinerSphereTimer)
        }
    }

    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunMine)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click", ProcessMineSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click", CloseMineSettings)

    optionsGUI.Show("w300")

    ProcessMineSettings(*) {

        values := optionsGUI.Submit()
        MinerEnableVeins := values.MinerEnableVeins
        MinerEnableTransmute := values.MinerEnableTransmute
        MinerEnableFreeRefuel := values.MinerEnableFreeRefuel
        MinerEnableBanks := values.MinerEnableBanks
        MinerEnableSpammer := values.MinerEnableSpammer
        MinerTransmuteTimer := values.MinerTransmuteTimer
        MinerRefuelTimer := values.MinerRefuelTimer
        MinerEnableVeinUpgrade := values.MinerEnableVeinUpgrade
        MinerEnableVeinRemoval := values.MinerEnableVeinRemoval
        MinerEnableSphereUse := values.MinerEnableSphereUse
        MinerSphereDelay := values.MinerSphereDelay
        MinerSphereAmount := values.MinerSphereAmount
        MinerSphereTimer := values.MinerSphereTimer


        settings.SaveCurrentSettings()
    }

    RunMine(*) {
        WinActivate(LBRWindowTitle)
        fMineStart()
    }

    CloseMineSettings(*) {
        optionsGUI.Hide()
    }
}

Button_Click_GeneralSettings(thisGui, info) {
    global settings, EnableLogging, NavigateTime, DisableZoneChecks, DisableSettingsChecks

    settingsGUI := GUI(, "General Settings")
    settingsGUI.Opt("+Owner +MinSize +MinSize500x")
    settingsGUI.BackColor := "0c0018"

    if (EnableLogging = true) {
        settingsGUI.Add("CheckBox", "vLogging ccfcfcf checked", "Enable Logging")
    } else {
        settingsGUI.Add("CheckBox", "vLogging ccfcfcf", "Enable Logging")
    }

    settingsGUI.Add("Text", "ccfcfcf", "Navigate Time Del:")
    settingsGUI.AddEdit()
    If (IsInteger(NavigateTime) && NavigateTime > 0) {
        settingsGUI.Add("UpDown", "vNavigateTime Range1-9999", NavigateTime)
    } else {
        if (settings.sUseNobody) {
            settingsGUI.Add("UpDown", "vNavigateTime Range1-9999",
                settings.defaultNobodySettings.NavigateTime)
        } else {
            settingsGUI.Add("UpDown", "vNavigateTime Range1-9999",
                settings.defaultSettings.NavigateTime)
        }
    }

    if (DisableZoneChecks = true) {
        settingsGUI.Add("CheckBox", "vDisableZoneChecks ccfcfcf checked", "Disable Zone Checks")
    } else {
        settingsGUI.Add("CheckBox", "vDisableZoneChecks ccfcfcf", "Disable Zone Checks")
    }


    if (DisableSettingsChecks = true) {
        settingsGUI.Add("CheckBox", "vDisableSettingsChecks ccfcfcf checked", "Disable Game Settings Checks")
    } else {
        settingsGUI.Add("CheckBox", "vDisableSettingsChecks ccfcfcf", "Disable Game Settings Checks")
    }
    settingsGUI.Add("Button", "default", "Save").OnEvent("Click", ProcessUserGeneralSettings)
    settingsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click", CloseUserGeneralSettings)

    settingsGUI.Show("w300")

    ProcessUserGeneralSettings(*) {
        global EnableLogging, NavigateTime, DisableZoneChecks, DisableSettingsChecks,
            settings
        values := settingsGUI.Submit()
        Log("Event Items: Logging " values.Logging " NavigateTime " values.NavigateTime
            "`nDisableZoneChecks " values.DisableZoneChecks " DisableSettingsChecks " values.DisableSettingsChecks)
        EnableLogging := values.Logging
        NavigateTime := values.NavigateTime
        DisableZoneChecks := values.DisableZoneChecks
        DisableSettingsChecks := values.DisableSettingsChecks
        settings.SaveCurrentSettings()
    }

    CloseUserGeneralSettings(*) {
        settingsGUI.Hide()
    }
}

/* Button_Click_EventItem(*) {
    global EventItemTypeArmour,
        EventItemAmount,
        EventItemGood,
        EventItemPerfect,
        EventItemSocketed,
        EventItemStoreSlot

    Log("Global Event Items: Amount " EventItemAmount " Good " EventItemGood
        "`nPerf " EventItemPerfect " Socketed " EventItemSocketed
        "`nStore " EventItemStoreSlot " Type " EventItemTypeArmour)
    optionsGUI := GUI(, "Options: Event Items")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    optionsGUI.Add("Text", "ccfcfcf", "Event Items Amount:")
    optionsGUI.AddEdit()
    If (IsInteger(EventItemAmount) && EventItemAmount > 0) {
        optionsGUI.Add("UpDown", "vAmount Range1-12", EventItemAmount)
    } else {
        optionsGUI.Add("UpDown", "vAmount Range1-12", 4)
    }

    optionsGUI.Add("Text", , "")

    if (EventItemGood = true) {
        optionsGUI.Add("CheckBox", "vIsGood ccfcfcf checked", "90%+ Quality")
    } else {
        optionsGUI.Add("CheckBox", "vIsGood ccfcfcf", "90%+ Quality")
    }

    if (EventItemPerfect = true) {
        optionsGUI.Add("CheckBox", "vIsPerfect ccfcfcf checked", "100% Quality")
    } else {
        optionsGUI.Add("CheckBox", "vIsPerfect ccfcfcf", "100% Quality")
    }

    if (EventItemSocketed = true) {
        optionsGUI.Add("CheckBox", "vIsSocketed ccfcfcf checked", "Socketed")
    } else {
        optionsGUI.Add("CheckBox", "vIsSocketed ccfcfcf", "Socketed")
    }

    optionsGUI.Add("Text", , "")
    optionsGUI.Add("Text", "ccfcfcf", "Event store slot:")
    if (EventItemStoreSlot = 1) {
        optionsGUI.Add("Radio", "vStoreSlot ccfcfcf checked", "1 TopLeft")
    } else {
        optionsGUI.Add("Radio", "vStoreSlot ccfcfcf", "1 TopLeft")
    }
    if (EventItemStoreSlot = 2) {
        optionsGUI.Add("Radio", "ccfcfcf checked", "2 TopRight")
    } else {
        optionsGUI.Add("Radio", "ccfcfcf", "2 TopRight")
    }
    if (EventItemStoreSlot = 3) {
        optionsGUI.Add("Radio", "ccfcfcf checked", "3 Left")
    } else {
        optionsGUI.Add("Radio", "ccfcfcf", "3 Left")
    }
    if (EventItemStoreSlot = 4) {
        optionsGUI.Add("Radio", "ccfcfcf checked", "4 Right")
    } else {
        optionsGUI.Add("Radio", "ccfcfcf", "4 Right")
    }
    if (EventItemStoreSlot = 5) {
        optionsGUI.Add("Radio", "ccfcfcf checked", "5 LowerLeft")
    } else {
        optionsGUI.Add("Radio", "ccfcfcf", "5 LowerLeft")
    }
    if (EventItemStoreSlot = 6) {
        optionsGUI.Add("Radio", "ccfcfcf checked", "6 LowerRight")
    } else {
        optionsGUI.Add("Radio", "ccfcfcf", "6 LowerRight")
    }
    if (EventItemStoreSlot = 7) {
        optionsGUI.Add("Radio", "ccfcfcf checked", "7 BottomLeft")
    } else {
        optionsGUI.Add("Radio", "ccfcfcf", "7 BottomLeft")
    }
    if (EventItemStoreSlot = 8) {
        optionsGUI.Add("Radio", "ccfcfcf checked", "8 BottomRight")
    } else {
        optionsGUI.Add("Radio", "ccfcfcf", "8 BottomRight")
    }

    optionsGUI.Add("Text", , "")
    optionsGUI.Add("Text", "ccfcfcf", "Item type:")
    if (EventItemTypeArmour) {
        optionsGUI.Add("Radio", "vItemType ccfcfcf", "Weapon")
        optionsGUI.Add("Radio", "ccfcfcf checked", "Armour")
    } else {
        optionsGUI.Add("Radio", "vItemType ccfcfcf checked", "Weapon")
        optionsGUI.Add("Radio", "ccfcfcf", "Armour")
    }

    optionsGUI.Add("Button", "default", "OK").OnEvent("Click", ProcessUserEventItemsSettings)
    ;    optionsGUI.OnEvent("Close", ProcessUserEventItemsSettings)
    ProcessUserEventItemsSettings(*) {
        values := optionsGUI.Submit()
        Log("Event Items: Amount " values.Amount " Good " values.IsGood
            "`nPerf " values.IsPerfect " Socketed " values.IsSocketed
            "`nStore " values.StoreSlot " Type " values.ItemType)
        EventItemTypeArmour := values.ItemType--
        EventItemAmount := values.Amount
        EventItemGood := values.IsGood
        EventItemPerfect := values.IsPerfect
        EventItemSocketed := values.IsSocketed
        EventItemStoreSlot := values.StoreSlot
        WinActivate(LBRWindowTitle)
    }
    optionsGUI.Show("w300")
} */
