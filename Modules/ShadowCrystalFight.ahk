#Requires AutoHotkey v2.0

fShadowCrystalFight() {
    If (!Window.Activate()) {
        Out.I("Exiting due to no window")
        Return
    }
    SCAdvanceReplace := true
    StopAdvance := false
    ; TODO Move point to Points
    AttackBtn := cPoint(1143, 422)
    ; TODO Move point to Points
    RestBtn := cPoint(1318, 422)

    If (!Window.IsActive() || !Window.IsPanel()) {
        Out.I("Exiting due to no panel or window")
        Return
    }
    cPoint(Window.W / 4, Window.H / 4)
    .TextTipAtCoord("Running")
    Loop {
        ; Is window
        If (!Window.IsActive() || !Window.IsPanel()) {
            Out.I("Exiting due to no panel or window")
            Break
        }
        State := ShadowCrystalState()
        Out.I(State)
        If (State = "PlayerDead") {
            ; Is player out of health
            RestBtn.ClickOffset(, , 34)
            Sleep(17)
            If (SCAdvanceReplace) {
                ReduceLevel()
                StopAdvance := true
            }
        }
        If (State = "LowHealth") {
            ; Is player low health
            RestBtn.ClickOffset(, , 34)
            Sleep(17)
        }
        If (State = "CrystalDead") {
            If (SCAdvanceReplace && !StopAdvance) {
                IncreaseLevel()
            }
        }
        If (State = "Attack") {
            ; Attack
            AttackBtn.ClickOffset(, , 17)
        }
        If (State = "Exception") {
            Out.I("Exception")
        }
        Sleep(17)
    }
    Out.I("Exiting due to no panel or window")
    ToolTip(, , , 15)
    Reload()
}

ShadowCrystalState() {
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
    ; Is player out of health
    If (AttackBtn.IsButtonInactive() && RestBtn.IsButtonActive() && HealthMin.IsColour("0xFFFFFF")) {
        Return "PlayerDead"
    }
    ; Is player low health
    If (HealthBuffer.IsColour("0xFFFFFF") || StaminaMin.IsColour("0xFFFFFF")) {
        Return "LowHealth"
    }
    ; Is awaiting respawn
    If (AttackBtn.IsButtonInactive() && RestBtn.IsButtonInactive() && HealthMin.IsColour("0xA11111")) {
        Return "CrystalDead"
    }
    ; Is attack available
    If (AttackBtn.IsButtonActive() && HealthMin.IsColour("0xA11111") && HealthBuffer.IsColour("0xA11111")) {
        Return "Attack"
    }
    Return "Exception"
}

ReduceLevel() {
    LevelDec := cPoint(1000, 310)
    LevelDec.ClickButtonActive()
    Sleep(17)
}

IncreaseLevel() {
    LevelInc := cPoint(1445, 310)
    LevelInc.ClickButtonActive()
    Sleep(17)
}

/*
323 321 left end health
365 321 buffer amount health
799 321 right end health

1% 4.76
1143 422 Attack
1318 422 Rest

1445 310 increase level
1000 310 decrease level
*/
