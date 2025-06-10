#Requires AutoHotkey v2.0

/** @type {cLog} */
Out := cLog(A_ScriptDir "\GemAlert.log", true, 3, false)

/** @type {cLBRWindow} */
Global Window := cLBRWindow("Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe", 2560, 1369)

#Include Lib\cPoints.ahk
#Include Lib\Misc.ahk
#Include Lib\Navigate.ahk
#Include ScriptLib\cLogging.ahk
#Include Lib\cLBRWindow.ahk


GemAlert()

;@region GemAlert()
/**
 * Check location of bars for non bar colours, do so within screenspace so alt
 * tab is available for users
 */
GemAlert() {
    NavigateTime := S.Get("NavigateTime")
    If (!Window.Exist()) {
        ExitApp()
    }
    Window.StartOrReload()
    Sleep(NavigateTime)
    If (Window.IsPanel()) {
        GameKeys.ClosePanel()
        Sleep(NavigateTime)
    }
    Out.I("Opening Mine")
    GameKeys.OpenMining()
    Sleep(NavigateTime)
    Loop {
        If (!Window.Exist()) {
            Break
        }
        If (Window.IsActive()) {
            If (!Window.IsPanel()) {
                Out.I("Opening Mine 2 " Window.IsPanel())
                GameKeys.OpenMining()
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
