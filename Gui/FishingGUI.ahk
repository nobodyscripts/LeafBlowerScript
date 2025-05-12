#Requires AutoHotkey v2.0

Button_Click_Fishing(thisGui, info) {
    Global Settings, FishCatchingDelay, FishCatchingSearch, FishTourneyNovice,
        FishTourneyIntermediate, FishTourneyExpert, FishTourneyLegend,
        FishTourneyNoviceAttack, FishTourneyIntermediateAttack,
        FishTourneyExpertAttack, FishTourneyLegendAttack

    optionsGUI := Gui(, "Fishing Settings")
    optionsGUI.Opt("")
    optionsGUI.BackColor := "0c0018"

    ;@region Fishing settings
    If (FishCatchingSearch = true) {
        optionsGUI.Add("CheckBox", "vFishCatchingSearch ccfcfcf checked",
            "Enable Search During Fishing")
    } Else {
        optionsGUI.Add("CheckBox", "vFishCatchingSearch ccfcfcf",
            "Enable Search During Fishing")
    }

    optionsGUI.Add("Text", "ccfcfcf", "Fish Reeling in delay (s):")
    optionsGUI.AddEdit()
    If (IsInteger(FishCatchingDelay) && FishCatchingDelay > 0) {
        optionsGUI.Add("UpDown", "vFishCatchingDelay Range1-600",
            FishCatchingDelay)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vFishCatchingDelay Range1-600",
                Settings.defaultNobodySettings.FishCatchingDelay)
        } Else {
            optionsGUI.Add("UpDown", "vFishCatchingDelay Range1-600",
                Settings.defaultSettings.FishCatchingDelay)
        }
    }
    ;@endregion

    optionsGUI.Add("Text", "ccfcfcf", "")

    ;@region Tourney difficulty settings

    ;@region Novice Tourney()
    If (FishTourneyNovice = true) {
        optionsGUI.Add("CheckBox", "vFishTourneyNovice ccfcfcf checked",
            "Enable Novice Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourneyNovice ccfcfcf",
            "Enable Novice Tourney")
    }

    ;@region Attack setting
    optionsGUI.Add("Text", "ccfcfcf vFishTourneyNoviceAttackLabel",
        "Novice Tourney Attack Type:")
    Switch FishTourneyNoviceAttack {
    Case 1:
        optionsGUI.Add("DropDownList", "vFishTourneyNoviceAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        optionsGUI.Add("DropDownList", "vFishTourneyNoviceAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        optionsGUI.Add("DropDownList", "vFishTourneyNoviceAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        optionsGUI.Add("DropDownList", "vFishTourneyNoviceAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@region Intermediate Tourney
    If (FishTourneyIntermediate = true) {
        optionsGUI.Add("CheckBox", "vFishTourneyIntermediate ccfcfcf checked",
            "Enable Intermediate Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourneyIntermediate ccfcfcf",
            "Enable Intermediate Tourney")
    }

    ;@region Attack setting
    optionsGUI.Add("Text", "ccfcfcf vFishTourneyIntermediateAttackLabel",
        "Intermediate Tourney Attack Type:")
    Switch FishTourneyIntermediateAttack {
    Case 1:
        optionsGUI.Add("DropDownList", "vFishTourneyIntermediateAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        optionsGUI.Add("DropDownList", "vFishTourneyIntermediateAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        optionsGUI.Add("DropDownList", "vFishTourneyIntermediateAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        optionsGUI.Add("DropDownList", "vFishTourneyIntermediateAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@region Expert Tourney
    If (FishTourneyExpert = true) {
        optionsGUI.Add("CheckBox", "vFishTourneyExpert ccfcfcf checked",
            "Enable Expert Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourneyExpert ccfcfcf",
            "Enable Expert Tourney")
    }

    ;@region Attack setting
    optionsGUI.Add("Text", "ccfcfcf vFishTourneyExpertAttackLabel",
        "Expert Tourney Attack Type:")
    Switch FishTourneyExpertAttack {
    Case 1:
        optionsGUI.Add("DropDownList", "vFishTourneyExpertAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        optionsGUI.Add("DropDownList", "vFishTourneyExpertAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        optionsGUI.Add("DropDownList", "vFishTourneyExpertAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        optionsGUI.Add("DropDownList", "vFishTourneyExpertAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion

    ;@region Legendary Tourney
    If (FishTourneyLegend = true) {
        optionsGUI.Add("CheckBox", "vFishTourneyLegend ccfcfcf checked",
            "Enable Legendary Tourney")
    } Else {
        optionsGUI.Add("CheckBox", "vFishTourneyLegend ccfcfcf",
            "Enable Legendary Tourney")
    }

    ;@region Attack setting
    optionsGUI.Add("Text", "ccfcfcf vFishTourneyLegendAttackLabel",
        "Legendary Tourney Attack Type:")
    Switch FishTourneyLegendAttack {
    Case 1:
        optionsGUI.Add("DropDownList", "vFishTourneyLegendAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    Case 2:
        optionsGUI.Add("DropDownList", "vFishTourneyLegendAttack Choose2", [
            "1",
            "2",
            "3"
        ])
    Case 3:
        optionsGUI.Add("DropDownList", "vFishTourneyLegendAttack Choose3", [
            "1",
            "2",
            "3"
        ])
    default:
        optionsGUI.Add("DropDownList", "vFishTourneyLegendAttack Choose1", [
            "1",
            "2",
            "3"
        ])
    }
    ;@endregion
    ;@endregion
    ;@endregion

    optionsGUI.Add("Button", "default", "Run Fishing").OnEvent("Click", RunFishAutoCatch)

    optionsGUI.Add("Button", "default yp", "Run Challenge").OnEvent("Click",
        RunFishAutoCatchChallenge)

    optionsGUI.Add("Button", "default yp", "Run Tourney").OnEvent("Click", RunFishTourneyStart)

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

    RunFishTourneyStart(thisGui, info) {
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
        FishTourneyNovice := values.FishTourneyNovice
        FishTourneyIntermediate := values.FishTourneyIntermediate
        FishTourneyExpert := values.FishTourneyExpert
        FishTourneyLegend := values.FishTourneyLegend
        FishTourneyNoviceAttack := values.FishTourneyNoviceAttack
        FishTourneyIntermediateAttack := values.FishTourneyIntermediateAttack
        FishTourneyExpertAttack := values.FishTourneyExpertAttack
        FishTourneyLegendAttack := values.FishTourneyLegendAttack
        Settings.SaveCurrentSettings()
    }
}
