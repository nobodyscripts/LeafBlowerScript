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

Global BossFarmUsesWobblyWings := false
Global BossFarmUsesWind := false
Global BossFarmUsesSeeds := false
Global WobblyWingsSleepAmount := 1
Global ArtifactSleepAmount := 1
Global settings := cSettings()
settings.initSettings(true)

OnExit(CleanupTimer)

Out.I("Secondary: Normal Boss Started")

fNormalBoss()
fNormalBoss() {
    startTime := A_Now
    If (BossFarmUsesWobblyWings && Window.IsActive() && IsBossTimerActive()) {
        SetTimer(UseWings, WobblyWingsSleepAmount)
        ; Use it once to avoid getting stuck
        GameKeys.TriggerWobblyWings()
    }
    Loop {
        If (!Window.Exist()) {
            Out.I("Secondary: Normal Boss Spammer exiting as no game.")
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

UseWings() {
    If (Window.IsActive() && IsBossTimerActive()) {
        GameKeys.TriggerWobblyWings()
    }
}

CleanupTimer(ExitReason, ExitCode) {
    SetTimer(UseWings, -1)
    ExitApp()
}