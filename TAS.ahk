#Requires AutoHotkey v2.0

#Include Lib\hTas.ahk
#Include Lib\hModules.ahk

Global ScriptsLogFile := A_ScriptDir "\TAS.Log"
Global IsSecondary := false

If (WinExist(LBRWindowTitle)) {
    If (!WinActive(LBRWindowTitle)) {
        WinActivate(LBRWindowTitle)
    }
} Else {
    Return
}

gc := cGameController()

F1:: {
    ExitApp()
}

F2:: {
    Reload()
}

Numpad0:: {
    gc.Run()
}