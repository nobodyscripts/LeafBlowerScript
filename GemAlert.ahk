#Requires AutoHotkey v2.0

#Include Lib\hGlobals.ahk
#Include Lib\cPoints.ahk
#Include Lib\Functions.ahk
#Include Lib\Navigate.ahk
#Include Lib\ScriptSettings.ahk
#Include Lib\SettingsCheck.ahk

global ScriptsLogFile := A_ScriptDir "\GemAlert.Log"
global NavigateTime := 150

GemAlert()

;@region GemAlert()
/**
 * Check location of bars for non bar colours, do so within screenspace so alt
 * tab is available for users
 */
GemAlert() {
    if (!GameWindowExist()) {
        ExitApp()
    }
    
    if (!IsWindowActive()) {
        WinActivate(LBRWindowTitle)
        Sleep(NavigateTime)
    }
    if (IsPanelActive()) {
        localClosePanel()
        Sleep(NavigateTime)
    }
    localOpenMining()
    Sleep(NavigateTime)
    loop {
        if (!GameWindowExist()) {
            break
        }
        if (WinActive(LBRWindowTitle)) {
            if (!IsPanelActive()) {
                localOpenMining()
                Sleep(NavigateTime)
            } else {
                FindVeinsWithBars2()
                Sleep(seconds(10))
            }
        } else {
            FindVeinsWithBars2()
            Sleep(seconds(10))
        }
    }
}
;@endregion

seconds(int) {
    return int * 1000
}

FindVeinsWithBars2() {
    SampleSlot4 := Points.Mine.Vein.Slot4.Icon.ClientToScreencPoint()
    SampleSlot5 := Points.Mine.Vein.Slot5.Icon.ClientToScreencPoint()
    SampleSlot6 := Points.Mine.Vein.Slot6.Icon.ClientToScreencPoint()
    CoordMode("Pixel", "Screen")
    if (PixelGetColor(SampleSlot4.x, SampleSlot4.y) != "0x6D758D" ||
        PixelGetColor(SampleSlot5.x, SampleSlot5.y) != "0x6D758D" ||
        PixelGetColor(SampleSlot6.x, SampleSlot6.y) != "0x6D758D") {
        SoundBeep()
    }
    CoordMode("Pixel", "Client")
    return
}

localOpenMining() {
    ControlSend("{l}", , LBRWindowTitle)
}

localClosePanel() {
    ControlSend("{Esc}", , LBRWindowTitle)
}