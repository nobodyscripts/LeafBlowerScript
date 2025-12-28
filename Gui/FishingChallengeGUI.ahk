#Requires AutoHotkey v2.0

Button_Click_FishingChallenge(thisGui, info) {

    FishChlCatchingDelay := S.Get("FishChlCatchingDelay")
    FishChlCatchingSearch := S.Get("FishChlCatchingSearch")
    FishChlEnableShopUpgrade := S.Get("FishChlEnableShopUpgrade")
    FishChlEnableUpgradeRods := S.Get("FishChlEnableUpgradeRods")
    FishChlEnableTransmute := S.Get("FishChlEnableTransmute")
    FishChlEnableJourneyCollect := S.Get("FishChlEnableJourneyCollect")
    FishChlTimerShopUpgrade := S.Get("FishChlTimerShopUpgrade")
    FishChlTimerUpgradeRods := S.Get("FishChlTimerUpgradeRods")
    FishChlTimerTransmute := S.Get("FishChlTimerTransmute")
    FishChlTimerJourneyCollect := S.Get("FishChlTimerJourneyCollect")
    FishChlTransmuteTtoFC := S.Get("FishChlTransmuteTtoFC")
    FishChlTransmuteFCtoCry := S.Get("FishChlTransmuteFCtoCry")
    FishChlTransmuteCrytoA := S.Get("FishChlTransmuteCrytoA")
    FishChlTransmuteFCtoA := S.Get("FishChlTransmuteFCtoA")
    FishChlTransmuteFCtoT := S.Get("FishChlTransmuteFCtoT")
    FishChlTransmuteCrytoFC := S.Get("FishChlTransmuteCrytoFC")
    FishChlTransmuteAtoCry := S.Get("FishChlTransmuteAtoCry")
    FishChlTransmuteAtoFC := S.Get("FishChlTransmuteAtoFC")
    FishChlAmount := S.Get("FishChlAmount")

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {GuiControl} */
    thisGui := thisGui

    /** @type {cGUI} */
    MyGui := cGui(, "Fishing Challenge Settings")
    MyGui.SetUserFontSettings()

    ;@region Challenge settings
    ;@region Challenge - Fishing
    MyGui.Add("Text", "", "Fish Reeling in delay (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishChlCatchingDelay) && FishChlCatchingDelay > 0) {
        MyGui.Add("UpDown", "vFishChlCatchingDelay Range1-9999",
            FishChlCatchingDelay)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishChlCatchingDelay Range1-9999",
                S.defaultNobodySettings.FishChlCatchingDelay)
        } Else {
            MyGui.Add("UpDown", "vFishChlCatchingDelay Range1-9999",
                S.defaultSettings.FishChlCatchingDelay)
        }
    }

    If (FishChlCatchingSearch = true) {
        MyGui.Add("CheckBox", "vFishChlCatchingSearch checked",
            "Enable Search During Challenge")
    } Else {
        MyGui.Add("CheckBox", "vFishChlCatchingSearch",
            "Enable Search During Challenge")
    }
    ;@endregion

    MyGui.Add("Text", "", "---")

    ;@region Challenge - ShopUpgrade
    If (FishChlEnableShopUpgrade = true) {
        MyGui.Add("CheckBox", "vFishChlEnableShopUpgrade checked",
            "Enable Shop Upgrade During Challenge")
    } Else {
        MyGui.Add("CheckBox", "vFishChlEnableShopUpgrade",
            "Enable Shop Upgrade During Challenge")
    }
    MyGui.Add("Text", "", "Shop Upgrade timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishChlTimerShopUpgrade) && FishChlTimerShopUpgrade > 0) {
        MyGui.Add("UpDown", "vFishChlTimerShopUpgrade Range1-9999",
            FishChlTimerShopUpgrade)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishChlTimerShopUpgrade Range1-9999",
                S.defaultNobodySettings.FishChlTimerShopUpgrade)
        } Else {
            MyGui.Add("UpDown", "vFishChlTimerShopUpgrade Range1-9999",
                S.defaultSettings.FishChlTimerShopUpgrade)
        }
    }
    ;@endregion

    MyGui.Add("Text", "", "---")

    ;@region Challenge - Rod Upgrade
    If (FishChlEnableUpgradeRods = true) {
        MyGui.Add("CheckBox", "vFishChlEnableUpgradeRods checked",
            "Enable Rod Upgrades During Challenge")
    } Else {
        MyGui.Add("CheckBox", "vFishChlEnableUpgradeRods",
            "Enable Rod Upgrades During Challenge")
    }
    MyGui.Add("Text", "", "Rod Upgrade timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishChlTimerUpgradeRods) && FishChlTimerUpgradeRods > 0) {
        MyGui.Add("UpDown", "vFishChlTimerUpgradeRods Range1-9999",
            FishChlTimerUpgradeRods)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishChlTimerUpgradeRods Range1-9999",
                S.defaultNobodySettings.FishChlTimerUpgradeRods)
        } Else {
            MyGui.Add("UpDown", "vFishChlTimerUpgradeRods Range1-9999",
                S.defaultSettings.FishChlTimerUpgradeRods)
        }
    }
    ;@endregion

    MyGui.Add("Text", "", "---")

    ;@region Challenge - Journey Collection
    If (FishChlEnableJourneyCollect = true) {
        MyGui.Add("CheckBox", "vFishChlEnableJourneyCollect checked",
            "Enable Journey Collection During Challenge")
    } Else {
        MyGui.Add("CheckBox", "vFishChlEnableJourneyCollect",
            "Enable Journey Collection During Challenge")
    }
    MyGui.Add("Text", "", "Journey Collection timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishChlTimerJourneyCollect) && FishChlTimerJourneyCollect > 0) {
        MyGui.Add("UpDown", "vFishChlTimerJourneyCollect Range1-9999",
            FishChlTimerJourneyCollect)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishChlTimerJourneyCollect Range1-9999",
                S.defaultNobodySettings.FishChlTimerJourneyCollect)
        } Else {
            MyGui.Add("UpDown", "vFishChlTimerJourneyCollect Range1-9999",
                S.defaultSettings.FishChlTimerJourneyCollect)
        }
    }
    ;@endregion

    MyGui.Add("Text", "", "---")

    ;@region Challenge - Transmute
    If (FishChlEnableTransmute = true) {
        MyGui.Add("CheckBox", "vFishChlEnableTransmute checked",
            "Enable Custom Transmute During Challenge")
    } Else {
        MyGui.Add("CheckBox", "vFishChlEnableTransmute",
            "Enable Custom Transmute During Challenge")
    }
    MyGui.Add("Text", "", "Transmute timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishChlTimerTransmute) && FishChlTimerTransmute > 0) {
        MyGui.Add("UpDown", "vFishChlTimerTransmute Range1-9999",
            FishChlTimerTransmute)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishChlTimerTransmute Range1-9999",
                S.defaultNobodySettings.FishChlTimerTransmute)
        } Else {
            MyGui.Add("UpDown", "vFishChlTimerTransmute Range1-9999",
                S.defaultSettings.FishChlTimerTransmute)
        }
    }

    If (FishChlTransmuteTtoFC = true) {
        MyGui.Add("CheckBox", "vFishChlTransmuteTtoFC checked",
            "Enable Transmute Trash to Fish Credits")
    } Else {
        MyGui.Add("CheckBox", "vFishChlTransmuteTtoFC",
            "Enable Transmute Trash to Fish Credits")
    }
    If (FishChlTransmuteFCtoCry = true) {
        MyGui.Add("CheckBox", "vFishChlTransmuteFCtoCry checked",
            "Enable Transmute Fish Credits to Crystal")
    } Else {
        MyGui.Add("CheckBox", "vFishChlTransmuteFCtoCry",
            "Enable Transmute Fish Credits to Crystal")
    }
    If (FishChlTransmuteCrytoA = true) {
        MyGui.Add("CheckBox", "vFishChlTransmuteCrytoA checked",
            "Enable Transmute Crystal to Advanced Crystal")
    } Else {
        MyGui.Add("CheckBox", "vFishChlTransmuteCrytoA",
            "Enable Transmute Crystal to Advanced Crystal")
    }

    checked := (FishChlTransmuteFCtoA) ? " checked" : ""
    MyGui.Add("CheckBox", "vFishChlTransmuteFCtoA" checked,
        "Enable Transmute Fish Credits to Advanced Crystal")

    If (FishChlTransmuteFCtoT = true) {
        MyGui.Add("CheckBox", "vFishChlTransmuteFCtoT checked",
            "Enable Transmute Fish Credits to Trash")
    } Else {
        MyGui.Add("CheckBox", "vFishChlTransmuteFCtoT",
            "Enable Transmute Fish Credits to Trash")
    }
    If (FishChlTransmuteCrytoFC = true) {
        MyGui.Add("CheckBox", "vFishChlTransmuteCrytoFC checked",
            "Enable Transmute Crystal to Fish Credits")
    } Else {
        MyGui.Add("CheckBox", "vFishChlTransmuteCrytoFC",
            "Enable Transmute Crystal to Fish Credits")
    }
    If (FishChlTransmuteAtoCry = true) {
        MyGui.Add("CheckBox", "vFishChlTransmuteAtoCry checked",
            "Enable Transmute Advanced Crystal to Crystal")
    } Else {
        MyGui.Add("CheckBox", "vFishChlTransmuteAtoCry",
            "Enable Transmute Advanced Crystal to Crystal")
    }
    
    checked := (FishChlTransmuteAtoFC) ? " checked" : ""
    MyGui.Add("CheckBox", "vFishChlTransmuteAtoFC" checked,
        "Enable Transmute Advanced Crystal to Fish Credits")
    ;@endregion
    ;@endregion

    MyGui.Add("Text", "", "Challenge Run Amount:")
    MyGui.AddEdit("cDefault")
    If (IsInteger(FishChlAmount) && FishChlAmount > 0) {
        MyGui.Add("UpDown", "vFishChlAmount Range1-9999",
            FishChlAmount)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vFishChlAmount Range1-9999",
                S.defaultNobodySettings.FishChlAmount)
        } Else {
            MyGui.Add("UpDown", "vFishChlAmount Range1-9999",
                S.defaultSettings.FishChlAmount)
        }
    }

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Run Once").OnEvent("Click",
        RunFishChallengeSingle)

    MyGui.Add("Button", "+Background" GuiBGColour " yp", "Run Looped").OnEvent("Click",
        RunFishChallengeLoop)

    MyGui.Add("Button", "+Background" GuiBGColour " yp", "Run User Amount").OnEvent("Click",
        RunFishChallengeAmount)

    MyGui.Add("Button", "+Background" GuiBGColour " yp", "Save").OnEvent("Click",
        ProcessFishChlSettings)
    MyGui.Add("Button", "+Background" GuiBGColour " yp", "Cancel").OnEvent("Click",
        CloseFishChlSettings)

    ;@endregion

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ProcessFishChlSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()
        FishChlSave()
        Saving.Hide()
        Temp.Show()
        MyGui.Show()
    }

    RunFishChallengeSingle(thisGui, info) {
        MyGui.Hide()
        FishingChallenge().StartLoop()
    }

    RunFishChallengeLoop(thisGui, info) {
        MyGui.Hide()
        FishingChallenge().StartLoop()
    }

    RunFishChallengeAmount(thisGui, info) {
        MyGui.Hide()
        FishingChallenge().StartLoop()
    }

    CloseFishChlSettings(*) {
        MyGui.Hide()
    }

    FishChlSave() {
        values := MyGui.Submit()

        S.Set("FishChlCatchingDelay", values.FishChlCatchingDelay)
        S.Set("FishChlCatchingSearch", values.FishChlCatchingSearch)
        S.Set("FishChlEnableShopUpgrade", values.FishChlEnableShopUpgrade)
        S.Set("FishChlEnableUpgradeRods", values.FishChlEnableUpgradeRods)
        S.Set("FishChlEnableTransmute", values.FishChlEnableTransmute)
        S.Set("FishChlEnableJourneyCollect", values.FishChlEnableJourneyCollect)
        S.Set("FishChlTimerShopUpgrade", values.FishChlTimerShopUpgrade)
        S.Set("FishChlTimerUpgradeRods", values.FishChlTimerUpgradeRods)
        S.Set("FishChlTimerTransmute", values.FishChlTimerTransmute)
        S.Set("FishChlTimerJourneyCollect", values.FishChlTimerJourneyCollect)
        S.Set("FishChlTransmuteTtoFC", values.FishChlTransmuteTtoFC)
        S.Set("FishChlTransmuteFCtoCry", values.FishChlTransmuteFCtoCry)
        S.Set("FishChlTransmuteCrytoA", values.FishChlTransmuteCrytoA)
        S.Set("FishChlTransmuteFCtoA", values.FishChlTransmuteFCtoA)
        S.Set("FishChlTransmuteFCtoT", values.FishChlTransmuteFCtoT)
        S.Set("FishChlTransmuteCrytoFC", values.FishChlTransmuteCrytoFC)
        S.Set("FishChlTransmuteAtoCry", values.FishChlTransmuteAtoCry)
        S.Set("FishChlTransmuteAtoFC", values.FishChlTransmuteAtoFC)
        S.Set("FishChlAmount", values.FishChlAmount)

        S.SaveCurrentSettings()
    }
}

#Include SavingGUI.ahk