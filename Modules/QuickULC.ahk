#Include ..\Lib\Navigate.ahk
#Include ..\Lib\hGlobals.ahk

#Include QuickULCStage1.ahk
#Include QuickULCStage2.ahk
#Include QuickULCStage3.ahk

; Curse brewing off, auto craft off

RunULC(*) {
    Switch (GetULCStage()) {
    Case 1:
        ULCStage1()
    default:
        ULCStage1()
    }
}

GetULCStage() {

}

ULCStage1ExitCheck(id) {
    Global ULCStage1Exit
    If (ULCStage1Exit) {
        Out.D("Exited at id " id)
        Out.S()
        ExitApp()
    }
}

ULCStage1(*) {
    EquipBlower()
    GetDailyReward()

    Travel.TheLeafTower.MaxTowerFloor()
    WaitForFloor100()
    ULCStage1ExitCheck(1)

    TriggerMLC()
    WaitForPortalAnimation()
    ULCStage1ExitCheck(2)

    Travel.TheLeafTower.MaxTowerFloor()
    ULCStage1ExitCheck(3)

    Shops.MLC.Max()
    Shops.MLC.Max()
    ULCStage1ExitCheck(4)

    TriggerMLCConverters()
    WaitForPortalAnimation()
    Shops.MLC.Max()
    ULCStage1ExitCheck(5)

    WaitForBLCPortal()
    ULCStage1ExitCheck(12)
    TriggerBLC()
    ULCStage1ExitCheck(13)
    WaitForPortalAnimation()
    ULCStage1ExitCheck(14)
    Shops.MLC.Max()
    ULCStage1ExitCheck(6)

    Travel.TheInnerCursedPyramid.GoTo() ; Get ancients to autobrew
    WaitTillPyramidReset()
    ULCStage1ExitCheck(7)

    PubTradeForCheese25000()
    ULCStage1ExitCheck(8)

    Use30minTimeWarp() ; Should we do something with e300 blc first or try e30
    ULCStage1ExitCheck(9)

    EquipMulchSword() ; Activates unique leaves/pets on loadout too
    Sleep(1000)
    Shops.Mulch.BuyTrade()
    ULCStage1ExitCheck(10)

    GoToTrade()
    ULCStage1ExitCheck(11)

    MsgBox("Trade for pyramid requirements now, then go to pyramid and get ancients`r`n"
        "After that do pyramid floor 100 and start stage 2.")
    /* TradeForPyramid() ; TODO
    
    If (IsULCCraftSaved()) { ; TODO
        EquipBlower()
    } Else {
        CraftMoonLeafsAndPreset() ; TODO
    }
    
    Travel.TheCursedPyramid.GoTo()
    ; Do we just leave ancient to user?
    WaitForAncients() ; TODO
    
    Shops.Pyramid.MaxFloor() */
}

ULCStage2(*) {
    UlcWindow()
    Travel.CursedKokkaupunki.GoTo()
    WaitForBossKill()

    Travel.TheExaltedBridge.GoTo()
    WaitForBossKill()

    Travel.VilewoodCemetery.GoTo()
    WaitForBossKill()

    Travel.TheLoneTree.GoTo()
    WaitForBossKill()

    Travel.SparkBubble.GoTo()
    WaitForBossKill()

    Travel.BluePlanetEdge.GoTo()
    WaitForBossKill()

    Travel.GreenPlanetEdge.GoTo()
    WaitForBossKill()

    Travel.RedPlanetEdge.GoTo()
    WaitForBossKill()

    Travel.PurplePlanetEdge.GoTo()
    WaitForBossKill()

    Travel.BlackPlanetEdge.GoTo()
    WaitForBossKillOrTimeout()

    Travel.EnergySingularity.GoTo()
    WaitForBossKillOrTimeout()

    Travel.MountMoltenfury.GoTo()
    Sleep(5000)

    Shops.Coal.Max()

    GoToGF()
    WaitForBossKillOrTimeout()

    GoToSS()
    WaitForBossKillOrTimeout()

    Travel.BiotiteForest.GoTo()

    MaxBVItems()
    WaitForBioOrTimeout()

    TimeWarpIfLackingBio()

    Shops.Biotite.Max()
    WaitForMalaOrTimeout()

    Shops.Malachite.Max()

    Travel.SparkRange.GoTo()
    WaitForHemaOrTimeout()

    Shops.Hematite.Max()

    Travel.PlasmaForest.GoTo()
    PlacePlayerPlasmaLoc()
    EquipElectric()
    WaitForElectricOrTimeout()
    Shops.Electric.Max()
    Shops.Plasma.Max()

    EquipBlower()

    Travel.TerrorGraveyard.GoTo()
    BuyDeathbook()

    ; Fight soul crypt floor 1
    Travel.SoulCrypt.GoTo()
    WaitForZoneChange() ; Let lack of taxi be a trigger
    MaxCryptFloors() ; Max 20

    ; Fight soul crypt floor 20
    Travel.SoulCrypt.GoTo()
    WaitForZoneChange()

    Travel.TheHollow.GoTo()
    WaitForBossKillOrTimeout()

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

    Travel.PrimordialEthos.GoTo()
    WaitForBossKillOrTimeout()

    Travel.TenebrisField.GoTo()
    WaitFor40thDice()
}

ULCStage3(*) {
    ; Prep for ulc after unlock
    BuyMaxCardPacks()

    BuyMaxBVPacks()

    MaxBVItems()

    StoreMineCurrency()

    EquipBlower()
}

;@region UlcWindow()
/**
 * Quick window handle for all the ulc test functions
 */
UlcWindow() {
    If (!Window.Activate()) {
        cReload()
        Return
    }
}
;@endregion

TriggerULC(*) {
    UlcWindow()
    GameKeys.OpenBluePortal()
    Sleep(50)
    cPoint(1710, 498).ClickButtonActive()
    Sleep(8000)
}
BossSweep(*) {
    UlcWindow()

}

EnableBanks(*) {
    UlcWindow()

}

GoToTrade(*) {
    UlcWindow()
    Shops.OpenTrades()
}

GoToPyramid(*) {
    UlcWindow()
    Travel.TheCursedPyramid.GoTo()
}

GoToLeafTower(*) {
    UlcWindow()
    Travel.TheLeafTower.GoTo()
}

GoToLeafTowerMax(*) {
    UlcWindow()
    Travel.TheLeafTower.MaxTowerFloor()
}

GoToPub(*) {
    UlcWindow()
    Travel.TheCheesePub.GoTo()
}

EquipMulchSword(*) {
    UlcWindow()
    GameKeys.EquipSwordGearLoadout()
}

EquipBlower(*) {
    UlcWindow()
    GameKeys.EquipDefaultGearLoadout()
}

EquipSlap(*) {
    UlcWindow()
    GameKeys.EquipSlapGearLoadout()
}

WaitForBossKill(*) {
    UlcWindow()

}

WaitForBossKillOrTimeout(*) {
    UlcWindow()

}

GoToWitch(*) {
    UlcWindow()
    Travel.CursedKokkaupunki.GoTo()
}

GoToCentaur(*) {
    UlcWindow()
    Travel.TheExaltedBridge.GoTo()
}

GoToVileCreature(*) {
    UlcWindow()
    Travel.VilewoodCemetery.GoTo()
}

GoToAirElemental(*) {
    UlcWindow()
    Travel.TheLoneTree.GoTo()
}

GoToSparkBubble(*) {
    UlcWindow()
    Travel.SparkBubble.GoTo()
}

GoToTerrorBlue(*) {
    UlcWindow()
    Travel.BluePlanetEdge.GoTo()
}

GoToTerrorGreen(*) {
    UlcWindow()
    Travel.GreenPlanetEdge.GoTo()
}

GoToTerrorRed(*) {
    UlcWindow()
    Travel.RedPlanetEdge.GoTo()
}

GoToTerrorPurple(*) {
    UlcWindow()
    Travel.PurplePlanetEdge.GoTo()
}

GoToTerrorSuper(*) {
    UlcWindow()
    Travel.BlackPlanetEdge.GoTo()
}

GoToEnergyGuard(*) {
    UlcWindow()
    Travel.EnergySingularity.GoTo()
}

GoToMountMoltenfury(*) {
    UlcWindow()
    Travel.MountMoltenfury.GoTo()
}

GotoBio(*) {
    UlcWindow()
    Travel.BiotiteForest.GoTo()
}

WaitForBioOrTimeout(*) {
    UlcWindow()

}

TimeWarpIfLackingBio(*) {

}

WaitForMalaOrTimeout(*) {
    UlcWindow()

}

GotoHema(*) {
    UlcWindow()
    Travel.SparkRange.GoTo()
}

WaitForHemaOrTimeout(*) {
    UlcWindow()

}

GoToPlasmaForest(*) {
    UlcWindow()
    Travel.PlasmaForest.GoTo()
}

PlacePlayerPlasmaLoc(*) {
    UlcWindow()
    Travel.ClosePanelIfActive()
    Sleep(100)
    cPoint(1275, 195)
    .ClickR(100)
    Sleep(100)
    cPoint(1275, 195)
    .ClickR(100)
}

PlacePlayerCenter(*) {
    UlcWindow()
    Travel.ClosePanelIfActive()
    Sleep(100)
    cPoint(1282, 622)
    .ClickR(100)
    Sleep(100)
    cPoint(1282, 622)
    .ClickR(100)
}

EquipElectric(*) {
    UlcWindow()
    GameKeys.EquipElectricGearLoadout()
}

WaitForElectricOrTimeout(*) {
    UlcWindow()

}

GoToDeathbook(*) {
    UlcWindow()
    Travel.TerrorGraveyard.GoTo()
    Sleep(100)
}

BuyDeathbook(*) {
    UlcWindow()
    GameKeys.ClosePanel()
    Sleep(100)
    cPoint(1282, 622)
    .Click() ; Open DB
    Sleep(50)
    cPoint(1139, 376)
    .ClickButtonActive() ; Unlock
}

GoToSoulCrypt(*) {
    UlcWindow()
    Travel.SoulCrypt.GoTo()
}

WaitForZoneChange(*) {
    UlcWindow()

}

GoToSoulTemple(*) {
    UlcWindow()
    Travel.SoulTemple.GoTo()
}

MaxCryptFloors(*) {
    UlcWindow()
    GameKeys.ClosePanel()
    Sleep(100)
    cPoint(1282, 622).Click() ; Open soul temple object
    Sleep(50)
    ; TODO Button for unlocking more levels
    AmountToModifier(100)
    Sleep(50)
    cPoint(1536, 462)
    .ClickButtonActive() ; Increase level
}

GoToQuarkBoss1(*) {
    UlcWindow()
    Travel.AstralOasis.GoTo()
}

GoToQuarkBoss2(*) {
    UlcWindow()
    Travel.DimensionalTapestry.GoTo()
}

GoToQuarkBoss3(*) {
    UlcWindow()
    Travel.PlanckScope.GoTo()
}

GoToSoulForge(*) {
    UlcWindow()
    Travel.SoulForge.GoTo()
    Sleep(100)
    GameKeys.ClosePanel()
    Sleep(100)
    cPoint(1291, 991)
    .Click() ; Soul forge
}

GoToWarden(*) {
    UlcWindow()
    Travel.TheFabricoftheLeafverse.GoTo()
}

GoToLeaftonPit(*) {
    UlcWindow()
    Travel.AnteLeafton.Goto()
}

WaitForQuarkOrTimeout(*) {
    UlcWindow()

}

GoToWoW(*) {
    UlcWindow()
    Travel.PrimordialEthos.GoTo()
}

WaitFor40thDice() {
    UlcWindow()
    Shops.Dice.GoTo()
}
