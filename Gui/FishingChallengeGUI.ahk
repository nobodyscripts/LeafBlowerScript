#Requires AutoHotkey v2.0

/**
 * 
 * @param thisGui 
 * @param info 
 */
Button_Click_FishingChallenge(thisGui, info) {
    /** @type {GuiControl} */
    thisGui := thisGui
    Global Settings

    Global FishChlCatchingDelay, FishChlCatchingSearch

    Global FishChlEnableShopUpgrade, FishChlEnableUpgradeRods,
        FishChlEnableTransmute, FishChlEnableJourneyCollect

    Global FishChlTimerShopUpgrade, FishChlTimerUpgradeRods,
        FishChlTimerTransmute, FishChlTimerJourneyCollect

    Global FishChlTransmuteTtoFC, FishChlTransmuteFCtoCry,
        FishChlTransmuteCrytoA, FishChlTransmuteFCtoT,
        FishChlTransmuteCrytoFC, FishChlTransmuteAtoCry

    /** @type {GUI} */
    optionsGUI := Gui(, "Fishing Challenge Settings")
    ;optionsGUI.Opt("")
    optionsGUI.BackColor := "0c0018"

    ;@region Challenge settings
    ;@region Challenge - Fishing
    optionsGUI.Add("Text", "ccfcfcf", "Fish Reeling in delay (s):")
    optionsGUI.AddEdit()
    If (IsInteger(FishChlCatchingDelay) && FishChlCatchingDelay > 0) {
        optionsGUI.Add("UpDown", "vFishChlCatchingDelay Range1-9999",
            FishChlCatchingDelay)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishChlCatchingDelay Range1-9999",
                Settings.defaultNobodySettings.FishChlCatchingDelay)
        } Else {
            optionsGUI.Add("UpDown", "vFishChlCatchingDelay Range1-9999",
                Settings.defaultSettings.FishChlCatchingDelay)
        }
    }

    If (FishChlCatchingSearch = true) {
        optionsGUI.Add("CheckBox", "vFishChlCatchingSearch ccfcfcf checked",
            "Enable Search During Challenge")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlCatchingSearch ccfcfcf",
            "Enable Search During Challenge")
    }
    ;@endregion

    optionsGUI.Add("Text", "ccfcfcf", "---")

    ;@region Challenge - ShopUpgrade
    If (FishChlEnableShopUpgrade = true) {
        optionsGUI.Add("CheckBox", "vFishChlEnableShopUpgrade ccfcfcf checked",
            "Enable Shop Upgrade During Challenge")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlEnableShopUpgrade ccfcfcf",
            "Enable Shop Upgrade During Challenge")
    }
    optionsGUI.Add("Text", "ccfcfcf", "Shop Upgrade timer (s):")
    optionsGUI.AddEdit()
    If (IsInteger(FishChlTimerShopUpgrade) && FishChlTimerShopUpgrade > 0) {
        optionsGUI.Add("UpDown", "vFishChlTimerShopUpgrade Range1-9999",
            FishChlTimerShopUpgrade)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishChlTimerShopUpgrade Range1-9999",
                Settings.defaultNobodySettings.FishChlTimerShopUpgrade)
        } Else {
            optionsGUI.Add("UpDown", "vFishChlTimerShopUpgrade Range1-9999",
                Settings.defaultSettings.FishChlTimerShopUpgrade)
        }
    }
    ;@endregion

    optionsGUI.Add("Text", "ccfcfcf", "---")

    ;@region Challenge - Rod Upgrade
    If (FishChlEnableUpgradeRods = true) {
        optionsGUI.Add("CheckBox", "vFishChlEnableUpgradeRods ccfcfcf checked",
            "Enable Rod Upgrades During Challenge")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlEnableUpgradeRods ccfcfcf",
            "Enable Rod Upgrades During Challenge")
    }
    optionsGUI.Add("Text", "ccfcfcf", "Rod Upgrade timer (s):")
    optionsGUI.AddEdit()
    If (IsInteger(FishChlTimerUpgradeRods) && FishChlTimerUpgradeRods > 0) {
        optionsGUI.Add("UpDown", "vFishChlTimerUpgradeRods Range1-9999",
            FishChlTimerUpgradeRods)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishChlTimerUpgradeRods Range1-9999",
                Settings.defaultNobodySettings.FishChlTimerUpgradeRods)
        } Else {
            optionsGUI.Add("UpDown", "vFishChlTimerUpgradeRods Range1-9999",
                Settings.defaultSettings.FishChlTimerUpgradeRods)
        }
    }
    ;@endregion

    optionsGUI.Add("Text", "ccfcfcf", "---")

    ;@region Challenge - Journey Collection
    If (FishChlEnableJourneyCollect = true) {
        optionsGUI.Add("CheckBox", "vFishChlEnableJourneyCollect ccfcfcf checked",
            "Enable Journey Collection During Challenge")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlEnableJourneyCollect ccfcfcf",
            "Enable Journey Collection During Challenge")
    }
    optionsGUI.Add("Text", "ccfcfcf", "Journey Collection timer (s):")
    optionsGUI.AddEdit()
    If (IsInteger(FishChlTimerJourneyCollect) && FishChlTimerJourneyCollect > 0) {
        optionsGUI.Add("UpDown", "vFishChlTimerJourneyCollect Range1-9999",
            FishChlTimerJourneyCollect)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishChlTimerJourneyCollect Range1-9999",
                Settings.defaultNobodySettings.FishChlTimerJourneyCollect)
        } Else {
            optionsGUI.Add("UpDown", "vFishChlTimerJourneyCollect Range1-9999",
                Settings.defaultSettings.FishChlTimerJourneyCollect)
        }
    }
    ;@endregion

    optionsGUI.Add("Text", "ccfcfcf", "---")

    ;@region Challenge - Transmute
    If (FishChlEnableTransmute = true) {
        optionsGUI.Add("CheckBox", "vFishChlEnableTransmute ccfcfcf checked",
            "Enable Custom Transmute During Challenge")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlEnableTransmute ccfcfcf",
            "Enable Custom Transmute During Challenge")
    }
    optionsGUI.Add("Text", "ccfcfcf", "Transmute timer (s):")
    optionsGUI.AddEdit()
    If (IsInteger(FishChlTimerTransmute) && FishChlTimerTransmute > 0) {
        optionsGUI.Add("UpDown", "vFishChlTimerTransmute Range1-9999",
            FishChlTimerTransmute)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishChlTimerTransmute Range1-9999",
                Settings.defaultNobodySettings.FishChlTimerTransmute)
        } Else {
            optionsGUI.Add("UpDown", "vFishChlTimerTransmute Range1-9999",
                Settings.defaultSettings.FishChlTimerTransmute)
        }
    }

    If (FishChlTransmuteTtoFC = true) {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteTtoFC ccfcfcf checked",
            "Enable Transmute Trash to Fish Credits")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteTtoFC ccfcfcf",
            "Enable Transmute Trash to Fish Credits")
    }
    If (FishChlTransmuteFCtoCry = true) {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteFCtoCry ccfcfcf checked",
            "Enable Transmute Fish Credits to Crystal")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteFCtoCry ccfcfcf",
            "Enable Transmute Fish Credits to Crystal")
    }
    If (FishChlTransmuteCrytoA = true) {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteCrytoA ccfcfcf checked",
            "Enable Transmute Crystal to Advanced Crystal")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteCrytoA ccfcfcf",
            "Enable Transmute Crystal to Advanced Crystal")
    }
    If (FishChlTransmuteFCtoT = true) {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteFCtoT ccfcfcf checked",
            "Enable Transmute Fish Credits to Trash")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteFCtoT ccfcfcf",
            "Enable Transmute Fish Credits to Trash")
    }
    If (FishChlTransmuteCrytoFC = true) {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteCrytoFC ccfcfcf checked",
            "Enable Transmute Crystal to Fish Credits")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteCrytoFC ccfcfcf",
            "Enable Transmute Crystal to Fish Credits")
    }
    If (FishChlTransmuteAtoCry = true) {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteAtoCry ccfcfcf checked",
            "Enable Transmute Advanced Crystal to Crystal")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteAtoCry ccfcfcf",
            "Enable Transmute Advanced Crystal to Crystal")
    }
    ;@endregion

    optionsGUI.Add("Button", "default", "Run Challenge").OnEvent("Click",
        RunFishAutoCatchChallenge)

    ;@endregion

    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click",
        ProcessFishChlSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseFishChlSettings)

    ;@endregion

    ShowGUIPosition(optionsGUI)
    optionsGUI.OnEvent("Size", SaveGUIPositionOnResize)
    OnMessage(0x0003, SaveGUIPositionOnMove)

    ProcessFishChlSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        optionsGUI.Hide()
        Temp.Hide()
        Saving.Show()
        FishChlSave()
        Saving.Hide()
        Temp.Show()
        optionsGUI.Show()
    }

    RunFishAutoCatchChallenge(thisGui, info) {
        optionsGUI.Hide()
        Window.Activate()
        Fishing().fFishAutoCatch(true)
    }

    CloseFishChlSettings(*) {
        optionsGUI.Hide()
    }

    FishChlSave() {
        values := optionsGUI.Submit()
        
        FishChlCatchingDelay := values.FishChlCatchingDelay
        FishChlCatchingSearch := values.FishChlCatchingSearch
        FishChlEnableShopUpgrade := values.FishChlEnableShopUpgrade
        FishChlEnableUpgradeRods := values.FishChlEnableUpgradeRods
        FishChlEnableTransmute := values.FishChlEnableTransmute
        FishChlEnableJourneyCollect := values.FishChlEnableJourneyCollect
        FishChlTimerShopUpgrade := values.FishChlTimerShopUpgrade
        FishChlTimerUpgradeRods := values.FishChlTimerUpgradeRods
        FishChlTimerTransmute := values.FishChlTimerTransmute
        FishChlTimerJourneyCollect := values.FishChlTimerJourneyCollect
        FishChlTransmuteTtoFC := values.FishChlTransmuteTtoFC
        FishChlTransmuteFCtoCry := values.FishChlTransmuteFCtoCry
        FishChlTransmuteCrytoA := values.FishChlTransmuteCrytoA
        FishChlTransmuteFCtoT := values.FishChlTransmuteFCtoT
        FishChlTransmuteCrytoFC := values.FishChlTransmuteCrytoFC
        FishChlTransmuteAtoCry := values.FishChlTransmuteAtoCry

        Settings.SaveCurrentSettings()
    }
}

#Include SavingGUI.ahk