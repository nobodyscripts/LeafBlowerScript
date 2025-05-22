#Requires AutoHotkey v2.0

#Include ../Modules/QuickULC.ahk

Button_Click_ULC(thisGui, info) {
    Global Settings

    /** @type {GUI} */
    optionsGUI := Gui(, "ULC TEST")
    optionsGUI.Opt("")
    SetFontOptions(optionsGUI)

    /* optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Test")
    .OnEvent("Click", Test)
    
    Test(*) {
        UlcWindow()
        gToolTip.CenterCD("Test tooltip", 5000)
        SetTimer(gToolTip.CenterCDDel.Bind(gToolTip), -2500)
    } */

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Scan and save BV Inventory")
    .OnEvent("Click", ScanBVInventory)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Stage 1`nHome Garden")
    .OnEvent("Click", RunULCStage1)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Get Daily Reward")
    .OnEvent("Click", GetDailyReward)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Go To Leaf Tower")
    .OnEvent("Click", GoToLeafTower)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "BLC Prestige")
    .OnEvent("Click", TriggerBLC)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "MLC Prestige")
    .OnEvent("Click", TriggerMLC)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "MLC Prestige and start converters")
    .OnEvent("Click", TriggerMLCConverters)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "ULC Prestige")
    .OnEvent("Click", TriggerULC)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Use30minTimeWarp")
    .OnEvent("Click", Use30minTimeWarp)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "EquipBlower")
    .OnEvent("Click", EquipBlower)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "EquipMulchSword")
    .OnEvent("Click", EquipMulchSword)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "EquipElectric")
    .OnEvent("Click", EquipElectric)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "EquipSlap")
    .OnEvent("Click", EquipSlap)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "PubTradeForCheese2500")
    .OnEvent("Click", PubTradeForCheese2500)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "PlacePlayerCenter")
    .OnEvent("Click", PlacePlayerCenter)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "PlacePlayerPlasmaLoc")
    .OnEvent("Click", PlacePlayerPlasmaLoc)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Go To Leaf Tower")
    .OnEvent("Click", GoToLeafTower)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Go To Leaf Tower Max Floor")
    .OnEvent("Click", GoToLeafTowerMax)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "MaxMLCShop")
    .OnEvent("Click", Shops.MLC.Max)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "GoToPyramid")
    .OnEvent("Click", GoToPyramid)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "GoToInnerPyramid")
    .OnEvent("Click", GoToInnerPyramid)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "GoToTrade")
    .OnEvent("Click", GoToTrade)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "TradeForPyramid")
    .OnEvent("Click", TradeForPyramid)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "UnlockPyramidFloors")
    .OnEvent("Click", Shops.Pyramid.MaxFloor)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default ys", "Stage2`nAfter Pyramid 100")
    .OnEvent("Click", RunULCStage2)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "BossSweep")
    .OnEvent("Click", BossSweep)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "BuyMulchMax")
    .OnEvent("Click", Shops.Mulch.Max)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "BuyMulchTrade")
    .OnEvent("Click", Shops.Mulch.BuyTrade)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default ys", "Stage3`nBiotite")
    .OnEvent("Click", RunULCStage3)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "MaxCoalShop")
    .OnEvent("Click", Shops.Coal.Max)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "MaxBioShop")
    .OnEvent("Click", Shops.Biotite.Max)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "MaxMalaShop")
    .OnEvent("Click", Shops.Malachite.Max)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "MaxHemaShop")
    .OnEvent("Click", Shops.Hematite.Max)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "MaxPlasmaShop")
    .OnEvent("Click", Shops.Plasma.Max)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "MaxElectricShop")
    .OnEvent("Click", Shops.Electric.Max)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "EnableBanks")
    .OnEvent("Click", EnableBanks)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "GoToWarden")
    .OnEvent("Click", GoToWarden)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "GoToWoW")
    .OnEvent("Click", GoToWoW)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default ys", "Stage4`nPostWow")
    .OnEvent("Click", RunULCStage4)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "MaxBVItems")
    .OnEvent("Click", MaxBVItems)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "MaxBVItemsJustBags")
    .OnEvent("Click", MaxBVItemsJustBags)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Max bv bags looped")
    .OnEvent("Click", MaxBVItemsJustBags641)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "MaxBVItemsJustSocks")
    .OnEvent("Click", MaxBVItemsJustSocks)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "MaxBVItemsJustRings")
    .OnEvent("Click", MaxBVItemsJustRings)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "BuyMaxCardPacks")
    .OnEvent("Click", BuyMaxCardPacks)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "BuyMaxBVPacks")
    .OnEvent("Click", BuyMaxBVPacks)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Max all shops post wow")
    .OnEvent("Click", MaxAllShopsAfterWoW)

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Test: Transmute relic reset loop")
    .OnEvent("Click", RelicTransmute)

    ShowGUIPosition(optionsGUI)
    optionsGUI.OnEvent("Size", SaveGUIPositionOnResize)
    OnMessage(0x0003, SaveGUIPositionOnMove)
}

RelicTransmute(*) {
    Shops.Relics.TransMuteResetLoop()
}
