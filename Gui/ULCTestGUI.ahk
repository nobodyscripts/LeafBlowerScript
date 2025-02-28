#Requires AutoHotkey v2.0

#Include ../Modules/QuickULC.ahk

Button_Click_ULC(thisGui, info) {
    Global Settings

    optionsGUI := Gui(, "ULC TEST")
    optionsGUI.Opt("+MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    /* optionsGUI.Add("Button", "default", "Test")
    .OnEvent("Click", Test)

    Test(*) {
        UlcWindow()
        gToolTip.CenterCD("Test tooltip", 5000)
        SetTimer(gToolTip.CenterCDDel.Bind(gToolTip), -2500)
    } */

    optionsGUI.Add("Button", "default", "Scan and save BV Inventory")
    .OnEvent("Click", ScanBVInventory)

    optionsGUI.Add("Button", "default", "Stage 1`nHome Garden")
    .OnEvent("Click", RunULCStage1)

    optionsGUI.Add("Button", "default", "Get Daily Reward")
    .OnEvent("Click", GetDailyReward)

    optionsGUI.Add("Button", "default", "Go To Leaf Tower")
    .OnEvent("Click", GoToLeafTower)

    optionsGUI.Add("Button", "default", "BLC Prestige")
    .OnEvent("Click", TriggerBLC)

    optionsGUI.Add("Button", "default", "MLC Prestige")
    .OnEvent("Click", TriggerMLC)

    optionsGUI.Add("Button", "default", "MLC Prestige and start converters")
    .OnEvent("Click", TriggerMLCConverters)

    optionsGUI.Add("Button", "default", "ULC Prestige")
    .OnEvent("Click", TriggerULC)

    optionsGUI.Add("Button", "default", "Use30minTimeWarp")
    .OnEvent("Click", Use30minTimeWarp)

    optionsGUI.Add("Button", "default", "EquipBlower")
    .OnEvent("Click", EquipBlower)

    optionsGUI.Add("Button", "default", "EquipMulchSword")
    .OnEvent("Click", EquipMulchSword)

    optionsGUI.Add("Button", "default", "EquipElectric")
    .OnEvent("Click", EquipElectric)

    optionsGUI.Add("Button", "default", "EquipSlap")
    .OnEvent("Click", EquipSlap)

    optionsGUI.Add("Button", "default", "PubTradeForCheese2500")
    .OnEvent("Click", PubTradeForCheese2500)

    optionsGUI.Add("Button", "default", "PlacePlayerCenter")
    .OnEvent("Click", PlacePlayerCenter)

    optionsGUI.Add("Button", "default", "PlacePlayerPlasmaLoc")
    .OnEvent("Click", PlacePlayerPlasmaLoc)

    optionsGUI.Add("Button", "default", "Go To Leaf Tower")
    .OnEvent("Click", GoToLeafTower)

    optionsGUI.Add("Button", "default", "Go To Leaf Tower Max Floor")
    .OnEvent("Click", GoToLeafTowerMax)

    optionsGUI.Add("Button", "default", "MaxMLCShop")
    .OnEvent("Click", Shops.MLC.Max)

    optionsGUI.Add("Button", "default", "GoToPyramid")
    .OnEvent("Click", GoToPyramid)

    optionsGUI.Add("Button", "default", "GoToInnerPyramid")
    .OnEvent("Click", GoToInnerPyramid)

    optionsGUI.Add("Button", "default", "GoToTrade")
    .OnEvent("Click", GoToTrade)

    optionsGUI.Add("Button", "default", "TradeForPyramid")
    .OnEvent("Click", TradeForPyramid)

    optionsGUI.Add("Button", "default", "UnlockPyramidFloors")
    .OnEvent("Click", Shops.Pyramid.MaxFloor)

    optionsGUI.Add("Button", "default ys", "Stage2`nAfter Pyramid 100")
    .OnEvent("Click", RunULCStage2)

    optionsGUI.Add("Button", "default", "BossSweep")
    .OnEvent("Click", BossSweep)

    optionsGUI.Add("Button", "default", "BuyMulchMax")
    .OnEvent("Click", Shops.Mulch.Max)

    optionsGUI.Add("Button", "default", "BuyMulchTrade")
    .OnEvent("Click", Shops.Mulch.BuyTrade)

    optionsGUI.Add("Button", "default ys", "Stage3`nBiotite")
    .OnEvent("Click", RunULCStage3)

    optionsGUI.Add("Button", "default", "MaxCoalShop")
    .OnEvent("Click", Shops.Coal.Max)

    optionsGUI.Add("Button", "default", "MaxBioShop")
    .OnEvent("Click", Shops.Biotite.Max)

    optionsGUI.Add("Button", "default", "MaxMalaShop")
    .OnEvent("Click", Shops.Malachite.Max)

    optionsGUI.Add("Button", "default", "MaxHemaShop")
    .OnEvent("Click", Shops.Hematite.Max)

    optionsGUI.Add("Button", "default", "MaxPlasmaShop")
    .OnEvent("Click", Shops.Plasma.Max)

    optionsGUI.Add("Button", "default", "MaxElectricShop")
    .OnEvent("Click", Shops.Electric.Max)

    optionsGUI.Add("Button", "default", "EnableBanks")
    .OnEvent("Click", EnableBanks)

    optionsGUI.Add("Button", "default", "GoToWarden")
    .OnEvent("Click", GoToWarden)

    optionsGUI.Add("Button", "default", "GoToWoW")
    .OnEvent("Click", GoToWoW)

    optionsGUI.Add("Button", "default ys", "Stage4`nPostWow")
    .OnEvent("Click", RunULCStage4)

    optionsGUI.Add("Button", "default", "MaxBVItems")
    .OnEvent("Click", MaxBVItems)

    optionsGUI.Add("Button", "default", "MaxBVItemsJustSocks")
    .OnEvent("Click", MaxBVItemsJustSocks)

    optionsGUI.Add("Button", "default", "MaxBVItemsJustBags")
    .OnEvent("Click", MaxBVItemsJustBags)

    optionsGUI.Add("Button", "default", "BuyMaxCardPacks")
    .OnEvent("Click", BuyMaxCardPacks)

    optionsGUI.Add("Button", "default", "BuyMaxBVPacks")
    .OnEvent("Click", BuyMaxBVPacks)

    

    optionsGUI.Show()
}
