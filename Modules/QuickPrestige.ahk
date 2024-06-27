#Requires AutoHotkey v2.0

fPrestigeSpammer() {
    ; TODO Move point to Points
    prestigeButton := cPoint(1456, 430)
    ; TODO Move point to Points
    prestigeConfirmButton := cPoint(1456, 525)
    Travel.OpenGoldPortal()
    Sleep(NavigateTime)
    count := 0
    while (count <= 29) {
        if (!IsWindowActive()) {
            break
        }
        if (IsWindowActive() && !IsPanelActive()) {
            Travel.OpenGoldPortal()
            Sleep(NavigateTime)
        }
        if (IsWindowActive() && IsPanelActive()) {
            if (prestigeConfirmButton.IsButtonActive()) {
                prestigeConfirmButton.ClickOffset()
                Sleep(NavigateTime)
                count++
            }
            if (prestigeButton.IsButtonActive()) {
                prestigeButton.ClickOffset()
                Sleep(NavigateTime)
            }
        }
    }
}
