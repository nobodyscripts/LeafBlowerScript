#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#SingleInstance Force

Global ScriptsLogFile := A_ScriptDir "\..\Secondaries.Log"
Global IsSecondary := true

#Include ..\Lib\hGlobals.ahk
#Include ..\Lib\ScriptSettings.ahk
#Include ..\Lib\Functions.ahk
#Include ..\Lib\cGameWindow.ahk
#Include ..\Lib\Navigate.ahk
#Include ..\Lib\cHotkeysInitGame.ahk

Global BossFarmUsesWind := false
Global BossFarmUsesSeeds := false
Global ArtifactSleepAmount := 1
Global settings := cSettings()
settings.initSettings(true)

Log("Secondary: GFSS Boss Started")

fGFSSBoss()
fGFSSBoss() {
    startTime := A_Now
    Loop {
        If (!Window.Exist()) {
            Log("Secondary: GFSS Spammer exiting as no game.")
            Return
        }
        If (!Window.IsActive()) {
            Window.Activate()
        } Else {
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
}