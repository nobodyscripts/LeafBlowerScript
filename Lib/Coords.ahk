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
/*
1036 575
1036 720
1036 870
2000 575
2000 720
2000 870

410 (Left row colour x)
1368 (Right row colour x)
*/
cMineEnhanceSlot1() { ; Top left
    o := RelCoord()
    o.SetCoordRel(1036, 575)
    return o
}

cMineEnhanceSlot2() { ; Mid left
    o := RelCoord()
    o.SetCoordRel(1036, 720)
    return o
}

cMineEnhanceSlot3() { ; Bottom left
    o := RelCoord()
    o.SetCoordRel(1036, 870)
    return o
}

cMineEnhanceSlot4() { ; Top right
    o := RelCoord()
    o.SetCoordRel(2000, 575)
    return o
}

cMineEnhanceSlot5() { ; Mid right
    o := RelCoord()
    o.SetCoordRel(2000, 720)
    return o
}

cMineEnhanceSlot6() { ; Bottom right
    o := RelCoord()
    o.SetCoordRel(2000, 870)
    return o
}

; Vein rarity colours

cMineColourSlot1() { ; Top left
    o := RelCoord()
    o.SetCoordRel(410, 575)
    return o
}

cMinColourSlot2() { ; Mid left
    o := RelCoord()
    o.SetCoordRel(410, 720)
    return o
}

cMineColourSlot3() { ; Bottom left
    o := RelCoord()
    o.SetCoordRel(410, 870)
    return o
}

cMineColourSlot4() { ; Top right
    o := RelCoord()
    o.SetCoordRel(1368, 575)
    return o
}

cMineColourSlot5() { ; Mid right
    o := RelCoord()
    o.SetCoordRel(1368, 720)
    return o
}

cMineColourSlot6() { ; Bottom right
    o := RelCoord()
    o.SetCoordRel(1368, 870)
    return o
}

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

cMineTransmuteButton() { ; Button for Transmute all bars
    o := RelCoord()
    o.SetCoordRel(1080, 383)
    return o
}

 