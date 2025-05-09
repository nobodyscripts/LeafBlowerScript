#Requires AutoHotkey v2.0
#Include ../Lib/cRects.ahk
#Include ../Lib/cPoints.ahk

;@region fFishAutoCatch()
/**
 * Attempt to auto catch fish (Simple)
 */
fFishAutoCatch() {
    /** @type {cRect} */
    Spot1Progress := cRect(400, 702, 500, 728)
    /** @type {cRect} */
    Spot2Progress := cRect(1005, 699, 1108, 728)
    Loop {
        If (!Window.IsActive()) {
            Break
        }
        If (!Spot1Progress.pixelSearch()) {
            cPoint(541, 667).ClickOffset()
        }
        If (!Spot2Progress.pixelSearch()) {
            cPoint(1157, 667).ClickOffset()
        }
        If (cPoint(858, 314).IsButtonActive()) {
            cPoint(858, 314).ClickButtonActive()
            Sleep (3000)
        }

        cPoint(541, 667).ClickButtonActive()
        cPoint(1157, 667).ClickButtonActive()

    }
}
;@endregion
