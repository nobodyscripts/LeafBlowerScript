#Requires AutoHotkey v2.0

Button_Click_Cards(thisGui, info) {
    Global Settings, CardsCommonAmount, CardsRareAmount, CardsLegendaryAmount,
        CardsDontOpenCommons, CardsDontOpenRare, CardsDontOpenLegendary,
        CardsSleepAmount, CardsPermaLoop, CardsBossFarmEnabled, CardsBuyEnabled,
        CardsBuyStyle, CardsCommonBuyAmount, CardsRareBuyAmount,
        CardsLegBuyAmount, CardsDontBuyCommons, CardsDontBuyRare,
        CardsDontBuyLeg, CardsSleepBuyAmount, CardsGreedyOpen, CardsGreedyBuy

    optionsGUI := Gui(, "Mine Maintainer Settings")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"
    optionsGUI.Add("Text", "ccfcfcf", "Cards Opening Options:")
    optionsGUI.Add("Text", "ccfcfcf", "Open Common Card Packs Amount:")
    Switch CardsCommonAmount {
        Case 1:
            optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose1", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 10:
            optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose2", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 25:
            optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose3", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 100:
            optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose4", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 250:
            optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose5", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 1000:
            optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose6", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 2500:
            optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose7", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 25000:
            optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose8", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        default:
            optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose8", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
    }

    optionsGUI.Add("Text", "ccfcfcf", "Open Rare Card Packs Amount:")
    Switch CardsRareAmount {
        Case 1:
            optionsGUI.Add("DropDownList", "vCardsRareAmount Choose1", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 10:
            optionsGUI.Add("DropDownList", "vCardsRareAmount Choose2", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 25:
            optionsGUI.Add("DropDownList", "vCardsRareAmount Choose3", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 100:
            optionsGUI.Add("DropDownList", "vCardsRareAmount Choose4", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 250:
            optionsGUI.Add("DropDownList", "vCardsRareAmount Choose5", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 1000:
            optionsGUI.Add("DropDownList", "vCardsRareAmount Choose6", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 2500:
            optionsGUI.Add("DropDownList", "vCardsRareAmount Choose7", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 25000:
            optionsGUI.Add("DropDownList", "vCardsRareAmount Choose8", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        default:
            optionsGUI.Add("DropDownList", "vCardsRareAmount Choose8", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
    }

    optionsGUI.Add("Text", "ccfcfcf", "Open Legendary Card Packs Amount:")
    Switch CardsLegendaryAmount {
        Case 1:
            optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose1", [
                "1", "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 10:
            optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose2", [
                "1", "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 25:
            optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose3", [
                "1", "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 100:
            optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose4", [
                "1", "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 250:
            optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose5", [
                "1", "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 1000:
            optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose6", [
                "1", "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 2500:
            optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose7", [
                "1", "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 25000:
            optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose8", [
                "1", "10", "25", "100", "250", "1000", "2500", "25000"])
        default:
            optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose8", [
                "1", "10", "25", "100", "250", "1000", "2500", "25000"])
    }

    optionsGUI.Add("Text", "ccfcfcf", "Greedy starts at Amount")
    If (CardsGreedyOpen = true) {
        optionsGUI.Add("CheckBox", "vCardsGreedyOpen ccfcfcf checked",
            "Greedy Open Cards")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsGreedyOpen ccfcfcf",
            "Greedy Open Cards")
    }

    If (CardsDontOpenCommons = true) {
        optionsGUI.Add("CheckBox", "vCardsDontOpenCommons ccfcfcf checked",
            "Disable Opening Common Cards")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsDontOpenCommons ccfcfcf",
            "Disable Opening Common Cards")
    }

    If (CardsDontOpenRare = true) {
        optionsGUI.Add("CheckBox", "vCardsDontOpenRare ccfcfcf checked",
            "Disable Opening Rare Cards")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsDontOpenRare ccfcfcf",
            "Disable Opening Rare Cards")
    }

    If (CardsDontOpenLegendary = true) {
        optionsGUI.Add("CheckBox", "vCardsDontOpenLegendary ccfcfcf checked",
            "Disable Opening Legendary Cards")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsDontOpenLegendary ccfcfcf",
            "Disable Opening Legendary Cards")
    }

    optionsGUI.Add("Text", "ccfcfcf", "Cards Opening Delay (ms):")
    optionsGUI.AddEdit()
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
        optionsGUI.Add("CheckBox", "vCardsPermaLoop ccfcfcf checked",
            "Enable Looping")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsPermaLoop ccfcfcf", "Enable Looping")
    }

    If (CardsBossFarmEnabled = true) {
        optionsGUI.Add("CheckBox", "vCardsBossFarmEnabled ccfcfcf checked",
            "Enable Boss Farm")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsBossFarmEnabled ccfcfcf",
            "Enable Boss Farm")
    }

    optionsGUI.Add("Text", "ccfcfcf", "")
    optionsGUI.Add("Text", "ccfcfcf", "Cards Purchasing Options:")

    If (CardsBuyEnabled = true) {
        optionsGUI.Add("CheckBox", "vCardsBuyEnabled ccfcfcf checked",
            "Enable Card Purchasing")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsBuyEnabled ccfcfcf",
            "Enable Card Purchasing")
    }

    optionsGUI.Add("Text", "ccfcfcf", "Purchase Card Packs Priority Style:")
    Switch CardsBuyStyle {
        Case "RoundRobin":
            optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose1", [
                "RoundRobin", "RoundRobin2", "FocusLegend", "FocusRare",
                "FocusRare2", "FocusCommon"])
        Case "RoundRobin2":
            optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose2", [
                "RoundRobin", "RoundRobin2", "FocusLegend", "FocusRare",
                "FocusRare2", "FocusCommon"])
        Case "FocusLegend":
            optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose3", [
                "RoundRobin", "RoundRobin2", "FocusLegend", "FocusRare",
                "FocusRare2", "FocusCommon"])
        Case "FocusRare":
            optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose4", [
                "RoundRobin", "RoundRobin2", "FocusLegend", "FocusRare",
                "FocusRare2", "FocusCommon"])
        Case "FocusRare2":
            optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose5", [
                "RoundRobin", "RoundRobin2", "FocusLegend", "FocusRare",
                "FocusRare2", "FocusCommon"])
        Case "FocusCommon":
            optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose6", [
                "RoundRobin", "RoundRobin2", "FocusLegend", "FocusRare",
                "FocusRare2", "FocusCommon"])
        default:
            optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose3", [
                "RoundRobin", "RoundRobin2", "FocusLegend", "FocusRare",
                "FocusRare2", "FocusCommon"])
    }

    optionsGUI.Add("Text", "ccfcfcf", "Purchase Common Card Packs Amount:")
    Switch CardsCommonBuyAmount {
        Case 1:
            optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose1", [
                "1", "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 10:
            optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose2", [
                "1", "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 25:
            optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose3", [
                "1", "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 100:
            optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose4", [
                "1", "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 250:
            optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose5", [
                "1", "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 1000:
            optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose6", [
                "1", "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 2500:
            optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose7", [
                "1", "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 25000:
            optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose8", [
                "1", "10", "25", "100", "250", "1000", "2500", "25000"])
        default:
            optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose8", [
                "1", "10", "25", "100", "250", "1000", "2500", "25000"])
    }

    optionsGUI.Add("Text", "ccfcfcf", "Purchase Rare Card Packs Amount:")
    Switch CardsRareBuyAmount {
        Case 1:
            optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose1", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 10:
            optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose2", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 25:
            optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose3", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 100:
            optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose4", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 250:
            optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose5", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 1000:
            optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose6", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 2500:
            optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose7", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 25000:
            optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose8", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        default:
            optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose8", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
    }

    optionsGUI.Add("Text", "ccfcfcf", "Purchase Legendary Card Packs Amount:")
    Switch CardsLegBuyAmount {
        Case 1:
            optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose1", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 10:
            optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose2", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 25:
            optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose3", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 100:
            optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose4", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 250:
            optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose5", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 1000:
            optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose6", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 2500:
            optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose7", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 25000:
            optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose8", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        default:
            optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose8", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
    }

    optionsGUI.Add("Text", "ccfcfcf", "Greedy starts at Amount")
    If (CardsGreedyBuy = true) {
        optionsGUI.Add("CheckBox", "vCardsGreedyBuy ccfcfcf checked",
            "Greedy Buy Cards")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsGreedyBuy ccfcfcf",
            "Greedy Buy Cards")
    }

    If (CardsDontBuyCommons = true) {
        optionsGUI.Add("CheckBox", "vCardsDontBuyCommons ccfcfcf checked",
            "Disable Common Card Purchasing")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsDontBuyCommons ccfcfcf",
            "Disable Common Card Purchasing")
    }

    If (CardsDontBuyRare = true) {
        optionsGUI.Add("CheckBox", "vCardsDontBuyRare ccfcfcf checked",
            "Disable Rare Card Purchasing")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsDontBuyRare ccfcfcf",
            "Disable Rare Card Purchasing")
    }

    If (CardsDontBuyLeg = true) {
        optionsGUI.Add("CheckBox", "vCardsDontBuyLeg ccfcfcf checked",
            "Disable Legendary Card Purchasing")
    } Else {
        optionsGUI.Add("CheckBox", "vCardsDontBuyLeg ccfcfcf",
            "Disable Legendary Card Purchasing")
    }

    optionsGUI.Add("Text", "ccfcfcf", "Cards Purchasing Delay (ms):")
    optionsGUI.AddEdit()
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


    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunCards)
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click",
        RunSaveCards)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click",
        ProcessCardsSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseCardsSettings)

    optionsGUI.Show("w300")

    ProcessCardsSettings(*) {
        CardsSave()
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