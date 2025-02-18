#Include ..\Lib\Navigate.ahk
#Include ..\Lib\hGlobals.ahk

#Include QuickULCStage1.ahk
#Include QuickULCStage2.ahk
#Include QuickULCStage3.ahk

; Curse brewing off, auto craft off, ancient autobuy taxi off, fixed nav
; hide max shops off, auto buy max leaves in blc set to 0,

/*
TODO
Wait for blc portal still getting held up in spots
inner cursed pyramid getting stuck
Max mlc setting leaf powered alb/others randomly off
little too much sleep on openareasleafgalaxy/resetscrolling

*/

RunULC(*) {
    StartTotal := A_Now
    Time1 := ULCStage1()
    if(!Time1) {
        Out.I("Run aborted in stage 1")
        Return 
    }
    Time2 := ULCStage2()
    if(!Time1) {
        Out.I("Run aborted in stage 2")
        Return 
    }
    Time3 := ULCStage3()
    if(!Time1) {
        Out.I("Run aborted in stage 3")
        Return 
    }
    EndTotal := A_Now

    Out.I(
        "Stage1 time: " Time1 "s"
        "Stage2 time: " Time2 "s"
        "Stage3 time: " Time3 "s"
        "Ulc run time: " DateDiff(StartTotal, EndTotal, "Seconds") "s"
    )
    MsgBox(
        "Stage1 time: " Time1 "s"
        "Stage2 time: " Time2 "s"
        "Stage3 time: " Time3 "s"
        "Ulc run time: " DateDiff(StartTotal, EndTotal, "Seconds") "s"
    )
    /*     Switch (GetULCStage()) {
        Case 1:
            ULCStage1()
        default:
            ULCStage1()
    } */
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
    Start := A_Now
    EquipBlower()
    GetDailyReward()

    If (!Travel.TheLeafTower.MaxTowerFloor()) {
        Out.I("Could not travel to tower, exiting")
        Return
    }
    WaitForFloor100()
    ULCStageExitCheck(1)

    TriggerMLC()
    WaitForPortalAnimation()
    ULCStageExitCheck(2)

    If (!Travel.TheLeafTower.MaxTowerFloor()) {
        Out.I("Could not travel to tower, exiting")
        Return
    }
    ULCStageExitCheck(3)

    Out.D("Max mlc")
    Shops.MLC.Max()
    ULCStageExitCheck(4)

    TriggerMLCConverters()
    WaitForPortalAnimation()
    ;Out.D("Max mlc")
    ;Shops.MLC.Max()
    ULCStageExitCheck(5)

    Sleep(100)
    WaitForBLCPortal()
    ULCStageExitCheck(12)
    TriggerBLC()
    ULCStageExitCheck(13)
    WaitForPortalAnimation()
    ULCStageExitCheck(14)
    Out.D("Max mlc")
    Shops.MLC.Max()
    ULCStageExitCheck(6)

    If (!Travel.TheInnerCursedPyramid.GoTo()) { ; Get ancients to autobrew
        Out.I("Could not travel to inner pyramid, exiting")
        Return
    }
    WaitTillPyramidReset()
    ULCStageExitCheck(7)

    PubTradeForCheese2500()
    ULCStageExitCheck(8)

    EquipMulchSword() ; Activates unique leaves/pets on loadout too
    If (!Travel.CursedKokkaupunki.GoTo()) {
        Out.I("Could not travel to CursedKokkaupunki, exiting")
        Return
    }
    ULCStageExitCheck(9)
    Sleep(3000)

    Shops.Mulch.BuyTrade()
    Shops.Mulch.Max()
    Use30minTimeWarp() ; Should we do something with e300 blc first or try e30
    ULCStageExitCheck(10)

    GoToTrade()
    EquipBlower()
    TradeForPyramid()
    If (!Travel.TheCursedPyramid.GoTo()) { ; Get ancients to autobrew
        Out.I("Could not travel to pyramid, exiting")
        Return
    }
    ULCStageExitCheck(11)

    MaxPyramidFloors()
    GoToTrade()

    ; Trade wait
    gToolTip.CenterMS("Waiting for trades to complete", 120050)
    Sleep(120050)


    GoToTrade()
    Sleep(100)
    cPoint(1970, 1087).ClickButtonActive() ; Collect all
    Travel.TheCursedPyramid.GoTo()
    Shops.Pyramid.MaxFloor()

    If (!Travel.TheInnerCursedPyramid.GoTo()) {
        Out.I("Could not travel to inner pyramid, exiting")
        Return
    }
    WaitTillPyramidReset()
    Finish := A_Now
    Out.I("Stage one completed in " DateDiff(Start, Finish, "Seconds") " seconds.") 
    Return DateDiff(Start, Finish, "Seconds")

    /*  ; TODO
    If (IsULCCraftSaved()) { ; TODO
        EquipBlower()
    } Else {
        CraftMoonLeafsAndPreset() ; TODO
    }    
    */
}

ULCStage2(*) {
    Start := A_Now
    UlcWindow()

    BossSweep()
    ULCStageExitCheck("s2 1")

    EquipBlower()
    Travel.MountMoltenfury.GoTo()
    Shops.Coal.GoTo()
    cPoint(1865, 535).WaitWhileColour(Colours().Background)
    Sleep(1500)
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
    PlacePlayerCenter()
    BuyDeathbook()

    ; Fight soul crypt floor 1
    Travel.SoulCrypt.GoTo()
    Sleep(100)
    WaitForZoneChange() ; Let lack of taxi be a trigger
    Sleep(70)
    If (!Travel.SoulTemple.IsZone()) {
        Travel.SoulTemple.GoTo()
    }
    Sleep(70)
    MaxCryptFloors() ; Max 20

    ; Fight soul crypt floor 20
    Travel.SoulCrypt.GoTo()
    Sleep(100)
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

    EquipSlap()
    Travel.PrimordialEthos.GoTo()
    WaitForBossKillOrTimeout()

    EquipBlower()
    Travel.TenebrisField.GoTo()
    WaitFor40thDice()

    Finish := A_Now
    Out.I("Stage two completed in " DateDiff(Start, Finish, "Seconds") " seconds.") 
    Return DateDiff(Start, Finish, "Seconds")
}

ULCStage3(*) {
    Start := A_Now
    ; Prep for ulc after unlock

    ; DisableDiceAutos()

    BuyMaxCardPacks()

    BuyMaxBVPacks()

    MaxBVItems()

    StoreMineCurrency()

    EquipBlower()

    Finish := A_Now
    Out.I("Stage two completed in " DateDiff(Start, Finish, "Seconds") " seconds.")
    Return DateDiff(Start, Finish, "Seconds")
}

TriggerULC(*) {
    UlcWindow()
    GameKeys.OpenBluePortal()
    Sleep(50)
    cPoint(1710, 498).ClickButtonActive()
    Sleep(8000)
}

GoToTrade(*) {
    UlcWindow()
    Shops.OpenTrades()
}

GoToPyramid(*) {
    UlcWindow()
    Travel.TheCursedPyramid.GoTo()
}

GoToInnerPyramid(*) {
    UlcWindow()
    Travel.TheInnerCursedPyramid.GoTo()
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
    Out.D("Waitforbosskill")
    Killcount := 0
    IsPrevTimerLong := IsBossTimerLong()
    gToolTip.Center("Waiting for Boss Kill")
    Loop {
        If (!Window.IsActive()) {
            Return false
        }
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
        Sleep(17)
    }
    ToolTip(, , , 15)
}

WaitForBossKillOrTimeout(seconds := 30) {
    UlcWindow()
    Out.D("WaitForBossKillOrTimeout")
    Killcount := 0
    IsPrevTimerLong := IsBossTimerLong()
    gToolTip.Center("Waiting for Boss Kill")
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
    ToolTip(, , , 15)
    Out.I("Wait for boss kill timed out.")
    Return false
}

GoToWitch(*) {
    UlcWindow()
    Out.D("CursedKokkaupunki")
    Travel.CursedKokkaupunki.GoTo()
}

GoToCentaur(*) {
    UlcWindow()
    Out.D("TheExaltedBridge")
    Travel.TheExaltedBridge.GoTo()
}

GoToVileCreature(*) {
    UlcWindow()
    Out.D("VilewoodCemetery")
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
    Out.D("WaitForZoneChange")
    gToolTip.Center("Waiting for zone change")
    /** @type {cPoint} */
    zonesample := Points.Misc.ZoneSample
    curCol := zonesample.GetColour()
    zonesample.WaitWhileColour(curCol, maxloops, interval)
    ToolTip(, , , 15)
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
    Out.D("GoToSoulForge")
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
    Out.D("TODO WaitForQuarkOrTimeout")
}

GoToWoW(*) {
    UlcWindow()
    Travel.PrimordialEthos.GoTo() ; TODO needs fix
}

WaitFor40thDice() {
    UlcWindow()
    ;Shops.Dice.GoTo()
    Out.D("TODO WaitFor40thDice")
    ; remember dlc will likely effect position

    ;cPoint(354, 395) ; 40th dice
    ;cPoint(416, 398) ; 41st dice
    ;cPoint(811, 299) ; Right page button
    ;cPoint(990, 402) ; 50th dice (dlc)
}
