#Requires AutoHotkey v2.0

Global bvAutostartDisabled := false
Global HaveBorbDLC := false
Global BVBlockMythLeg := false

fBorbVentureJuiceFarm() {
    Global bvAutostartDisabled, BVBlockMythLeg

    If (!Travel.GotoBorbVFirstTab()) {
        Log("Borbv: Failed to travel, aborting.")
        Return
    }

    Log("Borbv: Main loop starting.")
    bvAutostartDisabled := false
    If (IsBVAutoStartOn()) {
        Points.Borbventures.AutoStartFont0.Click()
        bvAutostartDisabled := true
    }
    If (BVBlockMythLeg) {
        ; Add note so that every time i turn it on and nothing starts i know why
        Log("Warning: BVBlockMythLeg is on, if all available trades are " .
            "myth/leg nothing will start.")
    }
    Loop {
        If (!Window.IsActive()) {
            Log("Borbv: Exiting as no game.")
            cReload()
            Return
        }
        If (!Window.IsPanel()) {
            Log("Borbv: Did not find panel. Aborted.")
            cReload()
            Return
        }
        BVMainLoop()
    }
    If (bvAutostartDisabled = true && !IsBVAutoStartOn()) {
        ; TODO Move point to Points
        cPoint(591, 1100).Click()
    }
    Log("Borbv: Aborted.")
    ToolTip()
}

BVMainLoop() {
    Global HaveBorbDLC, BVBlockMythLeg
    ; Check for any finished items in view and collect them
    ; Not really needed now but not much harm to leave going 586 1098
    Loop 6 {
        found := BVGetFinishButtonLocation()
        If (!found) {
            Break
        }
        Points.Borbventures.FinishAll.Click()
        Sleep(34)
    }
    ; Get a list of the arrows heights so we can check the buttons and icons
    ; relative to that position
    targetItemsYArray := []
    arrows := BVCachedArrowsLocations()
    VerboseLog("Y positions of arrows: " ArrToCommaDelimStr(arrows))
    arrowCount := 0
    activeSlots := 0
    If (!arrows) {
        Return
    }
    For arrowY in arrows {
        If (arrowY && Window.IsActive()) {
            arrowCount++
            ; If slot is active, we don't care what it is
            StartButton := cPoint(Window.RelW(1855), arrowY, false)
            CancelButton := cPoint(Window.RelW(2100), arrowY, false)
            If (StartButton.IsBackground() && !CancelButton.IsBackground()) {
                ; If slots cancel button exists, assume active. This lets us
                ; pause refreshing until something new happens to avoid wastage
                VerboseLog("Found active slot.")
                activeSlots++
            } Else {
                If ((BVScanSlotRarity(arrowY) != "0x9E10C1" && BVScanSlotRarity(
                    arrowY) != "0xE1661A" && BVBlockMythLeg) || !BVBlockMythLeg
                ) {

                    VerboseLog("Can scan slot " arrowCount)
                    ; If slot has an item we want add it to the target list
                    If (BVScanSlotItem(Window.RelW(1313), arrowY - Window.RelH(
                        17), Window.RelW(1347), arrowY + Window.RelH(20))) {
                        VerboseLog("Found item added to target items.")
                        targetItemsYArray.Push(arrowY)
                    }
                }
            }
        }
    }
    detailedMode := false
    ; If we have more than 4 arrows details mode is on
    If (arrowCount >= 6) {
        DebugLog("Found detailed mode off.")
        detailedMode := true
    }
    ; Check for only if scroll is not at the top
    If (!detailedMode && !IsBVScrollAblePanelAtTop()) {
        DebugLog("Reset scroll.")
        Travel.ResetBorbVScroll()
        Sleep(34)
        Return ; If we had to reset we should restart function and rescan
    }
    ; Check if scroll exists at top (if less than 4 trades)
    If (!detailedMode && !IsScrollAblePanelAtTop()) {
        GameKeys.RefreshTrades()
        Sleep(34)
        Return ; If we had to refresh we should restart function and rescan
    }
    started := 0
    For SlotY in targetItemsYArray {
        If (AreBVSlotsAvailable(detailedMode, HaveBorbDLC, activeSlots, started
        )) {
            If (BVStartItemFromSlot(SlotY)) {
                VerboseLog("Found item, added to started.")
                started++
            }
        }
    }
    If (Debug) {
        ToolTip("Found " . activeSlots . " active slots`n"
            "Detailed mode " detailedMode ", Dlc " HaveBorbDLC ", Arrows " arrowCount ", Target items " targetItemsYArray
            .Length, Window.W / 2.2, Window.H / 6.5, 1)
    } Else {
        ToolTip("Found " . activeSlots . " active slots", Window.W / 2.2,
            Window.H / 6.2, 1)
    }
    If (AreBVSlotsAvailable(detailedMode, HaveBorbDLC, activeSlots, started)) {
        ; If we have not filled all available slots refresh
        GameKeys.RefreshTrades()
        Sleep(34)
    }
}

AreBVSlotsAvailable(detailedMode, HaveBorbDLC, activeSlots, started) {
    If ((!detailedMode && !HaveBorbDLC && activeSlots + started < 3) || (
        detailedMode && !HaveBorbDLC && activeSlots + started < 5) || (!
            detailedMode && HaveBorbDLC && activeSlots + started < 4) || (
                detailedMode && HaveBorbDLC && activeSlots + started < 6)) {
        Return true
    }
    Return false
}

BVStartItemFromSlot(SlotY) {
    DebugLog("Attempting to start bv on slot with y " SlotY)
    StartButton := cPoint(Window.RelW(1864), SlotY, false)
    If (SlotY != 0 && Window.IsActive() && StartButton.IsButtonInactive()) {
        ; Don't try to start more if we're full even if another is
        ; detected
        ; If slots inactive, its ready to start,
        ; use its y to align clicks
        ; Click team slot 1
        bvSleepTime := 72
        ; Click team slot 1
        BorbSlot1 := cPoint(Window.RelW(1608), SlotY, false)
        BorbSlot1.ClickOffset(2, 0, bvSleepTime)
        Sleep(bvSleepTime)
        a := b := c := 0
        While (BorbSlot1.IsButtonActive() && a < 2) {
            BorbSlot1.ClickOffset(2, 0, bvSleepTime)
            a++
            Sleep(bvSleepTime)
        }
        ; Click team slot 2
        BorbSlot2 := cPoint(Window.RelW(1728), SlotY, false)
        BorbSlot2.ClickOffset(2, 0, bvSleepTime)
        Sleep(bvSleepTime)
        While (BorbSlot2.IsButtonActive() && b < 2) {
            BorbSlot2.ClickOffset(2, 0, bvSleepTime)
            b++
            Sleep(bvSleepTime)
        }
        ; Click Start
        StartButton2 := cPoint(Window.RelW(1850), SlotY, false)
        StartButton2.ClickOffset(61, 0, bvSleepTime)
        Sleep(bvSleepTime)
        While (StartButton2.IsButtonActive() && c < 2) {
            StartButton2.ClickOffset(61, 0, bvSleepTime)
            c++
            Sleep(bvSleepTime)
        }
        Return true
    }
    Return false
}

BVGetFinishButtonLocation() {
    col1 := Rects.Borbventures.FinishButtonCol.PixelSearch(Colours().Active)
    If (col1 != false) {
        Return col1
    }
    col2 := Rects.Borbventures.FinishButtonCol.PixelSearch(Colours().ActiveMouseOver
    )
    If (col2 != false) {
        Return col2
    }
    Return false
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
    Global BVItemsArr

    If (!BVItemsArr.Length) {
        BVItemsArr := ["0xF91FF6"]
        ; If no items selected default to purple juice
    }
    ; This is the check for the items colours, if you want to scan
    ; for something else. Change this colour to something unique to that
    ; type, or add more checks if you want several.
    Try {
        For colour in BVItemsArr {
            found := PixelSearch(&OutX, &OutY, X1, Y1, X2, Y2, colour, 0)
            If (found and OutX != 0) {
                VerboseLog("Found item thats useful " OutX " " OutY " " colour)
                Return OutY
            }
        }
    } Catch As exc {
        Log("Borbv: ScanSlotItem failed to scan - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n" exc
            .Message)
    }
    Return 0
}

BVColourToItem(colour) {
    Switch colour {
        Case "0xF91FF6": Return "Borb ascention juice (purple default)"
        Case "0x70F928": Return "Borb juice (green)"
        Case "0x0F2A1D": Return "Nature time sphere"
        Case "0x55B409": Return "Borb rune (green)"
        Case "0x018C9C": Return "Magic mulch"
        Case "0x01D814": Return "Nature gem"
        Case "0xAB5A53": Return "Random item box (all types)"
        Case "0x98125F": Return "Borb rune (purple)"
        Case "0xC1C1C1": Return "Candy"
        Case "0x6CD820": Return "Both clovers (uses same colours)"
        Case "0x6BEA15": Return "Borb token"
        Case "0xCEF587": Return "Free borb token"
        Case "0xC9C9C9": Return "Dice Points (white)"
        Case "0x0E44BE": Return "Power Dice Points (blue)"
        Case "0x11CF1C": Return "Quantum Blob (green)"
        Case "0x250D05": Return "Quark Blob (purple)"
        Case "0x120D1C": Return "Quark Structures"
        default: Return "Unknown"
    }
}

/**
 * Get the colour of the quest marker on the left side of the quest row
 * @param arrowX Screenspace coord of the arrow detection point
 * @param arrowY
 * @returns {string} Returns raw from Pixelgetcolor, can be false
 */
BVScanSlotRarity(arrowY) {
    rarity := cPoint(Window.RelW(331), arrowY, false).GetColour()
    VerboseLog("Slot rarity " rarity)
    Return rarity
}

IsBVAutoStartOn() {
    font0 := !Points.Borbventures.AutoStartFont0.IsButtonActive()
    font1 := !Points.Borbventures.AutoStartFont1.IsButtonActive()
    DebugLog("BVAutostart: Font 0 check " BinaryToStr(font0)
        ", Font 1 check " BinaryToStr(font1))
    If (font0 || font1) {
        Return false
    }
    Return true
}

BVCachedArrowsLocations() {
    Static locations := false
    If (locations != false) {
        ; if first two cached locations are correct, return the rest, otherwise
        ; refresh
        If (locations.Length >= 6 && PixelGetColor(Window.RelW(1280), locations[
            1]) = "0x1989B8" && PixelGetColor(Window.RelW(1280), locations[2]) =
            "0x1989B8" && PixelGetColor(Window.RelW(1280), locations[3]) =
            "0x1989B8" && PixelGetColor(Window.RelW(1280), locations[4]) =
            "0x1989B8" && PixelGetColor(Window.RelW(1280), locations[5]) =
            "0x1989B8" && PixelGetColor(Window.RelW(1280), locations[6]) =
            "0x1989B8") {
            Return locations
        }

    }
    newlocations := LineGetColourInstancesOffsetV(1280, 275, 1073, "0x1989B8",
        8)
    locations := newlocations
    Return locations
}