#Requires AutoHotkey v2.0

fSuitcaseSpam() {
    if (!IsWindowActive()) {
        return
    }
    if (IsPanelActive()) {
        ClosePanel()
    }
    OpenTrades()
    Sleep(150)
    loop {
        if (!IsWindowActive()) {
            break
        }
        if (IsWindowActive() && !IsPanelActive()) {
            OpenTrades()
            Sleep(NavigateTime)
        }
        if (IsWindowActive() && IsPanelActive()) {
            TriggerSuitcase()
    
            TriggerSeeds()
    
            RefreshTrades()
            Sleep(17)
        }
    }
}
