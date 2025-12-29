#Requires AutoHotkey v2.0

Button_Click_Harbor(thisGui, info) {

    HarborJobRefresh := S.Get("HarborJobRefresh")
    HarborShopMax := S.Get("HarborShopMax")
    HarborShipsClaim := S.Get("HarborShipsClaim")
    HarborJourneyClaim := S.Get("HarborJourneyClaim")
    HarborShopTimer := S.Get("HarborShopTimer")
    HarborShipsTimer := S.Get("HarborShipsTimer")
    HarborJourneyTimer := S.Get("HarborJourneyTimer")

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "Harbor Settings")
    ;MyGui.Opt("")
    MyGui.SetUserFontSettings()

    checked := (HarborJobRefresh) ? " checked" : ""
    MyGui.Add("CheckBox", "vHarborJobRefresh" checked,
        "Enable Delivery Job Manager")

    checked := (HarborShopMax) ? " checked" : ""
    MyGui.Add("CheckBox", "vHarborShopMax" checked,
        "Enable Harbor Shop Maxing")

    MyGui.Add("Text", "", "Shop Buy Max Timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(HarborShopTimer) && HarborShopTimer > 0) {
        MyGui.Add("UpDown", "vHarborShopTimer Range1-9999",
            HarborShopTimer)
    } Else {
        MyGui.Add("UpDown", "vHarborShopTimer Range1-9999",
            S.GetDefault("HarborShopTimer"))
    }

    checked := (HarborShipsClaim) ? " checked" : ""
    MyGui.Add("CheckBox", "vHarborShipsClaim" checked,
        "Enable Ships Claiming")

    MyGui.Add("Text", "", "Ships Claim Timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(HarborShipsTimer) && HarborShipsTimer > 0) {
        MyGui.Add("UpDown", "vHarborShipsTimer Range1-9999",
            HarborShipsTimer)
    } Else {
        MyGui.Add("UpDown", "vHarborShipsTimer Range1-9999",
            S.GetDefault("HarborShipsTimer"))
    }

    checked := (HarborJourneyClaim) ? " checked" : ""
    MyGui.Add("CheckBox", "vHarborJourneyClaim" checked,
        "Enable Harbor Journey Claim")

    MyGui.Add("Text", "", "Journey Claim Timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(HarborJourneyTimer) && HarborJourneyTimer > 0) {
        MyGui.Add("UpDown", "vHarborJourneyTimer Range1-9999",
            HarborJourneyTimer)
    } Else {
        MyGui.Add("UpDown", "vHarborJourneyTimer Range1-9999",
            S.GetDefault("HarborJourneyTimer"))
    }

    MyGui.Add("Button", "+Background" GuiBGColour " default xs", "Run Harbor").OnEvent("Click", RunHarborManager)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessHarborSettings)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseHarborSettings)

    ;@endregion

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ProcessHarborSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()
        HarborSave()
        Saving.Hide()
        Temp.Show()
        MyGui.Show()
    }

    RunHarborManager(thisGui, info) {
        MyGui.Hide()
        Harbor().startHarborManager()
    }

    CloseHarborSettings(*) {
        MyGui.Hide()
    }

    HarborSave() {
        values := MyGui.Submit()
        S.Set("HarborJobRefresh", values.HarborJobRefresh)
        S.Set("HarborShopMax", values.HarborShopMax)
        S.Set("HarborShipsClaim", values.HarborShipsClaim)
        S.Set("HarborJourneyClaim", values.HarborJourneyClaim)
        S.Set("HarborShopTimer", values.HarborShopTimer)
        S.Set("HarborShipsTimer", values.HarborShipsTimer)
        S.Set("HarborJourneyTimer", values.HarborJourneyTimer)

        S.SaveCurrentSettings()
    }
}
