#Requires AutoHotkey v2.0
/*
[Cards]
CardsCommonAmount=25000
CardsRareAmount=25000
CardsLegendaryAmount=25000
CardsDontOpenCommons=false
CardsDontOpenRare=false
CardsDontOpenLegendary=false
CardsSleepAmount=875
CardsPermaLoop=true

CardsBossFarmEnabled=true
[CardsBuy]
CardsBuyEnabled=true
CardsBuyStyle=FocusLegend
CardsCommonBuyAmount=25000
CardsRareBuyAmount=25000
CardsLegBuyAmount=25000
CardsDontBuyCommons=false
CardsDontBuyRare=false
CardsDontBuyLeg=false
CardsSleepBuyAmount=17 */


Button_Click_Cards(thisGui, info) {
    global Settings, CardsCommonAmount, CardsRareAmount,
        CardsLegendaryAmount, CardsDontOpenCommons, CardsDontOpenRare,
        CardsDontOpenLegendary, CardsSleepAmount, CardsPermaLoop,
        CardsBossFarmEnabled, CardsBuyEnabled, CardsBuyStyle,
        CardsCommonBuyAmount, CardsRareBuyAmount, CardsLegBuyAmount,
        CardsDontBuyCommons, CardsDontBuyRare, CardsDontBuyLeg,
        CardsSleepBuyAmount

    optionsGUI := Gui(, "Mine Maintainer Settings")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"
    optionsGUI.Add("Text", "ccfcfcf", "Cards Opening Options:")
    optionsGUI.Add("Text", "ccfcfcf", "Open Common Card Packs Amount:")
    switch CardsCommonAmount {
        case 1:
            optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose1", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 10:
            optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose2", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 25:
            optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose3", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 100:
            optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose4", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 250:
            optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose5", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 1000:
            optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose6", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 2500:
            optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose7", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 25000:
            optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose8", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        default:
            optionsGUI.Add("DropDownList", "vCardsCommonAmount Choose8", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
    }

    optionsGUI.Add("Text", "ccfcfcf", "Open Rare Card Packs Amount:")
    switch CardsRareAmount {
        case 1:
            optionsGUI.Add("DropDownList", "vCardsRareAmount Choose1", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 10:
            optionsGUI.Add("DropDownList", "vCardsRareAmount Choose2", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 25:
            optionsGUI.Add("DropDownList", "vCardsRareAmount Choose3", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 100:
            optionsGUI.Add("DropDownList", "vCardsRareAmount Choose4", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 250:
            optionsGUI.Add("DropDownList", "vCardsRareAmount Choose5", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 1000:
            optionsGUI.Add("DropDownList", "vCardsRareAmount Choose6", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 2500:
            optionsGUI.Add("DropDownList", "vCardsRareAmount Choose7", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 25000:
            optionsGUI.Add("DropDownList", "vCardsRareAmount Choose8", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        default:
            optionsGUI.Add("DropDownList", "vCardsRareAmount Choose8", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
    }

    optionsGUI.Add("Text", "ccfcfcf", "Open Legendary Card Packs Amount:")
    switch CardsLegendaryAmount {
        case 1:
            optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose1", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 10:
            optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose2", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 25:
            optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose3", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 100:
            optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose4", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 250:
            optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose5", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 1000:
            optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose6", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 2500:
            optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose7", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 25000:
            optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose8", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        default:
            optionsGUI.Add("DropDownList", "vCardsLegendaryAmount Choose8", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
    }

    if (CardsDontOpenCommons = true) {
        optionsGUI.Add("CheckBox", "vCardsDontOpenCommons ccfcfcf checked", "Disable Opening Common Cards")
    } else {
        optionsGUI.Add("CheckBox", "vCardsDontOpenCommons ccfcfcf", "Disable Opening Common Cards")
    }

    if (CardsDontOpenRare = true) {
        optionsGUI.Add("CheckBox", "vCardsDontOpenRare ccfcfcf checked", "Disable Opening Rare Cards")
    } else {
        optionsGUI.Add("CheckBox", "vCardsDontOpenRare ccfcfcf", "Disable Opening Rare Cards")
    }

    if (CardsDontOpenLegendary = true) {
        optionsGUI.Add("CheckBox", "vCardsDontOpenLegendary ccfcfcf checked", "Disable Opening Legendary Cards")
    } else {
        optionsGUI.Add("CheckBox", "vCardsDontOpenLegendary ccfcfcf", "Disable Opening Legendary Cards")
    }

    optionsGUI.Add("Text", "ccfcfcf", "Cards Opening Delay (ms):")
    optionsGUI.AddEdit()
    If (IsInteger(CardsSleepAmount) && CardsSleepAmount > 0) {
        optionsGUI.Add("UpDown", "vCardsSleepAmount Range1-9999",
            CardsSleepAmount)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vCardsSleepAmount Range1-9999",
                settings.defaultNobodySettings.CardsSleepAmount)
        } else {
            optionsGUI.Add("UpDown", "vCardsSleepAmount Range1-9999",
                settings.defaultSettings.CardsSleepAmount)
        }
    }

    if (CardsPermaLoop = true) {
        optionsGUI.Add("CheckBox", "vCardsPermaLoop ccfcfcf checked", "Enable Looping")
    } else {
        optionsGUI.Add("CheckBox", "vCardsPermaLoop ccfcfcf", "Enable Looping")
    }

    if (CardsBossFarmEnabled = true) {
        optionsGUI.Add("CheckBox", "vCardsBossFarmEnabled ccfcfcf checked", "Enable Boss Farm")
    } else {
        optionsGUI.Add("CheckBox", "vCardsBossFarmEnabled ccfcfcf", "Enable Boss Farm")
    }

    optionsGUI.Add("Text", "ccfcfcf", "")
    optionsGUI.Add("Text", "ccfcfcf", "Cards Purchasing Options:")

    if (CardsBuyEnabled = true) {
        optionsGUI.Add("CheckBox", "vCardsBuyEnabled ccfcfcf checked", "Enable Card Purchasing")
    } else {
        optionsGUI.Add("CheckBox", "vCardsBuyEnabled ccfcfcf", "Enable Card Purchasing")
    }

    optionsGUI.Add("Text", "ccfcfcf", "Purchase Card Packs Priority Style:")
    switch CardsBuyStyle {
        case "RoundRobin":
            optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose1", ["RoundRobin", "RoundRobin2", "FocusLegend", "FocusRare", "FocusRare2", "FocusCommon"])
        case "RoundRobin2":
            optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose2", ["RoundRobin", "RoundRobin2", "FocusLegend", "FocusRare", "FocusRare2", "FocusCommon"])
        case "FocusLegend":
            optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose3", ["RoundRobin", "RoundRobin2", "FocusLegend", "FocusRare", "FocusRare2", "FocusCommon"])
        case "FocusRare":
            optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose4", ["RoundRobin", "RoundRobin2", "FocusLegend", "FocusRare", "FocusRare2", "FocusCommon"])
        case "FocusRare2":
            optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose5", ["RoundRobin", "RoundRobin2", "FocusLegend", "FocusRare", "FocusRare2", "FocusCommon"])
        case "FocusCommon":
            optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose6", ["RoundRobin", "RoundRobin2", "FocusLegend", "FocusRare", "FocusRare2", "FocusCommon"])
        default:
            optionsGUI.Add("DropDownList", "vCardsBuyStyle Choose3", ["RoundRobin", "RoundRobin2", "FocusLegend", "FocusRare", "FocusRare2", "FocusCommon"])
    }

    optionsGUI.Add("Text", "ccfcfcf", "Purchase Common Card Packs Amount:")
    switch CardsCommonBuyAmount {
        case 1:
            optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose1", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 10:
            optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose2", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 25:
            optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose3", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 100:
            optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose4", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 250:
            optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose5", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 1000:
            optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose6", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 2500:
            optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose7", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 25000:
            optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose8", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        default:
            optionsGUI.Add("DropDownList", "vCardsCommonBuyAmount Choose8", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
    }

    optionsGUI.Add("Text", "ccfcfcf", "Purchase Rare Card Packs Amount:")
    switch CardsRareBuyAmount {
        case 1:
            optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose1", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 10:
            optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose2", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 25:
            optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose3", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 100:
            optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose4", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 250:
            optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose5", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 1000:
            optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose6", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 2500:
            optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose7", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 25000:
            optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose8", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        default:
            optionsGUI.Add("DropDownList", "vCardsRareBuyAmount Choose8", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
    }

    optionsGUI.Add("Text", "ccfcfcf", "Purchase Legendary Card Packs Amount:")
    switch CardsLegBuyAmount {
        case 1:
            optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose1", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 10:
            optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose2", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 25:
            optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose3", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 100:
            optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose4", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 250:
            optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose5", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 1000:
            optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose6", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 2500:
            optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose7", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        case 25000:
            optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose8", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
        default:
            optionsGUI.Add("DropDownList", "vCardsLegBuyAmount Choose8", ["1", "10", "25", "100", "250", "1000", "2500", "25000"])
    }

    if (CardsDontBuyCommons = true) {
        optionsGUI.Add("CheckBox", "vCardsDontBuyCommons ccfcfcf checked", "Disable Common Card Purchasing")
    } else {
        optionsGUI.Add("CheckBox", "vCardsDontBuyCommons ccfcfcf", "Disable Common Card Purchasing")
    }

    if (CardsDontBuyRare = true) {
        optionsGUI.Add("CheckBox", "vCardsDontBuyRare ccfcfcf checked", "Disable Rare Card Purchasing")
    } else {
        optionsGUI.Add("CheckBox", "vCardsDontBuyRare ccfcfcf", "Disable Rare Card Purchasing")
    }

    if (CardsDontBuyLeg = true) {
        optionsGUI.Add("CheckBox", "vCardsDontBuyLeg ccfcfcf checked", "Disable Legendary Card Purchasing")
    } else {
        optionsGUI.Add("CheckBox", "vCardsDontBuyLeg ccfcfcf", "Disable Legendary Card Purchasing")
    }

    optionsGUI.Add("Text", "ccfcfcf", "Cards Purchasing Delay (ms):")
    optionsGUI.AddEdit()
    If (IsInteger(CardsSleepBuyAmount) && CardsSleepBuyAmount > 0) {
        optionsGUI.Add("UpDown", "vCardsSleepBuyAmount Range1-9999",
            CardsSleepBuyAmount)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vCardsSleepBuyAmount Range1-9999",
                settings.defaultNobodySettings.CardsSleepBuyAmount)
        } else {
            optionsGUI.Add("UpDown", "vCardsSleepBuyAmount Range1-9999",
                settings.defaultSettings.CardsSleepBuyAmount)
        }
    }

    

    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunCards)
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click", RunSaveCards)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click", ProcessCardsSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click", CloseCardsSettings)

    optionsGUI.Show("w300")

    ProcessCardsSettings(*) {
        CardsSave()
    }

    RunCards(*) {
        optionsGUI.Hide()
        WinActivate(LBRWindowTitle)
        fCardsStart()
    }

    RunSaveCards(*) {
        CardsSave()
        optionsGUI.Hide()
        WinActivate(LBRWindowTitle)
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

        settings.SaveCurrentSettings()
    }
}