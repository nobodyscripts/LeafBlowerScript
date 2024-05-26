#Requires AutoHotkey v2.0

#Include Lib/Coords.ahk
#Include Lib/Functions.ahk
#Include Lib/Navigate.ahk
#Include Lib/ScriptSettings.ahk
#Include Lib/SettingsCheck.ahk

global ScriptsLogFile := A_ScriptDir "\LeafBlowerV3.Log"
global LBRWindowTitle := "Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe"
global X, Y, W, H
global NavigateTime := 150

X := Y := W := H := 0
if (WinExist(LBRWindowTitle)) {
    WinGetClientPos(&X, &Y, &W, &H, LBRWindowTitle)
}

if (IsPanelActive()) {
    ClosePanel()
    Sleep(NavigateTime)
}
OpenMining()
Sleep(NavigateTime)
loop {
    if (IsWindowActive() && !IsPanelActive()) {
        OpenMining()
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
            OpenMining()
            Sleep(NavigateTime)
        }
        if (IsPanelActive()) {
            FindVeinsWithBars2()
            Sleep(1000 * 30)
        }
    }
}

FindVeinsWithBars2() {

    SampleSlot4 := cMineVeinIconSlot4()
    SampleSlot5 := cMineVeinIconSlot5()
    SampleSlot6 := cMineVeinIconSlot6()
    if (SampleSlot4.GetColour() != "0x6D758D" ||
        SampleSlot5.GetColour() != "0x6D758D" ||
        SampleSlot6.GetColour() != "0x6D758D") {
        SoundBeep()
        Sleep(1000 * 30)
    }
    return
}

OpenMining() {
    ControlSend("{l}", , LBRWindowTitle)
}

ClosePanel() {
    ControlSend("{Esc}", , LBRWindowTitle)
}