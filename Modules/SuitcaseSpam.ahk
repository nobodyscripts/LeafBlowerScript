#Requires AutoHotkey v2.0

; TODO Travel and opening review

fSuitcaseSpam() {
    NavigateTime := S.Get("NavigateTime")
    If (!Window.IsActive()) {
        Return
    }
    Shops.OpenTrades()
    Sleep(150)
    Loop {
        If (!Window.IsActive()) {
            Break
        }
        If (Window.IsActive() && !Window.IsPanel()) {
            Shops.OpenTrades()
            Sleep(NavigateTime)
        }
        If (Window.IsActive() && Window.IsPanel()) {
            GameKeys.TriggerSuitcase()

            GameKeys.TriggerSeeds()

            GameKeys.RefreshTrades()
            Sleep(17)
        }
    }
}
