#Requires AutoHotkey v2.0

#Include GameHotkeys.ahk

global DisableZoneChecks := false
global NavigateTime := 150
global LBRWindowTitle

/**
 * Open the areas panel
 * @param {bool} reset (optional): swaps tab to reset scroll
 * @param {number} extraDelay (optional): adds ms to the sleep timers
 */
OpenAreasPanel(reset := true, extraDelay := 0) {
    NavTime := NavigateTime + extraDelay
    if (NavigateTime < 72) {
        NavTime := 72 + extraDelay
    }
    OpenPets() ; Opens or closes another screen so that when areas
    ; is opened it doesn't close
    sleep(NavTime)
    OpenAreas() ; Open areas
    sleep(NavTime * 2)
    i := 0
    while (!Points.AreasPanel.Tab1.IsButtonActive() && i <= 4) {
        Log("OpenAreasPanel: Retry, could not see active button.")
        OpenAreas() ; Open areas if it still hasn't opened
        sleep(NavTime)
        i++
    }
    if (reset) {
        ResetAreaScroll()
    }
}

/**
 * Resets the scroll position on areas panel by swapping tabs
 * @param {number} extraDelay (optional): add ms to the sleep timers
 */
ResetAreaScroll(extraDelay := 0) {
    NavTime := NavigateTime + extraDelay
    if (NavigateTime < 72) {
        NavTime := 72 + extraDelay
    }
    ; Click Favourites
    Points.AreasPanel.Tab1.ClickOffset(, , NavTime)
    Sleep(NavTime)

    ; Click Back to default page to reset the scroll
    Points.AreasPanel.Tab2.ClickOffset(, , NavTime)
    Sleep(NavTime)

    ; Double click for redundancy
    Points.AreasPanel.Tab2.ClickOffset(, , NavTime)
    Sleep(NavTime)
}

/**
 * Scroll downwards in a panel by ticks
 * @param {number} amount (optional): default 1, amount to scroll in ticks
 * of mousewheel
 * @param {number} extraDelay (optional): add ms to the sleep timers
 */
ScrollAmountDown(amount := 1, extraDelay := 0) {
    while (amount > 0) {
        if (!IsWindowActive() || !IsPanelActive()) {
            break
        } Else {
            ControlClick(, LBRWindowTitle, , "WheelDown")
            Sleep(NavigateTime + extraDelay)
            amount--
        }
    }
}

/**
 * Scroll upwards in a panel by ticks
 * @param {number} amount (optional): default 1, amount to scroll in ticks
 * of mousewheel
 * @param {number} extraDelay (optional): add ms to the sleep timers
 */
ScrollAmountUp(amount := 1, extraDelay := 0) {
    while (amount > 0) {
        if (!IsWindowActive() || !IsPanelActive()) {
            break
        } Else {
            ControlClick(, LBRWindowTitle, , "WheelUp")
            Sleep(NavigateTime + extraDelay)
            amount--
        }
    }
}

/**
 * Opens the areas panel, events tab
 * @param {number} extraDelay (optional): add ms to the sleep timers
 */
OpenEventsAreasPanel(extraDelay := 0) {
    OpenAreasPanel(false, extraDelay)
    ; Click Favourites
    Points.AreasPanel.Tab1.ClickOffset(, , NavigateTime + extraDelay)
    Sleep(NavigateTime + extraDelay)

    ; Click the event tab
    Points.AreasPanel.Tab8.ClickOffset(, , NavigateTime + extraDelay)
    sleep(NavigateTime + extraDelay)

    ; Redundant click
    Points.AreasPanel.Tab8.ClickOffset(, , NavigateTime + extraDelay)
    sleep(NavigateTime + extraDelay)
}

/**
 * Opens the quark panel
 * @param {number} extraDelay (optional): add ms to the sleep timers
 */
OpenQuarkPanel(extraDelay := 0) {
    OpenAreasPanel(false, extraDelay)

    ; Quark tab
    Points.AreasPanel.Tab7.ClickOffset(, , NavigateTime + extraDelay)
    Sleep(NavigateTime + extraDelay)

    ; Redundant click
    Points.AreasPanel.Tab7.ClickOffset(, , NavigateTime + extraDelay)
    Sleep(NavigateTime + extraDelay)

    ScrollAmountUp(2)
    Sleep(NavigateTime + extraDelay)
}

IsAreaResetToGarden() {
    if (!Areas.AreasPanel.GardenReset.PixelSearch("0x4A9754")) {
        return false
    }
    return true
}

GoToHomeGarden() {
    if (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        return false
    }
    global DisableZoneChecks
    i := 0
    if (!DisableZoneChecks) {
        while (!IsAreaSampleColour("0x4A9754") && i <= 4) {
            Log("Traveling to Home Garden")
            OpenAreasPanel()
            fSlowClick(830, 158, NavigateTime) ; Click Home Garden button
            Sleep(NavigateTime)
            i++
        }
    }
    if (IsAreaSampleColour("0x4A9754")) {
        DebugLog("Travel success to Home Garden.")
        return true
    } else {
        Log("Traveling to Home Garden. Attempt to blind travel with"
            " slowed times.")
        OpenAreasPanel(, 200)
        fSlowClick(830, 158, NavigateTime + 200)
        Sleep(NavigateTime + 200)
        if (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            return true
        }
        if (IsAreaSampleColour("0x4A9754")) {
            DebugLog("Blind travel success to Home Garden.")
            return true
        } else {
            Log("Traveling to Home Garden failed, colour found was "
                GetAreaSampleColour())
            return false
        }
    }
}

GoToGF() {
    if (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        return false
    }
    global DisableZoneChecks
    i := 0
    if (!DisableZoneChecks) {
        while (!IsAreaSampleColour("0x121328") && i <= 4) {
            if (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                return false
            }
            Log("Traveling to Flame Brazier (Green Flame)")
            GoToAreaFireFieldsTab()
            fSlowClickRelL(1680, 820, NavigateTime) ; Open Flame Brazier (GF zone)
            if (NavigateTime > 151) { ; Need a longer delay to load the slower map
                sleep(NavigateTime)
            } else {
                sleep(151)
            }
            i++
        }
    }
    if (IsAreaSampleColour("0x121328")) {
        DebugLog("Travel success to Flame Brazier (Green Flame).")
        return true
    } else {
        Log("Traveling to Flame Brazier (Green Flame). Attempt to blind travel"
            " with slowed times.")
        GoToAreaFireFieldsTab(200)
        fSlowClickRelL(1680, 820, NavigateTime + 200) ; Open Flame Brazier (GF zone)
        Sleep(NavigateTime + 200)
        if (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            return true
        }
        if (IsAreaSampleColour("0x121328")) {
            DebugLog("Blind travel success to Flame Brazier (Green Flame).")
            return true
        } else {
            Log("Traveling to Flame Brazier (Green Flame) failed,"
                " colour found was " GetAreaSampleColour())
            return false
        }
    }
}

GoToSS() {
    if (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        return false
    }
    global DisableZoneChecks
    i := 0
    if (!DisableZoneChecks) {
        while (!IsAreaSampleColour("0x17190F") && i <= 4) {
            if (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                return false
            }
            Log("Traveling to Flame Universe (Soulseeker)")
            GoToAreaFireFieldsTab()
            fSlowClick(877, 516, NavigateTime) ; Open Flame Universe (SS zone)
            if (NavigateTime > 151) { ; Need a longer delay to load the slower map
                sleep(NavigateTime)
            } else {
                sleep(151)
            }
            i++
        }
    }
    if (IsAreaSampleColour("0x17190F")) {
        DebugLog("Travel success to Flame Universe (Soulseeker).")
        return true
    } else {
        Log("Traveling to Flame Universe (Soulseeker). Attempt to blind travel"
            " with slowed times.")
        GoToAreaFireFieldsTab(200)
        fSlowClick(877, 516, NavigateTime + 200) ; Open Flame Universe (SS zone)
        Sleep(NavigateTime + 200)
        if (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            return true
        }
        if (IsAreaSampleColour("0x17190F")) {
            DebugLog("Blind travel success to Flame Universe (Soulseeker).")
            return true
        } else {
            Log("Traveling to Flame Universe (Soulseeker) failed,"
                " colour found was " GetAreaSampleColour())
            return false
        }
    }
}

GoToShadowCavern() {
    if (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        return false
    }
    global DisableZoneChecks
    i := 0
    if (!DisableZoneChecks) {
        while (!IsAreaSampleColour("0x260000") && i <= 4) {
            if (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                return false
            }
            Log("Traveling to Shadow Cavern")
            GoToAreaFireFieldsTab()
            fSlowClick(880, 159, NavigateTime) ; Go to shadow cavern
            if (NavigateTime > 151) { ; Need a longer delay to load the slower map
                sleep(NavigateTime)
            } else {
                sleep(151)
            }
            i++
        }
    }
    if (IsAreaSampleColour("0x260000")) {
        DebugLog("Travel success to shadow cavern.")
        return true
    } else {
        Log("Traveling to Shadow Cavern. Attempt to blind travel with slowed"
            " times.")
        GoToAreaFireFieldsTab(200)
        fSlowClick(880, 159, NavigateTime + 200) ; Go to shadow cavern
        sleep(NavigateTime + 200)
        if (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            return true
        }
        if (IsAreaSampleColour("0x260000")) {
            DebugLog("Blind travel success to shadow cavern.")
            return true
        } else {
            Log("Traveling to Shadow Cavern failed, colour found was "
                GetAreaSampleColour())
            return false
        }
    }
}

GotoResetSS() {
    if (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        return false
    }
    GoToShadowCavern()
    ClosePanel() ; Close the panel to see borb
    sleep(NavigateTime)
    fSlowClick(880, 180, NavigateTime) ; Go to Borbiana Jones screen
    sleep(NavigateTime)
}

ResetSS() {
    GotoResetSS()
    fSlowClickRelL(1280, 500, NavigateTime) ; Reset SpectralSeeker
}

ResetGF() {
    GotoResetSS()
    fSlowClick(280, 245, NavigateTime) ; Reset Green Flame
}

GoToNatureBoss() {
    buttonX := 840
    buttonY := 459
    if (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        return false
    }
    global DisableZoneChecks
    i := 0
    if (!DisableZoneChecks) {
        while (!IsAreaSampleColour("0x090B10") && i <= 4) {
            if (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                return false
            }
            Log("Traveling to The Doomed Tree")
            OpenEventsAreasPanel()
            Sleep(NavigateTime)
            if (!cPoint(WinRelPosW(buttonX), WinRelPosH(buttonY), true).IsBackground()) {
                ; Open nature boss area
                fSlowClick(buttonX, buttonY, NavigateTime)
            } else {
                Log("Nature event inactive, no button found.")
                return false
            }
            Sleep(NavigateTime)
            i++
        }
    }
    if (IsAreaSampleColour("0x090B10")) {
        DebugLog("Travel success to The Doomed Tree.")
        return true
    } else {
        Log("Traveling to The Doomed Tree. Attempt to blind travel with slowed"
            " times.")
        OpenEventsAreasPanel(200)
        Sleep(NavigateTime + 200)
        if (!cPoint(WinRelPosW(buttonX), WinRelPosH(buttonY), true).IsBackground()) {
            fSlowClick(buttonX, buttonY, NavigateTime + 200) ; Open nature boss area
        } else {
            Log("Nature event inactive, no button found.")
            return false
        }
        Sleep(NavigateTime + 200)
        if (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            return true
        }
        if (IsAreaSampleColour("0x090B10")) {
            DebugLog("Blind travel success to The Doomed Tree.")
            return true
        } else {
            Log("Traveling to The Doomed Tree failed, colour found was "
                GetAreaSampleColour())
            return false
        }
    }
}


GoToCheeseBoss() {
    buttonX := 840
    buttonY := 145
    if (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        return false
    }
    global DisableZoneChecks
    i := 0
    if (!DisableZoneChecks) {
        while (!IsAreaSampleColour("0x150412") && i <= 4) {
            if (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                return false
            }
            Log("Traveling to Cursed Halloween")
            OpenEventsAreasPanel()
            Sleep(NavigateTime)
            if (!cPoint(WinRelPosW(buttonX), WinRelPosH(buttonY), true).IsBackground()) {
                fSlowClick(buttonX, buttonY, NavigateTime) ; Open Cheese boss area
            } else {
                Log("Halloween event inactive, no button found.")
                return false
            }
            Sleep(NavigateTime)
            i++
        }
    }
    if (IsAreaSampleColour("0x150412")) {
        DebugLog("Travel success to Cursed Halloween.")
        return true
    } else {
        Log("Traveling to Cursed Halloween. Attempt to blind travel with slowed"
            " times.")
        OpenEventsAreasPanel(200)
        Sleep(NavigateTime + 200)
        if (!cPoint(WinRelPosW(buttonX), WinRelPosH(buttonY), true).IsBackground()) {
            fSlowClick(buttonX, buttonY, NavigateTime + 200) ; Open Cheese boss area
        } else {
            Log("Halloween event inactive, no button found.")
            return false
        }
        Sleep(NavigateTime + 200)
        if (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            return true
        }
        if (IsAreaSampleColour("0x150412")) {
            DebugLog("Blind travel success to Cursed Halloween.")
            return true
        } else {
            Log("Traveling to Cursed Halloween, colour found was "
                GetAreaSampleColour())
            return false
        }
    }
}

GoToFarmField() {
    buttonX := 840
    buttonY := 255
    if (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        return false
    }
    global DisableZoneChecks
    ; Of course i get this working then find a better way
    i := 0
    ; This ones messy because the colour matches home garden
    if (!DisableZoneChecks) {
        Log("Traveling to Farm Field")
        ; If farmfields we'll see the green + timer
        if (IsAreaSampleColour("0x4A9754") && IsBossTimerActive()) {
            Sleep(NavigateTime)
            return true
        }
        ; If we're at home garden attempt to travel, boss timer should appear,
        ; breaking
        while ((IsAreaSampleColour("0x4A9754") && !IsBossTimerActive())
            && i <= 4) {
            if (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                return false
            }
            OpenEventsAreasPanel()
            if (cPoint(WinRelPosW(buttonX), WinRelPosH(buttonY), true).IsBackground()) {
                return false
            }
            fSlowClick(buttonX, buttonY, NavigateTime) ; Open farm field
            Sleep(NavigateTime)
            i++
        }
        ; If we were not at home garden or now farm field, try travel
        while (!IsAreaSampleColour("0x4A9754") && i <= 4) {
            OpenEventsAreasPanel()
            if (cPoint(WinRelPosW(buttonX), WinRelPosH(buttonY), true).IsBackground()) {
                return false
            }
            fSlowClick(buttonX, buttonY, NavigateTime) ; Open farm field
            Sleep(NavigateTime)
            i++
        }
    }
    if (IsAreaSampleColour("0x4A9754") && IsBossTimerActive()) {
        DebugLog("Travel success to Farm Field.")
        return true
    } else {
        Log("Traveling to Farm Field. Attempt to blind travel with slowed"
            " times.")
        OpenEventsAreasPanel(200)
        if (cPoint(WinRelPosW(buttonX), WinRelPosH(buttonY), true).IsBackground()) {
            return false
        }
        fSlowClick(buttonX, buttonY, NavigateTime + 200) ; Open farm field
        Sleep(NavigateTime + 200)
        if (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            return true
        }
        if (IsAreaSampleColour("0x4A9754")) {
            DebugLog("Blind travel success to Farm Field.")
            return true
        } else {
            Log("Traveling to Farm Field failed, colour found was "
                GetAreaSampleColour())
            return false
        }
    }
}

GoToAstralOasis() {
    if (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        return false
    }
    global DisableZoneChecks
    i := 0
    button := cPoint(1665, 643)
    if (!DisableZoneChecks) {
        while (!IsAreaSampleColour("0x000108") && i <= 4) {
            if (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                return false
            }
            Log("Traveling to Astral Oasis (Quark Boss 1)")
            OpenQuarkPanel()
            if (!button.IsBackground()) {
                button.ClickOffset(5, 0, NavigateTime)
            } else {
                button.ClickOffset(5, 37, NavigateTime)
            }
            Sleep(NavigateTime)
            i++
        }
    }
    if (IsAreaSampleColour("0x000108")) {
        DebugLog("Blind travel success to Astral Oasis (Quark Boss 1).")
        return true
    } else {
        Log("Traveling to Astral Oasis (Quark Boss 1). Attempt to blind travel"
            " with slowed times.")
        OpenQuarkPanel(200)
        if (!button.IsBackground()) {
            button.ClickOffset(5, 0, NavigateTime + 200)
        } else {
            button.ClickOffset(5, 37, NavigateTime + 200)
        }
        Sleep(NavigateTime + 200)
        if (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            return true
        }
        if (IsAreaSampleColour("0x000108")) {
            DebugLog("Blind travel success to Astral Oasis (Quark Boss 1).")
            return true
        } else {
            Log("Traveling to Astral Oasis (Quark Boss 1) failed, colour"
                " found was " GetAreaSampleColour())
            return false
        }
    }
}

GoToDimentionalTapestry() {
    if (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        return false
    }
    global DisableZoneChecks
    i := 0
    button := cPoint(1665, 820)
    if (!DisableZoneChecks) {
        while (!IsAreaSampleColour("0x37356B") && i <= 4) {
            if (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                return false
            }
            Log("Traveling to Dimentional Tapestry (Quark Boss 2)")
            OpenQuarkPanel()
            if (!button.IsBackground()) {
                button.ClickOffset(5, 0, NavigateTime)
            } else {
                button.ClickOffset(5, 40, NavigateTime)
            }
            Sleep(NavigateTime)
            i++
        }
    }
    if (IsAreaSampleColour("0x37356B")) {
        DebugLog("Travel success to Dimentional Tapestry (Quark Boss 2).")
        return true
    } else {
        Log("Traveling to Dimentional Tapestry (Quark Boss 2). Attempt to"
            " blind travel with slowed times.")
        OpenQuarkPanel(200)
        if (!button.IsBackground()) {
            button.ClickOffset(5, 0, NavigateTime + 200)
        } else {
            button.ClickOffset(5, 40, NavigateTime + 200)
        }
        Sleep(NavigateTime + 200)
        if (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            return true
        }
        if (IsAreaSampleColour("0x37356B")) {
            DebugLog("Blind travel success to Dimentional Tapestry (Quark Boss 2).")
            return true
        } else {
            Log("Traveling to Dimentional Tapestry (Quark Boss 2) failed,"
                " colour found was " GetAreaSampleColour())
            return false
        }
    }
}

GoToPlankScope() {
    if (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        return false
    }
    global DisableZoneChecks
    i := 0
    if (!DisableZoneChecks) {
        while (!IsAreaSampleColour("0x0B1E32") && i <= 4) {
            if (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                return false
            }
            Log("Traveling to Plank Scope (Quark Boss 3)")
            OpenQuarkPanel()
            button := cPoint(1665, 970)
            if (!button.IsBackground()) {
                button.ClickOffset(5, 0, NavigateTime)
                fSlowClickRelL(1670, 970, NavigateTime + 200)
            } else {
                button.ClickOffset(5, 50, NavigateTime)
                fSlowClickRelL(1670, 1020, NavigateTime + 200)
            }
            Sleep(NavigateTime)
            i++
        }
    }
    if (IsAreaSampleColour("0x0B1E32")) {
        DebugLog("Travel success to Plank Scope (Quark Boss 3).")
        return true
    } else {
        Log("Traveling to Plank Scope (Quark Boss 3). Attempt to blind travel"
            " with slowed times.")
        OpenQuarkPanel(200)
        if (!button.IsBackground()) {
            button.ClickOffset(5, 0, NavigateTime + 200)
        } else if (!cPoint(1665, 1020).IsBackground()) {
            button.ClickOffset(5, 50, NavigateTime + 200)
        }
        Sleep(NavigateTime + 200)
        if (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            return true
        }
        if (IsAreaSampleColour("0x0B1E32")) {
            DebugLog("Blind travel success to Plank Scope (Quark Boss 3).")
            return true
        } else {
            Log("Traveling to Plank Scope (Quark Boss 3) failed, colour"
                " found was " GetAreaSampleColour())
            return false
        }
    }
}

SingleAnteLeaftonTravel(extradelay := 0) {
    if (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        return false
    }
    Log("Traveling to Ante Leafton")
    if (IsPanelActive()) {
        ClosePanel()
        Sleep(NavigateTime)
    }
    OpenQuarkPanel(extradelay)
    ScrollAmountDown(2)
    button := cPoint(1665, 970)
    if (!button.IsBackground()) {
        button.ClickOffset(5, 0, NavigateTime + extradelay)
    } else {
        button.ClickOffset(5, 50, NavigateTime + extradelay)
    }
    Sleep(NavigateTime)
}

GoToAnteLeafton() {
    if (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        return false
    }
    global DisableZoneChecks
    i := 0
    if (!DisableZoneChecks) {
        while (!IsAreaBlack() || !IsBossTimerActive() && i <= 4) {
            if (!SingleAnteLeaftonTravel()) {
                return false
            }
            i++
        }
        if (IsAreaBlack() && IsBossTimerActive()) {
            DebugLog("Travel success to Ante Leafton.")
            return true
        }
    }
    if (!IsAreaBlack() || !IsBossTimerActive()) {
        Log("Traveling to Ante Leafton. Attempt to blind travel"
            " with slowed times.")
        SingleAnteLeaftonTravel(200)
        if (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            return true
        }
        if (IsAreaSampleColour("0x000000")) {
            DebugLog("Blind travel success to Ante Leafton.")
            return true
        } else {
            Log("Traveling to Ante Leafton failed, colour"
                " found was " GetAreaSampleColour())
            return false
        }
    }
}


GotoCardsFirstTab() {
    if (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        return false
    }
    global DisableZoneChecks
    i := 0
    if (!DisableZoneChecks) {
        while (!IsOnCardsFirstPanel() && IsWindowActive() && i <= 4) {
            if (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                return false
            }
            Log("Opening cards, packs (first) tab.")
            OpenPets() ; Toggle alt panel to cleanup old panels
            Sleep(NavigateTime)
            OpenCards()
            Sleep(NavigateTime)
            fSlowClick(202, 574, NavigateTime)
            ; Open first tab incase wrong tab
            Sleep(NavigateTime)
            i++
        }
    }
    if (IsOnCardsFirstPanel()) {
        DebugLog("Travel success to Cards First Tab.")
        return true
    } else {
        ; Attempt to blind travel with slowed times
        Log("Opening cards, packs (first) tab. Attempt to blind travel with"
            " slowed times.")
        OpenPets() ; Toggle alt panel to cleanup old panels
        Sleep(NavigateTime + 200)
        OpenCards()
        Sleep(NavigateTime + 200)
        fSlowClick(202, 574, NavigateTime + 200)
        ; Open first tab incase wrong tab
        Sleep(NavigateTime + 200)
        if (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            return true
        }
        if (IsOnCardsFirstPanel()) {
            DebugLog("Blind travel success to Cards First Tab.")
            return true
        } else {
            Log("GotoCardsFirstTab: Not at cards first tab")
            return false
        }
    }
}

IsOnCardsFirstPanel() {
    if (cPoint(2129, 420).IsButtonActive()) {
        return true
    }
    return false
}

GoToAreaFireFieldsTab(extraDelay := 0) {
    i := 0
    OpenAreasPanel(false, extraDelay)
    fSlowClick(200, 574, NavigateTime + extraDelay) ; Click Favourites
    Sleep(NavigateTime + extraDelay)
    fSlowClick(686, 574, NavigateTime + extraDelay) ; Open Fire Fields tab
    sleep(NavigateTime + extraDelay)
    fSlowClick(686, 574, NavigateTime + extraDelay) ; Open Fire Fields tab
    sleep(NavigateTime + extraDelay)
}

GotoBorbventuresFirstTab() {
    OpenPets() ; Opens or closes another screen so that when areas is opened it
    ; doesn't close
    Sleep(101)
    OpenBorbVentures() ; Open BV
    Sleep(101)
    BVResetScroll()
    i := 0
    while (!IsButtonActive(WinRelPosLargeW(1100), WinRelPosLargeH(314)) &&
        !IsButtonActive(WinRelPosLargeW(1574), WinRelPosLargeH(314)) &&
        i <= 4) {
        OpenPets() ; Opens or closes another screen so that when areas is opened it
        ; doesn't close
        Sleep(101)
        OpenBorbVentures() ; Open BV
        Sleep(101)
        BVResetScroll()
        i++
    }
    if (IsButtonActive(WinRelPosLargeW(1100), WinRelPosLargeH(314)) &&
        IsButtonActive(WinRelPosLargeW(1574), WinRelPosLargeH(314))) {
        DebugLog("Travel success to Borbventures First Tab.")
        return true
    }
    Log("Failed to travel to borbventures first tab")
    return false
}

BVResetScroll() {
    ; Double up due to notifications
    fSlowClick(315, 574, 72) ; Click borbs tab to reset scroll
    fSlowClick(315, 574, 72) ; Redundant for stability
    Sleep(72)
    fSlowClick(200, 574, 72) ; Click borbventures
    fSlowClick(200, 574, 72) ; Redundant for stability
    Sleep(72)
}

GoToLeafTower() {
    OpenAreasPanel()
    ScrollAmountDown(16) ; Scroll down for the zones
    Sleep(101)

    ; Look for colour of a segment of the rightmost tower leaf c5d8e0
    try {
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(1563), WinRelPosLargeH(430),
            WinRelPosLargeW(1604), WinRelPosLargeH(964), "0xC5D8E0", 0)
        ; Leaf pixel search
        If (!found || OutX = 0) {
            ; Not found
            Log("TowerBoost: Could not find tower zone.")
            return false
        }
    } catch as exc {
        Log("Error 29: Tower leaf detection failed. Alignment1 - "
            exc.Message)
        MsgBox("Alignment issue 1, could not conduct the search due to the"
            " following error:`n" exc.Message)
    }
    ; Found at 1595x778 (1440)
    ; 1664 800 < tower floor zone Relative: 69 22
    ; 2066 865 < Max floor button Relative: 471 87
    ; 1664 646 < Leaksink Relative: 69 -132

    ; Open leafsing harbor to allow max level reset
    if (IsBackground(OutX + WinRelPosLargeW(69),
        OutY - WinRelPosLargeH(132))) {
        ; Background colour found
        Log("Error 30: Tower alt area detection failed. Alignment2.")
        return false
    }
    fCustomClick(OutX + WinRelPosLargeW(69),
        OutY - WinRelPosLargeH(132), 101)
    Sleep(101)

    ; Max Tower level
    if (!cPoint(OutX + WinRelPosLargeW(471),
        OutY + WinRelPosLargeH(67), true).IsButtonActive()) {
        Log("Error 31: Tower max detection failed. Alignment3.")
        return false
    }
    fCustomClick(OutX + WinRelPosLargeW(471),
        OutY + WinRelPosLargeH(67), 101)
    Sleep(101)

    ; Select Tower area
    if (!cPoint(OutX + WinRelPosLargeW(69),
        OutY + WinRelPosLargeH(5), true).IsButtonActive()) {
        Log("Error 32: Tower area detection failed. Could not find "
            " Leaf Tower Travel Button.")
        return
    }
    fCustomClick(OutX + WinRelPosLargeW(69),
        OutY + WinRelPosLargeH(5), 101)
    Sleep(101)
}

IsAreaSampleColour(targetColour := "0xFFFFFF") {
    try {
        ; Have to sample the corner to get a reliable pixel colour
        sampleColour := PixelGetColor(WinRelPosLargeW(0), WinRelPosLargeH(0))
        If (sampleColour = targetColour) {
            ; Found target colour
            return true
        }
    } catch as exc {
        Log("Error 12: IsAreaSampleColour failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    if (Debug) {
        Log("IsAreaSampleColour: Not in target area, colour: " sampleColour)
    }
    return false
}

GetAreaSampleColour() {
    try {
        ; Have to sample the corner to get a reliable pixel colour
        sampleColour := PixelGetColor(WinRelPosLargeW(0), WinRelPosLargeH(0))
    } catch as exc {
        Log("Error 13: GetAreaSampleColour failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return sampleColour
}

IsAreaFlameBrazier() {
    if (GetAreaSampleColour() = "0x121328") {
        return true
    }
    return false
}

IsAreaTheFireUniverse() {
    if (GetAreaSampleColour() = "0x17190F") {
        return true
    }
    return false
}

IsAreaGFOrSS() {
    local col := GetAreaSampleColour()
    if (col = "0x121328" || col = "0x17190F") {
        return true
    }
    return false
}

IsAreaBlack() {
    local col := GetAreaSampleColour()
    if (col = "0x000000") {
        return true
    }
    return false
}

; IsAreaSampleColour samples:
/*
0x4A9754 Home Garden (non unique)
0x3B8D43 Neighbors' Garden
0xA2C6CB Mountain
0x000004 Space
0x231A29 THE VOID
0x232222 The Abyss
0x7BB4D4 The Celestial Plane
0x384832 The Mythical Garden
0x292524 The Volcano
0xAEBCCC The Abandoned Research Station
0x002C5A The Hidden Sea
0x283C5D Leafsink Harbor
0x11151F The Leaf Tower
0x161720 The Moon
0xAC816B The Infernal Desert (non unique)
0xAC816B The Cursed Pyramid (non unique)
0x191516 The Inner Cursed Pyramid
0x001031 Kokkaupunki
0x000000 Cursed Kokkaupunki (non unique)
0x000000 The Dark Glade (non unique)
0x325211 Black Leaf Hole
0x121619 Dicey Meadows
0x161419 Glinting Thicket
0x492604 The Cheese Pub
0x20170D Your House
0x0C1911 Biotite Forest
0x000000 The Exalted Bridge (non unique)
0x257078 The Ancient Sanctum
0x0F1D1F Vilewood Cemetery
0x8C7B61 The Lone Tree
0x030607 Spark Range
0x201532 Spark Bubble
0x09010D Spark Portal
0x021721 Energy Shrine
0x151A32 Plasma Forest
0x02060D Blue Planet Edge
0x000300 Green Planet Edge
0x020000 Red Planet Edge
0x010007 Purple Planet Edge
0x000000 Black Planet Edge (non unique)
0x20191B Terror Graveyard
0x1A1A31 Energy Singularity
0x1F1509 Fire Fields Portal
0x260000 The Shadow Cavern
0x841E11 Mount Moltenfurty
0x291F31 The Fire Temple
0x121328 Flame Brazier
0x17190F Fire Universe
0x05050B Soul Portal
0x030706 Soul Temple
0x1C1C31 Soul Crypt
0x170F24 The Hollow
0x02030D Soul Forge
0x110B1B The Fabric of the Leafverse
0x000000 Quark Portal (non unique)
0x00000A Quark Nexus
0x131119 Quantum Aether
0x000108 Astral Oasis
0x37356B Dimensional Tapestry
0x0B1E32 Planck Scope
0x150412 Cursed Halloween
0x4A9754 Farm Field (non unique)
0x4A9754 Butterfly Field (non unique)
0x4A9754 Vial of Life (non unique)
0x090B10 The Doomed Tree

*/
