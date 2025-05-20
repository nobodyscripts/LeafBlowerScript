#Requires AutoHotkey v2.0

Button_Click_Fishing(thisGui, info) {
    Global Settings, FishCatchingDelay, FishCatchingSearch

    Global FishEnableShopUpgrade, FishEnableUpgradeRods, FishEnableTourneyPass,
        FishEnableUpgradeTourneyRods, FishEnableTransmute, FishEnableJourneyCollect

    Global FishTimerShopUpgrade, FishTimerUpgradeRods, FishTimerTourneyPass,
        FishTimerUpgradeTourneyRods, FishTimerTransmute, FishTimerJourneyCollect

    Global FishTransmuteTtoFC, FishTransmuteFCtoCry, FishTransmuteCrytoA,
        FishTransmuteFCtoT, FishTransmuteCrytoFC, FishTransmuteAtoCry

    Global FishChlCatchingDelay, FishChlCatchingSearch

    Global FishChlEnableShopUpgrade, FishChlEnableUpgradeRods,
        FishChlEnableTransmute, FishChlEnableJourneyCollect

    Global FishChlTimerShopUpgrade, FishChlTimerUpgradeRods,
        FishChlTimerTransmute, FishChlTimerJourneyCollect

    Global FishChlTransmuteTtoFC, FishChlTransmuteFCtoCry,
        FishChlTransmuteCrytoA, FishChlTransmuteFCtoT,
        FishChlTransmuteCrytoFC, FishChlTransmuteAtoCry

    Global FishTourCatchingDelay, FishTourCatchingSearch

    Global FishTourEnableShopUpgrade, FishTourEnableUpgradeRods,
        FishTourEnableFishingPass, FishTourEnableUpgradeTourneyRods,
        FishTourEnableTransmute, FishTourEnableJourneyCollect

    Global FishTourTimerShopUpgrade, FishTourTimerUpgradeRods,
        FishTourTimerUpgradeTourneyRods, FishTourTimerTransmute, FishTourTimerJourneyCollect

    Global FishTourTransmuteTtoFC, FishTourTransmuteFCtoCry, FishTourTransmuteCrytoA,
        FishTourTransmuteFCtoT, FishTourTransmuteCrytoFC, FishTourTransmuteAtoCry

    Global FishNovice, FishIntermediate, FishExpert,
        FishLegend, FishNoviceAttack, FishIntermediateAttack,
        FishExpertAttack, FishLegendAttack

    Global FishTourNovice, FishTourIntermediate, FishTourExpert,
        FishTourLegend, FishTourNoviceAttack, FishTourIntermediateAttack,
        FishTourExpertAttack, FishTourLegendAttack

    /** @type {GUI} */
    optionsGUI := Gui(, "Fishing Settings")
    optionsGUI.Opt("")
    optionsGUI.BackColor := "0c0018"

    ;@region Fishing settings
    ;@region Fishing auto
    optionsGUI.Add("Text", "ccfcfcf", "Fishing")
    optionsGUI.Add("Text", "ccfcfcf", "Fish Reeling in delay (s):")
    optionsGUI.AddEdit()
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
        optionsGUI.Add("CheckBox", "vFishCatchingSearch ccfcfcf checked",
            "Enable Search During Fishing")
    } Else {
        optionsGUI.Add("CheckBox", "vFishCatchingSearch ccfcfcf",
            "Enable Search During Fishing")
    }
    ;@endregion

    optionsGUI.Add("Text", "ccfcfcf", "---")

    ;@region Fishing - ShopUpgrade
    If (FishEnableShopUpgrade = true) {
        optionsGUI.Add("CheckBox", "vFishEnableShopUpgrade ccfcfcf checked",
            "Enable Shop Upgrade During Fishing")
    } Else {
        optionsGUI.Add("CheckBox", "vFishEnableShopUpgrade ccfcfcf",
            "Enable Shop Upgrade During Fishing")
    }
    optionsGUI.Add("Text", "ccfcfcf", "Shop Upgrade timer (s):")
    optionsGUI.AddEdit()
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

    optionsGUI.Add("Text", "ccfcfcf", "---")

    ;@region Fishing - Rod Upgrade
    If (FishEnableUpgradeRods = true) {
        optionsGUI.Add("CheckBox", "vFishEnableUpgradeRods ccfcfcf checked",
            "Enable Rod Upgrades During Fishing")
    } Else {
        optionsGUI.Add("CheckBox", "vFishEnableUpgradeRods ccfcfcf",
            "Enable Rod Upgrades During Fishing")
    }
    optionsGUI.Add("Text", "ccfcfcf", "Rod Upgrade timer (s):")
    optionsGUI.AddEdit()
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

    optionsGUI.Add("Text", "ccfcfcf", "---")

    ;@region Fishing - Tourney
    If (FishEnableTourneyPass = true) {
        optionsGUI.Add("CheckBox", "vFishEnableTourneyPass ccfcfcf checked",
            "Enable Tourney During Fishing")
    } Else {
        optionsGUI.Add("CheckBox", "vFishEnableTourneyPass ccfcfcf",
            "Enable Tourney During Fishing")
    }

    optionsGUI.Add("Text", "ccfcfcf", "Tourney timer (s):")
    optionsGUI.AddEdit()
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

    optionsGUI.Add("Text", "ccfcfcf", "---")

    ;@region Fishing - Tourney Rods
    If (FishEnableUpgradeTourneyRods = true) {
        optionsGUI.Add("CheckBox", "vFishEnableUpgradeTourneyRods ccfcfcf checked",
            "Enable Tourney Rod Upgrades During Fishing")
    } Else {
        optionsGUI.Add("CheckBox", "vFishEnableUpgradeTourneyRods ccfcfcf",
            "Enable Tourney Rod Upgrades During Fishing")
    }
    optionsGUI.Add("Text", "ccfcfcf", "Tourney Rods Upgrade timer (s):")
    optionsGUI.AddEdit()
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

    optionsGUI.Add("Text", "ccfcfcf", "---")

    ;@region Fishing - Journey Collection
    If (FishEnableJourneyCollect = true) {
        optionsGUI.Add("CheckBox", "vFishEnableJourneyCollect ccfcfcf checked",
            "Enable Journey Collection During Fishing")
    } Else {
        optionsGUI.Add("CheckBox", "vFishEnableJourneyCollect ccfcfcf",
            "Enable Journey Collection During Fishing")
    }
    optionsGUI.Add("Text", "ccfcfcf", "Journey Collection timer (s):")
    optionsGUI.AddEdit()
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

    optionsGUI.Add("Text", "ccfcfcf", "---")

    ;@region Fishing - Transmute
    If (FishEnableTransmute = true) {
        optionsGUI.Add("CheckBox", "vFishEnableTransmute ccfcfcf checked",
            "Enable Custom Transmute During Fishing")
    } Else {
        optionsGUI.Add("CheckBox", "vFishEnableTransmute ccfcfcf",
            "Enable Custom Transmute During Fishing")
    }
    optionsGUI.Add("Text", "ccfcfcf", "Transmute timer (s):")
    optionsGUI.AddEdit()
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
        optionsGUI.Add("CheckBox", "vFishTransmuteTtoFC ccfcfcf checked",
            "Enable Transmute Trash to Fish Credits")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTransmuteTtoFC ccfcfcf",
            "Enable Transmute Trash to Fish Credits")
    }
    If (FishTransmuteFCtoCry = true) {
        optionsGUI.Add("CheckBox", "vFishTransmuteFCtoCry ccfcfcf checked",
            "Enable Transmute Fish Credits to Crystal")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTransmuteFCtoCry ccfcfcf",
            "Enable Transmute Fish Credits to Crystal")
    }
    If (FishTransmuteCrytoA = true) {
        optionsGUI.Add("CheckBox", "vFishTransmuteCrytoA ccfcfcf checked",
            "Enable Transmute Crystal to Advanced Crystal")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTransmuteCrytoA ccfcfcf",
            "Enable Transmute Crystal to Advanced Crystal")
    }
    If (FishTransmuteFCtoT = true) {
        optionsGUI.Add("CheckBox", "vFishTransmuteFCtoT ccfcfcf checked",
            "Enable Transmute Fish Credits to Trash")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTransmuteFCtoT ccfcfcf",
            "Enable Transmute Fish Credits to Trash")
    }
    If (FishTransmuteCrytoFC = true) {
        optionsGUI.Add("CheckBox", "vFishTransmuteCrytoFC ccfcfcf checked",
            "Enable Transmute Crystal to Fish Credits")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTransmuteCrytoFC ccfcfcf",
            "Enable Transmute Crystal to Fish Credits")
    }
    If (FishTransmuteAtoCry = true) {
        optionsGUI.Add("CheckBox", "vFishTransmuteAtoCry ccfcfcf checked",
            "Enable Transmute Advanced Crystal to Crystal")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTransmuteAtoCry ccfcfcf",
            "Enable Transmute Advanced Crystal to Crystal")
    }
    ;@endregion

    optionsGUI.Add("Text", "ccfcfcf", "---")

    ;@region Fishing - Novice Tourney
    If (FishNovice = true) {
        optionsGUI.Add("CheckBox", "vFishNovice ccfcfcf checked",
            "Enable Novice Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishNovice ccfcfcf",
            "Enable Novice Tourney")
    }

    ;@region Attack setting
    optionsGUI.Add("Text", "ccfcfcf vFishNoviceAttackLabel",
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
        optionsGUI.Add("CheckBox", "vFishIntermediate ccfcfcf checked",
            "Enable Intermediate Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishIntermediate ccfcfcf",
            "Enable Intermediate Tourney")
    }

    ;@region Attack setting
    optionsGUI.Add("Text", "ccfcfcf vFishIntermediateAttackLabel",
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
        optionsGUI.Add("CheckBox", "vFishExpert ccfcfcf checked",
            "Enable Expert Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishExpert ccfcfcf",
            "Enable Expert Tourney")
    }

    ;@region Attack setting
    optionsGUI.Add("Text", "ccfcfcf vFishExpertAttackLabel",
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
        optionsGUI.Add("CheckBox", "vFishLegend ccfcfcf checked",
            "Enable Legendary Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishLegend ccfcfcf",
            "Enable Legendary Tourney")
    }

    ;@region Attack setting
    optionsGUI.Add("Text", "ccfcfcf vFishLegendAttackLabel",
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

    optionsGUI.Add("Button", "default", "Run Fishing").OnEvent("Click", RunFishAutoCatch)
    ;@endregion

    ;@region Challenge settings
    ;@region Challenge - Fishing
    optionsGUI.Add("Text", "ccfcfcf ys", "Challenge")

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

    ;@region Tourney settings
    optionsGUI.Add("Text", "ccfcfcf ys", "Tourney")

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

    optionsGUI.Add("Text", "ccfcfcf", "---")

    ;@region Novice Tourney
    If (FishTourNovice = true) {
        optionsGUI.Add("CheckBox", "vFishTourNovice ccfcfcf checked",
            "Enable Novice Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourNovice ccfcfcf",
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

    optionsGUI.Add("Button", "default", "Run Tourney").OnEvent("Click", RunFishTourStart)

    optionsGUI.Add("Button", "default xs", "Save").OnEvent("Click",
        ProcessFishingSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseFishingSettings)

    ;@endregion

    optionsGUI.Show()

    ProcessFishingSettings(*) {
        FishingSave()
    }

    RunFishAutoCatch(thisGui, info) {
        optionsGUI.Hide()
        Window.Activate()
        Fishing().fFishAutoCatch()
    }

    RunFishAutoCatchChallenge(thisGui, info) {
        optionsGUI.Hide()
        Window.Activate()
        Fishing().fFishAutoCatch(true)
    }

    RunFishTourStart(thisGui, info) {
        optionsGUI.Hide()
        Window.Activate()
        FishingTourney().Farm()
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

        FishTourNovice := values.FishTourNovice
        FishTourIntermediate := values.FishTourIntermediate
        FishTourExpert := values.FishTourExpert
        FishTourLegend := values.FishTourLegend
        FishTourNoviceAttack := values.FishTourNoviceAttack
        FishTourIntermediateAttack := values.FishTourIntermediateAttack
        FishTourExpertAttack := values.FishTourExpertAttack
        FishTourLegendAttack := values.FishTourLegendAttack

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

        FishChlTransmuteAtoCry := values.FishChlTransmuteAtoCry
        FishChlTransmuteCrytoFC := values.FishChlTransmuteCrytoFC
        FishChlTransmuteTtoFC := values.FishChlTransmuteTtoFC
        Settings.SaveCurrentSettings()
    }
}
