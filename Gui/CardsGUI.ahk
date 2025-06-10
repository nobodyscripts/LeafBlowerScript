#Requires AutoHotkey v2.0

Button_Click_Cards(thisGui, info) {
    CardsCommonAmount := S.Get("CardsCommonAmount")
    CardsRareAmount := S.Get("CardsRareAmount")
    CardsLegendaryAmount := S.Get("CardsLegendaryAmount")
    CardsDontOpenCommons := S.Get("CardsDontOpenCommons")
    CardsDontOpenRare := S.Get("CardsDontOpenRare")
    CardsDontOpenLegendary := S.Get("CardsDontOpenLegendary")
    CardsSleepAmount := S.Get("CardsSleepAmount")
    CardsPermaLoop := S.Get("CardsPermaLoop")
    CardsBossFarmEnabled := S.Get("CardsBossFarmEnabled")
    CardsBuyEnabled := S.Get("CardsBuyEnabled")
    CardsBuyStyle := S.Get("CardsBuyStyle")
    CardsCommonBuyAmount := S.Get("CardsCommonBuyAmount")
    CardsRareBuyAmount := S.Get("CardsRareBuyAmount")
    CardsLegBuyAmount := S.Get("CardsLegBuyAmount")
    CardsDontBuyCommons := S.Get("CardsDontBuyCommons")
    CardsDontBuyRare := S.Get("CardsDontBuyRare")
    CardsDontBuyLeg := S.Get("CardsDontBuyLeg")
    CardsSleepBuyAmount := S.Get("CardsSleepBuyAmount")
    CardsGreedyOpen := S.Get("CardsGreedyOpen")
    CardsGreedyBuy := S.Get("CardsGreedyBuy")

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "Mine Maintainer Settings")
    MyGui.SetUserFontSettings()

    MyGui.Add("Text", "", "Cards Opening Options:")
    MyGui.Add("Text", "", "Open Common Card Packs Amount:")
    Switch CardsCommonAmount {
    Case 1:
        MyGui.Add("DropDownList", "vCardsCommonAmount Choose1", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 10:
        MyGui.Add("DropDownList", "vCardsCommonAmount Choose2", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 25:
        MyGui.Add("DropDownList", "vCardsCommonAmount Choose3", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 100:
        MyGui.Add("DropDownList", "vCardsCommonAmount Choose4", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 250:
        MyGui.Add("DropDownList", "vCardsCommonAmount Choose5", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 1000:
        MyGui.Add("DropDownList", "vCardsCommonAmount Choose6", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 2500:
        MyGui.Add("DropDownList", "vCardsCommonAmount Choose7", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 25000:
        MyGui.Add("DropDownList", "vCardsCommonAmount Choose8", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    default:
        MyGui.Add("DropDownList", "vCardsCommonAmount Choose8", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    }

    MyGui.Add("Text", "", "Open Rare Card Packs Amount:")
    Switch CardsRareAmount {
    Case 1:
        MyGui.Add("DropDownList", "vCardsRareAmount Choose1", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 10:
        MyGui.Add("DropDownList", "vCardsRareAmount Choose2", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 25:
        MyGui.Add("DropDownList", "vCardsRareAmount Choose3", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 100:
        MyGui.Add("DropDownList", "vCardsRareAmount Choose4", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 250:
        MyGui.Add("DropDownList", "vCardsRareAmount Choose5", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 1000:
        MyGui.Add("DropDownList", "vCardsRareAmount Choose6", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 2500:
        MyGui.Add("DropDownList", "vCardsRareAmount Choose7", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 25000:
        MyGui.Add("DropDownList", "vCardsRareAmount Choose8", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    default:
        MyGui.Add("DropDownList", "vCardsRareAmount Choose8", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    }

    MyGui.Add("Text", "", "Open Legendary Card Packs Amount:")
    Switch CardsLegendaryAmount {
    Case 1:
        MyGui.Add("DropDownList", "vCardsLegendaryAmount Choose1", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 10:
        MyGui.Add("DropDownList", "vCardsLegendaryAmount Choose2", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 25:
        MyGui.Add("DropDownList", "vCardsLegendaryAmount Choose3", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 100:
        MyGui.Add("DropDownList", "vCardsLegendaryAmount Choose4", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 250:
        MyGui.Add("DropDownList", "vCardsLegendaryAmount Choose5", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 1000:
        MyGui.Add("DropDownList", "vCardsLegendaryAmount Choose6", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 2500:
        MyGui.Add("DropDownList", "vCardsLegendaryAmount Choose7", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 25000:
        MyGui.Add("DropDownList", "vCardsLegendaryAmount Choose8", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    default:
        MyGui.Add("DropDownList", "vCardsLegendaryAmount Choose8", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    }

    MyGui.Add("Text", "", "Greedy starts at Amount")
    If (CardsGreedyOpen = true) {
        MyGui.Add("CheckBox", "vCardsGreedyOpen checked",
            "Greedy Open Cards")
    } Else {
        MyGui.Add("CheckBox", "vCardsGreedyOpen",
            "Greedy Open Cards")
    }

    If (CardsDontOpenCommons = true) {
        MyGui.Add("CheckBox", "vCardsDontOpenCommons checked",
            "Disable Opening Common Cards")
    } Else {
        MyGui.Add("CheckBox", "vCardsDontOpenCommons",
            "Disable Opening Common Cards")
    }

    If (CardsDontOpenRare = true) {
        MyGui.Add("CheckBox", "vCardsDontOpenRare checked",
            "Disable Opening Rare Cards")
    } Else {
        MyGui.Add("CheckBox", "vCardsDontOpenRare",
            "Disable Opening Rare Cards")
    }

    If (CardsDontOpenLegendary = true) {
        MyGui.Add("CheckBox", "vCardsDontOpenLegendary checked",
            "Disable Opening Legendary Cards")
    } Else {
        MyGui.Add("CheckBox", "vCardsDontOpenLegendary",
            "Disable Opening Legendary Cards")
    }

    MyGui.Add("Text", "", "Cards Opening Delay (ms):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(CardsSleepAmount) && CardsSleepAmount > 0) {
        MyGui.Add("UpDown", "vCardsSleepAmount Range1-9999",
            CardsSleepAmount)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vCardsSleepAmount Range1-9999", S.defaultNobodySettings
                .CardsSleepAmount)
        } Else {
            MyGui.Add("UpDown", "vCardsSleepAmount Range1-9999", S.defaultSettings
                .CardsSleepAmount)
        }
    }

    If (CardsPermaLoop = true) {
        MyGui.Add("CheckBox", "vCardsPermaLoop checked",
            "Enable Looping")
    } Else {
        MyGui.Add("CheckBox", "vCardsPermaLoop", "Enable Looping")
    }

    If (CardsBossFarmEnabled = true) {
        MyGui.Add("CheckBox", "vCardsBossFarmEnabled checked",
            "Enable Boss Farm")
    } Else {
        MyGui.Add("CheckBox", "vCardsBossFarmEnabled",
            "Enable Boss Farm")
    }

    MyGui.Add("Text", "", "")
    MyGui.Add("Text", "", "Cards Purchasing Options:")

    If (CardsBuyEnabled = true) {
        MyGui.Add("CheckBox", "vCardsBuyEnabled checked",
            "Enable Card Purchasing")
    } Else {
        MyGui.Add("CheckBox", "vCardsBuyEnabled",
            "Enable Card Purchasing")
    }

    MyGui.Add("Text", "", "Purchase Card Packs Priority Style:")
    Switch CardsBuyStyle {
    Case "RoundRobin":
        MyGui.Add("DropDownList", "vCardsBuyStyle Choose1", [
            "RoundRobin",
            "RoundRobin2",
            "FocusLegend",
            "FocusRare",
            "FocusRare2",
            "FocusCommon"
        ])
    Case "RoundRobin2":
        MyGui.Add("DropDownList", "vCardsBuyStyle Choose2", [
            "RoundRobin",
            "RoundRobin2",
            "FocusLegend",
            "FocusRare",
            "FocusRare2",
            "FocusCommon"
        ])
    Case "FocusLegend":
        MyGui.Add("DropDownList", "vCardsBuyStyle Choose3", [
            "RoundRobin",
            "RoundRobin2",
            "FocusLegend",
            "FocusRare",
            "FocusRare2",
            "FocusCommon"
        ])
    Case "FocusRare":
        MyGui.Add("DropDownList", "vCardsBuyStyle Choose4", [
            "RoundRobin",
            "RoundRobin2",
            "FocusLegend",
            "FocusRare",
            "FocusRare2",
            "FocusCommon"
        ])
    Case "FocusRare2":
        MyGui.Add("DropDownList", "vCardsBuyStyle Choose5", [
            "RoundRobin",
            "RoundRobin2",
            "FocusLegend",
            "FocusRare",
            "FocusRare2",
            "FocusCommon"
        ])
    Case "FocusCommon":
        MyGui.Add("DropDownList", "vCardsBuyStyle Choose6", [
            "RoundRobin",
            "RoundRobin2",
            "FocusLegend",
            "FocusRare",
            "FocusRare2",
            "FocusCommon"
        ])
    default:
        MyGui.Add("DropDownList", "vCardsBuyStyle Choose3", [
            "RoundRobin",
            "RoundRobin2",
            "FocusLegend",
            "FocusRare",
            "FocusRare2",
            "FocusCommon"
        ])
    }

    MyGui.Add("Text", "", "Purchase Common Card Packs Amount:")
    Switch CardsCommonBuyAmount {
    Case 1:
        MyGui.Add("DropDownList", "vCardsCommonBuyAmount Choose1", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 10:
        MyGui.Add("DropDownList", "vCardsCommonBuyAmount Choose2", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 25:
        MyGui.Add("DropDownList", "vCardsCommonBuyAmount Choose3", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 100:
        MyGui.Add("DropDownList", "vCardsCommonBuyAmount Choose4", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 250:
        MyGui.Add("DropDownList", "vCardsCommonBuyAmount Choose5", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 1000:
        MyGui.Add("DropDownList", "vCardsCommonBuyAmount Choose6", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 2500:
        MyGui.Add("DropDownList", "vCardsCommonBuyAmount Choose7", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 25000:
        MyGui.Add("DropDownList", "vCardsCommonBuyAmount Choose8", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    default:
        MyGui.Add("DropDownList", "vCardsCommonBuyAmount Choose8", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    }

    MyGui.Add("Text", "", "Purchase Rare Card Packs Amount:")
    Switch CardsRareBuyAmount {
    Case 1:
        MyGui.Add("DropDownList", "vCardsRareBuyAmount Choose1", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 10:
        MyGui.Add("DropDownList", "vCardsRareBuyAmount Choose2", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 25:
        MyGui.Add("DropDownList", "vCardsRareBuyAmount Choose3", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 100:
        MyGui.Add("DropDownList", "vCardsRareBuyAmount Choose4", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 250:
        MyGui.Add("DropDownList", "vCardsRareBuyAmount Choose5", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 1000:
        MyGui.Add("DropDownList", "vCardsRareBuyAmount Choose6", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 2500:
        MyGui.Add("DropDownList", "vCardsRareBuyAmount Choose7", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 25000:
        MyGui.Add("DropDownList", "vCardsRareBuyAmount Choose8", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    default:
        MyGui.Add("DropDownList", "vCardsRareBuyAmount Choose8", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    }

    MyGui.Add("Text", "", "Purchase Legendary Card Packs Amount:")
    Switch CardsLegBuyAmount {
    Case 1:
        MyGui.Add("DropDownList", "vCardsLegBuyAmount Choose1", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 10:
        MyGui.Add("DropDownList", "vCardsLegBuyAmount Choose2", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 25:
        MyGui.Add("DropDownList", "vCardsLegBuyAmount Choose3", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 100:
        MyGui.Add("DropDownList", "vCardsLegBuyAmount Choose4", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 250:
        MyGui.Add("DropDownList", "vCardsLegBuyAmount Choose5", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 1000:
        MyGui.Add("DropDownList", "vCardsLegBuyAmount Choose6", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 2500:
        MyGui.Add("DropDownList", "vCardsLegBuyAmount Choose7", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 25000:
        MyGui.Add("DropDownList", "vCardsLegBuyAmount Choose8", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    default:
        MyGui.Add("DropDownList", "vCardsLegBuyAmount Choose8", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    }

    MyGui.Add("Text", "", "Greedy starts at Amount")
    If (CardsGreedyBuy = true) {
        MyGui.Add("CheckBox", "vCardsGreedyBuy checked",
            "Greedy Buy Cards")
    } Else {
        MyGui.Add("CheckBox", "vCardsGreedyBuy",
            "Greedy Buy Cards")
    }

    If (CardsDontBuyCommons = true) {
        MyGui.Add("CheckBox", "vCardsDontBuyCommons checked",
            "Disable Common Card Purchasing")
    } Else {
        MyGui.Add("CheckBox", "vCardsDontBuyCommons",
            "Disable Common Card Purchasing")
    }

    If (CardsDontBuyRare = true) {
        MyGui.Add("CheckBox", "vCardsDontBuyRare checked",
            "Disable Rare Card Purchasing")
    } Else {
        MyGui.Add("CheckBox", "vCardsDontBuyRare",
            "Disable Rare Card Purchasing")
    }

    If (CardsDontBuyLeg = true) {
        MyGui.Add("CheckBox", "vCardsDontBuyLeg checked",
            "Disable Legendary Card Purchasing")
    } Else {
        MyGui.Add("CheckBox", "vCardsDontBuyLeg",
            "Disable Legendary Card Purchasing")
    }

    MyGui.Add("Text", "", "Cards Purchasing Delay (ms):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(CardsSleepBuyAmount) && CardsSleepBuyAmount > 0) {
        MyGui.Add("UpDown", "vCardsSleepBuyAmount Range1-9999",
            CardsSleepBuyAmount)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vCardsSleepBuyAmount Range1-9999",
                S.defaultNobodySettings.CardsSleepBuyAmount)
        } Else {
            MyGui.Add("UpDown", "vCardsSleepBuyAmount Range1-9999",
                S.defaultSettings.CardsSleepBuyAmount)
        }
    }

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Run").OnEvent("Click", RunCards)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveCards)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessCardsSettings)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseCardsSettings)

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ProcessCardsSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()
        CardsSave()
        Saving.Hide()
        Temp.Show()
        MyGui.Show()
    }

    RunCards(*) {
        MyGui.Hide()
        fCardsStart()
    }

    RunSaveCards(*) {
        CardsSave()
        MyGui.Hide()
        fCardsStart()
    }

    CloseCardsSettings(*) {
        MyGui.Hide()
    }

    CardsSave() {
        values := MyGui.Submit()
        S.Set("CardsCommonAmount", values.CardsCommonAmount)
        S.Set("CardsRareAmount", values.CardsRareAmount)
        S.Set("CardsLegendaryAmount", values.CardsLegendaryAmount)
        S.Set("CardsDontOpenCommons", values.CardsDontOpenCommons)
        S.Set("CardsDontOpenRare", values.CardsDontOpenRare)
        S.Set("CardsDontOpenLegendary", values.CardsDontOpenLegendary)
        S.Set("CardsSleepAmount", values.CardsSleepAmount)
        S.Set("CardsPermaLoop", values.CardsPermaLoop)
        S.Set("CardsBossFarmEnabled", values.CardsBossFarmEnabled)
        S.Set("CardsBuyEnabled", values.CardsBuyEnabled)
        S.Set("CardsBuyStyle", values.CardsBuyStyle)
        S.Set("CardsCommonBuyAmount", values.CardsCommonBuyAmount)
        S.Set("CardsRareBuyAmount", values.CardsRareBuyAmount)
        S.Set("CardsLegBuyAmount", values.CardsLegBuyAmount)
        S.Set("CardsDontBuyCommons", values.CardsDontBuyCommons)
        S.Set("CardsDontBuyRare", values.CardsDontBuyRare)
        S.Set("CardsDontBuyLeg", values.CardsDontBuyLeg)
        S.Set("CardsSleepBuyAmount", values.CardsSleepBuyAmount)
        S.Set("CardsGreedyOpen", values.CardsGreedyOpen)
        S.Set("CardsGreedyBuy", values.CardsGreedyBuy)

        S.SaveCurrentSettings()
    }
}
