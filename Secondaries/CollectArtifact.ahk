#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#SingleInstance Force

/** Using Out instead of Log as thats taken by a func
 * @type {cLog} Global cLog object */
Global Out := cLog(A_ScriptDir "\..\Secondaries.Log", true, 3, true)

/** @type {cLBRWindow} */
Global Window := cLBRWindow("Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe", 2560, 1369)
#Include ..\ScriptLib\cSettings.ahk
#Include ..\Lib\Misc.ahk
#Include ..\Lib\cLBRButton.ahk
#Include ..\Lib\cLBRWindow.ahk
#Include ..\Lib\Navigate.ahk
#Include ..\Lib\cHotkeysInitGame.ahk
#Include ..\Modules\FarmNormalBoss.ahk
#Include ..\Modules\BlowLeaves.ahk

S.Filename := A_ScriptDir "\..\UserSettings.ini"
S.initSettings()

Scriptkeys.sFilename := A_ScriptDir "\..\ScriptHotkeys.ini"
Scriptkeys.initHotkeys()

GameKeys.sFilename := A_ScriptDir "\..\UserHotkeys.ini"
GameKeys.initHotkeys()

OnExit(CleanupTimerCA)

Out.I("Secondary: Collect Artifact Started")

fCollectArtifacts()
fCollectArtifacts() {
    startTime := A_Now
    Window.StartOrExit()
    Loop {
        Window.StartOrExit()
        MousePattern.SetSevenHorizontal()
        MousePattern.Task()
        MousePattern.SetSpiral()
        MousePattern.Task()
    }
}

CleanupTimerCA(ExitReason, ExitCode) {
    ExitApp()
}
