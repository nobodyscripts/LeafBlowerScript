#Requires AutoHotkey v2.0

#Include ../Modules/QuickULC.ahk
#Include ..\ScriptLib\cMousePattern.ahk

Button_Click_ULC(thisGui, info) {

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "ULC TEST")
    MyGui.SetUserFontSettings()

    MyGui.Add("Button", "+Background" GuiBGColour, "Scan and save BV Inventory")
    .OnEvent("Click", ScanBVInventory)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Stage 1`nHome Garden")
    .OnEvent("Click", RunULCStage1)

    MyGui.Add("Button", "+Background" GuiBGColour, "Get Daily Reward")
    .OnEvent("Click", GetDailyReward)

    MyGui.Add("Button", "+Background" GuiBGColour, "Go To Leaf Tower")
    .OnEvent("Click", GoToLeafTower)

    MyGui.Add("Button", "+Background" GuiBGColour, "BLC Prestige")
    .OnEvent("Click", TriggerBLC)

    MyGui.Add("Button", "+Background" GuiBGColour, "MLC Prestige")
    .OnEvent("Click", TriggerMLC)

    MyGui.Add("Button", "+Background" GuiBGColour, "MLC Prestige and start converters")
    .OnEvent("Click", TriggerMLCConverters)

    MyGui.Add("Button", "+Background" GuiBGColour, "ULC Prestige")
    .OnEvent("Click", TriggerULC)

    MyGui.Add("Button", "+Background" GuiBGColour, "Use30minTimeWarp")
    .OnEvent("Click", Use30minTimeWarp)

    MyGui.Add("Button", "+Background" GuiBGColour, "EquipBlower")
    .OnEvent("Click", EquipBlower)

    MyGui.Add("Button", "+Background" GuiBGColour, "EquipMulchSword")
    .OnEvent("Click", EquipMulchSword)

    MyGui.Add("Button", "+Background" GuiBGColour, "EquipElectric")
    .OnEvent("Click", EquipElectric)

    MyGui.Add("Button", "+Background" GuiBGColour, "EquipSlap")
    .OnEvent("Click", EquipSlap)

    MyGui.Add("Button", "+Background" GuiBGColour, "PubTradeForCheese2500")
    .OnEvent("Click", PubTradeForCheese2500)

    MyGui.Add("Button", "+Background" GuiBGColour, "PlacePlayerCenter")
    .OnEvent("Click", PlacePlayerCenter)

    MyGui.Add("Button", "+Background" GuiBGColour, "PlacePlayerPlasmaLoc")
    .OnEvent("Click", PlacePlayerPlasmaLoc)

    MyGui.Add("Button", "+Background" GuiBGColour, "Go To Leaf Tower")
    .OnEvent("Click", GoToLeafTower)

    MyGui.Add("Button", "+Background" GuiBGColour, "Go To Leaf Tower Max Floor")
    .OnEvent("Click", GoToLeafTowerMax)

    MyGui.Add("Button", "+Background" GuiBGColour, "MaxMLCShop")
    .OnEvent("Click", Shops.MLC.Max)

    MyGui.Add("Button", "+Background" GuiBGColour, "GoToPyramid")
    .OnEvent("Click", GoToPyramid)

    MyGui.Add("Button", "+Background" GuiBGColour, "GoToInnerPyramid")
    .OnEvent("Click", GoToInnerPyramid)

    MyGui.Add("Button", "+Background" GuiBGColour, "GoToTrade")
    .OnEvent("Click", GoToTrade)

    MyGui.Add("Button", "+Background" GuiBGColour, "TradeForPyramid")
    .OnEvent("Click", TradeForPyramid)

    MyGui.Add("Button", "+Background" GuiBGColour, "UnlockPyramidFloors")
    .OnEvent("Click", Shops.Pyramid.MaxFloor)

    MyGui.Add("Button", "+Background" GuiBGColour " ys", "Stage2`nAfter Pyramid 100")
    .OnEvent("Click", RunULCStage2)

    MyGui.Add("Button", "+Background" GuiBGColour, "BossSweep")
    .OnEvent("Click", BossSweep)

    MyGui.Add("Button", "+Background" GuiBGColour, "BuyMulchMax")
    .OnEvent("Click", Shops.Mulch.Max)

    MyGui.Add("Button", "+Background" GuiBGColour, "BuyMulchTrade")
    .OnEvent("Click", Shops.Mulch.BuyTrade)

    MyGui.Add("Button", "+Background" GuiBGColour " ys", "Stage3`nBiotite")
    .OnEvent("Click", RunULCStage3)

    MyGui.Add("Button", "+Background" GuiBGColour, "MaxCoalShop")
    .OnEvent("Click", Shops.Coal.Max)

    MyGui.Add("Button", "+Background" GuiBGColour, "MaxBioShop")
    .OnEvent("Click", Shops.Biotite.Max)

    MyGui.Add("Button", "+Background" GuiBGColour, "MaxMalaShop")
    .OnEvent("Click", Shops.Malachite.Max)

    MyGui.Add("Button", "+Background" GuiBGColour, "MaxHemaShop")
    .OnEvent("Click", Shops.Hematite.Max)

    MyGui.Add("Button", "+Background" GuiBGColour, "MaxPlasmaShop")
    .OnEvent("Click", Shops.Plasma.Max)

    MyGui.Add("Button", "+Background" GuiBGColour, "MaxElectricShop")
    .OnEvent("Click", Shops.Electric.Max)

    MyGui.Add("Button", "+Background" GuiBGColour, "EnableBanks")
    .OnEvent("Click", EnableBanks)

    MyGui.Add("Button", "+Background" GuiBGColour, "GoToWarden")
    .OnEvent("Click", GoToWarden)

    MyGui.Add("Button", "+Background" GuiBGColour, "GoToWoW")
    .OnEvent("Click", GoToWoW)

    MyGui.Add("Button", "+Background" GuiBGColour " default ys", "Stage4`nPostWow")
    .OnEvent("Click", RunULCStage4)

    MyGui.Add("Button", "+Background" GuiBGColour, "MaxBVItems")
    .OnEvent("Click", MaxBVItems)

    MyGui.Add("Button", "+Background" GuiBGColour, "MaxBVItemsJustBags")
    .OnEvent("Click", MaxBVItemsJustBags)

    MyGui.Add("Button", "+Background" GuiBGColour, "Max bv bags looped")
    .OnEvent("Click", MaxBVItemsJustBags641)

    MyGui.Add("Button", "+Background" GuiBGColour, "MaxBVItemsJustSocks")
    .OnEvent("Click", MaxBVItemsJustSocks)

    MyGui.Add("Button", "+Background" GuiBGColour, "MaxBVItemsJustRings")
    .OnEvent("Click", MaxBVItemsJustRings)

    MyGui.Add("Button", "+Background" GuiBGColour, "BuyMaxCardPacks")
    .OnEvent("Click", BuyMaxCardPacks)

    MyGui.Add("Button", "+Background" GuiBGColour, "BuyMaxBVPacks")
    .OnEvent("Click", BuyMaxBVPacks)

    MyGui.Add("Button", "+Background" GuiBGColour, "Max all shops post wow")
    .OnEvent("Click", MaxAllShopsAfterWoW)


    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))
}
