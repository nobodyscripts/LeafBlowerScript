#Requires AutoHotkey v2.0
#SingleInstance Force

Global DisableScriptKeysInit := true

/** @type {cLog} */
Out := cLog(A_ScriptDir "\TAS.log", true, 3, false)

/** @type {cLBRWindow} */
Global Window := cLBRWindow("Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe", 2560, 1369)

#Include ScriptLib\cSettings.ahk
#Include Lib\Misc.ahk
#Include Lib\cLBRWindow.ahk
#Include Lib\Navigate.ahk
#Include Lib\cHotkeysInitGame.ahk
#Include Lib\TAS\cGameController.ahk

S.initSettings()

GameKeys.sFilename := A_ScriptDir "\UserHotkeys.ini"
GameKeys.initHotkeys()

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