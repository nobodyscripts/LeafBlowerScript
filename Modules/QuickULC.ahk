#Include ..\Lib\Navigate.ahk
#Include ..\Lib\hGlobals.ahk

#Include ..\Shop\Bio.ahk
#Include ..\Shop\Coal.ahk
#Include ..\Shop\Electric.ahk
#Include ..\Shop\Hema.ahk
#Include ..\Shop\Mala.ahk
#Include ..\Shop\MLC.ahk
#Include ..\Shop\Mulch.ahk
#Include ..\Shop\Plasma.ahk
#Include ..\Shop\SoulForge.ahk
#Include ..\Shop\SoulShop.ahk

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

ULCStage1(*) {
    Travel.TheLeafTower.MaxTowerFloor()

    TriggerMLC()

    Travel.TheLeafTower.MaxTowerFloor()

    MaxMLCShop()

    TriggerMLC()

    WaitForBLCPortal()

    TriggerBLC()

    GoToPub()

    PubTradeForCheese25000()

    Use30minTimeWarp() ; Should we do something with e300 blc first or try e30

    EquipMulchSword() ; Activates unique leaves/pets on loadout too

    BuyMulchTrade()

    GoToTrade()

    TradeForPyramid()

    EquipBlower()

    GoToPyramid()

    ; Do we just leave ancient to user?
    WaitForAncients()

    UnlockPyramidFloors()
}

ULCStage2(*) {
    GoToWitch() WaitForBossKill()

    GoToCentaur() WaitForBossKill()

    GoToVileCreature() WaitForBossKill()

    GoToAirElemental() WaitForBossKill()

    GoToSparkBubble() WaitForBossKill()

    GoToTerrorBlue() WaitForBossKill()

    GoToTerrorGreen() WaitForBossKill()

    GoToTerrorRed() WaitForBossKill()

    GoToTerrorPurple() WaitForBossKill()

    GoToTerrorSuper() WaitForBossKillOrTimeout()

    GoToEnergyGuard() WaitForBossKillOrTimeout()

    GoToMountMoltenfury() Sleep(5000)

    MaxCoalShop()

    GoToGF() WaitForBossKillOrTimeout()

    GoToSS() WaitForBossKillOrTimeout()

    GotoBio()

    MaxBVItems()

    WaitForBioOrTimeout()

    MaxBioShop()

    WaitForMalaOrTimeout()

    MaxMalaShop()

    GotoHema()

    WaitForHemaOrTimeout()

    MaxHemaShop()

    GoToPlasmaForest()

    PlacePlayerPlasmaLoc()

    EquipElectric()

    WaitForElectricOrTimeout()

    MaxElectricShop()

    MaxPlasmaShop()

    EquipBlower()

    GoToDeathbook()

    BuyDeathbook()

    GoToSoulCrypt()

    WaitForZoneChange()

    GoToSoulTemple()

    MaxCryptFloors() ; Max 20

    GoToSoulCrypt()

    WaitForZoneChange()

    GoToQuarkBoss1() WaitForBossKillOrTimeout()

    GoToQuarkBoss2() WaitForBossKillOrTimeout()

    GoToQuarkBoss3() WaitForBossKillOrTimeout()

    GoToSoulForge()

    MaxSoulForge()

    MaxSoulShop()

    EnableBanks()

    GoToSoulTemple()

    MaxCryptFloors() ; Max 100

    GoToSoulCrypt()

    GoToWarden() WaitForBossKillOrTimeout()

    WaitForZoneChange()

    GoToLeaftonPit()

    WaitForQuarkOrTimeout()

    GoToWoW() WaitForBossKillOrTimeout()
}

ULCStage3(*) {
    BuyMaxCardPacks()

    BuyMaxBVPacks()

    MaxBVItems()

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

TriggerBLC(*) {
    UlcWindow()
    GameKeys.OpenRedPortal()
    Sleep(50)
    cPoint(1109, 553)
    .ClickButtonActive()
    Sleep(150)
    cPoint(1131, 525)
    .ClickButtonActive()
}

TriggerMLC(*) {
    UlcWindow()
    GameKeys.OpenGreenPortal()
    Sleep(50)
    cPoint(1109, 553)
    .ClickButtonActive()
    Sleep(150)
    cPoint(1131, 525)
    .ClickButtonActive()
    Sleep(8000)
    ActivateConverters()
}

TriggerULC(*) {
    UlcWindow()
    GameKeys.OpenBluePortal()
    Sleep(50)
    cPoint(1109, 553)
    .ClickButtonActive()
    Sleep(150)
    cPoint(1131, 525)
    .ClickButtonActive()
}

ActivateConverters(*) {
    UlcWindow()
    GameKeys.OpenConverters()
    Sleep(150)
    StartConvertorsBtn := cPoint(1075, 1102)
    StartConvertorsBtn.ClickButtonActive()
}

PubTradeForCheese25000(*) {
    UlcWindow()
    Travel.TheCheesePub.GoTo() ;TODO This won't work currently
    Sleep(150)
    BartenderBtn := cPoint(241, 741)
    BartenderBtn.Click()
    Sleep(250)
    QuestsBtn := cPoint(1091, 380)
    QuestsBtn.WaitUntilActiveButton()
    QuestsBtn.ClickButtonActive()
    QuestCheese250Btn := cPoint(1702, 312)
    QuestCheese250Btn.WaitUntilActiveButton()
    QuestCheese250Btn.ClickButtonActive()
    QuestCheese250Btn.WaitUntilActiveButton()
    QuestCheese250Btn.ClickButtonActive()
}

Use30minTimeWarp(*) {
    UlcWindow()
    TTtab := cPoint(1810, 1177)
    Buy30mins := cPoint(1592, 306)
    Available30mins := cPoint(1744, 306)
    Travel.OpenGemShop()
    TTtab.WaitUntilActiveButton()
    If (!TTtab.IsButtonActive()) {
        Out.I("Found no time travel button, exiting.")
        Return
    }
    ; Navigate to Time Travel tab
    TTtab.Click()

    Buy30mins.WaitUntilActiveButton()

    If (!Available30mins.IsButtonActive()) {
        Buy30mins.ClickButtonActive()

        Available30mins.WaitUntilActiveButton()

        Available30mins.ClickButtonActive()
        Sleep(100)
    } Else {
        Available30mins.ClickButtonActive()
        Sleep(100)
    }
}

TradeForPyramid(*) {
    UlcWindow()

}

BossSweep(*) {
    UlcWindow()

}

EnableBanks(*) {
    UlcWindow()

}

GoToTrade(*) {
    UlcWindow()

}

GoToPyramid(*) {
    UlcWindow()

}

GoToLeafTower(*) {
    UlcWindow()
    Travel.TheLeafTower.GoTo()
}

WaitForBLCPortal(*) {
    UlcWindow()

}

GoToPub(*) {
    UlcWindow()
    Travel.TheCheesePub.GoTo() ;TODO This won't work currently
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

WaitForAncients(*) {
    UlcWindow()

}

UnlockPyramidFloors(*) {
    UlcWindow()
    Travel.TheCursedPyramid.GoTo()
    GameKeys.ClosePanel()
    Sleep(100)
    cPoint(1282, 622)
    .Click(100) ; Center screen
    Sleep(50)
    cPoint(529, 740)
    .ClickButtonActive() ; Max unlock
    Sleep(50)
    AmountToModifier(100) ; Alt
    Sleep(50)
    cPoint(1539, 463)
    .ClickButtonActive() ; Increase level
    Sleep(50)
    ResetModifierKeys()
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
    cPoint(1282, 622)
    .Click() ; Open DB
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

;@region ULCStage3 Funcs
BuyMaxCardPacks(*) {
    UlcWindow()
    LegBtn := Points.Card.BuyLegend
    ComBtn := Points.Card.BuyCommon
    Travel.Cards.GoToPacks()
    Sleep(100)
    AmountToModifier(25000)
    Sleep(50)
    If (LegBtn.IsButtonActive()) {
        LegBtn.MouseMove()
        Sleep(50)
        MouseMove(1, 1, 5, "R")
        Sleep(50)
        LegBtn.ClickOffsetWhileColour(LegBtn.GetColour())
        Sleep(50)
    }
    If (ComBtn.IsButtonActive()) {
        ComBtn.MouseMove()
        Sleep(50)
        MouseMove(1, 1, 5, "R")
        Sleep(50)
        ComBtn.ClickOffsetWhileColour(ComBtn.GetColour())
        Sleep(50)
    }
    If (LegBtn.IsButtonActive() || ComBtn.IsButtonActive()) {
        LegBtn.GreedyModifierClick()
        ComBtn.GreedyModifierClick()
    }
    ResetModifierKeys()
}

BuyMaxBVPacks(*) {
    UlcWindow()
    ComBtn := Points.Borbventures.PacksBuyCommon
    LegBtn := Points.Borbventures.PacksBuyLegendary

    Travel.OpenBorbVentures()
    Sleep(100)
    Points.Borbventures.PacksTab.Click()
    Sleep(100)
    AmountToModifier(25000)
    Sleep(50)
    If (ComBtn.IsButtonActive()) {
        ComBtn.MouseMove()
        Sleep(50)
        MouseMove(1, 1, 5, "R")
        Sleep(50)
        ComBtn.ClickOffsetWhileColour(ComBtn.GetColour())
        Sleep(50)
        ComBtn.GreedyModifierClick()
    }
    /*
    If (LegBtn.IsButtonActive()) {
        LegBtn.MouseMove()
        Sleep(20)
        MouseMove(1, 1, 5, "R")
        Sleep(50)
        LegBtn.ClickOffsetWhileColour(LegBtn.GetColour())
        Sleep(50)
        ;LegBtn.GreedyModifierClick()
    } */
    ResetModifierKeys()
}

;@region MaxBVItems(*)
/**
 * MaxBVItems Go through each bv item in inventory and try to max it
 */
MaxBVItems(*) {
    /** @type {cPoint} */
    CraftBtn := cPoint(1570, 644)
    /** @type {cPoint} */
    AscendBtn := cPoint(1855, 646)
    /** @type {cPoint} */
    ScrapBtn := cPoint(2136, 646)

    BlockSlots := [
        "13-1",
        "8-4",
        "9-4",
        "10-4",
        "8-5"
    ]

    Columns := [
        391,
        463,
        530,
        596,
        665,
        736,
        799,
        868,
        935,
        1010,
        1074,
        1140,
        1206,
        1281,
        1344
    ]
    Rows := [
        502,
        623,
        749,
        877,
        1001
    ]
    UlcWindow()
    Travel.OpenBorbVentures()
    Sleep(100)
    Points.Borbventures.InvTab.Click()
    Sleep(100)
    For (rid, rvalue IN Rows) {
        For (cid, cvalue IN Columns) {
            /** @type cPoint */
            btn := cPoint(cvalue, rvalue)
            If (!btn.IsBackground()) {
                btn.ClickOffset()
                Sleep(50)
                AmountToModifier(25000)
                Sleep(50)
                If (IsItemCraftable()) {
                    CraftBtn.Click()
                    Sleep(50)
                    ResetModifierKeys()
                    Sleep(50)
                }
            }
        }
    }
    ResetModifierKeys()
    IsItemCraftable() {
        If (CraftBtn.IsButtonActive()) {
            Return true
        } Else {
            Return false
        }
    }
    IsItemBlocked(r,c) {
        
    }
}
;@endregion
;@endregion
