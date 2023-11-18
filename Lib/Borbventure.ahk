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
    ; Check for only if scroll is not at the top
    if (!IsBVScrollAblePanelAtTop()) {
        BVResetScroll()
        Sleep(34)
    }
    ; Check if scroll exists at top (if less than 4 trades)
    if (!IsScrollAblePanelAtTop()) {
        RefreshTrades()
        Sleep(34)
    }

    ; Check for any finished items in view and collect them
    loop 8 {
        found := BVGetFinishButtonLocation()
        if (!found) {
            break
        }
        fCustomClick(WinRelPosLargeW(1911),
            found[2] + WinRelPosLargeH(10), 72)
        Sleep(72)
    }

    ; Check first four slots for item
    Slot1Y := BVScanSlotItem(1299, 431, 1353, 520)
    Slot2Y := BVScanSlotItem(1299, 521, 1353, 750)
    Slot3Y := BVScanSlotItem(1299, 751, 1353, 900)
    Slot4Y := BVScanSlotItem(1299, 901, 1353, 1076)

    ;Charslot 1 is at X 1600
    ;Charslot 2 is at X 1717
    ;Start/Finish is at X 1911
    ;Cancel is at X 2120
    ;BorbJuice first detect point is at X 1326
    SlotsYArray := [Slot4Y, Slot3Y, Slot2Y, Slot1Y]
    activeSlots := 0
    for SlotY in SlotsYArray {
        if (SlotY != 0 && IsBackground(WinRelPosLargeW(1855), SlotY) &&
            IsButtonActive(WinRelPosLargeW(2120), SlotY - WinRelPosLargeH(5))) {
                ; If slots cancel button exists, assume active. This lets us
                ; pause refreshing until something new happens to avoid wastage
                activeSlots++
        }

    }

    for SlotY in SlotsYArray {
        if (SlotY != 0 && IsWindowActive() &&
            IsButtonInactive(WinRelPosLargeW(1864), SlotY)) {
                ; Don't try to start more if we're full even if another is
                ; detected
                if ((!HaveBorbDLC and activeSlots != 2) ||
                    (HaveBorbDLC and activeSlots != 4)) {
                        ; If slots inactive, its ready to start,
                        ; use its y to align clicks
                        fCustomClick(WinRelPosLargeW(1600), SlotY, 101)
                        ; Click team slot 1
                        Sleep(72)
                        fCustomClick(WinRelPosLargeW(1717), SlotY, 101)
                        ; Click team slot 2
                        Sleep(72)
                        fCustomClick(WinRelPosLargeW(1911), SlotY, 101)
                        ; Click Start
                        Sleep(72)
                }
        }
    }
    if (activeSlots >= 1) {
        ToolTip("Found " . activeSlots . " active slots", W / 2, H / 2)
    } else {
        ToolTip()
    }
    if (!HaveBorbDLC and activeSlots < 2) {
        ; If we have not filled all available slots refresh
        RefreshTrades()
        Sleep(34)
    }
    if (HaveBorbDLC and activeSlots < 4) {
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

BVScanSlotItem(X1, Y1, X2, Y2) {
    global BVItemsArr

    if (!BVItemsArr.Length) {
        BVItemsArr := ["0xF91FF6"]
        ; If no items selected default to purple juice
    }
    ; This is the check for the items colours, if you want to scan
    ; for something else. Change this colour to something unique to that
    ; type, or add more checks if you want several.
    ; "0xF91FF6" Borb ascention juice (purple default)
    ; "0x70F928" Borb juice (green)
    ; "0x0F2A1D" Nature time sphere
    ; "0x55B409" Borb rune (green)
    ; "0x018C9C" Magic mulch
    ; "0x01D814" Nature gem
    ; "0xAB5A53" Random item box (all types)
    ; "0x98125F" Borb rune (purple)
    ; "0xC1C1C1" Candy
    ; "0x6CD820" Both clovers (uses same colours)
    ; "0x6BEA15" Borb token
    ; "0xCEF587" Free borb token
    ; "0xC9C9C9" Dice Points (white)
    ; "0x0E44BE" Power Dice Points (blue)

    ; Please use config.ahk now to control this

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