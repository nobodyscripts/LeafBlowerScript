#Requires AutoHotkey v2.0
#SingleInstance Force

Global ScriptsLogFile := A_ScriptDir "\TAS.Log"
Global IsSecondary := false
;Global DisableGameKeysInit := true
Global DisableScriptKeysInit := true

#Include Lib\hTas.ahk
#Include Lib\hModules.ahk

If (!Window.Activate()) {
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