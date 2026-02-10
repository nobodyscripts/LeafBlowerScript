#Requires AutoHotkey v2.0

/**
 * Pyramid module for holding related functions
 * @module Pyramid
 * @method WaitTillReset Desc
 */
Class Pyramid {
    ;@region WaitTillReset()
    /**
     * Wait for pyramid to swap zones, so that progress can be noted
     * Only works if auto reset is turned off
     */
    WaitTillReset(*) {
        UlcWindow()
        Out.D("Wait Till Pyramid Reset")
        gToolTip.Center("Waiting for pyramid to reset zone")
        colour := Colours().GetColourByZone("The Cursed Pyramid")
        Points.Misc.ZoneSample.WaitWhileNotColour(colour, 1200, 50) ; 60s
        If (Points.Misc.ZoneSample.IsColour(colour)) {
            Out.I("Timed out waiting for pyramid to clear, "
                "taxi may have already been bought.")
        }
        gToolTip.CenterDel()
    }
    ;@endregion
}
