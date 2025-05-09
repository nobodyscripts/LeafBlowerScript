#Include ..\Lib\Navigate.ahk
#Include ..\Lib\hGlobals.ahk
#Include ..\Lib\hModules.ahk

#Include QuickULCStage1.ahk
#Include QuickULCStage2.ahk
#Include QuickULCStage4.ahk
#Include GemFarm.ahk

Global ULCBVItemsMultiPass := true
Global ULCBiotiteUseTW := "30m" ; "6h" "24h" "72h"
Global ULCMineStoreToSpheres := false

/*
Ingame settings
    Curse brewing - Off
    Auto craft leaves - Off
    Borb Pyramid Taxi (ancient) - Off
    Borb Crypt Taxi (soul shop) - Off
    Auto buy max leaves (BLC shop) - 0/Off
    Borbventures Scale Min - Off
    Borbventures Chance - 60%
    Biotite leaf marketing - 74
    
Graphics settings
    Fixed Navigation - On
    Hide maxed shops - Off

Loadouts
On each save; Tool, Pet team, Uniques, Dice, Scrolls, (no nature, no autobuy, scrolls optional)
    1 "Default"
        Bellows, general ULC crafted (+Ancient, MLC+, MLC%, Nuclear Fuel, Skip tower+, Skip tower%, Soul forge+, TGM). Sharded for a mixture
    2 "Slap"
        Soul Trout, damage crafted set for wow
    3 "Tower" (unused in ULC currently)
        Bellows, tower skip/more tower floors crafted
    4 "Sword"
        Mulch sword, same setup as 1 otherwise
    5 "Electric"
        Bellows, Electric storage+, Storage%, Charge+, Charge%. 1 Sharded for storage, the rest sharded for Charge
    Others unused: 6 "Curses", 7 "Quark", 8 "Piling"

ULC Saved
    Crafted, Quark, Cards, Other optional (tested with Dice)
*/

/*
TODO
02/26/2025 04:03:23:414 Debug: Clicking cheese quest
02/26/2025 04:03:23:447 Important: Didn't find cheese quest button, aborting.
02/26/2025 04:03:23:456 Debug: Exited at id 8
^ probably need to adjust WaitUntilActiveButton times

CursedKokkaupunki > reset scroll > no second button on reset > exit bs 1

e300 trades optional

Need a bv solution

Display tooltip for WaitForPortalAnimation

Gf/ss/quark custom travel to avoid closing areas panel

Leafton farming

Is crafted saved, automatic crafting with presets

*/

RunULCStage1(*) {
    StartTotal := A_Now
    Time1 := ULCStage1()
    If (!Time1) {
        Out.I("Run aborted in stage 1")
        Return
    }
    Time2 := ULCStage2()
    If (!Time2) {
        Out.I("`r`nStage1 time: " Time1 "s`r`n")
        Out.I("Run aborted in stage 2")
        Return
    }
    Time3 := ULCStage3()
    If (!Time3) {
        Out.I("`r`nStage1 time: " Time1 "s`r`n"
            "Stage2 time: " Time2 "s`r`n")
        Out.I("Run aborted in stage 3")
        Return
    }
    Time4 := ULCStage4()
    If (!Time4) {
        Out.I("`r`nStage1 time: " Time1 "s`r`n"
            "Stage2 time: " Time2 "s`r`n"
            "Stage3 time: " Time3 "s`r`n")
        Out.I("Run aborted in stage 4")
        Return
    }
    EndTotal := A_Now

    Out.I(
        "`r`nStage1 time: " Time1 "s`r`n"
        "Stage2 time: " Time2 "s`r`n"
        "Stage3 time: " Time3 "s`r`n"
        "Stage4 time: " Time4 "s`r`n"
        "Ulc run time: " DateDiff(StartTotal, EndTotal, "Seconds") "s"
    )
    MsgBox(
        "Stage1 time: " Time1 "s`r`n"
        "Stage2 time: " Time2 "s`r`n"
        "Stage3 time: " Time3 "s`r`n"
        "Stage4 time: " Time4 "s`r`n"
        "Ulc run time: " DateDiff(StartTotal, EndTotal, "Seconds") "s"
    )
}

RunULCStage2(*) {
    StartTotal := A_Now
    Time2 := ULCStage2()
    If (!Time2) {
        Out.I("Run aborted in stage 2")
        Return
    }
    Time3 := ULCStage3()
    If (!Time3) {
        Out.I("`r`nStage2 time: " Time2 "s`r`n")
        Out.I("Run aborted in stage 3")
        Return
    }
    Time4 := ULCStage4()
    If (!Time4) {
        Out.I("`r`nStage2 time: " Time2 "s`r`n"
            "Stage3 time: " Time3 "s`r`n")
        Out.I("Run aborted in stage 4")
        Return
    }
    EndTotal := A_Now

    Out.I(
        "`r`nStage2 time: " Time2 "s`r`n"
        "Stage3 time: " Time3 "s`r`n"
        "Stage4 time: " Time4 "s`r`n"
        "Ulc run time: " DateDiff(StartTotal, EndTotal, "Seconds") "s"
    )
    MsgBox(
        "Stage2 time: " Time2 "s`r`n"
        "Stage3 time: " Time3 "s`r`n"
        "Stage4 time: " Time4 "s`r`n"
        "Ulc run time: " DateDiff(StartTotal, EndTotal, "Seconds") "s"
    )
}

RunULCStage3(*) {
    StartTotal := A_Now
    Time3 := ULCStage3()
    If (!Time3) {
        Out.I("Run aborted in stage 3")
        Return
    }
    Time4 := ULCStage4()
    If (!Time4) {
        Out.I("`r`nStage3 time: " Time3 "s`r`n")
        Out.I("Run aborted in stage 4")
        Return
    }
    EndTotal := A_Now

    Out.I(
        "`r`nStage3 time: " Time3 "s`r`n"
        "Stage4 time: " Time4 "s`r`n"
        "Ulc run time: " DateDiff(StartTotal, EndTotal, "Seconds") "s"
    )
    MsgBox(
        "Stage3 time: " Time3 "s`r`n"
        "Stage4 time: " Time4 "s`r`n"
        "Ulc run time: " DateDiff(StartTotal, EndTotal, "Seconds") "s"
    )
}

RunULCStage4(*) {
    StartTotal := A_Now
    Time4 := ULCStage4()
    If (!Time4) {
        Out.I("Run aborted in stage 4")
        Return
    }
    EndTotal := A_Now

    Out.I("Stage4 run time: " DateDiff(StartTotal, EndTotal, "Seconds") "s")
    MsgBox("Stage4 run time: " DateDiff(StartTotal, EndTotal, "Seconds") "s")
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
    WaitForPortalAnimation()
    EquipBlower()
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

    If (!Shops.Pyramid.IsFloor100Done()) {
        If (!Travel.TheInnerCursedPyramid.GoTo()) { ; Get ancients to autobrew
            Out.I("Could not travel to inner pyramid, exiting")
            Return
        }
        WaitTillPyramidReset()
        ULCStageExitCheck(7)
    }

    PubTradeForCheese2500()
    ULCStageExitCheck(8)

    gToolTip.Center("Waiting for Benitoite to build up")
    SetTimer(ToggleULCLoadouts, 1200)
    If (!cPoint(1259, 1319).IsButtonActive()) { ; Moonstone shop icon
        Travel.TheLeafTower.GoTo()
    }
    While (!cPoint(1259, 1319).IsButtonActive()) {
        GameKeys.TriggerWind()
        Sleep(17)
    }
    gToolTip.CenterDel()

    Shops.Moonstone.WaitForMoonstoneOrTimeout()

    Shops.Sand.WaitForSandOrTimeout()
    SetTimer(ToggleULCLoadouts, 0)
    ULCStageExitCheck(9)

    Shops.Mulch.BuyTrade()
    Sleep(700)
    Shops.Mulch.Max()
    Use30minTimeWarp() ; Should we do something with e300 blc first or try e30
    ULCStageExitCheck(10)

    Travel.OpenAreas()
    Sleep(100)
    If (!Shops.Pyramid.IsFloor100Done()) {
        Out.D("Trade pass")
        Shops.MLC.MaxTrades()
        GoToTrade()
        EquipBlower()
        EquipBlower()
        TradeForPyramid()
        TradeForPyramidJustBeer()
        ; Trade wait
        gToolTip.CenterCD("Waiting for trades to complete", 120050)
        Sleep(120050)

        GoToTrade()
        Sleep(100)
        cPoint(1530, 1087).ClickButtonActive() ; Boost all
        Sleep(34)
        cPoint(1970, 1087).ClickButtonActive() ; Collect all
        ULCStageExitCheck(11)
    }
    If (!Shops.Pyramid.MaxFloor()) {
        Out.I("Pyramid max floors failed.")
        MsgBox("Pyramid max floors failed, aborted")
        Return
    }
    If (!Travel.TheInnerCursedPyramid.GoTo()) {
        Out.I("Could not travel to inner pyramid, exiting")
        Return
    }
    WaitTillPyramidReset()
    Finish := A_Now
    Out.I("Stage one completed in " DateDiff(Start, Finish, "Seconds") " seconds.")
    Return DateDiff(Start, Finish, "Seconds")
}

ULCStage2(*) {
    Start := A_Now
    UlcWindow()

    If (!Shops.Pyramid.IsFloor100Done()) {
        If (!Shops.Pyramid.MaxFloor()) {
            Out.I("Could not max pyramid floors, exiting")
            Return
        }

        If (!Travel.TheInnerCursedPyramid.GoTo()) {
            Out.I("Could not travel to inner pyramid, exiting")
            Return
        }
        WaitTillPyramidReset()
    }
    If (!Shops.Pyramid.IsFloor100Done()) {
        msg :=
            "Pyramid floor 100 incomplete cannot continue, please trade, max floor and run pyramid as appropriate then rerun stage 2."
        Out.E(msg)
        MsgBox(msg)
        Return
    }

    BossSweep()
    ULCStageExitCheck("s2 1")

    EquipBlower()
    EquipBlower()
    Travel.MountMoltenfury.GoTo()
    Shops.Coal.GoTo()
    /** @type {cPoint} */
    MaxCoalFert := cPoint(1865, 535)
    gToolTip.Center("Waiting for coal to collect")
    MaxCoalFert.WaitWhileNotColourS(Colours().Background, 30)
    Sleep(2000)
    gToolTip.CenterDel()
    Shops.Coal.Max()

    GoToGF()
    WaitForBossKillOrTimeout()

    GoToSS()
    WaitForBossKillOrTimeout()

    Shops.Coal.Max()

    Finish := A_Now
    Out.I("Stage two completed in " DateDiff(Start, Finish, "Seconds") " seconds.")
    Return DateDiff(Start, Finish, "Seconds")
}

ULCStage3(*) {
    UlcWindow()
    Start := A_Now

    MaxBVItemsJustSocks()
    MaxBVItemsJustRings()

    If (!Shops.Malachite.IsShopUnlocked()) {
        Travel.BiotiteForest.GoTo()
        If (!WaitForBioOrTimeout()) {
            TimeWarpIfLackingBio()
        }
    }
    Shops.Biotite.Max()

    WaitForMalaOrTimeout()
    Shops.Malachite.Max()
    If (!Shops.Malachite.IsShopUnlocked()) {
        msg := "Malachite shop still locked, will need another pass of stage 3 to unlock energy"
        Out.E(msg)
        MsgBox(msg)
        Return
    }

    Travel.SparkRange.GoTo()
    HemaFailed := false
    If (!WaitForHemaOrTimeout()) {
        HemaFailed := true
    }
    Shops.Hematite.Max()

    /*  Travel.VilewoodCemetery.GoTo() ; go get some early sacred?
    Shops.Sacred.Max() */

    Travel.PlasmaForest.GoTo()
    PlacePlayerPlasmaLoc()
    gToolTip.CenterCD("Waiting for plasma leaves", 20000)
    /** @type {Timer} */
    PlasmaTimer := Timer()
    PlasmaTimer.CoolDownS(20, &activeTimer)

    doHema := Shops.Hematite.BuyCraftBags()
    doMulch := Shops.Mulch.BuyCraftBags()

    While (activeTimer) {
        If (doHema) {
            doHema := Shops.Hematite.BuyCraftBags()
        }
        If (doMulch) {
            doMulch := Shops.Mulch.BuyCraftBags()
        }
        GameKeys.TriggerWind()
        Sleep(17)
    }
    gToolTip.CenterCDDel()
    EquipElectric()
    Shops.Plasma.FirstPass()

    EquipElectric()
    Shops.Electric.WaitForElectricOrTimeout()
    Shops.Electric.Max()
    Shops.Plasma.Max()

    EquipBlower()
    EquipBlower()
    Travel.TerrorGraveyard.GoTo()
    PlacePlayerCenter()
    Deathbook := BuyDeathbook()

    Travel.VilewoodCemetery.GoTo()
    Shops.Sacred.Max()
    Travel.TheLoneTree.GoTo()
    Shops.Sacred.Max()

    If (cPoint(1639, 1308).GetColour() = "0xFFFFF6") { ; Mala shop button
        msg := "Malachite shop still locked, will need another pass of stage 3 to unlock energy"
        Out.E(msg)
        MsgBox(msg)
        Return
    }

    If (HemaFailed) {
        msg := "Hematite shop still locked, will need another pass of stage 3 to unlock energy"
        Out.E(msg)
        MsgBox(msg)
        Return
    }

    If (!Deathbook) {
        Travel.TerrorGraveyard.GoTo()
        Deathbook2 := BuyDeathbook()
        If (!Deathbook2) {
            MsgBox(
                "Deathbook failed to unlock, likely due to lack of Borb Ascension Juice, restart stage 3 after checking BV."
            )
            Return
        }
    }

    EquipSlap()
    EquipSlap()
    ; Fight soul crypt floor 1
    Travel.SoulCrypt.GoTo()
    Sleep(100)
    WaitForZoneChange("Soul Temple", 1300, 50) ; 65s Let lack of taxi be a trigger
    Sleep(70)
    Shops.SoulTemple.MaxFloor() ; Max 20

    Shops.SoulShop.Max()
    Sleep(70)

    ; Fight soul crypt floor 20
    Travel.SoulCrypt.GoTo()
    WaitForZoneChange("Soul Temple", 1300, 50) ; 65s
    EquipBlower()
    EquipBlower()

    Travel.TheHollow.GoTo()
    If (!WaitForBossKillOrTimeout()) {
        msg := "Failed to kill Mirage, exiting."
        Msgbox(msg)
        Out.I(msg)
        Return
    }

    Travel.AstralOasis.GoTo()
    If (!WaitForBossKillOrTimeout()) {
        msg := "Failed to kill Arbiter, exiting."
        Msgbox(msg)
        Out.I(msg)
        Return
    }

    Travel.DimensionalTapestry.GoTo()
    If (!WaitForBossKillOrTimeout()) {
        msg := "Failed to kill Cosmic Dragon, exiting."
        Msgbox(msg)
        Out.I(msg)
        Return
    }

    Travel.PlanckScope.GoTo()
    If (!WaitForBossKillOrTimeout()) {
        msg := "Failed to kill Artificer, exiting."
        Msgbox(msg)
        Out.I(msg)
        Return
    }

    Travel.SoulForge.GoTo()
    Sleep(500)
    Shops.SoulForge.Critical()
    Sleep(500)
    Shops.SoulForge.Max()
    Sleep(500)
    Shops.SoulShop.Max()
    Sleep(500)
    Shops.SoulShop.Max()
    Sleep(500)

    EnableBanks()
    Sleep(100)

    Shops.SoulTemple.MaxFloor() ; Max 100

    Travel.SoulCrypt.GoTo()
    Sleep(100)
    WaitForZoneChange("Soul Temple", 1300, 50) ; 65s
    If (!Travel.SoulTemple.IsZone()) {
        Travel.SoulTemple.GoTo()
    }
    Shops.SoulForge.Max()
    Sleep(500)
    Shops.SoulShop.Max()
    Sleep(100)

    Travel.TheFabricoftheLeafverse.GoTo() ; Warden
    If (!WaitForBossKillOrTimeout()) {
        msg := "Failed to kill Warden, exiting."
        Msgbox(msg)
        Out.I(msg)
        Return
    }
    Sleep(100)

    ;Travel.AnteLeafton.GoTo()
    ;WaitForQuarkOrTimeout()

    EquipSlap()
    EquipSlap()
    Travel.PrimordialEthos.GoTo()
    If (!WaitForBossKillOrTimeout()) {
        msg := "Failed to kill WoW, exiting."
        Msgbox(msg)
        Out.I(msg)
        Return
    }

    Travel.TenebrisField.GoTo()

    EquipBlower()
    EquipBlower()
    ;WaitFor40thDice()

    Finish := A_Now
    Out.I("Stage three completed in " DateDiff(Start, Finish, "Seconds") " seconds.")
    Return DateDiff(Start, Finish, "Seconds")
}

ULCStage4(*) {
    Start := A_Now
    ; Prep for ulc after unlock

    ; DisableDiceAutos()

    BuyMaxCardPacks()

    BuyMaxBVPacks()

    Global ULCBVItemsMultiPass
    If (ULCBVItemsMultiPass) {
        MaxBVItemsJustBags641()
        MaxBVItems()
    } Else {
        MaxBVItems()
    }
    StoreMineCurrency()

    EquipBlower()
    EquipBlower()

    Finish := A_Now
    Out.I("Stage four completed in " DateDiff(Start, Finish, "Seconds") " seconds.")
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
            gToolTip.CenterDel()
            Return true
        }
        IsPrevTimerLong := IsTimerLong
        If (Travel.HomeGarden.IsAreaGarden()) {
            ToolTip(, , , 14)
            Out.I("User killed by boss.")
            ToolTip("Killed by boss", Window.W / 2, Window.H / 2 + Window.RelH(
                50), 2)
            SetTimer(ToolTip.Bind(, , , 2), -3000)

            gToolTip.CenterDel()
            Return false
        }
        GameKeys.TriggerViolin()
        Sleep(17)
    }
    gToolTip.CenterDel()
}

WaitForBossKillOrTimeout(seconds := 30) {
    UlcWindow()
    Out.D("WaitForBossKillOrTimeout")
    Killcount := 0
    IsPrevTimerLong := IsBossTimerLong()
    gToolTip.CenterCD("Waiting for Boss Kill", seconds * 1000)
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
            gToolTip.CenterCDDel()
            Return true
        }
        IsPrevTimerLong := IsTimerLong
        If (Travel.HomeGarden.IsAreaGarden()) {
            Out.I("User killed by boss.")
            ToolTip("Killed by boss", Window.W / 2, Window.H / 2 + Window.RelH(
                50), 2)
            SetTimer(ToolTip.Bind(, , , 2), -3000)
            gToolTip.CenterCDDel()
            Return false
        }
        GameKeys.TriggerViolin()
        GameKeys.TriggerWind()
        GameKeys.TriggerGravity()
        Sleep(17)
    }
    gToolTip.CenterCDDel()
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

/**
 * Default 10s period
 * @param maxloops 
 * @param interval 
 */
WaitForZoneChange(target, maxloops := 200, interval := 50) {
    UlcWindow()
    /** @type {Colours} */
    col := Colours()

    Out.D("WaitForZoneChange")
    time := maxloops * interval / 1000
    gToolTip.CenterCD("Waiting for zone change", maxloops * interval)
    /** @type {cPoint} */
    zonesample := Points.Misc.ZoneSample
    zonesample.WaitWhileNotColour(col.GetColourByZone(target), maxloops, interval)
    gToolTip.CenterCDDel()
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

ToggleULCLoadouts() {
    EquipBlower()
    Sleep(100)
    EquipMulchSword()
}
