#Requires AutoHotkey v2.0

#Include Lib\hGlobals.ahk
#Include Lib\cPoints.ahk
#Include Lib\Functions.ahk
#Include Lib\Navigate.ahk
#Include Lib\ScriptSettings.ahk
#Include Lib\cGameWindow.ahk

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
    If (!Window.Exist()) {
        ExitApp()
    }
    Window.Activate()
    Sleep(NavigateTime)
    If (Window.IsPanel()) {
        localClosePanel()
        Sleep(NavigateTime)
    }
    Out.I("Opening Mine")
    localOpenMining()
    Sleep(NavigateTime)
    Loop {
        If (!Window.Exist()) {
            Break
        }
        If (Window.IsActive()) {
            If (!Window.IsPanel()) {
                Out.I("Opening Mine 2 " Window.IsPanel())
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
    ControlSend("{l}", , Window.Title)
}

localClosePanel() {
    ControlSend("{Esc}", , Window.Title)
}