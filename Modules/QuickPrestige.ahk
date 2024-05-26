#Requires AutoHotkey v2.0

fPrestigeSpammer() {
    prestigeButton := RelCoord()
    prestigeButton.SetCoordRel(1456, 430)
    prestigeConfirmButton := RelCoord()
    prestigeConfirmButton.SetCoordRel(1456, 525)
    if (IsPanelActive()) {
        ClosePanel()
        Sleep(NavigateTime)
    }
    OpenGoldPortal()
    Sleep(NavigateTime)
    count := 0
    while (count <= 29) {
        if (!IsWindowActive()) {
            break
        }
        if (IsWindowActive() && !IsPanelActive()) {
            OpenGoldPortal()
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
