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
        BVMainLoop()
    }
}

BVMainLoop() {
        ; Check for any finished items in view and collect them
        loop 8 {
            found := BVGetFinishButtonLocation()
            if (!found) {
                break
            }
            fCustomClick(WinRelPosLargeW(1911),
                found[2] + WinRelPosLargeH(10), 72)
            Sleep 72
        }

        ; Check first four slots for item
        Slot1Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(431),
            WinRelPosLargeW(1353), WinRelPosLargeH(520))
        Slot2Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(521),
            WinRelPosLargeW(1353), WinRelPosLargeH(750))
        Slot3Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(751),
            WinRelPosLargeW(1353), WinRelPosLargeH(900))
        Slot4Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(901),
            WinRelPosLargeW(1353), WinRelPosLargeH(1076))

        ;Charslot 1 is at X 1600
        ;Charslot 2 is at X 1717
        ;Start/Finish is at X 1911
        ;Cancel is at X 2120
        ;BorbJuice first detect point is at X 1326
        SlotsYArray := [Slot4Y, Slot3Y, Slot2Y, Slot1Y]
        activeSlots := 0
        for SlotY in SlotsYArray {
            if (SlotY != 0) {
                if (!IsBackground(WinRelPosLargeW(1855), SlotY) && IsButtonActive(WinRelPosLargeW(2120), SlotY)) {
                    fCustomClick(WinRelPosLargeW(1911), SlotY, 72)
                    Sleep 150
                }
                if (IsButtonActive(WinRelPosLargeW(2120), SlotY - WinRelPosLargeH(5))) {
                    ; If slots cancel button exists, assume active. This lets us
                    ; pause refreshing until something new happens to avoid wastage
                    activeSlots := activeSlots + 1
                }
            }
        }
        
        Slot1Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(431),
            WinRelPosLargeW(1353), WinRelPosLargeH(520))
        Slot2Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(521),
            WinRelPosLargeW(1353), WinRelPosLargeH(750))
        Slot3Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(751),
            WinRelPosLargeW(1353), WinRelPosLargeH(900))
        Slot4Y := BVScanSlotItem(WinRelPosLargeW(1299), WinRelPosLargeH(901),
            WinRelPosLargeW(1353), WinRelPosLargeH(1076))
        SlotsYArray := [Slot4Y, Slot3Y, Slot2Y, Slot1Y]

        for SlotY in SlotsYArray {
            if (SlotY != 0 &&
                IsButtonInactive(WinRelPosLargeW(1864), SlotY) &&
                WinActive("Leaf Blower Revolution")) {
                    ; Don't try to start more if we're full even if another is
                    ; detected
                    if ((!HaveBorbDLC and activeSlots != 2) ||
                        (HaveBorbDLC and activeSlots != 4)) {
                            ; If slots inactive, its ready to start,
                            ; use its y to align clicks
                            fCustomClick(WinRelPosLargeW(1600), SlotY, 101)
                            ; Click team slot 1
                            Sleep 72
                            fCustomClick(WinRelPosLargeW(1717), SlotY, 101)
                            ; Click team slot 2
                            Sleep 72
                            fCustomClick(WinRelPosLargeW(1911), SlotY, 101)
                            ; Click Start
                            Sleep 72
                    }
            }
        }
        if (activeSlots >= 1) {
            ToolTip("Found " . activeSlots . " active slots", W / 2, H / 2)
            SetTimer(ToolTip, -700)
        }
        if (!HaveBorbDLC and activeSlots < 2) {
            ; If we have not filled all available slots refresh
            RefreshTrades()
            Sleep 34
        }
        if (HaveBorbDLC and activeSlots < 4) {
            RefreshTrades()
            Sleep 34
        }
}


BVGetFinishButtonLocation() {
    try {
        ; 1855 276 top left 1440 res
        ; 1855 1073 bottom right
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(1855), WinRelPosLargeH(276),
            WinRelPosLargeW(1855), WinRelPosLargeH(1073), "0xFFF1D2", 0)
        If (!found || OutX = 0) {
            found := PixelSearch(&OutX, &OutY,
                WinRelPosLargeW(1855), WinRelPosLargeH(276),
                WinRelPosLargeW(1855), WinRelPosLargeH(1073), "0xFDD28A", 0)
            If (!found || OutX = 0) {
                return false
            }
        }

    } catch as exc {
        MsgBox ("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return [OutX, OutY]
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