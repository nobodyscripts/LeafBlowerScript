#Requires AutoHotkey v2.0

#Include ../Modules/QuickULC.ahk

Button_Click_ULC(thisGui, info) {
    Global Settings

    optionsGUI := Gui(, "ULC TEST")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"


/*     optionsGUI.Add("Button", "default", "Run")
    .OnEvent("Click", RunULC) */

    optionsGUI.Add("Button", "default", "Stage 1")

    optionsGUI.Add("Button", "default", "BLC Prestige")
    .OnEvent("Click", TriggerBLC)

    optionsGUI.Add("Button", "default", "MLC Prestige and start converters")
    .OnEvent("Click", TriggerMLC)

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

    optionsGUI.Add("Button", "default", "PubTradeForCheese25000")
    .OnEvent("Click", PubTradeForCheese25000)

    optionsGUI.Add("Button", "default", "PlacePlayerCenter")
    .OnEvent("Click", PlacePlayerCenter)

    optionsGUI.Add("Button", "default", "PlacePlayerPlasmaLoc")
    .OnEvent("Click", PlacePlayerPlasmaLoc)

    optionsGUI.Add("Button", "default", "Go To Leaf Tower")
    .OnEvent("Click", GoToLeafTower)

    optionsGUI.Add("Button", "default", "Go To Leaf Tower Max Floor")
    .OnEvent("Click", GoToLeafTowerMax)

    GoToLeafTowerMax(*) {
        UlcWindow()
        Travel.TheLeafTower.MaxTowerFloor()
    }
/*

    
    optionsGUI.Add("Button", "default", "UnlockPyramidFloors")
    .OnEvent("Click", UnlockPyramidFloors)
    
    optionsGUI.Add("Button", "default", "MaxMLCShop")
    .OnEvent("Click", MaxMLCShop)

    optionsGUI.Add("Button", "default", "BuyMulchTrade")
    .OnEvent("Click", BuyMulchTrade)

    optionsGUI.Add("Button", "default", "GoToTrade")
    .OnEvent("Click", GoToTrade)

    optionsGUI.Add("Button", "default", "TradeForPyramid")
    .OnEvent("Click", TradeForPyramid)

    optionsGUI.Add("Button", "default", "GoToPyramid")
    .OnEvent("Click", GoToPyramid)

    optionsGUI.Add("Button", "default ys", "BossSweep")
    .OnEvent("Click", BossSweep)

    optionsGUI.Add("Button", "default", "MaxCoalShop")
    .OnEvent("Click", MaxCoalShop)

    optionsGUI.Add("Button", "default", "MaxBioShop")
    .OnEvent("Click", MaxBioShop)

    optionsGUI.Add("Button", "default", "MaxMalaShop")
    .OnEvent("Click", MaxMalaShop)

    optionsGUI.Add("Button", "default", "EnableBanks")
    .OnEvent("Click", EnableBanks) */

    optionsGUI.Add("Button", "default ys", "Stage3")
    .OnEvent("Click", ULCStage3)

    optionsGUI.Add("Button", "default", "MaxBVItems")
    .OnEvent("Click", MaxBVItems)

    optionsGUI.Add("Button", "default", "BuyMaxCardPacks")
    .OnEvent("Click", BuyMaxCardPacks)

    optionsGUI.Add("Button", "default", "BuyMaxBVPacks")
    .OnEvent("Click", BuyMaxBVPacks)
    
    optionsGUI.Show("w300")
}
