#Requires AutoHotkey v2.0

#Include Functions.ahk

/*
Defines the locations resolution independant for pixel checks
*/

Class Coord {
    x := 0
    y := 0

    NewCoord(xin, yin) {
        this.x := WinRelPosLargeW(xin)
        this.y := WinRelPosLargeH(yin)
        return this
    }

    NewCoordManual(xin, yin) {
        this.x := xin
        this.y := yin
        return this
    }
}

CardPacksOddButton() {
    return Coord.NewCoord(2130, 420)
}