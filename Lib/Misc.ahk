#Requires AutoHotkey v2.0

#Include ..\ScriptLib\Misc.ahk
#Include cPoints.ahk
#Include cRects.ahk
#Include Spammers.ahk

; ------------------- Functions -------------------

AmountToModifier(num) {
    Switch num {
        Case 10:
            SetModifierKeys(false, false, true)
        Case 25:
            SetModifierKeys(true, false, false)
        Case 100:
            SetModifierKeys(false, true, false)
        Case 250:
            SetModifierKeys(true, false, true)
        Case 1000:
            SetModifierKeys(false, true, true)
        Case 2500:
            SetModifierKeys(true, true, false)
        Case 25000:
            SetModifierKeys(true, true, true)
        default:
            SetModifierKeys(false, false, false)
    }
}

IsNotificationActive() {
    If (!Points.Misc.NotifArrow.IsButtonOffPanel()) {
        Return true
    }
    Return false
}

IsBossTimerActive() {
    If (!Rects.Misc.BossTimer.PixelSearch()) {
        Return false
    }
    Return true
}

IsBossTimerLong() {
    If (!Rects.Misc.BossTimerLong.PixelSearch()) {
        Return false
    }
    Return true
}

IsScrollAblePanel() {
    If (Points.Misc.ScrollArrow.IsButtonActive()) {
        ; Up Arrow exists, so scrolling is possible
        Return true
    }
    Return false
}

IsScrollAblePanelAtTop() {
    ; 2220 320 scroll handle
    If (IsScrollAblePanel()) {
        If (Points.Misc.ScrollHandle.IsButtonActive()) {
            ; Is at top
            Return true
        }
    }
    Return false
}

IsBVScrollAblePanelAtTop() {
    ; 2220 258 top scroll arrow button
    ; 2220 320 scroll handle
    If (Points.Misc.ScrollArrow.IsButtonActive()) {
        ; Up Arrow exists, so scrolling is possible
        If (Points.Misc.ScrollHandle.IsButtonActive()) {
            ; Is at top
            Return true
        } Else {
            Return false
        }
    }
    Return true
}

InitScriptHotKey() {
    Spammer.KillAllSpammers()
    ResetModifierKeys() ; Cleanup incase needed
}
