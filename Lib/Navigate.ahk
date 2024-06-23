#Requires AutoHotkey v2.0

#Include ..\Lib\cHotkeysInitGame.ahk
#Include ..\Lib\cHotkeysInitScript.ahk

global DisableZoneChecks := false
global NavigateTime := 150
global LBRWindowTitle

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
    Travel.OpenAreas(false, extraDelay)
    ; Click Favourites
    Points.Areas.Favs.Tab.ClickOffset(, , NavigateTime + extraDelay)
    Sleep(NavigateTime + extraDelay)

    ; Click the event tab
    Points.Areas.Events.Tab.ClickOffset(, , NavigateTime + extraDelay)
    sleep(NavigateTime + extraDelay)

    ; Redundant click
    Points.Areas.Events.Tab.ClickOffset(, , NavigateTime + extraDelay)
    sleep(NavigateTime + extraDelay)
}

/**
 * Opens the quark panel
 * @param {number} extraDelay (optional): add ms to the sleep timers
 */
OpenQuarkPanel(extraDelay := 0) {
    Travel.OpenAreas(false, extraDelay)

    ; Quark tab
    Points.Areas.QuarkA.Tab.ClickOffset(, , NavigateTime + extraDelay)
    Sleep(NavigateTime + extraDelay)

    ; Redundant click
    Points.Areas.QuarkA.Tab.ClickOffset(, , NavigateTime + extraDelay)
    Sleep(NavigateTime + extraDelay)

    ScrollAmountUp(2)
    Sleep(NavigateTime + extraDelay)
}

IsAreaResetToGarden() {
    if (!Areas.Areas.GardenReset.PixelSearch("0x4A9754")) {
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
            Travel.OpenAreas()
            ; Click Home Garden button
            cPoint(1662, 325).Click(NavigateTime)
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
        Travel.OpenAreas(true, 200)
        cPoint(1662, 325).Click(NavigateTime + 200)
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

            ; Open Flame Brazier (GF zone)
            fSlowClickRelL(1680, 947, NavigateTime)

            ; Need a longer delay to load the slower map
            if (NavigateTime > 201) {
                sleep(NavigateTime)
            } else {
                sleep(201)
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
        fSlowClickRelL(1680, 947, NavigateTime + 200) ; Open Flame Brazier (GF zone)
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
            ScrollAmountDown(2, NavigateTime)
            fSlowClickRelL(1680, 988, NavigateTime) ; Open Flame Universe (SS zone)
            if (NavigateTime > 201) { ; Need a longer delay to load the slower map
                sleep(NavigateTime)
            } else {
                sleep(201)
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
        ScrollAmountDown(2, NavigateTime + 200)
        fSlowClickRelL(1680, 988, NavigateTime + 200) ; Open Flame Universe (SS zone)
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
            fSlowClickRelL(1670, 320, NavigateTime) ; Go to shadow cavern
            if (NavigateTime > 201) { ; Need a longer delay to load the slower map
                sleep(NavigateTime)
            } else {
                sleep(201)
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
        fSlowClickRelL(1670, 320, NavigateTime + 200) ; Go to shadow cavern
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
    if (IsPanelActive()) {
        GameKeys.ClosePanel() ; Close the panel to see borb
        sleep(NavigateTime)
    }
    button := cPoint(1735, 397)
    Log(button.GetColour())
    ; Go to Borbiana Jones screen
    if (button.IsColour("0x60F811")) {
        button.Click(NavigateTime)
        sleep(NavigateTime)
    }
}

ResetSS() {
    GotoResetSS()
    ; Reset SpectralSeeker
    button := cPoint(1280, 500)
    if (button.IsButtonActive()) {
        button.Click(NavigateTime)
    }
}

ResetGF() {
    GotoResetSS()
    ; Reset Green Flame
    button := cPoint(820, 500)
    if (button.IsButtonActive()) {
        button.Click(NavigateTime)
    }
}

GoToNatureBoss() {
    button := cPoint(1682, 946)
    button2 := cPoint(1682, 860)

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
            while (!IsOnEventAreaPanel()) {
                OpenEventsAreasPanel(100)
            }
            Sleep(NavigateTime)
            if (!NatureBossButtonClick()) {
                Log("Nature event inactive, no button found.")
                return false
            }
            if (NavigateTime < 201) {
                Sleep(201)
            } else {
                Sleep(NavigateTime)
            }
            i++
        }
    }
    if (IsAreaSampleColour("0x090B10")) {
        DebugLog("Travel success to The Doomed Tree.")
        return true
    } else {
        Log("Traveling to The Doomed Tree. Attempt to blind travel with slowed"
            " times.")
        while (!IsOnEventAreaPanel()) {
            OpenEventsAreasPanel(200)
        }
        Sleep(NavigateTime + 200)
        if (!NatureBossButtonClick()) {
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

NatureBossButtonClick() {
    button := cPoint(1682, 946)
    button2 := cPoint(1682, 860)
    if (button.IsButton()) {
        button.Click(100)
        return true
    } else if (button2.IsButton()) {
        button2.Click(100)
        return true
    } else {
        return false
    }
}

IsOnEventAreaPanel() {
    button := cPoint(1682, 946)
    button2 := cPoint(1682, 860)
    if (button.IsButton()) {
        return true
    } else if (button2.IsButton()) {
        return true
    } else {
        return false
    }
}

GoToCheeseBoss() {
    button := cPoint(1682, 298)
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
            if (!button.IsBackground()) {
                ; Open Cheese boss area
                button.Click(NavigateTime)
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
        if (!button.IsBackground()) {
            ; Open Cheese boss area
            button.Click(NavigateTime + 200)
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
    button := cPoint(1682, 525)
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
            if (button.IsBackground()) {
                return false
            }
            ; Open farm field
            button.Click(NavigateTime)
            Sleep(NavigateTime)
            i++
        }
        ; If we were not at home garden or now farm field, try travel
        while (!IsAreaSampleColour("0x4A9754") && i <= 4) {
            OpenEventsAreasPanel()
            if (button.IsBackground()) {
                return false
            }
            ; Open farm field
            button.Click(NavigateTime)
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
        if (button.IsBackground()) {
            return false
        }
        ; Open farm field
        button.Click(NavigateTime + 200)
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
        GameKeys.ClosePanel()
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
            Travel.OpenCards()
            Sleep(NavigateTime)
            cPoint(404, 1183).Click(NavigateTime)
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
        Travel.OpenCards(, 200)
        Sleep(NavigateTime + 200)
        cPoint(404, 1183).Click(NavigateTime + 200)
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
    Travel.OpenAreas(false, extraDelay)

    ; Click Favourites
    Points.Areas.Favs.Tab.Click(NavigateTime + extraDelay)
    Sleep(NavigateTime + extraDelay)

    ; Open Fire Fields tab
    Points.Areas.FireF.Tab.Click(NavigateTime + extraDelay)
    sleep(NavigateTime + extraDelay)

    ; Repeat
    Points.Areas.FireF.Tab.Click(NavigateTime + extraDelay)
    sleep(NavigateTime + extraDelay)
}

; TODO Move this to cTravel or cZone
GotoBorbventuresFirstTab() {
    Travel.OpenBorbVentures() ; Open BV
    Sleep(101)
    BVResetScroll()
    i := 0
    while (!cPoint(1100, 314).IsButtonActive() &&
        !cPoint(1574, 314).IsButtonActive() &&
        i <= 4) {
        Travel.OpenBorbVentures() ; Open BV
        Sleep(101)
        BVResetScroll()
        i++
    }
    if (cPoint(1100, 314).IsButtonActive() &&
        cPoint(1574, 314).IsButtonActive()) {
        DebugLog("Travel success to Borbventures First Tab.")
        return true
    }
    Log("Failed to travel to borbventures first tab")
    return false
}

BVResetScroll() {
    ; Double up due to notifications
    cPoint(630, 1183).Click(72) ; Click borbs tab to reset scroll
    cPoint(630, 1183).Click(72) ; Redundant for stability
    Sleep(72)
    cPoint(400, 1183).Click(72) ; Click borbventures
    cPoint(400, 1183).Click(72) ; Redundant for stability
    Sleep(72)
}

GoToLeafTower() {
    Travel.OpenAreas()
    ScrollAmountDown(16) ; Scroll down for the zones
    Sleep(101)

    ; Leaf pixel search
    ; Look for colour of a segment of the rightmost tower leaf c5d8e0
    spot := cArea(1563, 430, 1615, 964).PixelSearch("0xC5D8E0")
    if (!spot) {
        ; Not found
        Log("TowerBoost: Could not find tower leaf to open area.")
        return false
    }
    LeafsingButton := cPoint(spot[1] + WinRelPosLargeW(69),
        spot[2] - WinRelPosLargeH(160), false)
    ; Open leafsing harbor to allow max level reset
    if (LeafsingButton.IsBackground()) {
        ; Background colour found
        Log("Error 30: Tower alt area detection failed. Alignment2.")
        return false
    }
    LeafsingButton.Click(101)
    Sleep(201)

    TowerMax := cPoint(spot[1] + WinRelPosLargeW(460),
        spot[2] + WinRelPosLargeH(60), false)
    ; Max Tower level
    if (!TowerMax.IsButtonActive()) {
        Log("Error 31: Tower max detection failed. Alignment3.")
        return false
    }
    TowerMax.Click(101)
    Sleep(101)

    TowerArea := cPoint(spot[1] + WinRelPosLargeW(69),
        spot[2] - WinRelPosLargeH(5), false)
    ; Select Tower area
    if (!TowerArea.IsButtonActive()) {
        Log("Error 32: Tower area detection failed. Could not find "
            " Leaf Tower Travel Button.")
        return
    }
    TowerArea.Click(101)
    Sleep(201)
}

IsAreaSampleColour(targetColour := "0xFFFFFF") {
    if (cPoint(0, 0).GetColour() = targetColour) {
        return true
    }
    return false
}

GetAreaSampleColour() {
    return cPoint(0, 0).GetColour()
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