#Requires AutoHotkey v2.0

fSuitcaseSpam() {
    if (!IsWindowActive()) {
        return
    }
    Travel.OpenTrades()
    Sleep(150)
    loop {
        if (!IsWindowActive()) {
            break
        }
        if (IsWindowActive() && !IsPanelActive()) {
            Travel.OpenTrades()
            Sleep(NavigateTime)
        }
        if (IsWindowActive() && IsPanelActive()) {
            Gamekeys.TriggerSuitcase()

            Gamekeys.TriggerSeeds()

            GameKeys.RefreshTrades()
            Sleep(17)
        }
    }
}