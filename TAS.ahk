#Requires AutoHotkey v2.0
#SingleInstance Force

#Include Lib\hTas.ahk
#Include Lib\hModules.ahk

Global ScriptsLogFile := A_ScriptDir "\TAS.Log"
Global IsSecondary := false
Global DisableGameKeysInit := true
Global DisableScriptKeysInit := true

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