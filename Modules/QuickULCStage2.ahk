#Requires AutoHotkey v2.0

BossSweep(*) {
    UlcWindow()
    Out.D("Travel to witch")
    Travel.CursedKokkaupunki.GoTo()
    WaitForBossKill()

    Travel.OpenAreasSacredNebula()
    Travel.ScrollResetToTop()
    Sleep(50)

    If (!BossButtonClickNWait(cPoint(1863, 440))) { ; TheExaltedBridge
        ULCStageExitCheck("bs 1")
        Return false
    }

    If (!BossButtonClickNWait(cPoint(1859, 751))) { ; VilewoodCemetery
        ULCStageExitCheck("bs 2")
        Return false
    }

    If (!BossButtonClickNWait(cPoint(1866, 906))) { ; TheLoneTree
        ULCStageExitCheck("bs 3")
        Return false
    }

    Travel.ScrollAmountDown(7)
    Sleep(70)

    If (!BossButtonClickNWait(cPoint(1864, 708))) { ; SparkBubble
        ULCStageExitCheck("bs 4")
        Return false
    }

    cPoint(1133, 1181).ClickButtonActive() ; EnergyBelt tab
    Sleep(20)
    cPoint(1133, 1181).ClickButtonActive() ; EnergyBelt tab
    Travel.ScrollResetToTop()
    Sleep(150)

    If (!BossButtonClickNWait(cPoint(1866, 640))) { ; BluePlanetEdge
        ULCStageExitCheck("bs 5")
        Return false
    }

    If (!BossButtonClickNWait(cPoint(1864, 774))) { ; GreenPlanetEdge
        ULCStageExitCheck("bs 6")
        Return false
    }

    If (!BossButtonClickNWait(cPoint(1867, 905))) { ; RedPlanetEdge
        ULCStageExitCheck("bs 8")
        Return false
    }

    If (!BossButtonClickNWait(cPoint(1863, 1038))) { ; PurplePlanetEdge
        ULCStageExitCheck("bs 9")
        Return false
    }

    Travel.ScrollAmountDown(7)
    Sleep(50)

    If (!BossButtonClickNWait(cPoint(1862, 604))) { ; BlackPlanetEdge
        ULCStageExitCheck("bs 10")
        Return false
    }

    If (!BossButtonClickNWait(cPoint(1869, 910))) { ; EnergySingularity
        ULCStageExitCheck("bs 11")
        Return false
    }

    /**
     * 
     * @param {cPoint} point Button point
     */
    BossButtonClickNWait(point) {
        i := 0
        While (point.ClickButtonActive(5, 5) && i < 10) {
            Sleep(34)
            i++
        }
        If (point.IsButton() && !point.IsButtonActive()) {
            WaitForBossKill()
        } Else {
            Out.D("BossButtonClickWait: Button wasn't inactive " point.GetColour())
            Global ULCStageExit := true
            Return false
        }
        Return true
    }
}

WaitForBioOrTimeout(*) {
    UlcWindow()
    Shops.Biotite.GoTo()
    Travel.ScrollResetToTop()
    Sleep(50)

    /** @type {Timer} */
    Limiter := Timer()
    Limiter.CoolDownS(60, &isactive)
    gToolTip.Center("Waiting for Malachite unlock availability")
    While (cPoint(1683, 305).IsButton() && isactive) {
        cPoint(1683, 305).ClickButtonActive() ; Unlock Malachite
        Sleep(50)
    }
    gToolTip.CenterDel()
    If (cPoint(1683, 305).IsButton()) {
        Return false
    }
    Return true
}

TimeWarpIfLackingBio(*) {
    UlcWindow()
    Use30minTimeWarp()
    ; Use6hTimeWarp()
    ; Use24hTimeWarp()
    ; Use72hTimeWarp()

    Shops.Biotite.GoTo()
    Travel.ScrollResetToTop()
    Sleep(50)

    /** @type {Timer} */
    Limiter := Timer()
    Limiter.CoolDownS(30, &isactive)
    gToolTip.Center("Waiting for Malachite unlock availability")
    While (cPoint(1683, 305).IsButton() && isactive) {
        cPoint(1683, 305).ClickButtonActive() ; Unlock Malachite
        Sleep(50)
    }
    gToolTip.CenterDel()
    If (cPoint(1683, 305).IsButton()) {
        Return false
    }
    Return true
}

WaitForMalaOrTimeout(*) {
    UlcWindow()
    Shops.Malachite.GoTo()
    Travel.ScrollResetToTop()
    Sleep(50)
    gToolTip.Center("Waiting for Hematite unlock availability")
    While (cPoint(1691, 305).IsButton()) {
        cPoint(1691, 305).ClickButtonActive() ; unlock hema
        Sleep(50)
    }
    gToolTip.CenterDel()
}

WaitForHemaOrTimeout(*) {
    UlcWindow()
    Shops.Hematite.GoTo()
    Travel.ScrollResetToTop()
    Sleep(50)

    gToolTip.Center("Waiting for Energy and Shards unlock availability")
    While (cPoint(1686, 311).IsButton()) {
        cPoint(1686, 311).ClickButtonActive() ; Unlock energy
        Sleep(150)
    }
    While (cPoint(1689, 532).IsButton() || cPoint(1688, 648).IsButton() ||
    cPoint(1686, 766).IsButton()) {
        cPoint(1689, 532).ClickButtonActive() ; Unlock ascension shards
        Sleep(50)
        cPoint(1688, 648).ClickButtonActive() ; Unlock fusion shards
        Sleep(50)
        cPoint(1686, 766).ClickButtonActive() ; Unlock transformation shards
        Sleep(50)
    }
    gToolTip.CenterDel()
}

PlacePlayerPlasmaLoc(*) {
    UlcWindow()
    Travel.ClosePanelIfActive()
    Travel.ClosePanelIfActive()
    Sleep(100)
    cPoint(1275, 195).ClickR(100)
    Sleep(100)
    cPoint(1275, 195).ClickR(100)
}

PlacePlayerCenter(*) {
    UlcWindow()
    Travel.ClosePanelIfActive()
    Travel.ClosePanelIfActive()
    Sleep(100)
    cPoint(1282, 622).ClickR(100)
    Sleep(100)
    cPoint(1282, 622).ClickR(100)
}

WaitForElectricOrTimeout(*) {
    UlcWindow()
    Shops.Electric.GoTo()
    Travel.ScrollResetToTop()
    Sleep(50)
    /** @type {Timer} */
    Limiter := Timer()
    chargingcount := storagecount := 0
    Limiter.CoolDownS(15, &isactive)
    gToolTip.Center("Waiting for Electric to build up")
    While (isactive && (storagecount < 3 && chargingcount < 3)) {
        If (cPoint(1861, 312).ClickButtonActive()) { ; storage
            storagecount++
        }
        Sleep(250)
        If (cPoint(1859, 419).ClickButtonActive()) { ; charging value
            chargingcount++
        }
        Sleep(250)
    }
    gToolTip.CenterDel()
}

GoToDeathbook(*) {
    UlcWindow()
    Travel.TerrorGraveyard.GoTo()
    Sleep(100)
}

BuyDeathbook(*) {
    UlcWindow()
    Travel.ClosePanelIfActive()
    Sleep(100)
    cPoint(1282, 622).Click() ; Open DB
    Sleep(50)
    cPoint(1139, 376).ClickButtonActive() ; Unlock
}

MaxCryptFloors(*) {
    UlcWindow()
    If (!Travel.SoulTemple.IsZone()) {
        Out.D("Trying to max crypt floors in wrong zone")
        Return
    }
    Out.D("Max crypt floors")
    Travel.ClosePanelIfActive()
    Sleep(100)
    Travel.ClosePanelIfActive()
    Sleep(100)
    If (!Window.Ispanel()) {
        cPoint(1282, 622).Click() ; Open object
        gToolTip.CenterMS("Maxing crypt floors", 500)
        cPoint(1464, 457).WaitUntilActiveButton(500, 20)
        cPoint(537, 670).ClickButtonActive()
        Sleep(50)
        AmountToModifier(100)
        Sleep(50)
        cPoint(1536, 462).ClickButtonActive() ; Increase level
        Sleep(50)
        ResetModifierKeys()
    }
}
