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
    SetFontOptions(optionsGUI)

    ;@region Challenge settings
    ;@region Challenge - Fishing
    optionsGUI.Add("Text", "", "Fish Reeling in delay (s):")
    optionsGUI.AddEdit("cDefault")
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
        optionsGUI.Add("CheckBox", "vFishChlCatchingSearch checked",
            "Enable Search During Challenge")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlCatchingSearch",
            "Enable Search During Challenge")
    }
    ;@endregion

    optionsGUI.Add("Text", "", "---")

    ;@region Challenge - ShopUpgrade
    If (FishChlEnableShopUpgrade = true) {
        optionsGUI.Add("CheckBox", "vFishChlEnableShopUpgrade checked",
            "Enable Shop Upgrade During Challenge")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlEnableShopUpgrade",
            "Enable Shop Upgrade During Challenge")
    }
    optionsGUI.Add("Text", "", "Shop Upgrade timer (s):")
    optionsGUI.AddEdit("cDefault")
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

    optionsGUI.Add("Text", "", "---")

    ;@region Challenge - Rod Upgrade
    If (FishChlEnableUpgradeRods = true) {
        optionsGUI.Add("CheckBox", "vFishChlEnableUpgradeRods checked",
            "Enable Rod Upgrades During Challenge")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlEnableUpgradeRods",
            "Enable Rod Upgrades During Challenge")
    }
    optionsGUI.Add("Text", "", "Rod Upgrade timer (s):")
    optionsGUI.AddEdit("cDefault")
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

    optionsGUI.Add("Text", "", "---")

    ;@region Challenge - Journey Collection
    If (FishChlEnableJourneyCollect = true) {
        optionsGUI.Add("CheckBox", "vFishChlEnableJourneyCollect checked",
            "Enable Journey Collection During Challenge")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlEnableJourneyCollect",
            "Enable Journey Collection During Challenge")
    }
    optionsGUI.Add("Text", "", "Journey Collection timer (s):")
    optionsGUI.AddEdit("cDefault")
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

    optionsGUI.Add("Text", "", "---")

    ;@region Challenge - Transmute
    If (FishChlEnableTransmute = true) {
        optionsGUI.Add("CheckBox", "vFishChlEnableTransmute checked",
            "Enable Custom Transmute During Challenge")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlEnableTransmute",
            "Enable Custom Transmute During Challenge")
    }
    optionsGUI.Add("Text", "", "Transmute timer (s):")
    optionsGUI.AddEdit("cDefault")
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
        optionsGUI.Add("CheckBox", "vFishChlTransmuteTtoFC checked",
            "Enable Transmute Trash to Fish Credits")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteTtoFC",
            "Enable Transmute Trash to Fish Credits")
    }
    If (FishChlTransmuteFCtoCry = true) {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteFCtoCry checked",
            "Enable Transmute Fish Credits to Crystal")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteFCtoCry",
            "Enable Transmute Fish Credits to Crystal")
    }
    If (FishChlTransmuteCrytoA = true) {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteCrytoA checked",
            "Enable Transmute Crystal to Advanced Crystal")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteCrytoA",
            "Enable Transmute Crystal to Advanced Crystal")
    }
    If (FishChlTransmuteFCtoT = true) {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteFCtoT checked",
            "Enable Transmute Fish Credits to Trash")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteFCtoT",
            "Enable Transmute Fish Credits to Trash")
    }
    If (FishChlTransmuteCrytoFC = true) {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteCrytoFC checked",
            "Enable Transmute Crystal to Fish Credits")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteCrytoFC",
            "Enable Transmute Crystal to Fish Credits")
    }
    If (FishChlTransmuteAtoCry = true) {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteAtoCry checked",
            "Enable Transmute Advanced Crystal to Crystal")
    } Else {
        optionsGUI.Add("CheckBox", "vFishChlTransmuteAtoCry",
            "Enable Transmute Advanced Crystal to Crystal")
    }
    ;@endregion

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Run Challenge").OnEvent("Click",
        RunFishAutoCatchChallenge)

    ;@endregion

    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessFishChlSettings)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
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