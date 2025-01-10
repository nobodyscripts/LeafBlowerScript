#Requires AutoHotkey v2.0

fShadowCrystalFight() {
    if (!Window.Activate()) {
        Out.I("Exiting due to no window")
        return
    }
    ; TODO Move point to Points
    HealthMin := cPoint(323, 321)
    ; TODO Move point to Points
    HealthBuffer := cPoint(365, 321)
    ; TODO Move point to Points
    HealthMax := cPoint(799, 321)
    ; TODO Move point to Points
    AttackBtn := cPoint(1143, 422)
    ; TODO Move point to Points
    RestBtn := cPoint(1318, 422)
    ; TODO Move point to Points
    StaminaMin := cPoint(323, 397)
    loop {
        if (!Window.IsActive() || !Window.IsPanel()) {
            Out.I("Exiting due to no panel or window")
            break
        }
        cPoint(Window.W / 4, Window.H / 4).TextTipAtCoord("Running")
        if (AttackBtn.IsButtonInactive() && RestBtn.IsButtonActive() && HealthMin.IsColour("0xFFFFFF")) {
            ; Need to revive
            Out.D("Reviving")
            RestBtn.ClickOffset(, , 34)
            Sleep(34)
        }
        if (HealthBuffer.IsColour("0xFFFFFF") || StaminaMin.IsColour("0xFFFFFF")) {
            Out.D("Resting")
            RestBtn.ClickOffset(, , 34)
            Sleep(34)
        }
        ; Attack
        if (AttackBtn.IsButtonActive() && HealthMin.IsColour("0xA11111") && HealthBuffer.IsColour("0xA11111")) {
            Out.D("Attacking")
            AttackBtn.ClickOffset(, , 17)
            Sleep(17)

        }
    }
    ToolTip()
    Reload()
}

/*
323 321 left end health
365 321 buffer amount health
799 321 right end health

1% 4.76
1143 422 Attack
1318 422 Rest
*/
