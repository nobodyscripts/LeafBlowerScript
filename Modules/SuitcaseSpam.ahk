#Requires AutoHotkey v2.0

fSuitcaseSpam() {
    If (!IsWindowActive()) {
        Return
    }
    Travel.OpenTrades()
    Sleep(150)
    Loop {
        If (!IsWindowActive()) {
            Break
        }
        If (IsWindowActive() && !IsPanelActive()) {
            Travel.OpenTrades()
            Sleep(NavigateTime)
        }
        If (IsWindowActive() && IsPanelActive()) {
            GameKeys.TriggerSuitcase()

            GameKeys.TriggerSeeds()

            GameKeys.RefreshTrades()
            Sleep(17)
        }
    }
}