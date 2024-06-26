#Requires AutoHotkey v2.0

#Include Lib\hGlobals.ahk
#Include TAS\cGameController.ahk

global ScriptsLogFile := A_ScriptDir "\TAS.Log"

if (WinExist(LBRWindowTitle)) {
    if (!WinActive(LBRWindowTitle)) {
        WinActivate(LBRWindowTitle)
    }
} else {
    return
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
