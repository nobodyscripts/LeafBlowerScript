#Requires AutoHotkey v2.0

Button_Click_Cards(thisGui, info) {
    Global Settings, CardsCommonAmount, CardsRareAmount, CardsLegendaryAmount,
        CardsDontOpenCommons, CardsDontOpenRare, CardsDontOpenLegendary,
        CardsSleepAmount, CardsPermaLoop, CardsBossFarmEnabled, CardsBuyEnabled,
        CardsBuyStyle, CardsCommonBuyAmount, CardsRareBuyAmount,
        CardsLegBuyAmount, CardsDontBuyCommons, CardsDontBuyRare,
        CardsDontBuyLeg, CardsSleepBuyAmount, CardsGreedyOpen, CardsGreedyBuy

    /** @type {GUI} */
    optionsGUI := Gui(, "Mine Maintainer Settings")
    optionsGUI.Opt("")
    SetFontOptions(optionsGUI)
    optionsGUI.Add("Text", "", "Cards Opening Options:")
    optionsGUI.Add("Text", "", "Open Common Card Packs Amount:")
    Switch CardsCommonAmount {
    Case 1:
        optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose1", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 10:
        optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose2", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 25:
        optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose3", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 100:
        optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose4", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 250:
        optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose5", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 1000:
        optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose6", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 2500:
        optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose7", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 25000:
        optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose8", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    default:
        optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose8", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    }

    optionsGUI.Add("Text", "", "Open Rare Card Packs Amount:")
    Switch CardsRareAmount {
    Case 1:
        optionsGUI.Add("DropDownList", "vCardsRareAmount Choose1", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 10:
        optionsGUI.Add("DropDownList", "vCardsRareAmount Choose2", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 25:
        optionsGUI.Add("DropDownList", "vCardsRareAmount Choose3", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 100:
        optionsGUI.Add("DropDownList", "vCardsRareAmount Choose4", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 250:
        optionsGUI.Add("DropDownList", "vCardsRareAmount Choose5", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 1000:
        optionsGUI.Add("DropDownList", "vCardsRareAmount Choose6", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 2500:
        optionsGUI.Add("DropDownList", "vCardsRareAmount Choose7", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 25000:
        optionsGUI.Add("DropDownList", "vCardsRareAmount Choose8", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    default:
        optionsGUI.Add("DropDownList", "vCardsRareAmount Choose8", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    }

    optionsGUI.Add("Text", "", "Open Legendary Card Packs Amount:")
    Switch CardsLegendaryAmount {
    Case 1:
        optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose1", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 10:
        optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose2", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 25:
        optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose3", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 100:
        optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose4", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 250:
        optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose5", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 1000:
        optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose6", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 2500:
        optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose7", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 25000:
        optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose8", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    default:
        optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose8", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    }

    optionsGUI.Add("Text", "", "Greedy starts at Amount")
    If (CardsGreedyOpen = true) {
        optionsGUI.Add("CheckBox", "vCardsGreedyOpen checked",
            "Greedy Open Cards")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsGreedyOpen",
            "Greedy Open Cards")
    }

    If (CardsDontOpenCommons = true) {
        optionsGUI.Add("CheckBox", "vCardsDontOpenCommons checked",
            "Disable Opening Common Cards")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsDontOpenCommons",
            "Disable Opening Common Cards")
    }

    If (CardsDontOpenRare = true) {
        optionsGUI.Add("CheckBox", "vCardsDontOpenRare checked",
            "Disable Opening Rare Cards")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsDontOpenRare",
            "Disable Opening Rare Cards")
    }

    If (CardsDontOpenLegendary = true) {
        optionsGUI.Add("CheckBox", "vCardsDontOpenLegendary checked",
            "Disable Opening Legendary Cards")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsDontOpenLegendary",
            "Disable Opening Legendary Cards")
    }

    optionsGUI.Add("Text", "", "Cards Opening Delay (ms):")
    optionsGUI.AddEdit("cDefault")
    If (IsInteger(CardsSleepAmount) && CardsSleepAmount > 0) {
        optionsGUI.Add("UpDown", "vCardsSleepAmount Range1-9999",
            CardsSleepAmount)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vCardsSleepAmount Range1-9999", Settings.defaultNobodySettings
                .CardsSleepAmount)
        } Else {
            optionsGUI.Add("UpDown", "vCardsSleepAmount Range1-9999", Settings.defaultSettings
                .CardsSleepAmount)
        }
    }

    If (CardsPermaLoop = true) {
        optionsGUI.Add("CheckBox", "vCardsPermaLoop checked",
            "Enable Looping")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsPermaLoop", "Enable Looping")
    }

    If (CardsBossFarmEnabled = true) {
        optionsGUI.Add("CheckBox", "vCardsBossFarmEnabled checked",
            "Enable Boss Farm")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsBossFarmEnabled",
            "Enable Boss Farm")
    }

    optionsGUI.Add("Text", "", "")
    optionsGUI.Add("Text", "", "Cards Purchasing Options:")

    If (CardsBuyEnabled = true) {
        optionsGUI.Add("CheckBox", "vCardsBuyEnabled checked",
            "Enable Card Purchasing")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsBuyEnabled",
            "Enable Card Purchasing")
    }

    optionsGUI.Add("Text", "", "Purchase Card Packs Priority Style:")
    Switch CardsBuyStyle {
    Case "RoundRobin":
        optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose1", [
            "RoundRobin",
            "RoundRobin2",
            "FocusLegend",
            "FocusRare",
            "FocusRare2",
            "FocusCommon"
        ])
    Case "RoundRobin2":
        optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose2", [
            "RoundRobin",
            "RoundRobin2",
            "FocusLegend",
            "FocusRare",
            "FocusRare2",
            "FocusCommon"
        ])
    Case "FocusLegend":
        optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose3", [
            "RoundRobin",
            "RoundRobin2",
            "FocusLegend",
            "FocusRare",
            "FocusRare2",
            "FocusCommon"
        ])
    Case "FocusRare":
        optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose4", [
            "RoundRobin",
            "RoundRobin2",
            "FocusLegend",
            "FocusRare",
            "FocusRare2",
            "FocusCommon"
        ])
    Case "FocusRare2":
        optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose5", [
            "RoundRobin",
            "RoundRobin2",
            "FocusLegend",
            "FocusRare",
            "FocusRare2",
            "FocusCommon"
        ])
    Case "FocusCommon":
        optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose6", [
            "RoundRobin",
            "RoundRobin2",
            "FocusLegend",
            "FocusRare",
            "FocusRare2",
            "FocusCommon"
        ])
    default:
        optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose3", [
            "RoundRobin",
            "RoundRobin2",
            "FocusLegend",
            "FocusRare",
            "FocusRare2",
            "FocusCommon"
        ])
    }

    optionsGUI.Add("Text", "", "Purchase Common Card Packs Amount:")
    Switch CardsCommonBuyAmount {
    Case 1:
        optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose1", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 10:
        optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose2", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 25:
        optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose3", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 100:
        optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose4", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 250:
        optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose5", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 1000:
        optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose6", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 2500:
        optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose7", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 25000:
        optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose8", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    default:
        optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose8", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    }

    optionsGUI.Add("Text", "", "Purchase Rare Card Packs Amount:")
    Switch CardsRareBuyAmount {
    Case 1:
        optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose1", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 10:
        optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose2", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 25:
        optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose3", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 100:
        optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose4", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 250:
        optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose5", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 1000:
        optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose6", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 2500:
        optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose7", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 25000:
        optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose8", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    default:
        optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose8", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    }

    optionsGUI.Add("Text", "", "Purchase Legendary Card Packs Amount:")
    Switch CardsLegBuyAmount {
    Case 1:
        optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose1", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 10:
        optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose2", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 25:
        optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose3", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 100:
        optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose4", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 250:
        optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose5", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 1000:
        optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose6", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 2500:
        optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose7", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 25000:
        optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose8", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    default:
        optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose8", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    }

    optionsGUI.Add("Text", "", "Greedy starts at Amount")
    If (CardsGreedyBuy = true) {
        optionsGUI.Add("CheckBox", "vCardsGreedyBuy checked",
            "Greedy Buy Cards")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsGreedyBuy",
            "Greedy Buy Cards")
    }

    If (CardsDontBuyCommons = true) {
        optionsGUI.Add("CheckBox", "vCardsDontBuyCommons checked",
            "Disable Common Card Purchasing")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsDontBuyCommons",
            "Disable Common Card Purchasing")
    }

    If (CardsDontBuyRare = true) {
        optionsGUI.Add("CheckBox", "vCardsDontBuyRare checked",
            "Disable Rare Card Purchasing")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsDontBuyRare",
            "Disable Rare Card Purchasing")
    }

    If (CardsDontBuyLeg = true) {
        optionsGUI.Add("CheckBox", "vCardsDontBuyLeg checked",
            "Disable Legendary Card Purchasing")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsDontBuyLeg",
            "Disable Legendary Card Purchasing")
    }

    optionsGUI.Add("Text", "", "Cards Purchasing Delay (ms):")
    optionsGUI.AddEdit("cDefault")
    If (IsInteger(CardsSleepBuyAmount) && CardsSleepBuyAmount > 0) {
        optionsGUI.Add("UpDown", "vCardsSleepBuyAmount Range1-9999",
            CardsSleepBuyAmount)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vCardsSleepBuyAmount Range1-9999",
                Settings.defaultNobodySettings.CardsSleepBuyAmount)
        } Else {
            optionsGUI.Add("UpDown", "vCardsSleepBuyAmount Range1-9999",
                Settings.defaultSettings.CardsSleepBuyAmount)
        }
    }

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Run").OnEvent("Click", RunCards)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveCards)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessCardsSettings)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseCardsSettings)

    ShowGUIPosition(optionsGUI)
    optionsGUI.OnEvent("Size", SaveGUIPositionOnResize)
    OnMessage(0x0003, SaveGUIPositionOnMove)

    ProcessCardsSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        optionsGUI.Hide()
        Temp.Hide()
        Saving.Show()
        CardsSave()
        Saving.Hide()
        Temp.Show()
        optionsGUI.Show()
    }

    RunCards(*) {
        optionsGUI.Hide()
        Window.Activate()
        fCardsStart()
    }

    RunSaveCards(*) {
        CardsSave()
        optionsGUI.Hide()
        Window.Activate()
        fCardsStart()
    }

    CloseCardsSettings(*) {
        optionsGUI.Hide()
    }

    CardsSave() {
        values := optionsGUI.Submit()
        CardsCommonAmount := values.CardsCommonAmount
        CardsRareAmount := values.CardsRareAmount
        CardsLegendaryAmount := values.CardsLegendaryAmount
        CardsDontOpenCommons := values.CardsDontOpenCommons
        CardsDontOpenRare := values.CardsDontOpenRare
        CardsDontOpenLegendary := values.CardsDontOpenLegendary
        CardsSleepAmount := values.CardsSleepAmount
        CardsPermaLoop := values.CardsPermaLoop
        CardsBossFarmEnabled := values.CardsBossFarmEnabled
        CardsBuyEnabled := values.CardsBuyEnabled
        CardsBuyStyle := values.CardsBuyStyle
        CardsCommonBuyAmount := values.CardsCommonBuyAmount
        CardsRareBuyAmount := values.CardsRareBuyAmount
        CardsLegBuyAmount := values.CardsLegBuyAmount
        CardsDontBuyCommons := values.CardsDontBuyCommons
        CardsDontBuyRare := values.CardsDontBuyRare
        CardsDontBuyLeg := values.CardsDontBuyLeg
        CardsSleepBuyAmount := values.CardsSleepBuyAmount
        CardsGreedyOpen := values.CardsGreedyOpen
        CardsGreedyBuy := values.CardsGreedyBuy

        Settings.SaveCurrentSettings()
    }
}
