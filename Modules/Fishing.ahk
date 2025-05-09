#Requires AutoHotkey v2.0
#Include ../Lib/cRects.ahk
#Include ../Lib/cPoints.ahk

;@region fFishAutoCatch()
/**
 * Attempt to auto catch fish (Simple)
 */
fFishAutoCatch() {
    /** @type {cPoint} */
    Lure := cPoint(858, 314)

    /** @type {cPoint} */
    Spot1Cast := cPoint(541, 667)
    /** @type {cRect} */
    Spot1Progress := cRect(400, 702, 500, 728)
    /** @type {cRect} */
    Spot1CooldownSuffix := cRect(464, 705, 500, 728)
    /** @type {Timer} */
    Spot1Timer := Timer()
    Spot1IsOnCD := false

    /** @type {cPoint} */
    Spot2Cast := cPoint(1157, 667)
    /** @type {cRect} */
    Spot2Progress := cRect(1005, 699, 1108, 728)
    /** @type {cRect} */
    Spot2CooldownSuffix := cRect(1073, 703, 1108, 728)
    /** @type {Timer} */
    Spot2Timer := Timer()
    Spot2IsOnCD := false

    /** @type {cPoint} */
    Spot3Cast := cPoint(542, 972)
    /** @type {cRect} */
    Spot3Progress := cRect(396, 1001, 500, 1031)
    /** @type {cRect} */
    Spot3CooldownSuffix := cRect(465, 1004, 500, 1031)
    /** @type {Timer} */
    Spot3Timer := Timer()
    Spot3IsOnCD := false
    Loop {
        If (!Window.IsActive()) {
            Break
        }

        If (!Spot1Progress.pixelSearch()) {
            ; Was off cooldown and nothing catching
            Spot1Cast.ClickButtonActive()
        }
        If (!Spot2Progress.pixelSearch()) {
            ; Was off cooldown and nothing catching
            Spot2Cast.ClickButtonActive()
        }
        If (!Spot3Progress.pixelSearch()) {
            ; Was off cooldown and nothing catching
            Spot3Cast.ClickButtonActive()
        }
        If (Spot1Progress.PixelSearch() && !Spot1CooldownSuffix.PixelSearch()) {
            Spot1Timer.CoolDownS(10, &Spot1IsOnCD)
            Out.D("Spot 1 CD")
        }
        If (Spot2Progress.PixelSearch() && !Spot2CooldownSuffix.PixelSearch()) {
            Spot2Timer.CoolDownS(10, &Spot2IsOnCD)
            Out.D("Spot 2 CD")
        }
        If (Spot3Progress.PixelSearch() && !Spot3CooldownSuffix.PixelSearch()) {
            Spot3Timer.CoolDownS(10, &Spot3IsOnCD)
            Out.D("Spot 3 CD")
        }
        If (!Spot1IsOnCD) {
            Spot1Cast.ClickButtonActive()
        }
        If (!Spot2IsOnCD) {
            Spot2Cast.ClickButtonActive()
        }
        If (!Spot3IsOnCD) {
            Spot3Cast.ClickButtonActive()
        }
        Sleep (17)
        If (Lure.IsButtonActive()) {
            Lure.ClickButtonActive()
        }
    }
}
;@endregion
