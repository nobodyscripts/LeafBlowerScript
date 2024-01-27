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

    IsCoordButtonActive() {
        if (IsButtonActive(this.x, this.y)) {
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