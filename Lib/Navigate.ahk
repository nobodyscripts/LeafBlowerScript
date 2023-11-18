#Requires AutoHotkey v2.0

OpenAreasPanel(reset := true) {
    OpenPets() ; Opens or closes another screen so that when areas
    ; is opened it doesn't close
    sleep(NavigateTime)
    OpenAreas() ; Open areas
    sleep(NavigateTime)
    if (reset) {
        ResetAreaScroll()
        sleep(NavigateTime)
    }
}

ResetAreaScroll() {
    ; Double up due to notifications
    fSlowClick(200, 574, NavigateTime) ; Click Favourites
    Sleep(NavigateTime)
    fSlowClick(315, 574, NavigateTime) ; Click Back to default page to reset the scroll
    Sleep(NavigateTime)
}

ScrollAmountDown(amount := 1) {
    while amount > 0 {
        if (!IsWindowActive()) {
            break
        } Else {
            ControlClick(, "Leaf Blower Revolution", , "WheelDown")
            Sleep(NavigateTime)
            amount--
        }
    }
}

ScrollAmountUp(amount := 1) {
    while amount > 0 {
        if (!IsWindowActive()) {
            break
        } Else {
            ControlClick(, "Leaf Blower Revolution", , "WheelUp")
            Sleep(NavigateTime)
            amount--
        }
    }
}

OpenEventsAreasPanel() {
    OpenAreasPanel(false)
    fSlowClick(200, 574, NavigateTime) ; Click Favourites
    Sleep(NavigateTime)
    fSlowClick(1049, 572, NavigateTime) ; Click the event tab
    sleep(NavigateTime)
}

OpenQuarkPanel() {
    OpenAreasPanel()
    fSlowClickRelL(1780, 1180, NavigateTime) ; Quark tab
    Sleep(NavigateTime)
    ScrollAmountUp(2)
    Sleep(NavigateTime)
}

IsAreaResetToGarden() {
    try {
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(1240), WinRelPosLargeH(5),
            WinRelPosLargeW(1280), WinRelPosLargeH(40), "0x4A9754", 0)
        ; Timer pixel search
        If (found and OutX != 0) {
            return true ; Found colour
        }
    } catch as exc {
        Log("Error: IsAreaResetToGarden check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
}

GoToHomeGarden() {
    i := 0
    while (!IsAreaSampleColour("0x4A9754") || i >= 4) {
        Log("Traveling to Home Garden")
        OpenAreasPanel()
        fSlowClick(830, 158, NavigateTime)
        Sleep(NavigateTime)
        i++
    }
    return IsAreaSampleColour("0x4A9754")
}

GoToGF() {
    i := 0
    while (!IsAreaSampleColour("0x121328") || i >= 4) {
        Log("Traveling to Flame Brazier (Green Flame)")
        OpenAreasPanel(false)
        fSlowClick(200, 574, NavigateTime) ; Click Favourites
        Sleep(NavigateTime)
        fSlowClick(686, 574, NavigateTime) ; Open Fire Fields tab
        Sleep(NavigateTime)
        fSlowClick(877, 411, NavigateTime) ; Open Flame Brazier (GF zone)
        Sleep(NavigateTime)
        i++
    }
    return IsAreaSampleColour("0x121328")
}

GoToSS() {
    i := 0
    while (!IsAreaSampleColour("0x17190F") || i >= 4) {
        Log("Traveling to Flame Universe (Soulseeker)")
        OpenAreasPanel(false)
        fSlowClick(200, 574, NavigateTime) ; Click Favourites
        Sleep(NavigateTime)
        fSlowClick(686, 574, NavigateTime) ; Open Fire Fields tab
        Sleep(NavigateTime)
        fSlowClick(877, 516, NavigateTime) ; Open Flame Universe (SS zone)
        Sleep(NavigateTime)
        i++
    }
    return IsAreaSampleColour("0x17190F")
}

GoToShadowCavern() {
    i := 0
    while (!IsAreaSampleColour("0x260000") || i >= 4) {
        Log("Traveling to Shadow Cavern")
        OpenAreasPanel(false)
        fSlowClick(200, 574, NavigateTime) ; Click Favourites
        Sleep(NavigateTime)
        fSlowClick(686, 574, NavigateTime) ; Open Fire Fields tab
        sleep(NavigateTime)
        fSlowClick(880, 159, NavigateTime) ; Go to shadow cavern
        sleep(NavigateTime)
        i++
    }
    return IsAreaSampleColour("0x260000")
}

ResetSS() {
    GoToShadowCavern()
    ClosePanel() ; Close the panel to see borb
    sleep(NavigateTime)
    fSlowClick(880, 180, NavigateTime) ; Go to Borbiana Jones screen
    sleep(NavigateTime)
    fSlowClick(517, 245, NavigateTime) ; Reset SpectralSeeker
}

ResetGF() {
    GoToShadowCavern()
    ClosePanel() ; Close the panel to see borb
    sleep(NavigateTime)
    fSlowClick(880, 180, NavigateTime) ; Go to Borbiana Jones screen
    sleep(NavigateTime)
    fSlowClick(280, 245, NavigateTime) ; Reset Green Flame
}

GoToNatureBoss() {
    i := 0
    while (!IsAreaSampleColour("0x17190F") || i >= 4) {
        Log("Traveling to The Doomed Tree")
        OpenEventsAreasPanel()
        Sleep(NavigateTime)
        if (IsBackground(WinRelPosW(875), WinRelPosH(470))) {
            fSlowClick(875, 470, NavigateTime) ; Open nature boss area
            return false
        }
        Sleep(NavigateTime)
        i++
    }
    return IsAreaSampleColour("0x17190F")
}

GoToFarmField() {
    ; Of course i get this working then find a better way
    i := 0
    ; This ones messy because the colour matches home garden
    Log("Traveling to Farm Field")
    ; If farmfields we'll see the green + timer
    if (IsAreaSampleColour("0x4A9754") && IsBossTimerActive()) {
        Sleep(NavigateTime)
        return true
    }
    ; If we're at home garden attempt to travel, boss timer should appear, breaking
    while ((IsAreaSampleColour("0x4A9754") && !IsBossTimerActive())
        || i >= 4) {
            OpenEventsAreasPanel()
            if (IsBackground(WinRelPosW(875), WinRelPosH(260))) {
                return false
            }
            fSlowClick(875, 260, NavigateTime) ; Open farm field
            Sleep(NavigateTime)
            i++
    }
    ; If we were not at home garden or now farm field, try travel
    while (!IsAreaSampleColour("0x4A9754") || i >= 4) {
        OpenEventsAreasPanel()
        if (IsBackground(WinRelPosW(875), WinRelPosH(260))) {
            return false
        }
        fSlowClick(875, 260, NavigateTime) ; Open farm field
        Sleep(NavigateTime)
        i++
    }
    if (!IsAreaSampleColour("0x4A9754")) {
        return false
    }
    Sleep(NavigateTime)
    return true
}

GoToDesert() {
    Log("Traveling to The Infernal Desert")
    i := 0
    ; Advantage of this sample check is script doesn't travel if already there
    ; and can recheck if travels failed
    while (!(IsAreaSampleColour("0xAC816B") && !IsBossTimerActive()) || i >= 4) {
        OpenAreasPanel(true)
        ScrollAmountDown(23) ; Scroll down for the zones 0xAC816B
        Sleep(NavigateTime)
        DesertLeaf := FindDesertZone()
        if (DesertLeaf) {
            ButtonX := DesertLeaf[1] + WinRelPosLargeW(225)
            ButtonY := DesertLeaf[2] + WinRelPosLargeW(30)
            if (!IsBackground(ButtonX, ButtonY)) {
                fCustomClick(ButtonX, ButtonY, NavigateTime) ; Set zone to The Infernal Desert
            }
        }
        Sleep(NavigateTime) ; Delay to allow the map to change, otherwise we travel twice
        i++
    }
    return IsAreaSampleColour("0xAC816B")
}

GoToAstralOasis() {
    i := 0
    while (!IsAreaSampleColour("0x000108") || i >= 4) {
        Log("Traveling to Astral Oasis (Quark Boss 1)")
        OpenQuarkPanel()
        fSlowClickRelL(840, 670, NavigateTime)
        Sleep(NavigateTime)
        i++
    }
    return IsAreaSampleColour("0x000108")
}

GoToDimentionalTapestry() {
    i := 0
    while (!IsAreaSampleColour("0x37356B") || i >= 4) {
        Log("Traveling to Dimentional Tapestry (Quark Boss 2)")
        OpenQuarkPanel()
        fSlowClickRelL(840, 838, NavigateTime)
        Sleep(NavigateTime)
        i++
    }
    return IsAreaSampleColour("0x37356B")
}

GoToPlankScope() {
    i := 0
    while (!IsAreaSampleColour("0x0B1E32") || i >= 4) {
        Log("Traveling to Plank Scope (Quark Boss 3)")
        OpenQuarkPanel()
        ; Litterally only 1 pixel overlaps between font size 0/1
        ; This really needs a image search
        fSlowClickRelL(840, 988, NavigateTime)
        Sleep(NavigateTime)
        i++
    }
    return IsAreaSampleColour("0x0B1E32")
}

GotoCardsFirstTab() {
    i := 0
    while (!IsOnCardsFirstPanel() && IsWindowActive() && i <= 4) {
        Log("Opening cards, packs (first) tab.")
        OpenPets() ; Toggle alt panel to cleanup old panels
        Sleep(NavigateTime)
        OpenCards()
        Sleep(NavigateTime)
        fSlowClick(202, 574, NavigateTime) ; Open first tab incase wrong tab
        Sleep(NavigateTime)
        i++
    }
    Sleep(NavigateTime)
    return IsOnCardsFirstPanel()
}

IsOnCardsFirstPanel() {
    if (IsButtonActive(WinRelPosLargeW(2129), WinRelPosLargeH(383))) {
        return true
    }
    return false
}

IsAreaSampleColour(targetColour := "0xFFFFFF") {
    try {
        ; Have to sample the corner to get a reliable pixel colour
        sampleColour := PixelGetColor(WinRelPosLargeW(0), WinRelPosLargeH(0))
        If (sampleColour = targetColour) {
            ; Found target colour
            Log("IsAreaSampleColour: Found colour " sampleColour)
            return true
        }
    } catch as exc {
        Log("Error: Panel transparency check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    Log("IsAreaSampleColour: Found invalid colour " sampleColour)
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
