#Include ..\Lib\Navigate.ahk
#Include ..\Lib\hGlobals.ahk

#Include QuickULCStage1.ahk
#Include QuickULCStage2.ahk
#Include QuickULCStage3.ahk

; Curse brewing off, auto craft off, ancient autobuy taxi off, fixed nav
; hide max shops off, auto buy max leaves in blc set to 0,

/* 
TODO
Wait for blc portal still waiting too long to buy blc portal
inner cursed pyramid getting stuck on favourites tab
Max mlc setting leaf powered alb/others randomly off

*/

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
    Start := A_Now
    EquipBlower()
    GetDailyReward()

    if(!Travel.TheLeafTower.MaxTowerFloor()) {
        Out.I("Could not travel to tower, exiting")
        return
    }
    WaitForFloor100()
    ULCStageExitCheck(1)

    TriggerMLC()
    WaitForPortalAnimation()
    ULCStageExitCheck(2)
    
    if(!Travel.TheLeafTower.MaxTowerFloor()) {
        Out.I("Could not travel to tower, exiting")
        return
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
    
    if(!Travel.TheInnerCursedPyramid.GoTo()) { ; Get ancients to autobrew
        Out.I("Could not travel to inner pyramid, exiting")
        return
    }
    WaitTillPyramidReset()
    ULCStageExitCheck(7)

    PubTradeForCheese2500()
    ULCStageExitCheck(8)

    EquipMulchSword() ; Activates unique leaves/pets on loadout too
    if(!Travel.CursedKokkaupunki.GoTo()) {
        Out.I("Could not travel to CursedKokkaupunki, exiting")
        return
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
    if(!Travel.TheCursedPyramid.GoTo()) { ; Get ancients to autobrew
        Out.I("Could not travel to pyramid, exiting")
        return
    }
    ULCStageExitCheck(11)

    MaxPyramidFloors()
    GoToTrade()

    Finish := A_Now
    MsgBox("Trade for pyramid requirements now if incomplete.`r`n"
        "After that start stage 2.`n"
    "Time taken: " DateDiff(Start, Finish, "Seconds") "s")
    /*  ; TODO
    
    If (IsULCCraftSaved()) { ; TODO
        EquipBlower()
    } Else {
        CraftMoonLeafsAndPreset() ; TODO
    }
    
    Travel.TheCursedPyramid.GoTo()
    ; Do we just leave ancient to user?
    WaitForAncients() ; TODO
    
    Shops.Pyramid.MaxFloor() 
    
    tower travel
    blc portal purchase
    pyramid taxi
    pyramid travel

    */
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
    cPoint(1063, 628).TextTipAtCoord("Waiting for boss kill", 14)
    Loop {
        if (!Window.IsActive()) {
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
    ToolTip(, , , 14)
}

WaitForBossKillOrTimeout(seconds := 30) {
    UlcWindow()
    Out.D("WaitForBossKillOrTimeout")
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

}

GoToWoW(*) {
    UlcWindow()
    Travel.PrimordialEthos.GoTo()
}

WaitFor40thDice() {
    UlcWindow()
    Shops.Dice.GoTo()
    ; remember dlc will likely effect position

    ;cPoint(354, 395) ; 40th dice
    ;cPoint(416, 398) ; 41st dice
    ;cPoint(811, 299) ; Right page button
    ;cPoint(990, 402) ; 50th dice (dlc)
}
