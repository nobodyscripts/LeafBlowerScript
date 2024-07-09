#Requires AutoHotkey v2.0

#Include Lib\hGlobals.ahk
#Include Lib\cPoints.ahk
#Include Lib\Functions.ahk
#Include Lib\Navigate.ahk
#Include Lib\ScriptSettings.ahk
#Include Lib\SettingsCheck.ahk

Global ScriptsLogFile := A_ScriptDir "\GemAlert.Log"
Global NavigateTime := 150
Global IsSecondary := false

GemAlert()

;@region GemAlert()
/**
 * Check location of bars for non bar colours, do so within screenspace so alt
 * tab is available for users
 */
GemAlert() {
    If (!GameWindowExist()) {
        ExitApp()
    }

    If (!IsWindowActive()) {
        WinActivate(LBRWindowTitle)
        Sleep(NavigateTime)
    }
    If (IsPanelActive()) {
        localClosePanel()
        Sleep(NavigateTime)
    }
    localOpenMining()
    Sleep(NavigateTime)
    Loop {
        If (!GameWindowExist()) {
            Break
        }
        If (WinActive(LBRWindowTitle)) {
            If (!IsPanelActive()) {
                localOpenMining()
                Sleep(NavigateTime)
            } Else {
                FindVeinsWithBars2()
                Sleep(seconds(10))
            }
        } Else {
            FindVeinsWithBars2()
            Sleep(seconds(10))
        }
    }
}
;@endregion

seconds(int) {
    Return int * 1000
}

FindVeinsWithBars2() {
    SampleSlot4 := Points.Mine.Vein.Slot4.Icon.ClientToScreencPoint()
    SampleSlot5 := Points.Mine.Vein.Slot5.Icon.ClientToScreencPoint()
    SampleSlot6 := Points.Mine.Vein.Slot6.Icon.ClientToScreencPoint()
    CoordMode("Pixel", "Screen")
    If (PixelGetColor(SampleSlot4.x, SampleSlot4.y) != "0x6D758D" ||
        PixelGetColor(SampleSlot5.x, SampleSlot5.y) != "0x6D758D" ||
        PixelGetColor(SampleSlot6.x, SampleSlot6.y) != "0x6D758D") {
        SoundBeep()
    }
    CoordMode("Pixel", "Client")
    Return
}

localOpenMining() {
    ControlSend("{l}", , LBRWindowTitle)
}

localClosePanel() {
    ControlSend("{Esc}", , LBRWindowTitle)
}