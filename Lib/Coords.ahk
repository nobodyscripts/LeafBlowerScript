#Requires AutoHotkey v2.0

#Include Functions.ahk

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

; ------------------- Mining Coords --------------------

cMineEnhanceSlot1() { ; Top left
    o := RelCoord()
    o.SetCoordRel(1016, 575)
    return o
}

cMineEnhanceSlot2() { ; Top right
    o := RelCoord()
    o.SetCoordRel(1980, 575)
    return o
}

cMineEnhanceSlot3() { ; Mid left
    o := RelCoord()
    o.SetCoordRel(1016, 725)
    return o
}

cMineEnhanceSlot4() { ; Mid right
    o := RelCoord()
    o.SetCoordRel(1980, 725)
    return o
}

cMineEnhanceSlot5() { ; Bottom left
    o := RelCoord()
    o.SetCoordRel(1016, 870)
    return o
}

cMineEnhanceSlot6() { ; Bottom right
    o := RelCoord()
    o.SetCoordRel(1980, 870)
    return o
}

; Vein rarity colours

cMineColourSlot1() { ; Top left
    o := RelCoord()
    o.SetCoordRel(410, 575)
    return o
}

cMineColourSlot2() { ; Top right
    o := RelCoord()
    o.SetCoordRel(1368, 575)
    return o
}

cMineColourSlot3() { ; Mid left
    o := RelCoord()
    o.SetCoordRel(410, 720)
    return o
}

cMineColourSlot4() { ; Mid right
    o := RelCoord()
    o.SetCoordRel(1368, 720)
    return o
}

cMineColourSlot5() { ; Bottom left
    o := RelCoord()
    o.SetCoordRel(410, 870)
    return o
}

cMineColourSlot6() { ; Bottom right
    o := RelCoord()
    o.SetCoordRel(1368, 870)
    return o
}

; Vein type icon locations

cMineVeinIconSlot1() { ; Top left
    o := RelCoord()
    o.SetCoordRel(829, 561)
    return o
}

cMineVeinIconSlot2() { ; Top right
    o := RelCoord()
    o.SetCoordRel(1789, 561)
    return o
}

cMineVeinIconSlot3() { ; Mid left
    o := RelCoord()
    o.SetCoordRel(829, 711)
    return o
}

cMineVeinIconSlot4() { ; Mid right
    o := RelCoord()
    o.SetCoordRel(1789, 711)
    return o
}

cMineVeinIconSlot5() { ; Bottom left
    o := RelCoord()
    o.SetCoordRel(829, 860)
    return o
}

cMineVeinIconSlot6() { ; Bottom right
    o := RelCoord()
    o.SetCoordRel(1789, 860)
    return o
}

; Vein cancel button locations

cMineVeinCancelSlot1() { ; Top left
    o := RelCoord()
    o.SetCoordRel(1140, 575)
    return o
}

cMineVeinCancelSlot2() { ; Top right
    o := RelCoord()
    o.SetCoordRel(2100, 575)
    return o
}

cMineVeinCancelSlot3() { ; Mid left
    o := RelCoord()
    o.SetCoordRel(1140, 723)
    return o
}

cMineVeinCancelSlot4() { ; Mid right
    o := RelCoord()
    o.SetCoordRel(2100, 723)
    return o
}

cMineVeinCancelSlot5() { ; Bottom left
    o := RelCoord()
    o.SetCoordRel(1140, 874)
    return o
}

cMineVeinCancelSlot6() { ; Bottom right
    o := RelCoord()
    o.SetCoordRel(2100, 874)
    return o
}

; Mine navigate tabs

cMineTabVein() { ; First tab
    o := RelCoord()
    o.SetCoordRel(526, 1180)
    return o
}

cMineTabMines() { ; Mines tab
    o := RelCoord()
    o.SetCoordRel(760, 1180)
    return o
}

cMineTabDrill() { ; Drill tab
    o := RelCoord()
    o.SetCoordRel(1320, 1180)
    return o
}

cMineTabShop() { ; Shop tab
    o := RelCoord()
    o.SetCoordRel(1600, 1180)
    return o
}

cMineTabTransmute() { ; Transmute tab
    o := RelCoord()
    o.SetCoordRel(1900, 1180)
    return o
}

cMineFreeFuelButton() { ; Button for free fuel refill
    o := RelCoord()
    o.SetCoordRel(1220, 615)
    return o
}

cMineDrillSphereButton() { ; Button for sphere use
    o := RelCoord()
    o.SetCoordRel(1260, 445)
    return o
}

cMineTransmuteButton() { ; Button for Transmute all bars
    o := RelCoord()
    o.SetCoordRel(703, 385)
    return o
}

cMineVeinUpgradeButton() { ; Button for upgrading vein level
    o := RelCoord()
    o.SetCoordRel(840, 370)
    return o
}

cMineVeinCancelConfirmButton() { ; Button for upgrading vein level
    o := RelCoord()
    o.SetCoordRel(1190, 520) ; Formerly 1247 527, 1063, 505
    return o
}
/* 
*Up:: {

 cMineEnhanceSlot1().ToolTipAtCoord(1)
cMineEnhanceSlot2().ToolTipAtCoord(2)
cMineEnhanceSlot3().ToolTipAtCoord(3)
cMineEnhanceSlot4().ToolTipAtCoord(4)
cMineEnhanceSlot5().ToolTipAtCoord(5)
cMineEnhanceSlot6().ToolTipAtCoord(6)
; Vein rarity colours
cMineColourSlot1().ToolTipAtCoord(7)
cMineColourSlot2().ToolTipAtCoord(8)
cMineColourSlot3().ToolTipAtCoord(9)
cMineColourSlot4().ToolTipAtCoord(10)
cMineColourSlot5().ToolTipAtCoord(11)
cMineColourSlot6().ToolTipAtCoord(12)
; Vein type icon locations
cMineVeinIconSlot1().ToolTipAtCoord(13)
cMineVeinIconSlot2().ToolTipAtCoord(14)
cMineVeinIconSlot3().ToolTipAtCoord(15)
cMineVeinIconSlot4().ToolTipAtCoord(16)
cMineVeinIconSlot5().ToolTipAtCoord(17)
cMineVeinIconSlot6().ToolTipAtCoord(18) 
; Vein cancel button locations
cMineVeinCancelSlot1().ToolTipAtCoord(1)
cMineVeinCancelSlot2().ToolTipAtCoord(2)
cMineVeinCancelSlot3().ToolTipAtCoord(3)
cMineVeinCancelSlot4().ToolTipAtCoord(4)
cMineVeinCancelSlot5().ToolTipAtCoord(5)
cMineVeinCancelSlot6().ToolTipAtCoord(6)
; Mine navigate tabs
cMineTabVein().ToolTipAtCoord(7)
cMineTabMines().ToolTipAtCoord(8)
cMineTabDrill().ToolTipAtCoord(9)
cMineTabShop().ToolTipAtCoord(10)
cMineTabTransmute().ToolTipAtCoord(11)
cMineFreeFuelButton().ToolTipAtCoord(12)
cMineDrillSphereButton().ToolTipAtCoord(13)
cMineTransmuteButton().ToolTipAtCoord(14)
cMineVeinUpgradeButton().ToolTipAtCoord(15)
cMineVeinCancelConfirmButton().ToolTipAtCoord(16) 

} */