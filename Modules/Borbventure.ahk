#Requires AutoHotkey v2.0

global bvAutostartDisabled := false
global HaveBorbDLC := false
global BVBlockMythLeg := false

fBorbVentureJuiceFarm() {
    global bvAutostartDisabled, BVBlockMythLeg

    if (!Travel.GotoBorbVFirstTab()) {
        Log("Borbv: Failed to travel, aborting.")
        return
    }

    Log("Borbv: Main loop starting.")
    bvAutostartDisabled := false
    if (IsBVAutoStartOn()) {
        ; TODO Move point to Points
        cPoint(591, 1100).Click()
        bvAutostartDisabled := true
    }
    if (BVBlockMythLeg) {
        ; Add note so that every time i turn it on and nothing starts i know why
        Log(
            "Warning: BVBlockMythLeg is on, if all available trades are myth/leg nothing will start."
        )
    }
    loop {
        if (!IsWindowActive()) {
            Log("Borbv: Exiting as no game.")
            cReload()
            return
        }
        if (!IsPanelActive()) {
            Log("Borbv: Did not find panel. Aborted.")
            cReload()
            return
        }
        BVMainLoop()
    }
    if (bvAutostartDisabled = true && !IsBVAutoStartOn()) {
        ; TODO Move point to Points
        cPoint(591, 1100).Click()
    }
    Log("Borbv: Aborted.")
    ToolTip()
}

BVMainLoop() {
    global HaveBorbDLC, BVBlockMythLeg
    ; Check for any finished items in view and collect them
    ; Not really needed now but not much harm to leave going 586 1098
    loop 6 {
        found := BVGetFinishButtonLocation()
        if (!found) {
            break
        }
        ; TODO Move point to Points
        cPoint(1847, 1085).Click()
        Sleep(34)
    }
    ; Get a list of the arrows heights so we can check the buttons and icons
    ; relative to that position
    targetItemsYArray := []
    arrows := BVCachedArrowsLocations()
    VerboseLog(ArrToCommaDelimStr(arrows))
    arrowCount := 0
    activeSlots := 0
    if (!arrows) {
        return
    }
    for arrowY in arrows {
        if (arrowY && IsWindowActive()) {
            arrowCount++
            ; If slot is active, we don't care what it is
            StartButton := cPoint(WinRelPosLargeW(1855), arrowY, false)
            CancelButton := cPoint(WinRelPosLargeW(2100), arrowY, false)
            if (StartButton.IsBackground() && !CancelButton.IsBackground()) {
                ; If slots cancel button exists, assume active. This lets us
                ; pause refreshing until something new happens to avoid wastage
                VerboseLog("Found active slot.")
                activeSlots++
            } else {
                if ((BVScanSlotRarity(arrowY) != "0x9E10C1" && BVScanSlotRarity(
                    arrowY) != "0xE1661A" && BVBlockMythLeg) || !BVBlockMythLeg
                ) {

                    VerboseLog("Can scan slot " arrowCount)
                    ; If slot has an item we want add it to the target list
                    if (BVScanSlotItem(WinRelPosLargeW(1313), arrowY -
                        WinRelPosLargeH(17), WinRelPosLargeW(1347), arrowY +
                        WinRelPosLargeH(20))) {
                        VerboseLog("Found item added to target items.")
                        targetItemsYArray.Push(arrowY)
                    }
                }
            }
        }
    }
    detailedMode := false
    ; If we have more than 4 arrows details mode is on
    if (arrowCount >= 6) {
        DebugLog("Found detailed mode off.")
        detailedMode := true
    }
    ; Check for only if scroll is not at the top
    if (!detailedMode && !IsBVScrollAblePanelAtTop()) {
        DebugLog("Reset scroll.")
        Travel.ResetBorbVScroll()
        Sleep(34)
        return ; If we had to reset we should restart function and rescan
    }
    ; Check if scroll exists at top (if less than 4 trades)
    if (!detailedMode && !IsScrollAblePanelAtTop()) {
        GameKeys.RefreshTrades()
        Sleep(34)
        return ; If we had to refresh we should restart function and rescan
    }
    started := 0
    for SlotY in targetItemsYArray {
        if (AreBVSlotsAvailable(detailedMode, HaveBorbDLC, activeSlots, started
        )) {
            if (BVStartItemFromSlot(SlotY)) {
                VerboseLog("Found item, added to started.")
                started++
            }
        }
    }
    if (Debug) {
        ToolTip("Found " . activeSlots . " active slots`n"
            "Detailed mode " detailedMode ", Dlc " HaveBorbDLC ", Arrows " arrowCount ", Target items " targetItemsYArray
            .Length, W / 2.2, H / 6.5, 1)
    } else {
        ToolTip("Found " . activeSlots . " active slots", W / 2.2, H / 6.2, 1)
    }
    if (AreBVSlotsAvailable(detailedMode, HaveBorbDLC, activeSlots, started)) {
        ; If we have not filled all available slots refresh
        GameKeys.RefreshTrades()
        Sleep(34)
    }
}

AreBVSlotsAvailable(detailedMode, HaveBorbDLC, activeSlots, started) {
    if ((!detailedMode && !HaveBorbDLC && activeSlots + started < 3) || (
        detailedMode && !HaveBorbDLC && activeSlots + started < 5) || (!
            detailedMode && HaveBorbDLC && activeSlots + started < 4) || (
                detailedMode && HaveBorbDLC && activeSlots + started < 6)) {
        return true
    }
    return false
}

BVStartItemFromSlot(SlotY) {
    DebugLog("Attempting to start bv on slot with y " SlotY)
    StartButton := cPoint(WinRelPosLargeW(1864), SlotY, false)
    if (SlotY != 0 && IsWindowActive() && StartButton.IsButtonInactive()) {
        ; Don't try to start more if we're full even if another is
        ; detected
        ; If slots inactive, its ready to start,
        ; use its y to align clicks
        ; Click team slot 1
        bvSleepTime := 72
        ; Click team slot 1
        BorbSlot1 := cPoint(WinRelPosLargeW(1608), SlotY, false)
        BorbSlot1.ClickOffset(2, 0, bvSleepTime)
        Sleep(bvSleepTime)
        a := b := c := 0
        while (BorbSlot1.IsButtonActive() && a < 2) {
            BorbSlot1.ClickOffset(2, 0, bvSleepTime)
            a++
            Sleep(bvSleepTime)
        }
        ; Click team slot 2
        BorbSlot2 := cPoint(WinRelPosLargeW(1728), SlotY, false)
        BorbSlot2.ClickOffset(2, 0, bvSleepTime)
        Sleep(bvSleepTime)
        while (BorbSlot2.IsButtonActive() && b < 2) {
            BorbSlot2.ClickOffset(2, 0, bvSleepTime)
            b++
            Sleep(bvSleepTime)
        }
        ; Click Start
        StartButton2 := cPoint(WinRelPosLargeW(1850), SlotY, false)
        StartButton2.ClickOffset(61, 0, bvSleepTime)
        Sleep(bvSleepTime)
        while (StartButton2.IsButtonActive() && c < 2) {
            StartButton2.ClickOffset(61, 0, bvSleepTime)
            c++
            Sleep(bvSleepTime)
        }
        return true
    }
    return false
}

BVGetFinishButtonLocation() {
    col1 := Rects.Borbventures.FinishButtonCol.PixelSearch(Colours().Active)
    if (col1 != false) {
        return col1
    }
    col2 := Rects.Borbventures.FinishButtonCol.PixelSearch(Colours().ActiveMouseOver
    )
    if (col2 != false) {
        return col2
    }
    return false
}

/**
 * Looks for user selected colour in designated box and returns height
 * @param x1 Top left Coordinate
 * @param y1 Top left Coordinate
 * @param x2 Bottom Right Coordinate
 * @param y2 Bottom Right Coordinate
 * @returns {number} 0 if nothing, Y if found, nonrel coord
 */
BVScanSlotItem(X1, Y1, X2, Y2) {
    global BVItemsArr

    if (!BVItemsArr.Length) {
        BVItemsArr := ["0xF91FF6"]
        ; If no items selected default to purple juice
    }
    ; This is the check for the items colours, if you want to scan
    ; for something else. Change this colour to something unique to that
    ; type, or add more checks if you want several.
    try {
        for colour in BVItemsArr {
            found := PixelSearch(&OutX, &OutY, X1, Y1, X2, Y2, colour, 0)
            If (found and OutX != 0) {
                VerboseLog("Found item thats useful " OutX " " OutY " " colour)
                return OutY
            }
        }
    } catch as exc {
        Log("Borbv: ScanSlotItem failed to scan - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n" exc
            .Message)
    }
    return 0
}

BVColourToItem(colour) {
    switch colour {
        case "0xF91FF6": return "Borb ascention juice (purple default)"
        case "0x70F928": return "Borb juice (green)"
        case "0x0F2A1D": return "Nature time sphere"
        case "0x55B409": return "Borb rune (green)"
        case "0x018C9C": return "Magic mulch"
        case "0x01D814": return "Nature gem"
        case "0xAB5A53": return "Random item box (all types)"
        case "0x98125F": return "Borb rune (purple)"
        case "0xC1C1C1": return "Candy"
        case "0x6CD820": return "Both clovers (uses same colours)"
        case "0x6BEA15": return "Borb token"
        case "0xCEF587": return "Free borb token"
        case "0xC9C9C9": return "Dice Points (white)"
        case "0x0E44BE": return "Power Dice Points (blue)"
        case "0x11CF1C": return "Quantum Blob (green)"
        case "0x250D05": return "Quark Blob (purple)"
        case "0x120D1C": return "Quark Structures"
        default: return "Unknown"
    }
}

/**
 * Get the colour of the quest marker on the left side of the quest row
 * @param arrowX Screenspace coord of the arrow detection point
 * @param arrowY
 * @returns {string} Returns raw from Pixelgetcolor, can be false
 */
BVScanSlotRarity(arrowY) {
    rarity := cPoint(WinRelPosLargeW(331), arrowY, false).GetColour()
    VerboseLog("Slot rarity " rarity)
    return rarity
}

IsBVAutoStartOn() {
    font0 := !Points.Borbventures.AutoStartFont0.IsButtonActive()
    font1 := !Points.Borbventures.AutoStartFont1.IsButtonActive()
    DebugLog("BVAutostart: Font 0 check " BinaryToStr(font0)
        ", Font 1 check " BinaryToStr(font1))
    if (font0 || font1) {
        return false
    }
    return true
}

BVCachedArrowsLocations() {
    static locations := false
    if (locations != false) {
        ; if first two cached locations are correct, return the rest, otherwise
        ; refresh
        if (locations.Length >= 6 && PixelGetColor(WinRelPosLargeW(1280),
            locations[1]) = "0x1989B8" && PixelGetColor(WinRelPosLargeW(1280),
                locations[2]) = "0x1989B8" && PixelGetColor(WinRelPosLargeW(
                    1280), locations[3]) = "0x1989B8" && PixelGetColor(
                        WinRelPosLargeW(1280), locations[4]) = "0x1989B8" &&
            PixelGetColor(WinRelPosLargeW(1280), locations[5]) = "0x1989B8" &&
            PixelGetColor(WinRelPosLargeW(1280), locations[6]) = "0x1989B8") {
            return locations
        }

    }
    newlocations := LineGetColourInstancesOffsetV(1280, 275, 1073, "0x1989B8",
        8)
    locations := newlocations
    return locations
}