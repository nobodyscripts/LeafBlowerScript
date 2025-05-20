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
    optionsGUI.Opt("+Resize +0x200000")
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

    optionsGUI.OnEvent("Size", Resize)

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

    Resize(GuiObj, MinMax, Width, Height) {
        If (MinMax != 1)
            UpdateScrollBars(GuiObj)
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

    ; Credit to https://www.autohotkey.com/boards/viewtopic.php?f=83&t=112708
    OnMessage(0x0115, OnScroll) ; WM_VSCROLL
    ;OnMessage(0x0114, OnScroll) ; WM_HSCROLL
    OnMessage(0x020A, OnWheel)  ; WM_MOUSEWHEEL

    UpdateScrollBars(GuiObj) {
        ; SIF_RANGE = 0x1, SIF_PAGE = 0x2, SIF_DISABLENOSCROLL = 0x8, SB_HORZ = 0, SB_VERT = 1
        ; Calculate scrolling area.
        WinGetClientPos(, , &GuiW, &GuiH, GuiObj.Hwnd)
        L := T := 2147483647   ; Left, Top
        R := B := -2147483648  ; Right, Bottom
        For CtrlHwnd In WinGetControlsHwnd(GuiObj.Hwnd) {
            ControlGetPos(&CX, &CY, &CW, &CH, CtrlHwnd)
            L := Min(CX, L)
            T := Min(CY, T)
            R := Max(CX + CW, R)
            B := Max(CY + CH, B)
        }
        L -= 8, T -= 8
        R += 8, B += 8
        ScrW := R - L ; scroll width
        ScrH := B - T ; scroll height
        ; Initialize SCROLLINFO.
        SI := Buffer(28, 0)
        NumPut("UInt", 28, "UInt", 3, SI, 0) ; cbSize , fMask: SIF_RANGE | SIF_PAGE
        ; Update horizontal scroll bar.
        NumPut("Int", ScrW, "Int", GuiW, SI, 12) ; nMax , nPage
        DllCall("SetScrollInfo", "Ptr", GuiObj.Hwnd, "Int", 0, "Ptr", SI, "Int", 1) ; SB_HORZ
        ; Update vertical scroll bar.
        ; NumPut("UInt", SIF_RANGE | SIF_PAGE | SIF_DISABLENOSCROLL, SI, 4) ; fMask
        NumPut("Int", ScrH, "UInt", GuiH, SI, 12) ; nMax , nPage
        DllCall("SetScrollInfo", "Ptr", GuiObj.Hwnd, "Int", 1, "Ptr", SI, "Int", 1) ; SB_VERT
        ; Scroll if necessary
        X := (L < 0) && (R < GuiW) ? Min(Abs(L), GuiW - R) : 0
        Y := (T < 0) && (B < GuiH) ? Min(Abs(T), GuiH - B) : 0
        If (X || Y)
            DllCall("ScrollWindow", "Ptr", GuiObj.Hwnd, "Int", X, "Int", Y, "Ptr", 0, "Ptr", 0)
    }

    OnWheel(W, L, M, H) {
        If !(HWND := WinExist()) || GuiCtrlFromHwnd(H)
            Return
        HT := DllCall("SendMessage", "Ptr", HWND, "UInt", 0x0084, "Ptr", 0, "Ptr", l) ; WM_NCHITTEST = 0x0084
        If (HT = 6) || (HT = 7) { ; HTHSCROLL = 6, HTVSCROLL = 7
            SB := (W & 0x80000000) ? 1 : 0 ; SB_LINEDOWN = 1, SB_LINEUP = 0
            SM := (HT = 6) ? 0x0114 : 0x0115 ;  WM_HSCROLL = 0x0114, WM_VSCROLL = 0x0115
            OnScroll(SB, 0, SM, HWND)
            Return 0
        }
    }

    OnScroll(WP, LP, M, H) {
        Static SCROLL_STEP := 20
        If !(LP = 0) ; not sent by a standard scrollbar
            Return
        Bar := (M = 0x0115) ; SB_HORZ=0, SB_VERT=1
        SI := Buffer(28, 0)
        NumPut("UInt", 28, "UInt", 0x17, SI) ; cbSize, fMask: SIF_ALL
        If !DllCall("GetScrollInfo", "Ptr", H, "Int", Bar, "Ptr", SI)
            Return
        RC := Buffer(16, 0)
        DllCall("GetClientRect", "Ptr", H, "Ptr", RC)
        NewPos := NumGet(SI, 20, "Int") ; nPos
        MinPos := NumGet(SI, 8, "Int") ; nMin
        MaxPos := NumGet(SI, 12, "Int") ; nMax
        Switch (WP & 0xFFFF) {
        Case 0: NewPos -= SCROLL_STEP ; SB_LINEUP
        Case 1: NewPos += SCROLL_STEP ; SB_LINEDOWN
        Case 2: NewPos -= NumGet(RC, 12, "Int") - SCROLL_STEP ; SB_PAGEUP
        Case 3: NewPos += NumGet(RC, 12, "Int") - SCROLL_STEP ; SB_PAGEDOWN
        Case 4, 5: NewPos := WP >> 16 ; SB_THUMBTRACK, SB_THUMBPOSITION
        Case 6: NewPos := MinPos ; SB_TOP
        Case 7: NewPos := MaxPos ; SB_BOTTOM
        Default: Return
        }
        MaxPos -= NumGet(SI, 16, "Int") ; nPage
        NewPos := Min(NewPos, MaxPos)
        NewPos := Max(MinPos, NewPos)
        OldPos := NumGet(SI, 20, "Int") ; nPos
        X := (Bar = 0) ? OldPos - NewPos : 0
        Y := (Bar = 1) ? OldPos - NewPos : 0
        If (X || Y) {
            ; Scroll contents of window and invalidate uncovered area.
            DllCall("ScrollWindow", "Ptr", H, "Int", X, "Int", Y, "Ptr", 0, "Ptr", 0)
            ; Update scroll bar.
            NumPut("Int", NewPos, SI, 20) ; nPos
            DllCall("SetScrollInfo", "ptr", H, "Int", Bar, "Ptr", SI, "Int", 1)
        }
    }
}
