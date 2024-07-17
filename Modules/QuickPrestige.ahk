#Requires AutoHotkey v2.0

fPrestigeSpammer() {
    ; TODO Move point to Points
    prestigeButton := cPoint(1456, 430)
    ; TODO Move point to Points
    prestigeConfirmButton := cPoint(1456, 525)
    Travel.OpenGoldPortal()
    Sleep(NavigateTime)
    count := 0
    While (count <= 29) {
        If (!Window.IsActive()) {
            Break
        }
        If (Window.IsActive() && !Window.IsPanel()) {
            Travel.OpenGoldPortal()
            Sleep(NavigateTime)
        }
        If (Window.IsActive() && Window.IsPanel()) {
            If (prestigeConfirmButton.IsButtonActive()) {
                prestigeConfirmButton.ClickOffset()
                Sleep(NavigateTime)
                count++
            }
            If (prestigeButton.IsButtonActive()) {
                prestigeButton.ClickOffset()
                Sleep(NavigateTime)
            }
        }
    }
}