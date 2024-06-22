#Requires AutoHotkey v2.0

fPrestigeSpammer() {
    prestigeButton := cPoint(1456, 430)
    prestigeConfirmButton := cPoint(1456, 525)
    if (IsPanelActive()) {
        GameKeys.ClosePanel()
        Sleep(NavigateTime)
    }
    GameKeys.OpenGoldPortal()
    Sleep(NavigateTime)
    count := 0
    while (count <= 29) {
        if (!IsWindowActive()) {
            break
        }
        if (IsWindowActive() && !IsPanelActive()) {
            GameKeys.OpenGoldPortal()
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
