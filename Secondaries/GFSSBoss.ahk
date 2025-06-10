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

Out.I("Secondary: GFSS Boss Started")

fGFSSBoss()
fGFSSBoss() {
    Window.StartOrExit()
    ArtifactSleepAmount := S.Get("ArtifactSleepAmount")
    BossFarmUsesSeeds := S.Get("BossFarmUsesSeeds")
    BossFarmUsesWind := S.Get("BossFarmUsesWind")
    ; TODO add BossFarmFast to GFSS
    startTime := A_Now
    Loop {
        Window.StartOrExit()
        If (IsBossTimerActive() || DateDiff(A_Now, startTime, "Seconds") >=
        30) {
            GameKeys.TriggerViolin()
            Sleep(ArtifactSleepAmount)
            startTime := A_Now
        }
        If (!IsBossTimerActive() && !Travel.HomeGarden.IsAreaGarden()) {
            If (BossFarmUsesSeeds) {
                GameKeys.TriggerSeeds()
            }
            If (IsAreaGFOrSS()) {
                GameKeys.TriggerGravity()
                GameKeys.TriggerWind()
                Sleep(ArtifactSleepAmount)
            } Else {
                If (BossFarmUsesWind) {
                    GameKeys.TriggerWind()
                    Sleep(ArtifactSleepAmount)
                }
            }
        }
    }
}
