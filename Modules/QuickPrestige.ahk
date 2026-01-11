#Requires AutoHotkey v2.0

; TODO Travel and opening review

fPrestigeSpammer() {
    Travel.ClosePanelIfActive()
    count := 1
    While (count <= 30) {
        If (!Window.IsActive()) {
            Break
        }
        TriggerLC()
        WaitForPortalAnimation()
        count++
    }
}
