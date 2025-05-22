#Requires AutoHotkey v2.0

Button_Click_Fishing(thisGui, info) {
    Global Settings, FishCatchingDelay, FishCatchingSearch

    Global FishEnableShopUpgrade, FishEnableUpgradeRods, FishEnableTourneyPass,
        FishEnableUpgradeTourneyRods, FishEnableTransmute, FishEnableJourneyCollect

    Global FishTimerShopUpgrade, FishTimerUpgradeRods, FishTimerTourneyPass,
        FishTimerUpgradeTourneyRods, FishTimerTransmute, FishTimerJourneyCollect

    Global FishTransmuteTtoFC, FishTransmuteFCtoCry, FishTransmuteCrytoA,
        FishTransmuteFCtoT, FishTransmuteCrytoFC, FishTransmuteAtoCry

    Global FishNovice, FishIntermediate, FishExpert,
        FishLegend, FishNoviceAttack, FishIntermediateAttack,
        FishExpertAttack, FishLegendAttack

    /** @type {GUI} */
    optionsGUI := Gui(, "Fishing Settings")
    ;optionsGUI.Opt("")
    SetFontOptions(optionsGUI)

    ;@region Fishing settings
    ;@region Fishing auto
    optionsGUI.Add("Text", "", "Fish Reeling in delay (s):")
    optionsGUI.AddEdit("cDefault")
    If (IsInteger(FishCatchingDelay) && FishCatchingDelay > 0) {
        optionsGUI.Add("UpDown", "vFishCatchingDelay Range1-9999",
            FishCatchingDelay)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishCatchingDelay Range1-9999",
                Settings.defaultNobodySettings.FishCatchingDelay)
        } Else {
            optionsGUI.Add("UpDown", "vFishCatchingDelay Range1-9999",
                Settings.defaultSettings.FishCatchingDelay)
        }
    }

    If (FishCatchingSearch = true) {
        optionsGUI.Add("CheckBox", "vFishCatchingSearch checked",
            "Enable Search During Fishing")
    } Else {
        optionsGUI.Add("CheckBox", "vFishCatchingSearch",
            "Enable Search During Fishing")
    }
    ;@endregion

    optionsGUI.Add("Text", "", "---")

    ;@region Fishing - ShopUpgrade
    If (FishEnableShopUpgrade = true) {
        optionsGUI.Add("CheckBox", "vFishEnableShopUpgrade checked",
            "Enable Shop Upgrade During Fishing")
    } Else {
        optionsGUI.Add("CheckBox", "vFishEnableShopUpgrade",
            "Enable Shop Upgrade During Fishing")
    }
    optionsGUI.Add("Text", "", "Shop Upgrade timer (s):")
    optionsGUI.AddEdit("cDefault")
    If (IsInteger(FishTimerShopUpgrade) && FishTimerShopUpgrade > 0) {
        optionsGUI.Add("UpDown", "vFishTimerShopUpgrade Range1-9999",
            FishTimerShopUpgrade)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishTimerShopUpgrade Range1-9999",
                Settings.defaultNobodySettings.FishTimerShopUpgrade)
        } Else {
            optionsGUI.Add("UpDown", "vFishTimerShopUpgrade Range1-9999",
                Settings.defaultSettings.FishTimerShopUpgrade)
        }
    }
    ;@endregion

    optionsGUI.Add("Text", "", "---")

    ;@region Fishing - Rod Upgrade
    If (FishEnableUpgradeRods = true) {
        optionsGUI.Add("CheckBox", "vFishEnableUpgradeRods checked",
            "Enable Rod Upgrades During Fishing")
    } Else {
        optionsGUI.Add("CheckBox", "vFishEnableUpgradeRods",
            "Enable Rod Upgrades During Fishing")
    }
    optionsGUI.Add("Text", "", "Rod Upgrade timer (s):")
    optionsGUI.AddEdit("cDefault")
    If (IsInteger(FishTimerUpgradeRods) && FishTimerUpgradeRods > 0) {
        optionsGUI.Add("UpDown", "vFishTimerUpgradeRods Range1-9999",
            FishTimerUpgradeRods)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishTimerUpgradeRods Range1-9999",
                Settings.defaultNobodySettings.FishTimerUpgradeRods)
        } Else {
            optionsGUI.Add("UpDown", "vFishTimerUpgradeRods Range1-9999",
                Settings.defaultSettings.FishTimerUpgradeRods)
        }
    }
    ;@endregion

    optionsGUI.Add("Text", "", "---")

    ;@region Fishing - Tourney
    If (FishEnableTourneyPass = true) {
        optionsGUI.Add("CheckBox", "vFishEnableTourneyPass checked",
            "Enable Tourney During Fishing")
    } Else {
        optionsGUI.Add("CheckBox", "vFishEnableTourneyPass",
            "Enable Tourney During Fishing")
    }

    optionsGUI.Add("Text", "", "Tourney timer (s):")
    optionsGUI.AddEdit("cDefault")
    If (IsInteger(FishTimerTourneyPass) && FishTimerTourneyPass > 0) {
        optionsGUI.Add("UpDown", "vFishTimerTourneyPass Range1-9999",
            FishTimerTourneyPass)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishTimerTourneyPass Range1-9999",
                Settings.defaultNobodySettings.FishTimerTourneyPass)
        } Else {
            optionsGUI.Add("UpDown", "vFishTimerTourneyPass Range1-9999",
                Settings.defaultSettings.FishTimerTourneyPass)
        }
    }
    ;@endregion

    optionsGUI.Add("Text", "", "---")

    ;@region Fishing - Tourney Rods
    If (FishEnableUpgradeTourneyRods = true) {
        optionsGUI.Add("CheckBox", "vFishEnableUpgradeTourneyRods checked",
            "Enable Tourney Rod Upgrades During Fishing")
    } Else {
        optionsGUI.Add("CheckBox", "vFishEnableUpgradeTourneyRods",
            "Enable Tourney Rod Upgrades During Fishing")
    }
    optionsGUI.Add("Text", "", "Tourney Rods Upgrade timer (s):")
    optionsGUI.AddEdit("cDefault")
    If (IsInteger(FishTimerUpgradeTourneyRods) && FishTimerUpgradeTourneyRods > 0) {
        optionsGUI.Add("UpDown", "vFishTimerUpgradeTourneyRods Range1-9999",
            FishTimerUpgradeTourneyRods)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishTimerUpgradeTourneyRods Range1-9999",
                Settings.defaultNobodySettings.FishTimerUpgradeTourneyRods)
        } Else {
            optionsGUI.Add("UpDown", "vFishTimerUpgradeTourneyRods Range1-9999",
                Settings.defaultSettings.FishTimerUpgradeTourneyRods)
        }
    }
    ;@endregion

    optionsGUI.Add("Text", "", "---")

    ;@region Fishing - Journey Collection
    If (FishEnableJourneyCollect = true) {
        optionsGUI.Add("CheckBox", "vFishEnableJourneyCollect checked",
            "Enable Journey Collection During Fishing")
    } Else {
        optionsGUI.Add("CheckBox", "vFishEnableJourneyCollect",
            "Enable Journey Collection During Fishing")
    }
    optionsGUI.Add("Text", "", "Journey Collection timer (s):")
    optionsGUI.AddEdit("cDefault")
    If (IsInteger(FishTimerJourneyCollect) && FishTimerJourneyCollect > 0) {
        optionsGUI.Add("UpDown", "vFishTimerJourneyCollect Range1-9999",
            FishTimerJourneyCollect)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishTimerJourneyCollect Range1-9999",
                Settings.defaultNobodySettings.FishTimerJourneyCollect)
        } Else {
            optionsGUI.Add("UpDown", "vFishTimerJourneyCollect Range1-9999",
                Settings.defaultSettings.FishTimerJourneyCollect)
        }
    }
    ;@endregion

    optionsGUI.Add("Text", "", "---")

    ;@region Fishing - Transmute
    If (FishEnableTransmute = true) {
        optionsGUI.Add("CheckBox", "vFishEnableTransmute checked",
            "Enable Custom Transmute During Fishing")
    } Else {
        optionsGUI.Add("CheckBox", "vFishEnableTransmute",
            "Enable Custom Transmute During Fishing")
    }
    optionsGUI.Add("Text", "", "Transmute timer (s):")
    optionsGUI.AddEdit("cDefault")
    If (IsInteger(FishTimerTransmute) && FishTimerTransmute > 0) {
        optionsGUI.Add("UpDown", "vFishTimerTransmute Range1-9999",
            FishTimerTransmute)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishTimerTransmute Range1-9999",
                Settings.defaultNobodySettings.FishTimerTransmute)
        } Else {
            optionsGUI.Add("UpDown", "vFishTimerTransmute Range1-9999",
                Settings.defaultSettings.FishTimerTransmute)
        }
    }

    If (FishTransmuteTtoFC = true) {
        optionsGUI.Add("CheckBox", "vFishTransmuteTtoFC checked",
            "Enable Transmute Trash to Fish Credits")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTransmuteTtoFC",
            "Enable Transmute Trash to Fish Credits")
    }
    If (FishTransmuteFCtoCry = true) {
        optionsGUI.Add("CheckBox", "vFishTransmuteFCtoCry checked",
            "Enable Transmute Fish Credits to Crystal")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTransmuteFCtoCry",
            "Enable Transmute Fish Credits to Crystal")
    }
    If (FishTransmuteCrytoA = true) {
        optionsGUI.Add("CheckBox", "vFishTransmuteCrytoA checked",
            "Enable Transmute Crystal to Advanced Crystal")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTransmuteCrytoA",
            "Enable Transmute Crystal to Advanced Crystal")
    }
    If (FishTransmuteFCtoT = true) {
        optionsGUI.Add("CheckBox", "vFishTransmuteFCtoT checked",
            "Enable Transmute Fish Credits to Trash")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTransmuteFCtoT",
            "Enable Transmute Fish Credits to Trash")
    }
    If (FishTransmuteCrytoFC = true) {
        optionsGUI.Add("CheckBox", "vFishTransmuteCrytoFC checked",
            "Enable Transmute Crystal to Fish Credits")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTransmuteCrytoFC",
            "Enable Transmute Crystal to Fish Credits")
    }
    If (FishTransmuteAtoCry = true) {
        optionsGUI.Add("CheckBox", "vFishTransmuteAtoCry checked",
            "Enable Transmute Advanced Crystal to Crystal")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTransmuteAtoCry",
            "Enable Transmute Advanced Crystal to Crystal")
    }
    ;@endregion

    ;@region Fishing - Novice Tourney
    If (FishNovice = true) {
        optionsGUI.Add("CheckBox", "vFishNovice ys checked",
            "Enable Novice Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishNovice ys",
            "Enable Novice Tourney")
    }

    ;@region Attack setting
    optionsGUI.Add("Text", "vFishNoviceAttackLabel",
        "Novice Tourney Attack Type:")
    Switch FishNoviceAttack {
    Case 1:
        optionsGUI.Add("DropDownList", "vFishNoviceAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        optionsGUI.Add("DropDownList", "vFishNoviceAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        optionsGUI.Add("DropDownList", "vFishNoviceAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        optionsGUI.Add("DropDownList", "vFishNoviceAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@region Fishing - Intermediate Tourney
    If (FishIntermediate = true) {
        optionsGUI.Add("CheckBox", "vFishIntermediate checked",
            "Enable Intermediate Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishIntermediate",
            "Enable Intermediate Tourney")
    }

    ;@region Attack setting
    optionsGUI.Add("Text", "vFishIntermediateAttackLabel",
        "Intermediate Tourney Attack Type:")
    Switch FishIntermediateAttack {
    Case 1:
        optionsGUI.Add("DropDownList", "vFishIntermediateAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        optionsGUI.Add("DropDownList", "vFishIntermediateAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        optionsGUI.Add("DropDownList", "vFishIntermediateAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        optionsGUI.Add("DropDownList", "vFishIntermediateAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@region Fishing - Expert Tourney
    If (FishExpert = true) {
        optionsGUI.Add("CheckBox", "vFishExpert checked",
            "Enable Expert Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishExpert",
            "Enable Expert Tourney")
    }

    ;@region Attack setting
    optionsGUI.Add("Text", "vFishExpertAttackLabel",
        "Expert Tourney Attack Type:")
    Switch FishExpertAttack {
    Case 1:
        optionsGUI.Add("DropDownList", "vFishExpertAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        optionsGUI.Add("DropDownList", "vFishExpertAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        optionsGUI.Add("DropDownList", "vFishExpertAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        optionsGUI.Add("DropDownList", "vFishExpertAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@region Fishing - Legendary Tourney
    If (FishLegend = true) {
        optionsGUI.Add("CheckBox", "vFishLegend checked",
            "Enable Legendary Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishLegend",
            "Enable Legendary Tourney")
    }

    ;@region Attack setting
    optionsGUI.Add("Text", "vFishLegendAttackLabel",
        "Legendary Tourney Attack Type:")
    Switch FishLegendAttack {
    Case 1:
        optionsGUI.Add("DropDownList", "vFishLegendAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        optionsGUI.Add("DropDownList", "vFishLegendAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        optionsGUI.Add("DropDownList", "vFishLegendAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        optionsGUI.Add("DropDownList", "vFishLegendAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@endregion

    optionsGUI.Add("Button", "+Background" GuiBGColour " default xs", "Run Fishing").OnEvent("Click", RunFishAutoCatch)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessFishingSettings)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseFishingSettings)

    ;@endregion

    ShowGUIPosition(optionsGUI)
    MakeGUIResizableIfOversize(optionsGUI)
    optionsGUI.OnEvent("Size", SaveGUIPositionOnResize)
    OnMessage(0x0003, SaveGUIPositionOnMove)

    ProcessFishingSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        optionsGUI.Hide()
        Temp.Hide()
        Saving.Show()
        FishingSave()
        Saving.Hide()
        Temp.Show()
        optionsGUI.Show()
    }

    RunFishAutoCatch(thisGui, info) {
        optionsGUI.Hide()
        Window.Activate()
        Fishing().fFishAutoCatch()
    }

    CloseFishingSettings(*) {
        optionsGUI.Hide()
    }

    FishingSave() {
        values := optionsGUI.Submit()
        FishCatchingDelay := values.FishCatchingDelay
        FishCatchingSearch := values.FishCatchingSearch

        FishNovice := values.FishNovice
        FishIntermediate := values.FishIntermediate
        FishExpert := values.FishExpert
        FishLegend := values.FishLegend
        FishNoviceAttack := values.FishNoviceAttack
        FishIntermediateAttack := values.FishIntermediateAttack
        FishExpertAttack := values.FishExpertAttack
        FishLegendAttack := values.FishLegendAttack

        FishEnableShopUpgrade := values.FishEnableShopUpgrade
        FishEnableUpgradeRods := values.FishEnableUpgradeRods
        FishEnableTourneyPass := values.FishEnableTourneyPass
        FishEnableUpgradeTourneyRods := values.FishEnableUpgradeTourneyRods
        FishEnableTransmute := values.FishEnableTransmute
        FishEnableJourneyCollect := values.FishEnableJourneyCollect

        FishTimerShopUpgrade := values.FishTimerShopUpgrade
        FishTimerUpgradeRods := values.FishTimerUpgradeRods
        FishTimerTourneyPass := values.FishTimerTourneyPass
        FishTimerUpgradeTourneyRods := values.FishTimerUpgradeTourneyRods
        FishTimerTransmute := values.FishTimerTransmute
        FishTimerJourneyCollect := values.FishTimerJourneyCollect

        FishTransmuteTtoFC := values.FishTransmuteTtoFC
        FishTransmuteFCtoCry := values.FishTransmuteFCtoCry
        FishTransmuteCrytoA := values.FishTransmuteCrytoA
        FishTransmuteFCtoT := values.FishTransmuteFCtoT
        FishTransmuteCrytoFC := values.FishTransmuteCrytoFC
        FishTransmuteAtoCry := values.FishTransmuteAtoCry

        Settings.SaveCurrentSettings()
    }
}
