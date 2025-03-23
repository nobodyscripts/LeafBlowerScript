#Requires AutoHotkey v2.0

BossSweep(*) {
    UlcWindow()
    Out.D("Travel to witch")
    Travel.ClosePanelIfActive()
    Travel.CursedKokkaupunki.GoTo()
    WaitForBossKill()

    Travel.OpenAreasSacredNebula()
    Travel.ScrollResetToTop()
    Sleep(50)

    If (!BossButtonClickNWait(cPoint(1863, 440))) { ; TheExaltedBridge
        ULCStageExitCheck("bs 1")
        Return false
    }
    Sleep(50)

    If (!BossButtonClickNWait(cPoint(1859, 751))) { ; VilewoodCemetery
        ULCStageExitCheck("bs 2")
        Return false
    }
    Sleep(50)

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
    Sleep(50)

    If (!BossButtonClickNWait(cPoint(1867, 905))) { ; RedPlanetEdge
        ULCStageExitCheck("bs 8")
        Return false
    }
    Sleep(50)

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
    Sleep(50)

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
        ; TODO Review this, its unreliable
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
    Sleep(50)
    Travel.ScrollResetToTop()
    Sleep(50)

    /** @type {Timer} */
    Limiter := Timer()
    Limiter.CoolDownS(30, &isactive)
    gToolTip.CenterCD("Waiting for Malachite unlock availability", 30000)
    While (cPoint(1683, 305).IsButton() && isactive) {
        cPoint(1683, 305).ClickButtonActive() ; Unlock Malachite
        GameKeys.TriggerWind()
        Sleep(17)
    }
    gToolTip.CenterCDDel()
    If (cPoint(1683, 305).IsButton()) {
        Return false
    }
    Return true
}

TimeWarpIfLackingBio(*) {
    UlcWindow()
    Global ULCBiotiteUseTW
    Switch (ULCBiotiteUseTW) {
    Case "30m":
        Use30minTimeWarp()
    Case "6h":
        Use6hTimeWarp()
    Case "24h":
        Use24hTimeWarp()
    Case "72h":
        Use72hTimeWarp()
    default:
        Use30minTimeWarp()
    }
    Travel.ClosePanelIfActive()
    Sleep(50)
    Shops.Biotite.GoTo()
    Sleep(50)
    Travel.ScrollResetToTop()
    Sleep(50)

    /** @type {Timer} */
    Limiter := Timer()
    Limiter.CoolDownS(45, &isactive)
    gToolTip.CenterCD("Waiting for Malachite unlock availability", 45000)
    While (cPoint(1683, 305).IsButton() && isactive) {
        cPoint(1683, 305).ClickButtonActive() ; Unlock Malachite
        GameKeys.TriggerWind()
        Sleep(50)
    }
    gToolTip.CenterCDDel()
    If (cPoint(1683, 305).IsButton()) {
        Return false
    }
    Return true
}

Use30minTimeWarp(*) {
    _UseATimeWarp("30m")
}

Use6hTimeWarp(*) {
    _UseATimeWarp("6h")
}

Use24hTimeWarp(*) {
    _UseATimeWarp("24h")
}

Use72hTimeWarp(*) {
    _UseATimeWarp("72h")
}

_UseATimeWarp(type := "30m") {
    UlcWindow()
    /** @type {cPoint} */
    TTtab := cPoint(1761, 1163)
    /** @type {cPoint} */
    BuyTW := 0
    /** @type {cPoint} */
    AvailableTW := 0
    Switch (ULCBiotiteUseTW) {
    Case "30m":
        Out.D("Use30minTimeWarp")
        BuyTW := cPoint(1592, 306)
        AvailableTW := cPoint(1744, 306)
    Case "6h":
        Out.D("Use6hTimeWarp")
        BuyTW := cPoint(1592, 420)
        AvailableTW := cPoint(1744, 420)
    Case "24h":
        Out.D("Use24hTimeWarp")
        BuyTW := cPoint(1592, 530)
        AvailableTW := cPoint(1744, 530)
    Case "72h":
        Out.D("Use72hTimeWarp")
        BuyTW := cPoint(1592, 645)
        AvailableTW := cPoint(1744, 645)
    default:
        Out.D("Use30minTimeWarp")
        BuyTW := cPoint(1592, 306)
        AvailableTW := cPoint(1744, 306)
    }
    Shops.OpenGemShop()
    TTtab.WaitUntilActiveButtonS(8)
    If (!TTtab.IsButtonActive()) {
        Out.I("Found no time travel button, exiting.")
        Global ULCStageExit := true
        Return
    }
    ; Navigate to Time Travel tab
    TTtab.Click(72)

    BuyTW.WaitUntilActiveButtonS(8)

    If (!AvailableTW.IsButtonActive()) {
        BuyTW.ClickButtonActive(, , 72)

        AvailableTW.WaitUntilActiveButtonS(8)

        AvailableTW.ClickButtonActive(, , 72)
        Sleep(100)
    } Else {
        AvailableTW.ClickButtonActive(, , 72)
        Sleep(100)
    }
}

WaitForMalaOrTimeout(*) {
    UlcWindow()
    Shops.Malachite.GoTo()
    Travel.ScrollResetToTop()
    Sleep(50)
    /** @type {Timer} */
    Limiter := Timer()
    Limiter.CoolDownS(5, &isactive)
    gToolTip.CenterCD("Waiting for Hematite unlock availability", 5000)
    While (cPoint(1691, 305).IsButton() && isactive) {
        cPoint(1691, 305).ClickButtonActive() ; unlock hema
        Sleep(50)
    }
    gToolTip.CenterCDDel()
}

WaitForHemaOrTimeout(*) {
    UlcWindow()
    If (!Shops.Hematite.GoTo()) {
        Out.I("Travel to Hematite shop failed, likely not unlocked.")
        Return false
    }
    Travel.ScrollResetToTop()
    Sleep(50)

    /** @type {Timer} */
    Limiter := Timer()
    Limiter.CoolDownS(10, &isactive)
    gToolTip.CenterCD("Waiting for Energy and Shards unlock availability", 10000)
    While (cPoint(1686, 311).IsButton() && isactive) {
        cPoint(1686, 311).ClickButtonActive() ; Unlock energy
        Sleep(150)
    }
    While (cPoint(1689, 532).IsButton() || cPoint(1688, 648).IsButton() ||
    cPoint(1686, 766).IsButton() && isactive) {
        cPoint(1689, 532).ClickButtonActive() ; Unlock ascension shards
        Sleep(50)
        cPoint(1688, 648).ClickButtonActive() ; Unlock fusion shards
        Sleep(50)
        cPoint(1686, 766).ClickButtonActive() ; Unlock transformation shards
        Sleep(50)
    }
    gToolTip.CenterCDDel()
    Return true
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

GoToDeathbook(*) {
    UlcWindow()
    Travel.TerrorGraveyard.GoTo()
    Sleep(100)
}

BuyDeathbook(*) {
    Out.I("BuyDeathbook")
    UlcWindow()
    Travel.ClosePanelIfActive()
    cPoint(1282, 622).Click() ; Open DB
    cPoint(1139, 376).WaitUntilButtonS(3)
    If (cPoint(1139, 376).IsButtonInactive()) {
        Out.D("Deathbook was not purchasable.")
        Return false
    }
    cPoint(1139, 376).ClickButtonActive() ; Unlock
    Sleep(50)
    cPoint(1139, 376).ClickButtonActive() ; Unlock
    Sleep(100)
    Return IsDeathbookUnlocked()
}

IsDeathbookUnlocked() {
    If (cPoint(362, 531).IsButton() || cPoint(442, 533).IsButton()) {
        Out.I("Deathbook unlocked")
        Return true
    }
    Return false
}
