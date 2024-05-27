#Requires AutoHotkey v2.0

#Include Functions.ahk

/*
Defines the locations resolution independant for area colour checks
*/

Class RelSampleArea {
    x1 := 0
    y1 := 0
    x2 := 0
    y2 := 0
    w := 0
    h := 0

    SetCoordRel(xin1, yin1, xin2, yin2) {
        this.x1 := WinRelPosLargeW(xin1)
        this.y1 := WinRelPosLargeH(yin1)
        this.x2 := WinRelPosLargeW(xin2)
        this.y2 := WinRelPosLargeH(yin2)
        tw := this.x2 - this.x1
        if (tw > 0) {
            this.w := tw
        }
        th := this.y2 - this.y1
        if (th > 0) {
            this.h := th
        }
        return this
    }

    NewCoordManual(xin1, yin1, xin2, yin2) {
        this.x1 := xin1
        this.y1 := yin1
        this.x2 := xin2
        this.y2 := yin2
        tw := this.x2 - this.x1
        if (tw > 0) {
            this.w := tw
        }
        th := this.y2 - this.y1
        if (th > 0) {
            this.h := th
        }
        return this
    }

    toString() {
        return ("X1: " this.x1 " Y1: " this.y1 " X2: " this.x2 " Y2: "
        this.y2 "`nW: " this.w " H: " this.h)
    }

    ToolTipAtCoord(id1 := 14, id2 := 15) {
        ToolTip(" ", this.x1, this.y1, id1)
        ToolTip(" ", this.x2, this.y2, id2)
    }

    AreaPixelSearch(colour := "0xFFFFFF") {
        try {
            found := PixelSearch(&OutX, &OutY,
                this.x1, this.y1,
                this.x2, this.y2, colour, 0)
            If (found and OutX != 0) {
                return [OutX, OutY] ; Found colour
            }
        } catch as exc {
            Log("Error 8: AreaPixelSearch search failed - " exc.Message)
            MsgBox("Could not conduct the search due to the following error:`n"
                exc.Message)
        }
        return false
    }
}
