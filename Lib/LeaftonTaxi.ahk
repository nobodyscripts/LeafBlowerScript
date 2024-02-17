#Requires AutoHotkey v2.0

#Include ../Lib/Coords.ahk

global LeaftonCraftEnabled := true

fLeaftonTaxi() {
    centerCoord := cLeaftonCenter()
    startCoord := cLeaftonStart()
    craftStopCoord := cCraftingStop()

    ClosePanel()
    loop {
        if (IsAreaBlack() && IsBossTimerActive()) {
            centerCoord.Click()
            Sleep(NavigateTime)
            if (startCoord.IsButtonActive()) {
                startCoord.Click()
            }
        } else {
            if (LeaftonCraftEnabled) {
                OpenCrafting()
                while (!IsBossTimerActive()) {
                    craftStopCoord.Click(17)
                }
                ClosePanel()
            }
        }
    }
}