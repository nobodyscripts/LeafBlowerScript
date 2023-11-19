#Requires AutoHotkey v2.0

fBorbVentureJuiceFarm() {
    OpenPets() ; Opens or closes another screen so that when areas is opened it
    ; doesn't close
    Sleep(101)
    OpenBorbVentures() ; Open BV
    Sleep(101)
    BVResetScroll()
    Log("Borbv: Main loop starting.")
    loop {
        if (!IsWindowActive()) {
            Log("Borbv: Exiting as no game.")
            reload()
            return
        }
        if (!IsPanelActive()) {
            Log("Borbv: Did not find panel. Aborted.")
            reload()
            return
        }
        BVMainLoop()
    }
    Log("Borbv: Aborted.")
    ToolTip()
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

BVMainLoop() {
    global HaveBorbDLC
    ; Check for any finished items in view and collect them
    ; Not really needed now but not much harm to leave going
    loop 6 {
        found := BVGetFinishButtonLocation()
        if (!found) {
            break
        }
        fCustomClick(WinRelPosLargeW(1911),
            found[2] + WinRelPosLargeH(10), 72)
        Sleep(72)
    }
    ; Get a list of the arrows heights so we can check the buttons and icons
    ; relative to that position
    ; Arrows 83 from point to point, 31 tall
    SlotsYArray := []
    arrows := LineGetColourInstancesOffsetV(1280, 275, 1073, "0x1989B8", 9)
    arrowCount := 0
    for arrowY in arrows {
        if (arrowY) {
            arrowCount++
            IsUsefulItem := BVScanSlotItem(1299, arrowY - 20, 1353, arrowY + 30)
            if (IsUsefulItem) {
                SlotsYArray.Push(IsUsefulItem)
                if (Debug) {
                    Log("Have found a useful item at " IsUsefulItem)
                }
            }
        }
    }
    detailedMode := false
    ; If we have more than 4 arrows details mode is on
    if (arrowCount >= 6) {
        detailedMode := true
    }
    
    ToolTip("Detailed mode " detailedMode ", Dlc " HaveBorbDLC ", Arrows " 
        arrowCount,
        W / 2 - WinRelPosLargeW(50), H / 5, 1)
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

    /*     ; Check first four slots for item
    Slot1Y := BVScanSlotItem(1299, 431, 1353, 520)
    Slot2Y := BVScanSlotItem(1299, 521, 1353, 750)
    Slot3Y := BVScanSlotItem(1299, 751, 1353, 900)
    Slot4Y := BVScanSlotItem(1299, 901, 1353, 1076) */

    ;Charslot 1 is at X 1600
    ;Charslot 2 is at X 1717
    ;Start/Finish is at X 1911
    ;Cancel is at X 2120
    ;BorbJuice first detect point is at X 1326
    /* SlotsYArray := [Slot4Y, Slot3Y, Slot2Y, Slot1Y] */
    activeSlots := 0

    ToolTip("Found " . activeSlots . " active slots`n"
        "Detailed mode " detailedMode ", Dlc " HaveBorbDLC ", Arrows " 
        arrowCount,
        W / 2 - WinRelPosLargeW(50), H / 5, 1)

    for SlotY in arrows {
        if (SlotY != 0 && IsBackground(WinRelPosLargeW(1855), SlotY) &&
            IsButtonActive(WinRelPosLargeW(2120), SlotY - WinRelPosLargeH(5))) {
                ; If slots cancel button exists, assume active. This lets us
                ; pause refreshing until something new happens to avoid wastage
                activeSlots++
        }

    }

    ToolTip("Found " . activeSlots . " active slots`n"
        "Detailed mode " detailedMode ", Dlc " HaveBorbDLC ", Arrows " 
        arrowCount,
        W / 2 - WinRelPosLargeW(50), H / 5, 1)

    for SlotY in SlotsYArray {
        if (SlotY != 0 && IsWindowActive() &&
            IsButtonInactive(WinRelPosLargeW(1864), SlotY)) {
                ; Don't try to start more if we're full even if another is
                ; detected
                if ((!detailedMode && !HaveBorbDLC && activeSlots < 2) ||
                    (detailedMode && !HaveBorbDLC && activeSlots < 4) ||
                    (!detailedMode && HaveBorbDLC && activeSlots < 4) ||
                    (detailedMode && HaveBorbDLC && activeSlots < 6)) {
                        ; If slots inactive, its ready to start,
                        ; use its y to align clicks
                        ; Click team slot 1
                        fCustomClick(WinRelPosLargeW(1600), SlotY, 101)
                        Sleep(72)
                        if (IsButtonActive(WinRelPosLargeW(1595), SlotY)) {
                            fCustomClick(WinRelPosLargeW(1600), SlotY, 101)
                        }
                        ; Click team slot 2
                        fCustomClick(WinRelPosLargeW(1717), SlotY, 101)
                        Sleep(72)
                        if (IsButtonActive(WinRelPosLargeW(1715), SlotY)) {
                            fCustomClick(WinRelPosLargeW(1717), SlotY, 101)
                            Sleep(17)
                        }
                        ; Click Start
                        fCustomClick(WinRelPosLargeW(1911), SlotY, 101)
                        Sleep(72)
                }
        }
    }

    ToolTip("Found " . activeSlots . " active slots`n"
        "Detailed mode " detailedMode ", Dlc " HaveBorbDLC ", Arrows " 
        arrowCount,
        W / 2 - WinRelPosLargeW(50), H / 5, 1)

    if ((!detailedMode && !HaveBorbDLC && activeSlots < 2) ||
        (detailedMode && !HaveBorbDLC && activeSlots < 4) ||
        (!detailedMode && HaveBorbDLC && activeSlots < 4) ||
        (detailedMode && HaveBorbDLC && activeSlots < 6)) {
            ; If we have not filled all available slots refresh
            RefreshTrades()
            Sleep(34)
    }
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
 * @param X1 
 * @param Y1 
 * @param X2 
 * @param Y2 
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
        Log("Borbv: ScanSlotItem failed to scan - " exc.Message)
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