#Requires AutoHotkey v2.0

#Include Functions.ahk
#Include ..\Coords\MineCoords.ahk
#Include ..\Coords\MineCaveCoords.ahk

/*
Defines the locations resolution independant for pixel checks
*/

Class RelCoord {
    x := 0
    y := 0

    SetCoordRel(xin, yin) {
        this.x := WinRelPosLargeW(xin)
        this.y := WinRelPosLargeH(yin)
        return this
    }

    NewCoordManual(xin, yin) {
        this.x := xin
        this.y := yin
        return this
    }

    IsButton() {
        if (IsButton(this.x, this.y)) {
            return true
        }
        return false
    }


    IsButtonActive() {
        if (IsButtonActive(this.x, this.y)) {
            return true
        }
        return false
    }

    IsButtonClickable() {
        if (IsButtonClickable(this.x, this.y)) {
            return true
        }
        return false
    }

    IsButtonInactive() {
        if (IsButtonInactive(this.x, this.y)) {
            return true
        }
        return false
    }

    IsBackground() {
        if (IsBackground(this.x, this.y)) {
            return true
        }
        return false
    }

    Click(delay := 34) {
        fCustomClick(this.x, this.y, delay)
    }

    ClickOffset(xOffset := 1, yOffset := 1, delay := 34) {
        fCustomClick(this.x + xOffset, this.y + yOffset, delay)
    }

    toString() {
        return "X: " this.x " Y: " this.y
    }

    GetColour() {
        try {
            colour := PixelGetColor(this.x, this.y)
        } catch as exc {
            Log("Error 36: GetColour check failed - " exc.Message)
            MsgBox("Could not conduct the search due to the following error:`n"
                exc.Message)
        }
        return colour
    }

    ToolTipAtCoord(id := 15) {
        ToolTip(" ", this.x, this.y, id)
    }

    ClickOffsetWhileColour(colour, maxLoops := 20, offsetX := 1, offsetY := 1, delay := 54, interval := 50) {
        i := maxLoops
        while (IsWindowActive() && this.GetColour() = colour) {
            this.ClickOffset(offsetX, offsetY, delay)
            Sleep(interval)
            i--
            if (i = 0) {
                return false
            }
        }
        return true
    }

    ClickOffsetUntilColour(colour, maxLoops := 20, offsetX := 1, offsetY := 1, delay := 54, interval := 50) {
        i := maxLoops
        while (IsWindowActive() && this.GetColour() != colour) {
            this.ClickOffset(offsetX, offsetY, delay)
            Sleep(interval)
            i--
            if (i = 0) {
                return false
            }
        }
        return true
    }

    WaitWhileColour(colour, maxLoops := 20, interval := 50) {
        i := maxLoops
        while (IsWindowActive() && this.GetColour() = colour) {
            Sleep(interval)
            i--
            if (i = 0) {
                return false
            }
        }
        return true
    }

    WaitUntilColour(colour, maxLoops := 20, interval := 50) {
        i := maxLoops
        while (IsWindowActive() && this.GetColour() != colour) {
            Sleep(interval)
            i--
            if (i = 0) {
                return false
            }
        }
        return true
    }

    GreedyModifierUsageClick(delay := 54) {
        AmountArr := ["25000", "2500", "1000", "250", "100", "25", "10", "1"]
        if (!IsWindowActive() || !IsPanelActive() ||
            !this.IsButtonClickable()) {
                return
        }
        for Amount in AmountArr {
            AmountToModifier(Amount)
            Sleep(delay)
            while (IsWindowActive() && IsPanelActive() &&
                this.IsButtonClickable()) {
                    this.ClickOffset()
                    Sleep(delay)
            }
        }
    }
}

CardPacksOddButton() {
    o := RelCoord()
    o.SetCoordRel(2130, 420)
    return o
}

; ------------------ Bank Coords -------------------

cBankDepositRESS() {
    o := RelCoord()
    o.SetCoordRel(1920, 460)
    return o
}

cBankUpgradeStorage() {
    o := RelCoord()
    o.SetCoordRel(2140, 575)
    return o
}

cBankTabLG() {
    o := RelCoord()
    o.SetCoordRel(600, 315)
    return o
}

cBankTabSN() {
    o := RelCoord()
    o.SetCoordRel(600, 375)
    return o
}

cBankTabEB() {
    o := RelCoord()
    o.SetCoordRel(600, 445)
    return o
}

cBankTabFF() {
    o := RelCoord()
    o.SetCoordRel(600, 510)
    return o
}

cBankTabSR() {
    o := RelCoord()
    o.SetCoordRel(600, 575)
    return o
}

cBankTabQA() {
    o := RelCoord()
    o.SetCoordRel(600, 635)
    return o
}

; ------------------ Leafton Coords -------------------

cLeaftonCenter() {
    o := RelCoord()
    o.SetCoordRel(1270, 680)
    return o
}

cLeaftonStart() {
    o := RelCoord()
    o.SetCoordRel(690, 370)
    return o
}

; ------------------ Crafting Coords -------------------

cCraftingStop() {
    o := RelCoord()
    o.SetCoordRel(675, 750)
    return o
}

; ------------------ Hyacinth Coords -------------------

cNatureFarmUseSphere() {
    o := RelCoord()
    o.SetCoordRel(1615, 420)
    return o
}

; ------------------ Crafting Coords -------------------

cCraftingTab1() {
    o := RelCoord()
    o.SetCoordRel(500, 1180)
    return o
}
