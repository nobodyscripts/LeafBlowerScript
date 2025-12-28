#Requires AutoHotkey v2.0

Button_Click_Fishing(thisGui, info) {

    FishCatchingDelay := S.Get("FishCatchingDelay")
    FishCatchingSearch := S.Get("FishCatchingSearch")
    FishNovice := S.Get("FishNovice")
    FishIntermediate := S.Get("FishIntermediate")
    FishExpert := S.Get("FishExpert")
    FishLegend := S.Get("FishLegend")
    FishNoviceAttack := S.Get("FishNoviceAttack")
    FishIntermediateAttack := S.Get("FishIntermediateAttack")
    FishExpertAttack := S.Get("FishExpertAttack")
    FishLegendAttack := S.Get("FishLegendAttack")
    FishEnableShopUpgrade := S.Get("FishEnableShopUpgrade")
    FishEnableUpgradeRods := S.Get("FishEnableUpgradeRods")
    FishEnableTourneyPass := S.Get("FishEnableTourneyPass")
    FishEnableUpgradeTourneyRods := S.Get("FishEnableUpgradeTourneyRods")
    FishEnableTransmute := S.Get("FishEnableTransmute")
    FishEnableJourneyCollect := S.Get("FishEnableJourneyCollect")
    FishTimerShopUpgrade := S.Get("FishTimerShopUpgrade")
    FishTimerUpgradeRods := S.Get("FishTimerUpgradeRods")
    FishTimerTourneyPass := S.Get("FishTimerTourneyPass")
    FishTimerUpgradeTourneyRods := S.Get("FishTimerUpgradeTourneyRods")
    FishTimerTransmute := S.Get("FishTimerTransmute")
    FishTimerJourneyCollect := S.Get("FishTimerJourneyCollect")
    FishTransmuteTtoFC := S.Get("FishTransmuteTtoFC")
    FishTransmuteFCtoCry := S.Get("FishTransmuteFCtoCry")
    FishTransmuteCrytoA := S.Get("FishTransmuteCrytoA")
    FishTransmuteFCtoA := S.Get("FishTransmuteFCtoA")
    FishTransmuteFCtoT := S.Get("FishTransmuteFCtoT")
    FishTransmuteCrytoFC := S.Get("FishTransmuteCrytoFC")
    FishTransmuteAtoCry := S.Get("FishTransmuteAtoCry")
    FishTransmuteAtoFC := S.Get("FishTransmuteAtoFC")

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "Fishing Settings")
    ;MyGui.Opt("")
    MyGui.SetUserFontSettings()

    ;@region Fishing settings
    ;@region Fishing auto
    MyGui.Add("Text", "", "Fish Reeling in delay (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishCatchingDelay) && FishCatchingDelay > 0) {
        MyGui.Add("UpDown", "vFishCatchingDelay Range1-9999",
            FishCatchingDelay)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishCatchingDelay Range1-9999",
                S.defaultNobodySettings.FishCatchingDelay)
        } Else {
            MyGui.Add("UpDown", "vFishCatchingDelay Range1-9999",
                S.defaultSettings.FishCatchingDelay)
        }
    }

    If (FishCatchingSearch = true) {
        MyGui.Add("CheckBox", "vFishCatchingSearch checked",
            "Enable Search During Fishing")
    } Else {
        MyGui.Add("CheckBox", "vFishCatchingSearch",
            "Enable Search During Fishing")
    }
    ;@endregion

    MyGui.Add("Text", "", "---")

    ;@region Fishing - ShopUpgrade
    If (FishEnableShopUpgrade = true) {
        MyGui.Add("CheckBox", "vFishEnableShopUpgrade checked",
            "Enable Shop Upgrade During Fishing")
    } Else {
        MyGui.Add("CheckBox", "vFishEnableShopUpgrade",
            "Enable Shop Upgrade During Fishing")
    }
    MyGui.Add("Text", "", "Shop Upgrade timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishTimerShopUpgrade) && FishTimerShopUpgrade > 0) {
        MyGui.Add("UpDown", "vFishTimerShopUpgrade Range1-9999",
            FishTimerShopUpgrade)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishTimerShopUpgrade Range1-9999",
                S.defaultNobodySettings.FishTimerShopUpgrade)
        } Else {
            MyGui.Add("UpDown", "vFishTimerShopUpgrade Range1-9999",
                S.defaultSettings.FishTimerShopUpgrade)
        }
    }
    ;@endregion

    MyGui.Add("Text", "", "---")

    ;@region Fishing - Rod Upgrade
    If (FishEnableUpgradeRods = true) {
        MyGui.Add("CheckBox", "vFishEnableUpgradeRods checked",
            "Enable Rod Upgrades During Fishing")
    } Else {
        MyGui.Add("CheckBox", "vFishEnableUpgradeRods",
            "Enable Rod Upgrades During Fishing")
    }
    MyGui.Add("Text", "", "Rod Upgrade timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishTimerUpgradeRods) && FishTimerUpgradeRods > 0) {
        MyGui.Add("UpDown", "vFishTimerUpgradeRods Range1-9999",
            FishTimerUpgradeRods)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishTimerUpgradeRods Range1-9999",
                S.defaultNobodySettings.FishTimerUpgradeRods)
        } Else {
            MyGui.Add("UpDown", "vFishTimerUpgradeRods Range1-9999",
                S.defaultSettings.FishTimerUpgradeRods)
        }
    }
    ;@endregion

    MyGui.Add("Text", "", "---")

    ;@region Fishing - Tourney
    If (FishEnableTourneyPass = true) {
        MyGui.Add("CheckBox", "vFishEnableTourneyPass checked",
            "Enable Tourney During Fishing")
    } Else {
        MyGui.Add("CheckBox", "vFishEnableTourneyPass",
            "Enable Tourney During Fishing")
    }

    MyGui.Add("Text", "", "Tourney timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishTimerTourneyPass) && FishTimerTourneyPass > 0) {
        MyGui.Add("UpDown", "vFishTimerTourneyPass Range1-9999",
            FishTimerTourneyPass)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishTimerTourneyPass Range1-9999",
                S.defaultNobodySettings.FishTimerTourneyPass)
        } Else {
            MyGui.Add("UpDown", "vFishTimerTourneyPass Range1-9999",
                S.defaultSettings.FishTimerTourneyPass)
        }
    }
    ;@endregion

    MyGui.Add("Text", "", "---")

    ;@region Fishing - Tourney Rods
    If (FishEnableUpgradeTourneyRods = true) {
        MyGui.Add("CheckBox", "vFishEnableUpgradeTourneyRods checked",
            "Enable Tourney Rod Upgrades During Fishing")
    } Else {
        MyGui.Add("CheckBox", "vFishEnableUpgradeTourneyRods",
            "Enable Tourney Rod Upgrades During Fishing")
    }
    MyGui.Add("Text", "", "Tourney Rods Upgrade timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishTimerUpgradeTourneyRods) && FishTimerUpgradeTourneyRods > 0) {
        MyGui.Add("UpDown", "vFishTimerUpgradeTourneyRods Range1-9999",
            FishTimerUpgradeTourneyRods)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishTimerUpgradeTourneyRods Range1-9999",
                S.defaultNobodySettings.FishTimerUpgradeTourneyRods)
        } Else {
            MyGui.Add("UpDown", "vFishTimerUpgradeTourneyRods Range1-9999",
                S.defaultSettings.FishTimerUpgradeTourneyRods)
        }
    }
    ;@endregion

    MyGui.Add("Text", "", "---")

    ;@region Fishing - Journey Collection
    If (FishEnableJourneyCollect = true) {
        MyGui.Add("CheckBox", "vFishEnableJourneyCollect checked",
            "Enable Journey Collection During Fishing")
    } Else {
        MyGui.Add("CheckBox", "vFishEnableJourneyCollect",
            "Enable Journey Collection During Fishing")
    }
    MyGui.Add("Text", "", "Journey Collection timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishTimerJourneyCollect) && FishTimerJourneyCollect > 0) {
        MyGui.Add("UpDown", "vFishTimerJourneyCollect Range1-9999",
            FishTimerJourneyCollect)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishTimerJourneyCollect Range1-9999",
                S.defaultNobodySettings.FishTimerJourneyCollect)
        } Else {
            MyGui.Add("UpDown", "vFishTimerJourneyCollect Range1-9999",
                S.defaultSettings.FishTimerJourneyCollect)
        }
    }
    ;@endregion

    MyGui.Add("Text", "", "---")

    ;@region Fishing - Transmute
    If (FishEnableTransmute = true) {
        MyGui.Add("CheckBox", "vFishEnableTransmute checked",
            "Enable Custom Transmute During Fishing")
    } Else {
        MyGui.Add("CheckBox", "vFishEnableTransmute",
            "Enable Custom Transmute During Fishing")
    }
    MyGui.Add("Text", "", "Transmute timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishTimerTransmute) && FishTimerTransmute > 0) {
        MyGui.Add("UpDown", "vFishTimerTransmute Range1-9999",
            FishTimerTransmute)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishTimerTransmute Range1-9999",
                S.defaultNobodySettings.FishTimerTransmute)
        } Else {
            MyGui.Add("UpDown", "vFishTimerTransmute Range1-9999",
                S.defaultSettings.FishTimerTransmute)
        }
    }

    If (FishTransmuteTtoFC = true) {
        MyGui.Add("CheckBox", "vFishTransmuteTtoFC checked",
            "Enable Transmute Trash to Fish Credits")
    } Else {
        MyGui.Add("CheckBox", "vFishTransmuteTtoFC",
            "Enable Transmute Trash to Fish Credits")
    }
    If (FishTransmuteFCtoCry = true) {
        MyGui.Add("CheckBox", "vFishTransmuteFCtoCry checked",
            "Enable Transmute Fish Credits to Crystal")
    } Else {
        MyGui.Add("CheckBox", "vFishTransmuteFCtoCry",
            "Enable Transmute Fish Credits to Crystal")
    }
    If (FishTransmuteCrytoA = true) {
        MyGui.Add("CheckBox", "vFishTransmuteCrytoA checked",
            "Enable Transmute Crystal to Advanced Crystal")
    } Else {
        MyGui.Add("CheckBox", "vFishTransmuteCrytoA",
            "Enable Transmute Crystal to Advanced Crystal")
    }

    checked := (FishTransmuteFCtoA) ? " checked" : ""
    MyGui.Add("CheckBox", "vFishTransmuteFCtoA" checked,
        "Enable Transmute Fish Credits to Advanced Crystal")

    If (FishTransmuteFCtoT = true) {
        MyGui.Add("CheckBox", "vFishTransmuteFCtoT checked",
            "Enable Transmute Fish Credits to Trash")
    } Else {
        MyGui.Add("CheckBox", "vFishTransmuteFCtoT",
            "Enable Transmute Fish Credits to Trash")
    }
    If (FishTransmuteCrytoFC = true) {
        MyGui.Add("CheckBox", "vFishTransmuteCrytoFC checked",
            "Enable Transmute Crystal to Fish Credits")
    } Else {
        MyGui.Add("CheckBox", "vFishTransmuteCrytoFC",
            "Enable Transmute Crystal to Fish Credits")
    }
    If (FishTransmuteAtoCry = true) {
        MyGui.Add("CheckBox", "vFishTransmuteAtoCry checked",
            "Enable Transmute Advanced Crystal to Crystal")
    } Else {
        MyGui.Add("CheckBox", "vFishTransmuteAtoCry",
            "Enable Transmute Advanced Crystal to Crystal")
    }

    checked := (FishTransmuteAtoFC) ? " checked" : ""
    MyGui.Add("CheckBox", "vFishTransmuteAtoFC" checked,
        "Enable Transmute Advanced Crystal to Fish Credits")
    ;@endregion

    ;@region Fishing - Novice Tourney
    If (FishNovice = true) {
        MyGui.Add("CheckBox", "vFishNovice ys checked",
            "Enable Novice Tourney")
    } Else {
        MyGui.Add("CheckBox", "vFishNovice ys",
            "Enable Novice Tourney")
    }

    ;@region Attack setting
    MyGui.Add("Text", "vFishNoviceAttackLabel",
        "Novice Tourney Attack Type:")
    Switch FishNoviceAttack {
    Case 1:
        MyGui.Add("DropDownList", "vFishNoviceAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        MyGui.Add("DropDownList", "vFishNoviceAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        MyGui.Add("DropDownList", "vFishNoviceAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        MyGui.Add("DropDownList", "vFishNoviceAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@region Fishing - Intermediate Tourney
    If (FishIntermediate = true) {
        MyGui.Add("CheckBox", "vFishIntermediate checked",
            "Enable Intermediate Tourney")
    } Else {
        MyGui.Add("CheckBox", "vFishIntermediate",
            "Enable Intermediate Tourney")
    }

    ;@region Attack setting
    MyGui.Add("Text", "vFishIntermediateAttackLabel",
        "Intermediate Tourney Attack Type:")
    Switch FishIntermediateAttack {
    Case 1:
        MyGui.Add("DropDownList", "vFishIntermediateAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        MyGui.Add("DropDownList", "vFishIntermediateAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        MyGui.Add("DropDownList", "vFishIntermediateAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        MyGui.Add("DropDownList", "vFishIntermediateAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@region Fishing - Expert Tourney
    If (FishExpert = true) {
        MyGui.Add("CheckBox", "vFishExpert checked",
            "Enable Expert Tourney")
    } Else {
        MyGui.Add("CheckBox", "vFishExpert",
            "Enable Expert Tourney")
    }

    ;@region Attack setting
    MyGui.Add("Text", "vFishExpertAttackLabel",
        "Expert Tourney Attack Type:")
    Switch FishExpertAttack {
    Case 1:
        MyGui.Add("DropDownList", "vFishExpertAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        MyGui.Add("DropDownList", "vFishExpertAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        MyGui.Add("DropDownList", "vFishExpertAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        MyGui.Add("DropDownList", "vFishExpertAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@region Fishing - Legendary Tourney
    If (FishLegend = true) {
        MyGui.Add("CheckBox", "vFishLegend checked",
            "Enable Legendary Tourney")
    } Else {
        MyGui.Add("CheckBox", "vFishLegend",
            "Enable Legendary Tourney")
    }

    ;@region Attack setting
    MyGui.Add("Text", "vFishLegendAttackLabel",
        "Legendary Tourney Attack Type:")
    Switch FishLegendAttack {
    Case 1:
        MyGui.Add("DropDownList", "vFishLegendAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        MyGui.Add("DropDownList", "vFishLegendAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        MyGui.Add("DropDownList", "vFishLegendAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        MyGui.Add("DropDownList", "vFishLegendAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@endregion

    MyGui.Add("Button", "+Background" GuiBGColour " default xs", "Run Fishing").OnEvent("Click", RunFishAutoCatch)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessFishingSettings)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseFishingSettings)

    ;@endregion

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ProcessFishingSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()
        FishingSave()
        Saving.Hide()
        Temp.Show()
        MyGui.Show()
    }

    RunFishAutoCatch(thisGui, info) {
        MyGui.Hide()
        Fishing().fFishAutoCatch()
    }

    CloseFishingSettings(*) {
        MyGui.Hide()
    }

    FishingSave() {
        values := MyGui.Submit()
        S.Set("FishCatchingDelay", values.FishCatchingDelay)
        S.Set("FishCatchingSearch", values.FishCatchingSearch)
        S.Set("FishNovice", values.FishNovice)
        S.Set("FishIntermediate", values.FishIntermediate)
        S.Set("FishExpert", values.FishExpert)
        S.Set("FishLegend", values.FishLegend)
        S.Set("FishNoviceAttack", values.FishNoviceAttack)
        S.Set("FishIntermediateAttack", values.FishIntermediateAttack)
        S.Set("FishExpertAttack", values.FishExpertAttack)
        S.Set("FishLegendAttack", values.FishLegendAttack)
        S.Set("FishEnableShopUpgrade", values.FishEnableShopUpgrade)
        S.Set("FishEnableUpgradeRods", values.FishEnableUpgradeRods)
        S.Set("FishEnableTourneyPass", values.FishEnableTourneyPass)
        S.Set("FishEnableUpgradeTourneyRods", values.FishEnableUpgradeTourneyRods)
        S.Set("FishEnableTransmute", values.FishEnableTransmute)
        S.Set("FishEnableJourneyCollect", values.FishEnableJourneyCollect)
        S.Set("FishTimerShopUpgrade", values.FishTimerShopUpgrade)
        S.Set("FishTimerUpgradeRods", values.FishTimerUpgradeRods)
        S.Set("FishTimerTourneyPass", values.FishTimerTourneyPass)
        S.Set("FishTimerUpgradeTourneyRods", values.FishTimerUpgradeTourneyRods)
        S.Set("FishTimerTransmute", values.FishTimerTransmute)
        S.Set("FishTimerJourneyCollect", values.FishTimerJourneyCollect)
        S.Set("FishTransmuteTtoFC", values.FishTransmuteTtoFC)
        S.Set("FishTransmuteFCtoCry", values.FishTransmuteFCtoCry)
        S.Set("FishTransmuteCrytoA", values.FishTransmuteCrytoA)
        S.Set("FishTransmuteFCtoA", values.FishTransmuteFCtoA)
        S.Set("FishTransmuteFCtoT", values.FishTransmuteFCtoT)
        S.Set("FishTransmuteCrytoFC", values.FishTransmuteCrytoFC)
        S.Set("FishTransmuteAtoCry", values.FishTransmuteAtoCry)
        S.Set("FishTransmuteAtoFC", values.FishTransmuteAtoFC)

        S.SaveCurrentSettings()
    }
}
