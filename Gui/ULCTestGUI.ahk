#Requires AutoHotkey v2.0

#Include ../Modules/QuickULC.ahk

Button_Click_ULC(thisGui, info) {
    Global Settings

    optionsGUI := Gui(, "ULC TEST")
    optionsGUI.Opt("+MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    optionsGUI.Add("Button", "default", "Run")
    .OnEvent("Click", RunULC)

    optionsGUI.Add("Button", "default", "Stage 1")
    .OnEvent("Click", ULCStage1)

    optionsGUI.Add("Button", "default", "Get Daily Reward")
    .OnEvent("Click", GetDailyReward)

    optionsGUI.Add("Button", "default", "Go To Leaf Tower")
    .OnEvent("Click", GoToLeafTower)

    optionsGUI.Add("Button", "default", "test")
    .OnEvent("Click", test)

    test(*) {
        UlcWindow()
       
        Travel.TheHollow.GoTo()
        WaitForBossKillOrTimeout()
/* 
        Travel.AstralOasis.GoTo()
        WaitForBossKillOrTimeout()

        Travel.DimensionalTapestry.GoTo()
        WaitForBossKillOrTimeout()

        Travel.PlanckScope.GoTo()
        WaitForBossKillOrTimeout()

        Travel.SoulForge.GoTo()
        Shops.SoulForge.Max()
        Shops.SoulShop.Max()

        EnableBanks()

        Travel.SoulTemple.GoTo()
        MaxCryptFloors() ; Max 100

        Travel.SoulCrypt.GoTo()

        Travel.TheFabricoftheLeafverse.GoTo() ; Warden
        WaitForBossKillOrTimeout()

        Travel.AnteLeafton.GoTo()
        WaitForQuarkOrTimeout()

        EquipSlap()
        Travel.PrimordialEthos.GoTo()
        WaitForBossKillOrTimeout()

        EquipBlower()
        Travel.TenebrisField.GoTo()
        WaitFor40thDice()
 */
    }

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

    optionsGUI.Add("Button", "default", "UnlockPyramidFloors")
    .OnEvent("Click", Shops.Pyramid.MaxFloor)

    optionsGUI.Add("Button", "default ys", "Stage2")
    .OnEvent("Click", ULCStage2)

    optionsGUI.Add("Button", "default", "BossSweep")
    .OnEvent("Click", BossSweep)

    optionsGUI.Add("Button", "default", "MaxMLCShop")
    .OnEvent("Click", Shops.MLC.Max)

    optionsGUI.Add("Button", "default", "BuyMulchMax")
    .OnEvent("Click", Shops.Mulch.Max)

    optionsGUI.Add("Button", "default", "BuyMulchTrade")
    .OnEvent("Click", Shops.Mulch.BuyTrade)

    optionsGUI.Add("Button", "default", "GoToTrade")
    .OnEvent("Click", GoToTrade)

    optionsGUI.Add("Button", "default", "TradeForPyramid")
    .OnEvent("Click", TradeForPyramid)

    optionsGUI.Add("Button", "default", "GoToPyramid")
    .OnEvent("Click", GoToPyramid)

    optionsGUI.Add("Button", "default", "GoToInnerPyramid")
    .OnEvent("Click", GoToInnerPyramid)

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

    optionsGUI.Add("Button", "default", "Open Dice")
    .OnEvent("Click", OpenDice)

    OpenDice(*) {
        UlcWindow()
        Shops.Dice.GoTo()
    }

    optionsGUI.Add("Button", "default", "EnableBanks")
    .OnEvent("Click", EnableBanks)

    optionsGUI.Add("Button", "default", "GoToWarden")
    .OnEvent("Click", GoToWarden)

    optionsGUI.Add("Button", "default", "GoToWoW")
    .OnEvent("Click", GoToWoW)

    optionsGUI.Add("Button", "default ys", "Stage3")
    .OnEvent("Click", ULCStage3)

    optionsGUI.Add("Button", "default", "MaxBVItems")
    .OnEvent("Click", MaxBVItems)

    optionsGUI.Add("Button", "default", "BuyMaxCardPacks")
    .OnEvent("Click", BuyMaxCardPacks)

    optionsGUI.Add("Button", "default", "BuyMaxBVPacks")
    .OnEvent("Click", BuyMaxBVPacks)

    optionsGUI.Show()
}
