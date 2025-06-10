#Requires AutoHotkey v2.0

#Include ../Modules/QuickULC.ahk

Button_Click_ULC(thisGui, info) {

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "ULC TEST")
    MyGui.SetUserFontSettings()

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Scan and save BV Inventory")
    .OnEvent("Click", ScanBVInventory)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Stage 1`nHome Garden")
    .OnEvent("Click", RunULCStage1)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Get Daily Reward")
    .OnEvent("Click", GetDailyReward)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Go To Leaf Tower")
    .OnEvent("Click", GoToLeafTower)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "BLC Prestige")
    .OnEvent("Click", TriggerBLC)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "MLC Prestige")
    .OnEvent("Click", TriggerMLC)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "MLC Prestige and start converters")
    .OnEvent("Click", TriggerMLCConverters)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "ULC Prestige")
    .OnEvent("Click", TriggerULC)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Use30minTimeWarp")
    .OnEvent("Click", Use30minTimeWarp)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "EquipBlower")
    .OnEvent("Click", EquipBlower)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "EquipMulchSword")
    .OnEvent("Click", EquipMulchSword)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "EquipElectric")
    .OnEvent("Click", EquipElectric)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "EquipSlap")
    .OnEvent("Click", EquipSlap)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "PubTradeForCheese2500")
    .OnEvent("Click", PubTradeForCheese2500)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "PlacePlayerCenter")
    .OnEvent("Click", PlacePlayerCenter)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "PlacePlayerPlasmaLoc")
    .OnEvent("Click", PlacePlayerPlasmaLoc)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Go To Leaf Tower")
    .OnEvent("Click", GoToLeafTower)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Go To Leaf Tower Max Floor")
    .OnEvent("Click", GoToLeafTowerMax)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "MaxMLCShop")
    .OnEvent("Click", Shops.MLC.Max)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "GoToPyramid")
    .OnEvent("Click", GoToPyramid)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "GoToInnerPyramid")
    .OnEvent("Click", GoToInnerPyramid)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "GoToTrade")
    .OnEvent("Click", GoToTrade)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "TradeForPyramid")
    .OnEvent("Click", TradeForPyramid)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "UnlockPyramidFloors")
    .OnEvent("Click", Shops.Pyramid.MaxFloor)

    MyGui.Add("Button", "+Background" GuiBGColour " default ys", "Stage2`nAfter Pyramid 100")
    .OnEvent("Click", RunULCStage2)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "BossSweep")
    .OnEvent("Click", BossSweep)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "BuyMulchMax")
    .OnEvent("Click", Shops.Mulch.Max)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "BuyMulchTrade")
    .OnEvent("Click", Shops.Mulch.BuyTrade)

    MyGui.Add("Button", "+Background" GuiBGColour " default ys", "Stage3`nBiotite")
    .OnEvent("Click", RunULCStage3)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "MaxCoalShop")
    .OnEvent("Click", Shops.Coal.Max)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "MaxBioShop")
    .OnEvent("Click", Shops.Biotite.Max)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "MaxMalaShop")
    .OnEvent("Click", Shops.Malachite.Max)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "MaxHemaShop")
    .OnEvent("Click", Shops.Hematite.Max)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "MaxPlasmaShop")
    .OnEvent("Click", Shops.Plasma.Max)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "MaxElectricShop")
    .OnEvent("Click", Shops.Electric.Max)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "EnableBanks")
    .OnEvent("Click", EnableBanks)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "GoToWarden")
    .OnEvent("Click", GoToWarden)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "GoToWoW")
    .OnEvent("Click", GoToWoW)

    MyGui.Add("Button", "+Background" GuiBGColour " default ys", "Stage4`nPostWow")
    .OnEvent("Click", RunULCStage4)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "MaxBVItems")
    .OnEvent("Click", MaxBVItems)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "MaxBVItemsJustBags")
    .OnEvent("Click", MaxBVItemsJustBags)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Max bv bags looped")
    .OnEvent("Click", MaxBVItemsJustBags641)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "MaxBVItemsJustSocks")
    .OnEvent("Click", MaxBVItemsJustSocks)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "MaxBVItemsJustRings")
    .OnEvent("Click", MaxBVItemsJustRings)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "BuyMaxCardPacks")
    .OnEvent("Click", BuyMaxCardPacks)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "BuyMaxBVPacks")
    .OnEvent("Click", BuyMaxBVPacks)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Max all shops post wow")
    .OnEvent("Click", MaxAllShopsAfterWoW)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Test: Transmute relic reset loop")
    .OnEvent("Click", RelicTransmute)

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))
}

RelicTransmute(*) {
    Shops.Relics.TransMuteResetLoop()
}
