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
#Include ..\Lib\cLBRWindow.ahk
#Include ..\Lib\Navigate.ahk
#Include ..\Lib\cHotkeysInitGame.ahk

S.Filename := A_ScriptDir "\..\UserSettings.ini"
S.initSettings()

Scriptkeys.sFilename := A_ScriptDir "\..\ScriptHotkeys.ini"
Scriptkeys.initHotkeys()

GameKeys.sFilename := A_ScriptDir "\..\UserHotkeys.ini"
GameKeys.initHotkeys()

Out.I("Secondary: Wind Spammer Started")

fWindSpammer()
fWindSpammer() {
    Window.StartOrExit()
    ArtifactSleepAmount := S.Get("ArtifactSleepAmount")
    BossFarmUsesSeeds := S.Get("BossFarmUsesSeeds")
    Loop {
        Window.StartOrExit()
        If (!IsBossTimerActive() && !Travel.HomeGarden.IsAreaGarden()) {
            GameKeys.TriggerWind()
            If (BossFarmUsesSeeds) {
                GameKeys.TriggerSeeds()
            }
            Sleep(ArtifactSleepAmount)
        }
    }
}
