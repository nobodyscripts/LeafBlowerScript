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

ULCStageExitCheck(id) {
    Global ULCStageExit
    If (ULCStageExit) {
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
    ULCStageExitCheck(1)

    TriggerMLC()
    WaitForPortalAnimation()
    ULCStageExitCheck(2)

    Travel.TheLeafTower.MaxTowerFloor()
    ULCStageExitCheck(3)

    Shops.MLC.Max()
    Shops.MLC.Max()
    ULCStageExitCheck(4)

    TriggerMLCConverters()
    WaitForPortalAnimation()
    Shops.MLC.Max()
    ULCStageExitCheck(5)

    WaitForBLCPortal()
    ULCStageExitCheck(12)
    TriggerBLC()
    ULCStageExitCheck(13)
    WaitForPortalAnimation()
    ULCStageExitCheck(14)
    Shops.MLC.Max()
    ULCStageExitCheck(6)

    Travel.TheInnerCursedPyramid.GoTo() ; Get ancients to autobrew
    WaitTillPyramidReset()
    ULCStageExitCheck(7)

    PubTradeForCheese25000()
    ULCStageExitCheck(8)

    Use30minTimeWarp() ; Should we do something with e300 blc first or try e30
    ULCStageExitCheck(9)

    EquipMulchSword() ; Activates unique leaves/pets on loadout too
    Sleep(1000)
    Shops.Mulch.BuyTrade()
    ULCStageExitCheck(10)

    GoToTrade()
    ULCStageExitCheck(11)

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

    BossSweep()
    ULCStageExitCheck("s2 1")

    Travel.MountMoltenfury.GoTo()
    Sleep(5000)

    Shops.Coal.Max()

    GoToGF()
    WaitForBossKillOrTimeout()

    GoToSS()
    WaitForBossKillOrTimeout()

    Travel.BiotiteForest.GoTo()

    MaxBVItems()
    If (!WaitForBioOrTimeout()) {
        TimeWarpIfLackingBio()
    }

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
    Killcount := 0
    IsPrevTimerLong := IsBossTimerLong()
    cPoint(1063, 628).TextTipAtCoord("Waiting for boss kill", 14)
    Loop {
        UlcWindow()
        IsTimerLong := IsBossTimerLong()
        ; if state of timer has changed and is now off, we killed
        If ((IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
            ; If the timer is longer, killed too quick to get a gap
            ; Out.I("Kill timerlast " TimerLastCheckStatus " timer cur "
            ; TimerCurrentState " waslong " IsPrevTimerLong
            ; " islong " IsTimerLong)
            ToolTip(, , , 14)
            Return true
        }
        IsPrevTimerLong := IsTimerLong
        If (Travel.HomeGarden.IsAreaGarden()) {
            ToolTip(, , , 14)
            Out.I("User killed by boss.")
            ToolTip("Killed by boss", Window.W / 2, Window.H / 2 + Window.RelH(
                50), 2)
            SetTimer(ToolTip.Bind(, , , 2), -3000)
            Return false
        }
        GameKeys.TriggerViolin()
    }
    ToolTip(, , , 14)
}

WaitForBossKillOrTimeout(seconds := 30) {
    UlcWindow()
    Killcount := 0
    IsPrevTimerLong := IsBossTimerLong()
    /** @type {Timer} */
    Limiter := Timer()
    Limiter.CoolDownS(seconds, &isactive)
    While (isactive) {
        UlcWindow()
        IsTimerLong := IsBossTimerLong()
        ; if state of timer has changed and is now off, we killed
        If ((IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
            ; If the timer is longer, killed too quick to get a gap
            ; Out.I("Kill timerlast " TimerLastCheckStatus " timer cur "
            ; TimerCurrentState " waslong " IsPrevTimerLong
            ; " islong " IsTimerLong)
            Return true
        }
        IsPrevTimerLong := IsTimerLong
        If (Travel.HomeGarden.IsAreaGarden()) {
            Out.I("User killed by boss.")
            ToolTip("Killed by boss", Window.W / 2, Window.H / 2 + Window.RelH(
                50), 2)
            SetTimer(ToolTip.Bind(, , , 2), -3000)
            Return false
        }
    }
    Out.I("Wait for boss kill timed out.")
    Return false
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

GotoHema(*) {
    UlcWindow()
    Travel.SparkRange.GoTo()
}

GoToPlasmaForest(*) {
    UlcWindow()
    Travel.PlasmaForest.GoTo()
}

EquipElectric(*) {
    UlcWindow()
    GameKeys.EquipElectricGearLoadout()
}

GoToSoulCrypt(*) {
    UlcWindow()
    Travel.SoulCrypt.GoTo()
}

WaitForZoneChange(maxloops := 20, interval := 50) {
    UlcWindow()
    /** @type {cPoint} */
    zonesample := Points.Misc.ZoneSample
    curCol := zonesample.GetColour()
    zonesample.WaitWhileColour(curCol, maxloops, interval)
}

GoToSoulTemple(*) {
    UlcWindow()
    Travel.SoulTemple.GoTo()
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
    ; remember dlc will likely effect position
}
