#Requires AutoHotkey v2.0

#Include ../Lib/Coords.ahk

global LeaftonCraftEnabled := true
global LeaftonWindEnabled := true

fLeaftonTaxi() {
    centerCoord := cLeaftonCenter()
    startCoord := cLeaftonStart()
    craftStopCoord := cCraftingStop()
    ToolTip("Leafton Active", W / 2, 300, 4)
    OpenPets()
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
            }
            while (!IsBossTimerActive()) {

                if (LeaftonCraftEnabled) {
                    craftStopCoord.Click(17)
                }
                TriggerWind()
            }

            if (LeaftonCraftEnabled) {
                ClosePanel()
            }

        }
    }
}