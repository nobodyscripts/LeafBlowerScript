#Requires AutoHotkey v2.0

#Include Lib/cPoints.ahk
#Include Lib/Functions.ahk
#Include Lib/Navigate.ahk
#Include Lib/ScriptSettings.ahk
#Include Lib/SettingsCheck.ahk
#Include Navigate\Mines\Travel.ahk

global ScriptsLogFile := A_ScriptDir "\LeafBlowerV3.Log"
global LBRWindowTitle := "Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe"
global X, Y, W, H
global NavigateTime := 150

X := Y := W := H := 0
if (WinExist(LBRWindowTitle)) {
    WinGetClientPos(&X, &Y, &W, &H, LBRWindowTitle)
}

if (IsPanelActive()) {
    localClosePanel()
    Sleep(NavigateTime)
}
localOpenMining()
Sleep(NavigateTime)
loop {
    if (IsWindowActive() && !IsPanelActive()) {
        localOpenMining()
        Sleep(NavigateTime)
    }
    if (IsWindowActive() && IsPanelActive()) {
        FindVeinsWithBars2()
        Sleep(1000 * 10)
    }

    if (!IsWindowActive()) {
        WinActivate(LBRWindowTitle)
        Sleep(NavigateTime)

        if (!IsPanelActive()) {
            localOpenMining()
            Sleep(NavigateTime)
        }
        if (IsPanelActive()) {
            FindVeinsWithBars2()
            Sleep(1000 * 30)
        }
    }
}

FindVeinsWithBars2() {
    SampleSlot4 := Points.Mine.Vein.Slot4.Icon
    SampleSlot5 := Points.Mine.Vein.Slot5.Icon
    SampleSlot6 := Points.Mine.Vein.Slot6.Icon
    if (SampleSlot4.GetColour() != "0x6D758D" ||
        SampleSlot5.GetColour() != "0x6D758D" ||
        SampleSlot6.GetColour() != "0x6D758D") {
        SoundBeep()
        Sleep(1000 * 30)
    }
    return
}

localOpenMining() {
    ControlSend("{l}", , LBRWindowTitle)
}

localClosePanel() {
    ControlSend("{Esc}", , LBRWindowTitle)
}