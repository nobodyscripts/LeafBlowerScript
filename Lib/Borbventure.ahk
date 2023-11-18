#Requires AutoHotkey v2.0

#Include ..\Config.ahk

fBorbVentureJuiceFarm() {

    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    OpenPets() ; Opens or closes another screen so that when areas is opened it
    ; doesn't close
    Sleep 100
    OpenBorbVentures() ; Open BV
    Sleep 100
    If (CheckForTransparentPanelsSilent()) {
        ; Warning is displayed if there is an issue, return to avoid harm
        return
    }

    fSlowClick(211, 573) ; Select tab
    Sleep 50

    loop {

        if (!WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution")) {
                break ; Kill if no game
        }

        ; Check first four slots for item
        Slot1Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(431),
            WinRelPosLargeW(1353), WinRelPosLargeH(490))
        Slot2Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(620),
            WinRelPosLargeW(1353), WinRelPosLargeH(675))
        Slot3Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(811),
            WinRelPosLargeW(1353), WinRelPosLargeH(866))
        Slot4Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(1028),
            WinRelPosLargeW(1353), WinRelPosLargeH(1076))

        ;Charslot 1 is at X 1600
        ;Charslot 2 is at X 1717
        ;Start/Finish is at X 1911
        ;Cancel is at X 2120
        ;BorbJuice first detect point is at X 1326
        SlotsYArray := [Slot4Y, Slot3Y, Slot2Y, Slot1Y]

        for SlotY in SlotsYArray {
            While (SlotY != 0 && IsButtonActive(WinRelPosLargeW(1911), SlotY)) {
                BVCollectFinishedItem(SlotY)
            }
        }

        activeSlots := 0
        for SlotY in SlotsYArray {
            if (SlotY != 0 && BVIsSlotActive(SlotY)) {
                ; If slots cancel button exists, assume active. This lets us
                ; pause refreshing until something new happens to avoid wastage
                activeSlots := activeSlots + 1
            }
        }

        ; Scan again to account for changes since 'finishing'

        Slot1Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(431),
            WinRelPosLargeW(1353), WinRelPosLargeH(490))
        Slot2Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(620),
            WinRelPosLargeW(1353), WinRelPosLargeH(675))
        Slot3Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(811),
            WinRelPosLargeW(1353), WinRelPosLargeH(866))
        Slot4Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(1028),
            WinRelPosLargeW(1353), WinRelPosLargeH(1076))

        SlotsYArray := [Slot4Y, Slot3Y, Slot2Y, Slot1Y]

        for SlotY in SlotsYArray {
            if (SlotY != 0 && BVIsSlotStartInactive(SlotY) &&
                WinActive("Leaf Blower Revolution")) {
                    ; Don't try to start more if we're full even if another is
                    ; detected
                    if ((!HaveBorbDLC and activeSlots != 2) ||
                        (HaveBorbDLC and activeSlots != 4)) {
                            ; If slots inactive, its ready to start,
                            ; use its y to align clicks
                            fCustomClick(WinRelPosLargeW(1600), SlotY, 101)
                            ; Click team slot 1
                            Sleep 34
                            fCustomClick(WinRelPosLargeW(1717), SlotY, 101)
                            ; Click team slot 2
                            Sleep 34
                            fCustomClick(WinRelPosLargeW(1911), SlotY, 101)
                            ; Click Start
                            Sleep 34
                    }
            }
        }
        if (activeSlots >= 1) {
            ToolTip("Found " . activeSlots . " active slots", W / 2, H / 2, 1)
            SetTimer(ToolTip, -500)
        }
        if (!HaveBorbDLC and activeSlots != 2) {
            ; If we have not filled all available slots refresh
            RefreshTrades()
        }
        if (HaveBorbDLC and activeSlots != 4) {
            RefreshTrades()
        }
    }
}

BVCollectFinishedItem(SlotY) {
    if (SlotY != 0 && IsButtonActive(WinRelPosLargeW(1911), SlotY) &&
        WinActive("Leaf Blower Revolution")) {
            ; If slots finished, its Y is used to align click and
            ; spam
            fCustomClick(WinRelPosLargeW(1911), SlotY, 72)
            Sleep 17
            fCustomClick(WinRelPosLargeW(1911), SlotY, 72)
            Sleep 17
    }
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
            found := PixelSearch(&OutX, &OutY, X1, Y1, X2, Y2, colour, 0)
            If (found and OutX != 0) {
                return OutY ; Found item row
            }
        }
    } catch as exc {
        MsgBox ("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return 0
}

BVIsSlotStartInactive(Y) {
    ; Start/finish left side, blank background X 1864
    try {
        If (PixelGetColor(WinRelPosLargeW(1864), Y) = "0xC8BDA5") {
            ; Check point to the left of the button to make sure its blank
            ;ToolTip("Slot found Inactive button", WinRelPosLargeW(1864), Y, 1)
            ;SetTimer(ToolTip, -500)
            return true
        }
    } catch as exc {
        MsgBox ("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
}

BVIsSlotActive(Y) {
    ; Position less important as just checking if not background X2120
    try {
        targetColour := PixelGetColor(WinRelPosLargeW(2120), Y)
        If (targetColour != "0x97714A") {
            ; Check cancel button for non background colour
            return true
        }
    } catch as exc {
        MsgBox ("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
}