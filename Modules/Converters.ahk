#Requires AutoHotkey v2.0

/**
 * Converters collection of functions
 * @module Converters
 * @method Open Open Converters UI
 * @method Activate Activate Converters
 */
Class Converters {

    ;@region Open()
    /**
     * Open Converters UI
     */
    Open() {
        UlcWindow()
        Out.D("Open Converters")
        GameKeys.OpenConverters()
    }

    /**
     * Activate Converters
     */
    Activate() {
        StartConvertorsBtn := cLBRButton(1074, 1102)
        UlcWindow()
        Out.D("Activate Converters")
        this.Open()
        StartConvertorsBtn.WaitUntilActiveButtonS(5)
        StartConvertorsBtn.ClickOffset(, 5)
        StartConvertorsBtn.ClickOffset(, 5)
        If (!Window.IsPanel()) {
            Out.I("Didn't find converter start button, exiting.")
            Global ULCStageExit := true
        }
    }
    ;@endregion
}
