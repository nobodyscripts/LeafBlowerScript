#Requires AutoHotkey v2.0

Button_Click_FishingTourney(thisGui, info) {
    Global Settings

    Global FishTourCatchingDelay, FishTourCatchingSearch

    Global FishTourEnableShopUpgrade, FishTourEnableUpgradeRods,
        FishTourEnableFishingPass, FishTourEnableUpgradeTourneyRods,
        FishTourEnableTransmute, FishTourEnableJourneyCollect

    Global FishTourTimerShopUpgrade, FishTourTimerUpgradeRods,
        FishTourTimerUpgradeTourneyRods, FishTourTimerTransmute, FishTourTimerJourneyCollect

    Global FishTourTransmuteTtoFC, FishTourTransmuteFCtoCry, FishTourTransmuteCrytoA,
        FishTourTransmuteFCtoT, FishTourTransmuteCrytoFC, FishTourTransmuteAtoCry


    Global FishTourNovice, FishTourIntermediate, FishTourExpert,
        FishTourLegend, FishTourNoviceAttack, FishTourIntermediateAttack,
        FishTourExpertAttack, FishTourLegendAttack

    /** @type {GUI} */
    optionsGUI := Gui(, "Fishing Tourney Settings")
    optionsGUI.BackColor := "0c0018"

    ;@region Tourney settings
    ;@region Fishing
    If (FishTourEnableFishingPass = true) {
        optionsGUI.Add("CheckBox", "vFishTourEnableFishingPass ccfcfcf checked",
            "Enable Fishing During Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourEnableFishingPass ccfcfcf",
            "Enable Fishing During Tourney")
    }
    optionsGUI.Add("Text", "ccfcfcf", "Fish Reeling in delay (s):")
    optionsGUI.AddEdit()
    If (IsInteger(FishTourCatchingDelay) && FishTourCatchingDelay > 0) {
        optionsGUI.Add("UpDown", "vFishTourCatchingDelay Range1-9999",
            FishTourCatchingDelay)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishTourCatchingDelay Range1-9999",
                Settings.defaultNobodySettings.FishTourCatchingDelay)
        } Else {
            optionsGUI.Add("UpDown", "vFishTourCatchingDelay Range1-9999",
                Settings.defaultSettings.FishTourCatchingDelay)
        }
    }

    If (FishTourCatchingSearch = true) {
        optionsGUI.Add("CheckBox", "vFishTourCatchingSearch ccfcfcf checked",
            "Enable Search During Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourCatchingSearch ccfcfcf",
            "Enable Search During Tourney")
    }
    ;@endregion

    optionsGUI.Add("Text", "ccfcfcf", "---")

    ;@region ShopUpgrade
    If (FishTourEnableShopUpgrade = true) {
        optionsGUI.Add("CheckBox", "vFishTourEnableShopUpgrade ccfcfcf checked",
            "Enable Shop Upgrade During Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourEnableShopUpgrade ccfcfcf",
            "Enable Shop Upgrade During Tourney")
    }
    optionsGUI.Add("Text", "ccfcfcf", "Shop Upgrade timer (s):")
    optionsGUI.AddEdit()
    If (IsInteger(FishTourTimerShopUpgrade) && FishTourTimerShopUpgrade > 0) {
        optionsGUI.Add("UpDown", "vFishTourTimerShopUpgrade Range1-9999",
            FishTourTimerShopUpgrade)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishTourTimerShopUpgrade Range1-9999",
                Settings.defaultNobodySettings.FishTourTimerShopUpgrade)
        } Else {
            optionsGUI.Add("UpDown", "vFishTourTimerShopUpgrade Range1-9999",
                Settings.defaultSettings.FishTourTimerShopUpgrade)
        }
    }
    ;@endregion

    optionsGUI.Add("Text", "ccfcfcf", "---")

    ;@region Rod Upgrade
    If (FishTourEnableUpgradeRods = true) {
        optionsGUI.Add("CheckBox", "vFishTourEnableUpgradeRods ccfcfcf checked",
            "Enable Rod Upgrades During Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourEnableUpgradeRods ccfcfcf",
            "Enable Rod Upgrades During Tourney")
    }
    optionsGUI.Add("Text", "ccfcfcf", "Rod Upgrade timer (s):")
    optionsGUI.AddEdit()
    If (IsInteger(FishTourTimerUpgradeRods) && FishTourTimerUpgradeRods > 0) {
        optionsGUI.Add("UpDown", "vFishTourTimerUpgradeRods Range1-9999",
            FishTourTimerUpgradeRods)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishTourTimerUpgradeRods Range1-9999",
                Settings.defaultNobodySettings.FishTourTimerUpgradeRods)
        } Else {
            optionsGUI.Add("UpDown", "vFishTourTimerUpgradeRods Range1-9999",
                Settings.defaultSettings.FishTourTimerUpgradeRods)
        }
    }
    ;@endregion

    optionsGUI.Add("Text", "ccfcfcf", "---")

    ;@region Tourney Rods
    If (FishTourEnableUpgradeTourneyRods = true) {
        optionsGUI.Add("CheckBox", "vFishTourEnableUpgradeTourneyRods ccfcfcf checked",
            "Enable Tourney Rod Upgrades During Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourEnableUpgradeTourneyRods ccfcfcf",
            "Enable Tourney Rod Upgrades During Tourney")
    }
    optionsGUI.Add("Text", "ccfcfcf", "Tourney Rods Upgrade timer (s):")
    optionsGUI.AddEdit()
    If (IsInteger(FishTourTimerUpgradeTourneyRods) && FishTourTimerUpgradeTourneyRods > 0) {
        optionsGUI.Add("UpDown", "vFishTourTimerUpgradeTourneyRods Range1-9999",
            FishTourTimerUpgradeTourneyRods)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishTourTimerUpgradeTourneyRods Range1-9999",
                Settings.defaultNobodySettings.FishTourTimerUpgradeTourneyRods)
        } Else {
            optionsGUI.Add("UpDown", "vFishTourTimerUpgradeTourneyRods Range1-9999",
                Settings.defaultSettings.FishTourTimerUpgradeTourneyRods)
        }
    }
    ;@endregion

    optionsGUI.Add("Text", "ccfcfcf", "---")

    ;@region Journey Collection
    If (FishTourEnableJourneyCollect = true) {
        optionsGUI.Add("CheckBox", "vFishTourEnableJourneyCollect ccfcfcf checked",
            "Enable Journey Collection During Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourEnableJourneyCollect ccfcfcf",
            "Enable Journey Collection During Tourney")
    }
    optionsGUI.Add("Text", "ccfcfcf", "Journey Collection timer (s):")
    optionsGUI.AddEdit()
    If (IsInteger(FishTourTimerJourneyCollect) && FishTourTimerJourneyCollect > 0) {
        optionsGUI.Add("UpDown", "vFishTourTimerJourneyCollect Range1-9999",
            FishTourTimerJourneyCollect)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishTourTimerJourneyCollect Range1-9999",
                Settings.defaultNobodySettings.FishTourTimerJourneyCollect)
        } Else {
            optionsGUI.Add("UpDown", "vFishTourTimerJourneyCollect Range1-9999",
                Settings.defaultSettings.FishTourTimerJourneyCollect)
        }
    }
    ;@endregion

    optionsGUI.Add("Text", "ccfcfcf", "---")

    ;@region Transmute
    If (FishTourEnableTransmute = true) {
        optionsGUI.Add("CheckBox", "vFishTourEnableTransmute ccfcfcf checked",
            "Enable Custom Transmute During Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourEnableTransmute ccfcfcf",
            "Enable Custom Transmute During Tourney")
    }
    optionsGUI.Add("Text", "ccfcfcf", "Transmute timer (s):")
    optionsGUI.AddEdit()
    If (IsInteger(FishTourTimerTransmute) && FishTourTimerTransmute > 0) {
        optionsGUI.Add("UpDown", "vFishTourTimerTransmute Range1-9999",
            FishTourTimerTransmute)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishTourTimerTransmute Range1-9999",
                Settings.defaultNobodySettings.FishTourTimerTransmute)
        } Else {
            optionsGUI.Add("UpDown", "vFishTourTimerTransmute Range1-9999",
                Settings.defaultSettings.FishTourTimerTransmute)
        }
    }

    If (FishTourTransmuteTtoFC = true) {
        optionsGUI.Add("CheckBox", "vFishTourTransmuteTtoFC ccfcfcf checked",
            "Enable Transmute Trash to Fish Credits")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourTransmuteTtoFC ccfcfcf",
            "Enable Transmute Trash to Fish Credits")
    }
    If (FishTourTransmuteFCtoCry = true) {
        optionsGUI.Add("CheckBox", "vFishTourTransmuteFCtoCry ccfcfcf checked",
            "Enable Transmute Fish Credits to Crystal")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourTransmuteFCtoCry ccfcfcf",
            "Enable Transmute Fish Credits to Crystal")
    }
    If (FishTourTransmuteCrytoA = true) {
        optionsGUI.Add("CheckBox", "vFishTourTransmuteCrytoA ccfcfcf checked",
            "Enable Transmute Crystal to Advanced Crystal")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourTransmuteCrytoA ccfcfcf",
            "Enable Transmute Crystal to Advanced Crystal")
    }
    If (FishTourTransmuteFCtoT = true) {
        optionsGUI.Add("CheckBox", "vFishTourTransmuteFCtoT ccfcfcf checked",
            "Enable Transmute Fish Credits to Trash")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourTransmuteFCtoT ccfcfcf",
            "Enable Transmute Fish Credits to Trash")
    }
    If (FishTourTransmuteCrytoFC = true) {
        optionsGUI.Add("CheckBox", "vFishTourTransmuteCrytoFC ccfcfcf checked",
            "Enable Transmute Crystal to Fish Credits")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourTransmuteCrytoFC ccfcfcf",
            "Enable Transmute Crystal to Fish Credits")
    }
    If (FishTourTransmuteAtoCry = true) {
        optionsGUI.Add("CheckBox", "vFishTourTransmuteAtoCry ccfcfcf checked",
            "Enable Transmute Advanced Crystal to Crystal")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourTransmuteAtoCry ccfcfcf",
            "Enable Transmute Advanced Crystal to Crystal")
    }
    ;@endregion

    ;@region Novice Tourney
    If (FishTourNovice = true) {
        optionsGUI.Add("CheckBox", "vFishTourNovice ccfcfcf ys checked",
            "Enable Novice Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourNovice ccfcfcf ys",
            "Enable Novice Tourney")
    }

    ;@region Attack setting
    optionsGUI.Add("Text", "ccfcfcf vFishTourNoviceAttackLabel",
        "Novice Tourney Attack Type:")
    Switch FishTourNoviceAttack {
    Case 1:
        optionsGUI.Add("DropDownList", "vFishTourNoviceAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        optionsGUI.Add("DropDownList", "vFishTourNoviceAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        optionsGUI.Add("DropDownList", "vFishTourNoviceAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        optionsGUI.Add("DropDownList", "vFishTourNoviceAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@region Intermediate Tourney
    If (FishTourIntermediate = true) {
        optionsGUI.Add("CheckBox", "vFishTourIntermediate ccfcfcf checked",
            "Enable Intermediate Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourIntermediate ccfcfcf",
            "Enable Intermediate Tourney")
    }

    ;@region Attack setting
    optionsGUI.Add("Text", "ccfcfcf vFishTourIntermediateAttackLabel",
        "Intermediate Tourney Attack Type:")
    Switch FishTourIntermediateAttack {
    Case 1:
        optionsGUI.Add("DropDownList", "vFishTourIntermediateAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        optionsGUI.Add("DropDownList", "vFishTourIntermediateAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        optionsGUI.Add("DropDownList", "vFishTourIntermediateAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        optionsGUI.Add("DropDownList", "vFishTourIntermediateAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@region Expert Tourney
    If (FishTourExpert = true) {
        optionsGUI.Add("CheckBox", "vFishTourExpert ccfcfcf checked",
            "Enable Expert Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourExpert ccfcfcf",
            "Enable Expert Tourney")
    }

    ;@region Attack setting
    optionsGUI.Add("Text", "ccfcfcf vFishTourExpertAttackLabel",
        "Expert Tourney Attack Type:")
    Switch FishTourExpertAttack {
    Case 1:
        optionsGUI.Add("DropDownList", "vFishTourExpertAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        optionsGUI.Add("DropDownList", "vFishTourExpertAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        optionsGUI.Add("DropDownList", "vFishTourExpertAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        optionsGUI.Add("DropDownList", "vFishTourExpertAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@region Legendary Tourney
    If (FishTourLegend = true) {
        optionsGUI.Add("CheckBox", "vFishTourLegend ccfcfcf checked",
            "Enable Legendary Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourLegend ccfcfcf",
            "Enable Legendary Tourney")
    }

    ;@region Attack setting
    optionsGUI.Add("Text", "ccfcfcf vFishTourLegendAttackLabel",
        "Legendary Tourney Attack Type:")
    Switch FishTourLegendAttack {
    Case 1:
        optionsGUI.Add("DropDownList", "vFishTourLegendAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        optionsGUI.Add("DropDownList", "vFishTourLegendAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        optionsGUI.Add("DropDownList", "vFishTourLegendAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        optionsGUI.Add("DropDownList", "vFishTourLegendAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@endregion

    optionsGUI.Add("Button", "default xs", "Run Tourney").OnEvent("Click", RunFishTourStart)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click",
        ProcessFishTourSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseFishTourSettings)

    ;@endregion

    ShowGUIPosition(optionsGUI)
    optionsGUI.OnEvent("Size", SaveGUIPositionOnResize)
    OnMessage(0x0003, SaveGUIPositionOnMove)

    ProcessFishTourSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        optionsGUI.Hide()
        Temp.Hide()
        Saving.Show()
        FishTourSave()
        Saving.Hide()
        Temp.Show()
        optionsGUI.Show()
    }

    RunFishTourStart(thisGui, info) {
        optionsGUI.Hide()
        Window.Activate()
        FishingTourney().Farm()
    }

    CloseFishTourSettings(*) {
        optionsGUI.Hide()
    }

    FishTourSave() {
        values := optionsGUI.Submit()
        FishTourCatchingDelay := values.FishTourCatchingDelay
        FishTourCatchingSearch := values.FishTourCatchingSearch
        FishTourEnableShopUpgrade := values.FishTourEnableShopUpgrade
        FishTourEnableUpgradeRods := values.FishTourEnableUpgradeRods
        FishTourEnableFishingPass := values.FishTourEnableFishingPass
        FishTourEnableUpgradeTourneyRods := values.FishTourEnableUpgradeTourneyRods
        FishTourEnableTransmute := values.FishTourEnableTransmute
        FishTourEnableJourneyCollect := values.FishTourEnableJourneyCollect
        FishTourTimerShopUpgrade := values.FishTourTimerShopUpgrade
        FishTourTimerUpgradeRods := values.FishTourTimerUpgradeRods
        FishTourTimerUpgradeTourneyRods := values.FishTourTimerUpgradeTourneyRods
        FishTourTimerTransmute := values.FishTourTimerTransmute
        FishTourTimerJourneyCollect := values.FishTourTimerJourneyCollect
        FishTourTransmuteTtoFC := values.FishTourTransmuteTtoFC
        FishTourTransmuteFCtoCry := values.FishTourTransmuteFCtoCry
        FishTourTransmuteCrytoA := values.FishTourTransmuteCrytoA
        FishTourTransmuteFCtoT := values.FishTourTransmuteFCtoT
        FishTourTransmuteCrytoFC := values.FishTourTransmuteCrytoFC
        FishTourTransmuteAtoCry := values.FishTourTransmuteAtoCry
        FishTourNovice := values.FishTourNovice
        FishTourIntermediate := values.FishTourIntermediate
        FishTourExpert := values.FishTourExpert
        FishTourLegend := values.FishTourLegend
        FishTourNoviceAttack := values.FishTourNoviceAttack
        FishTourIntermediateAttack := values.FishTourIntermediateAttack
        FishTourExpertAttack := values.FishTourExpertAttack
        FishTourLegendAttack := values.FishTourLegendAttack

        Settings.SaveCurrentSettings()
    }
}
