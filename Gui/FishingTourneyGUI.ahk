#Requires AutoHotkey v2.0

Button_Click_FishingTourney(thisGui, info) {

    FishTourCatchingDelay := S.Get("FishTourCatchingDelay")
    FishTourCatchingSearch := S.Get("FishTourCatchingSearch")
    FishTourEnableShopUpgrade := S.Get("FishTourEnableShopUpgrade")
    FishTourEnableUpgradeRods := S.Get("FishTourEnableUpgradeRods")
    FishTourEnableFishingPass := S.Get("FishTourEnableFishingPass")
    FishTourEnableUpgradeTourneyRods := S.Get("FishTourEnableUpgradeTourneyRods")
    FishTourEnableTransmute := S.Get("FishTourEnableTransmute")
    FishTourEnableJourneyCollect := S.Get("FishTourEnableJourneyCollect")
    FishTourTimerShopUpgrade := S.Get("FishTourTimerShopUpgrade")
    FishTourTimerUpgradeRods := S.Get("FishTourTimerUpgradeRods")
    FishTourTimerUpgradeTourneyRods := S.Get("FishTourTimerUpgradeTourneyRods")
    FishTourTimerTransmute := S.Get("FishTourTimerTransmute")
    FishTourTimerJourneyCollect := S.Get("FishTourTimerJourneyCollect")
    FishTourTransmuteTtoFC := S.Get("FishTourTransmuteTtoFC")
    FishTourTransmuteFCtoCry := S.Get("FishTourTransmuteFCtoCry")
    FishTourTransmuteCrytoA := S.Get("FishTourTransmuteCrytoA")
    FishTourTransmuteFCtoA := S.Get("FishTourTransmuteFCtoA")
    FishTourTransmuteFCtoT := S.Get("FishTourTransmuteFCtoT")
    FishTourTransmuteCrytoFC := S.Get("FishTourTransmuteCrytoFC")
    FishTourTransmuteAtoCry := S.Get("FishTourTransmuteAtoCry")
    FishTourTransmuteAtoFC := S.Get("FishTourTransmuteAtoFC")
    FishTourNovice := S.Get("FishTourNovice")
    FishTourIntermediate := S.Get("FishTourIntermediate")
    FishTourExpert := S.Get("FishTourExpert")
    FishTourLegend := S.Get("FishTourLegend")
    FishTourNoviceAttack := S.Get("FishTourNoviceAttack")
    FishTourIntermediateAttack := S.Get("FishTourIntermediateAttack")
    FishTourExpertAttack := S.Get("FishTourExpertAttack")
    FishTourLegendAttack := S.Get("FishTourLegendAttack")

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "Fishing Tourney Settings")
    MyGui.SetUserFontSettings()

    ;@region Tourney settings
    ;@region Fishing
    If (FishTourEnableFishingPass = true) {
        MyGui.Add("CheckBox", "vFishTourEnableFishingPass checked",
            "Enable Fishing During Tourney")
    } Else {
        MyGui.Add("CheckBox", "vFishTourEnableFishingPass",
            "Enable Fishing During Tourney")
    }
    MyGui.Add("Text", "", "Fish Reeling in delay (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishTourCatchingDelay) && FishTourCatchingDelay > 0) {
        MyGui.Add("UpDown", "vFishTourCatchingDelay Range1-9999",
            FishTourCatchingDelay)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishTourCatchingDelay Range1-9999",
                S.defaultNobodySettings.FishTourCatchingDelay)
        } Else {
            MyGui.Add("UpDown", "vFishTourCatchingDelay Range1-9999",
                S.defaultSettings.FishTourCatchingDelay)
        }
    }

    If (FishTourCatchingSearch = true) {
        MyGui.Add("CheckBox", "vFishTourCatchingSearch checked",
            "Enable Search During Tourney")
    } Else {
        MyGui.Add("CheckBox", "vFishTourCatchingSearch",
            "Enable Search During Tourney")
    }
    ;@endregion

    MyGui.Add("Text", "", "---")

    ;@region ShopUpgrade
    If (FishTourEnableShopUpgrade = true) {
        MyGui.Add("CheckBox", "vFishTourEnableShopUpgrade checked",
            "Enable Shop Upgrade During Tourney")
    } Else {
        MyGui.Add("CheckBox", "vFishTourEnableShopUpgrade",
            "Enable Shop Upgrade During Tourney")
    }
    MyGui.Add("Text", "", "Shop Upgrade timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishTourTimerShopUpgrade) && FishTourTimerShopUpgrade > 0) {
        MyGui.Add("UpDown", "vFishTourTimerShopUpgrade Range1-9999",
            FishTourTimerShopUpgrade)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishTourTimerShopUpgrade Range1-9999",
                S.defaultNobodySettings.FishTourTimerShopUpgrade)
        } Else {
            MyGui.Add("UpDown", "vFishTourTimerShopUpgrade Range1-9999",
                S.defaultSettings.FishTourTimerShopUpgrade)
        }
    }
    ;@endregion

    MyGui.Add("Text", "", "---")

    ;@region Rod Upgrade
    If (FishTourEnableUpgradeRods = true) {
        MyGui.Add("CheckBox", "vFishTourEnableUpgradeRods checked",
            "Enable Rod Upgrades During Tourney")
    } Else {
        MyGui.Add("CheckBox", "vFishTourEnableUpgradeRods",
            "Enable Rod Upgrades During Tourney")
    }
    MyGui.Add("Text", "", "Rod Upgrade timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishTourTimerUpgradeRods) && FishTourTimerUpgradeRods > 0) {
        MyGui.Add("UpDown", "vFishTourTimerUpgradeRods Range1-9999",
            FishTourTimerUpgradeRods)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishTourTimerUpgradeRods Range1-9999",
                S.defaultNobodySettings.FishTourTimerUpgradeRods)
        } Else {
            MyGui.Add("UpDown", "vFishTourTimerUpgradeRods Range1-9999",
                S.defaultSettings.FishTourTimerUpgradeRods)
        }
    }
    ;@endregion

    MyGui.Add("Text", "", "---")

    ;@region Tourney Rods
    If (FishTourEnableUpgradeTourneyRods = true) {
        MyGui.Add("CheckBox", "vFishTourEnableUpgradeTourneyRods checked",
            "Enable Tourney Rod Upgrades During Tourney")
    } Else {
        MyGui.Add("CheckBox", "vFishTourEnableUpgradeTourneyRods",
            "Enable Tourney Rod Upgrades During Tourney")
    }
    MyGui.Add("Text", "", "Tourney Rods Upgrade timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishTourTimerUpgradeTourneyRods) && FishTourTimerUpgradeTourneyRods > 0) {
        MyGui.Add("UpDown", "vFishTourTimerUpgradeTourneyRods Range1-9999",
            FishTourTimerUpgradeTourneyRods)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishTourTimerUpgradeTourneyRods Range1-9999",
                S.defaultNobodySettings.FishTourTimerUpgradeTourneyRods)
        } Else {
            MyGui.Add("UpDown", "vFishTourTimerUpgradeTourneyRods Range1-9999",
                S.defaultSettings.FishTourTimerUpgradeTourneyRods)
        }
    }
    ;@endregion

    MyGui.Add("Text", "", "---")

    ;@region Journey Collection
    If (FishTourEnableJourneyCollect = true) {
        MyGui.Add("CheckBox", "vFishTourEnableJourneyCollect checked",
            "Enable Journey Collection During Tourney")
    } Else {
        MyGui.Add("CheckBox", "vFishTourEnableJourneyCollect",
            "Enable Journey Collection During Tourney")
    }
    MyGui.Add("Text", "", "Journey Collection timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishTourTimerJourneyCollect) && FishTourTimerJourneyCollect > 0) {
        MyGui.Add("UpDown", "vFishTourTimerJourneyCollect Range1-9999",
            FishTourTimerJourneyCollect)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishTourTimerJourneyCollect Range1-9999",
                S.defaultNobodySettings.FishTourTimerJourneyCollect)
        } Else {
            MyGui.Add("UpDown", "vFishTourTimerJourneyCollect Range1-9999",
                S.defaultSettings.FishTourTimerJourneyCollect)
        }
    }
    ;@endregion

    MyGui.Add("Text", "", "---")

    ;@region Transmute
    If (FishTourEnableTransmute = true) {
        MyGui.Add("CheckBox", "vFishTourEnableTransmute checked",
            "Enable Custom Transmute During Tourney")
    } Else {
        MyGui.Add("CheckBox", "vFishTourEnableTransmute",
            "Enable Custom Transmute During Tourney")
    }
    MyGui.Add("Text", "", "Transmute timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishTourTimerTransmute) && FishTourTimerTransmute > 0) {
        MyGui.Add("UpDown", "vFishTourTimerTransmute Range1-9999",
            FishTourTimerTransmute)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishTourTimerTransmute Range1-9999",
                S.defaultNobodySettings.FishTourTimerTransmute)
        } Else {
            MyGui.Add("UpDown", "vFishTourTimerTransmute Range1-9999",
                S.defaultSettings.FishTourTimerTransmute)
        }
    }

    checked := (FishTourTransmuteTtoFC) ? " checked" : ""
    MyGui.Add("CheckBox", "vFishTourTransmuteTtoFC" checked,
        "Enable Transmute Trash to Fish Credits")

    checked := (FishTourTransmuteFCtoCry) ? " checked" : ""
    MyGui.Add("CheckBox", "vFishTourTransmuteFCtoCry" checked,
        "Enable Transmute Fish Credits to Crystal")

    checked := (FishTourTransmuteCrytoA) ? " checked" : ""
    MyGui.Add("CheckBox", "vFishTourTransmuteCrytoA" checked,
        "Enable Transmute Crystal to Advanced Crystal")

    checked := (FishTourTransmuteFCtoA) ? " checked" : ""
    MyGui.Add("CheckBox", "vFishTourTransmuteFCtoA" checked,
        "Enable Transmute Fish Credits to Advanced Crystal")

    checked := (FishTourTransmuteFCtoT) ? " checked" : ""
    MyGui.Add("CheckBox", "vFishTourTransmuteFCtoT" checked,
        "Enable Transmute Fish Credits to Trash")

    checked := (FishTourTransmuteCrytoFC) ? " checked" : ""
    MyGui.Add("CheckBox", "vFishTourTransmuteCrytoFC" checked,
        "Enable Transmute Crystal to Fish Credits")

    checked := (FishTourTransmuteAtoCry) ? " checked" : ""
    MyGui.Add("CheckBox", "vFishTourTransmuteAtoCry" checked,
        "Enable Transmute Advanced Crystal to Crystal")

    checked := (FishTourTransmuteAtoFC) ? " checked" : ""
    MyGui.Add("CheckBox", "vFishTourTransmuteAtoFC" checked,
        "Enable Transmute Advanced Crystal to Fish Credits")

    ;@endregion

    ;@region Novice Tourney
    checked := (FishTourNovice) ? " checked" : ""
    MyGui.Add("CheckBox", "vFishTourNovice ys" checked,
        "Enable Novice Tourney")

    ;@region Attack setting
    MyGui.Add("Text", "vFishTourNoviceAttackLabel",
        "Novice Tourney Attack Type:")
    Switch FishTourNoviceAttack {
    Case 1:
        MyGui.Add("DropDownList", "vFishTourNoviceAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        MyGui.Add("DropDownList", "vFishTourNoviceAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        MyGui.Add("DropDownList", "vFishTourNoviceAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        MyGui.Add("DropDownList", "vFishTourNoviceAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@region Intermediate Tourney
    If (FishTourIntermediate = true) {
        MyGui.Add("CheckBox", "vFishTourIntermediate checked",
            "Enable Intermediate Tourney")
    } Else {
        MyGui.Add("CheckBox", "vFishTourIntermediate",
            "Enable Intermediate Tourney")
    }

    ;@region Attack setting
    MyGui.Add("Text", "vFishTourIntermediateAttackLabel",
        "Intermediate Tourney Attack Type:")
    Switch FishTourIntermediateAttack {
    Case 1:
        MyGui.Add("DropDownList", "vFishTourIntermediateAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        MyGui.Add("DropDownList", "vFishTourIntermediateAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        MyGui.Add("DropDownList", "vFishTourIntermediateAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        MyGui.Add("DropDownList", "vFishTourIntermediateAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@region Expert Tourney
    If (FishTourExpert = true) {
        MyGui.Add("CheckBox", "vFishTourExpert checked",
            "Enable Expert Tourney")
    } Else {
        MyGui.Add("CheckBox", "vFishTourExpert",
            "Enable Expert Tourney")
    }

    ;@region Attack setting
    MyGui.Add("Text", "vFishTourExpertAttackLabel",
        "Expert Tourney Attack Type:")
    Switch FishTourExpertAttack {
    Case 1:
        MyGui.Add("DropDownList", "vFishTourExpertAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        MyGui.Add("DropDownList", "vFishTourExpertAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        MyGui.Add("DropDownList", "vFishTourExpertAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        MyGui.Add("DropDownList", "vFishTourExpertAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@region Legendary Tourney
    If (FishTourLegend = true) {
        MyGui.Add("CheckBox", "vFishTourLegend checked",
            "Enable Legendary Tourney")
    } Else {
        MyGui.Add("CheckBox", "vFishTourLegend",
            "Enable Legendary Tourney")
    }

    ;@region Attack setting
    MyGui.Add("Text", "vFishTourLegendAttackLabel",
        "Legendary Tourney Attack Type:")
    Switch FishTourLegendAttack {
    Case 1:
        MyGui.Add("DropDownList", "vFishTourLegendAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        MyGui.Add("DropDownList", "vFishTourLegendAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        MyGui.Add("DropDownList", "vFishTourLegendAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        MyGui.Add("DropDownList", "vFishTourLegendAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@endregion

    MyGui.Add("Button", "+Background" GuiBGColour " default xs", "Run Tourney").OnEvent("Click", RunFishTourStart)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessFishTourSettings)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseFishTourSettings)

    ;@endregion

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ProcessFishTourSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()
        FishTourSave()
        Saving.Hide()
        Temp.Show()
        MyGui.Show()
    }

    RunFishTourStart(thisGui, info) {
        MyGui.Hide()
        FishingTourney().Farm()
    }

    CloseFishTourSettings(*) {
        MyGui.Hide()
    }

    FishTourSave() {
        values := MyGui.Submit()
        S.Set("FishTourCatchingDelay", values.FishTourCatchingDelay)
        S.Set("FishTourCatchingSearch", values.FishTourCatchingSearch)
        S.Set("FishTourEnableShopUpgrade", values.FishTourEnableShopUpgrade)
        S.Set("FishTourEnableUpgradeRods", values.FishTourEnableUpgradeRods)
        S.Set("FishTourEnableFishingPass", values.FishTourEnableFishingPass)
        S.Set("FishTourEnableUpgradeTourneyRods", values.FishTourEnableUpgradeTourneyRods)
        S.Set("FishTourEnableTransmute", values.FishTourEnableTransmute)
        S.Set("FishTourEnableJourneyCollect", values.FishTourEnableJourneyCollect)
        S.Set("FishTourTimerShopUpgrade", values.FishTourTimerShopUpgrade)
        S.Set("FishTourTimerUpgradeRods", values.FishTourTimerUpgradeRods)
        S.Set("FishTourTimerUpgradeTourneyRods", values.FishTourTimerUpgradeTourneyRods)
        S.Set("FishTourTimerTransmute", values.FishTourTimerTransmute)
        S.Set("FishTourTimerJourneyCollect", values.FishTourTimerJourneyCollect)
        S.Set("FishTourTransmuteTtoFC", values.FishTourTransmuteTtoFC)
        S.Set("FishTourTransmuteFCtoCry", values.FishTourTransmuteFCtoCry)
        S.Set("FishTourTransmuteCrytoA", values.FishTourTransmuteCrytoA)
        S.Set("FishTourTransmuteFCtoA", values.FishTourTransmuteFCtoA)
        S.Set("FishTourTransmuteFCtoT", values.FishTourTransmuteFCtoT)
        S.Set("FishTourTransmuteCrytoFC", values.FishTourTransmuteCrytoFC)
        S.Set("FishTourTransmuteAtoCry", values.FishTourTransmuteAtoCry)
        S.Set("FishTourTransmuteAtoFC", values.FishTourTransmuteAtoFC)
        S.Set("FishTourNovice", values.FishTourNovice)
        S.Set("FishTourIntermediate", values.FishTourIntermediate)
        S.Set("FishTourExpert", values.FishTourExpert)
        S.Set("FishTourLegend", values.FishTourLegend)
        S.Set("FishTourNoviceAttack", values.FishTourNoviceAttack)
        S.Set("FishTourIntermediateAttack", values.FishTourIntermediateAttack)
        S.Set("FishTourExpertAttack", values.FishTourExpertAttack)
        S.Set("FishTourLegendAttack", values.FishTourLegendAttack)

        S.SaveCurrentSettings()
    }
}
