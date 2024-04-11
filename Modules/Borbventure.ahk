#Requires AutoHotkey v2.0

global bvAutostartDisabled := false
global HaveBorbDLC := false
global BVBlockMythLeg := false

fBorbVentureJuiceFarm() {
    global bvAutostartDisabled

    if (!GotoBorbventuresFirstTab()) {
        Log("Borbv: Failed to travel, aborting.")
        return
    }

    Log("Borbv: Main loop starting.")
    bvAutostartDisabled := false
    if (IsBVAutoStartOn()) {
        fCustomClick(WinRelPosLargeW(591), WinRelPosLargeH(1100), 34)
        bvAutostartDisabled := true
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
        fCustomClick(WinRelPosLargeW(591), WinRelPosLargeH(1100), 34)
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
        fCustomClick(WinRelPosLargeW(1847), WinRelPosLargeH(1085), 34)
        Sleep(34)
    }
    ; Get a list of the arrows heights so we can check the buttons and icons
    ; relative to that position
    targetItemsYArray := []
    arrows := BVCachedArrowsLocations()
    arrowCount := 0
    activeSlots := 0
    if (!arrows) {
        return
    }
    for arrowY in arrows {
        if (arrowY && IsWindowActive()) {
            arrowCount++
            ; If slot is active, we don't care what it is
            if (IsBackground(WinRelPosLargeW(1855), arrowY) &&
                !IsBackground(WinRelPosLargeW(2100), arrowY)) {
                    ; If slots cancel button exists, assume active. This lets us
                    ; pause refreshing until something new happens to avoid wastage
                    activeSlots++
            } else {
                if ((BVScanSlotRarity(arrowY) != "0x9E10C1" &&
                    BVScanSlotRarity(arrowY) != "0xE1661A") || !BVBlockMythLeg) {
                        ; If slot has an item we want add it to the target list
                        IsUsefulItem := BVScanSlotItem(WinRelPosLargeW(1313),
                            arrowY - WinRelPosLargeH(17),
                            WinRelPosLargeW(1347),
                            arrowY + WinRelPosLargeH(20))
                        if (IsUsefulItem) {
                            targetItemsYArray.Push(arrowY)
                        }
                }
            }
        }
    }
    detailedMode := false
    ; If we have more than 4 arrows details mode is on
    if (arrowCount >= 6) {
        detailedMode := true
    }
    ; Check for only if scroll is not at the top
    if (!detailedMode && !IsBVScrollAblePanelAtTop()) {
        BVResetScroll()
        Sleep(34)
        return ; If we had to reset we should restart function and rescan
    }
    ; Check if scroll exists at top (if less than 4 trades)
    if (!detailedMode && !IsScrollAblePanelAtTop()) {
        RefreshTrades()
        Sleep(34)
        return ; If we had to refresh we should restart function and rescan
    }
    started := 0
    for SlotY in targetItemsYArray {
        if (AreBVSlotsAvailable(detailedMode, HaveBorbDLC, activeSlots, started)) {
            if (BVStartItemFromSlot(SlotY)) {
                started++
            }
        }
    }
    if (Debug) {
        ToolTip("Found " . activeSlots . " active slots`n"
            "Detailed mode " detailedMode ", Dlc " HaveBorbDLC ", Arrows "
            arrowCount ", Target items " targetItemsYArray.Length,
            W / 2.2, H / 6.5, 1)
    } else {
        ToolTip("Found " . activeSlots . " active slots",
            W / 2.2, H / 6.2, 1)
    }
    if (AreBVSlotsAvailable(detailedMode, HaveBorbDLC, activeSlots, started)) {
        ; If we have not filled all available slots refresh
        RefreshTrades()
        Sleep(34)
    }
}

AreBVSlotsAvailable(detailedMode, HaveBorbDLC, activeSlots, started) {
    if ((!detailedMode && !HaveBorbDLC && activeSlots + started < 3) ||
        (detailedMode && !HaveBorbDLC && activeSlots + started < 5) ||
        (!detailedMode && HaveBorbDLC && activeSlots + started < 4) ||
        (detailedMode && HaveBorbDLC && activeSlots + started < 6)) {
            return true
    }
    return false
}

BVStartItemFromSlot(SlotY) {
    if (SlotY != 0 && IsWindowActive() &&
        IsButtonInactive(WinRelPosLargeW(1864), SlotY)) {
            ; Don't try to start more if we're full even if another is
            ; detected
            ; If slots inactive, its ready to start,
            ; use its y to align clicks
            ; Click team slot 1
            bvSleepTime := 72
            fCustomClick(WinRelPosLargeW(1610), SlotY, bvSleepTime)
            Sleep(bvSleepTime)
            a := b := c := 0
            while (IsButtonActive(WinRelPosLargeW(1608), SlotY) &&
                a < 2) {
                    fCustomClick(WinRelPosLargeW(1610), SlotY, bvSleepTime)
                    a++
                    Sleep(bvSleepTime)
            }
            ; Click team slot 2
            fCustomClick(WinRelPosLargeW(1730), SlotY, bvSleepTime)
            Sleep(bvSleepTime)
            while (IsButtonActive(WinRelPosLargeW(1728), SlotY) &&
                b < 2) {
                    fCustomClick(WinRelPosLargeW(1730), SlotY, bvSleepTime)
                    b++
                    Sleep(bvSleepTime)
            }
            ; Click Start
            fCustomClick(WinRelPosLargeW(1911), SlotY, bvSleepTime)
            Sleep(bvSleepTime)
            while (IsButtonActive(WinRelPosLargeW(1850), SlotY) &&
                c < 2) {
                    fCustomClick(WinRelPosLargeW(1911), SlotY, bvSleepTime)
                    c++
                    Sleep(bvSleepTime)
            }
            return true
    }
    return false
}

BVGetFinishButtonLocation() {
    ; 1855 276 top left 1440 res
    ; 1855 1073 bottom right
    col1 := PixelSearchWrapperRel(1855, 352, 1855, 1073, "0xFFF1D2")
    if (col1 != false) {
        return col1
    }
    col2 := PixelSearchWrapperRel(1855, 352, 1855, 1073, "0xFDD28A")
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
            If (PixelSearch(&OutX, &OutY, X1, Y1, X2, Y2, colour, 0)) {
                return OutY
            }
        }
    } catch as exc {
        Log("Borbv: ScanSlotItem failed to scan - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return 0
}

/**
 * Looks for user selected colour in designated box and returns height
 * @param x1 Top left Coordinate (relative 1440)
 * @param y1 Top left Coordinate (relative 1440)
 * @param x2 Bottom Right Coordinate (relative 1440)
 * @param y2 Bottom Right Coordinate (relative 1440)
 * @returns {number} 0 if nothing, Y if found, nonrel coord
 */
BVScanSlotItemRel(X1, Y1, X2, Y2) {
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
            found := PixelSearch(&OutX, &OutY,
                WinRelPosLargeW(X1), WinRelPosLargeH(Y1),
                WinRelPosLargeW(X2), WinRelPosLargeH(Y2),
                colour, 0)
            If (found and OutX != 0) {
                ; Log("Borbv: Found " BVColourToItem(colour) " at " OutX
                ;    " x " OutY)
                return OutY ; Found item row
            }
        }
    } catch as exc {
        Log("Borbv: ScanSlotItemRel failed to scan - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
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
    return PixelGetColor(WinRelPosLargeW(331), arrowY)
}

IsBVScrollAblePanelAtTop() {
    ; 2220 258 top scroll arrow button
    ; 2220 320 scroll handle
    if (IsButtonActive(WinRelPosLargeW(2220), WinRelPosLargeH(258))) {
        ; Up Arrow exists, so scrolling is possible
        if (IsButtonActive(WinRelPosLargeW(2220), WinRelPosLargeH(320))) {
            ; Is at top
            return true
        } else {
            return false
        }
    }
    return true
}

IsBVAutoStartOn() {
    font0 := !IsButtonActive(WinRelPosLargeW(586), WinRelPosLargeH(1097))
    font1 := !IsButtonActive(WinRelPosLargeW(597), WinRelPosLargeH(1097))
    if (Debug) {
        Log("BVAutostart: Font 0 check " BinaryToStr(font0)
            ", Font 1 check " BinaryToStr(font1))
    }
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
        if (locations.Length >= 6 && PixelGetColor(WinRelPosLargeW(1280), locations[1]) = "0x1989B8" &&
            PixelGetColor(WinRelPosLargeW(1280), locations[2]) = "0x1989B8" &&
            PixelGetColor(WinRelPosLargeW(1280), locations[3]) = "0x1989B8" &&
            PixelGetColor(WinRelPosLargeW(1280), locations[4]) = "0x1989B8" &&
            PixelGetColor(WinRelPosLargeW(1280), locations[5]) = "0x1989B8" &&
            PixelGetColor(WinRelPosLargeW(1280), locations[6]) = "0x1989B8") {
                return locations
        }

    }
    newlocations := LineGetColourInstancesOffsetV(1280, 275, 1073, "0x1989B8", 8)
    locations := newlocations
    return locations
}